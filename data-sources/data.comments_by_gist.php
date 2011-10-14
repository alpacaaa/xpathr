<?php

	require_once(TOOLKIT . '/class.datasource.php');

	class datasourcecomments_by_gist extends Datasource
	{

		public $dsParamROOTELEMENT = 'comments-by-gist';

		public function about(){
			return array(
				'name' => 'Comments by gist',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'website' => 'http://dev/xpathr',
					'email' => 'm@rcosa.mp'),
				'version' => 'Symphony 2.2.3',
				'release-date' => '2011-10-14T12:47:53+00:00'
			);
		}

		public function allowEditorToParse(){
			return false;
		}

		public function grab(&$param_pool=NULL){
			$update = Xpathr::needUpdate();

			$params = Symphony::Engine()->Page()->Env();
			$id = $params['url']['gist-id'];

			$cache = new Cacheable(Symphony::Database());
			$key  = md5('xpathr-comments-'. $id);
			$data = $cache->check($key);

			if ($data && !$update) return $this->send($data['data']);

			$comments = Xpathr::getComments($id);
			if (!$comments) return $this->emptyXMLSet();

			$list = '';
			foreach ($comments as $c)
			{
				$attributes = array(
					'id' => $c->id,
					'updated-at' => $c->updated_at,
					'user' => $c->user->login
				);

				$node  = new XMLElement('entry', $c->body, $attributes);
				$list .= $node->generate(). "\n";
			}

			$cache->write($key, $list);
			return $this->send($list);
		}

		protected function send($data)
		{
			return new XMLElement($this->dsParamROOTELEMENT, $data);
		}
	}
