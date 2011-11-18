<?php

	require_once TOOLKIT. '/class.event.php';

	class XpathrEvent extends Event
	{
		const ROOTELEMENT = 'xpathr-event';
		protected $last;
		protected static $source;

		public function __construct()
		{
			parent::__construct(Symphony::Engine());
		}

		public static function setSource($id)
		{
			self::$source = $id;
		}

		public static function getSource()
		{
			return self::$source;
		}

		public function run($fields = null, $entry_id = null)
		{
			$post = $_POST;

			if ($fields)
			{
				$_POST = array(
					'fields' => $fields
				);

				if ($entry_id) $_POST['id'] = $entry_id;
			}

			include(TOOLKIT . '/events/event.section.php');
			$_POST = $post;

			$this->last = $result;
			return $result;
		}

		public function getLastId()
		{
			if (!$this->last) return null;

			return $this->last->getAttribute('id');
		}

		public function load(){}
		public function __trigger(){}
		public static function about(){}
	}





	class Xpathr
	{
		protected static $cache = array();

		public static function getGist($id)
		{
			$data = self::api('/gists/'. $id);
			return $data;
		}

		public static function getRevision($id, $sha1 = null)
		{
			if (!$sha1 || $sha1 == 'HEAD') $sha1 = '';

			$data = self::api('/gists/'. $id. '/'. $sha1);
			return $data;
		}

		public static function needUpdate()
		{
			return isset($_REQUEST['update']);
		}

		public static function getSnippetsDir($id, $revision)
		{
			if (!$revision) $revision = 'HEAD';
			return join('/', array(WORKSPACE, 'user-data', $id, $revision));
		}

		public static function createGist($xml, $xsl)
		{
			$files = self::githubify(array(
				'master.xml' => $xml,
				'master.xsl' => $xsl
			));

			$token = self::getToken();

			return self::api('/gists', array(
				'method' => 'post',
				'token'  => $token,
				'fields' => array(
					'files'  => $files,
					'public' => true
				)
			));
		}

		public static function updateGist($id, $options = array())
		{
			$token = self::getToken();
			if (!$token) return;


			$options = array_merge(array(
				'files'   => array(),
				'rename'  => array(),
				'deletes' => array()
			), $options);

			extract($options);
			foreach ($deletes as $f => $v)
				$files[$f] = null;

			$files = self::githubify($files);

			foreach ($rename as $old => $new)
			{
				if (isset($files[$old]))
					$files[$old]['filename'] = $new;
				else
					$files[$old] = array('filename' => $new);
			}


			return self::api('/gists/'. $id, array(
				'method' => 'patch',
				'token'  =>  $token,
				'fields' => array(
					'files' => $files
				)
			));
		}

		public static function forkGist($id)
		{
			$token = self::getToken();
			if (!$token) return;

			return self::api('/gists/'. $id. '/fork', array(
				'method' => 'post',
				'token'  => $token
			));
		}

		public static function starGist($id, $action = 'star')
		{
			$token = self::getToken();
			if (!$token) return;

			$method = 'put';
			if ($action !== 'star') $method = 'delete';

			return self::api('/gists/'. $id. '/star', array(
				'method' => $method,
				'token'  => $token
			));
		}

		public static function addComment($id, $comment)
		{
			$token = self::getToken();
			if (!$token) return;

			return self::api('/gists/'. $id. '/comments', array(
				'method' => 'post',
				'token'  => $token,
				'fields' => array('body' => $comment)
			));
		}

		public static function getComments($id)
		{
			return self::api('/gists/'. $id. '/comments');
		}

		public static function getUser($token)
		{
			return self::api('/user', array(
				'token' => $token
			));
		}

		public static function githubify($array)
		{
			foreach ($array as $k => $v)
				$array[$k] = array('content' => $v);

			return $array;
		}

		public static function getToken()
		{
			$params = Symphony::Engine()->Page()->_param;

			return isset($params['github-access-token'])
					? $params['github-access-token'] : null;
		}

		protected static function api($url, $options = array())
		{
			$url  = trim('https://api.github.com'. $url, '/');
			$default = array('method' => 'get', 'token' => null);
			$options = array_merge($default, $options);

			$options['method'] = strtoupper($options['method']);

			if ($options['token'])
				$url .= '?access_token='. $options['token'];

			if ($options['method'] !== 'GET')
			{
				require_once TOOLKIT. '/class.gateway.php';

				$ch = new Gateway();
				$ch->init($url);

				$ch->setopt(CURLOPT_CUSTOMREQUEST, $options['method']);

				//$ch->setopt('RETURNHEADERS', 1);
				$ch->setopt('CONTENTTYPE', 'application/json');
				$ch->setopt(CURLOPT_POSTFIELDS, json_encode($options['fields']));

				$data = $ch->exec();
				$info = $ch->getInfoLast();
				$status = intval($info['http_code']);

				if ($status < 200 || $status >= 400)
					throw new XpathrException('Problems with github api :(');

				$data = json_decode($data);
				return $data->id;
			}


			if (isset(self::$cache[$url]))
				return self::$cache[$url];

			$data = file_get_contents($url);
			if (!$data) throw new XpathrException('Resource not found');

			$data = json_decode($data);
			return self::$cache[$url] = $data;
		}
	}



	class XpathrException extends Exception {
		public function asNode($node = 'xpathr', $data = array())
		{
			$xml = new XMLElement($node);
			$xml->appendChild(
				new XMLElement('message', $this->getMessage())
			);

			if (!$data) return $xml;

			$data = General::array_map_recursive('htmlentities', $data);

			$post = new XMLElement('data');
			self::buildDataNode($post, $data);
			$xml->appendChild($post);

			return $xml;
		}

		protected static function buildDataNode(XMLElement $node, $data = array())
		{
			foreach ($data as $k => $v)
			{
				$item = new XMLElement('item', null, array('key' => $k));
				if (is_array($v)) self::buildDataNode($item, $v);
				else $item->setValue($v);

				$node->appendChild($item);
			}
		}
	}
