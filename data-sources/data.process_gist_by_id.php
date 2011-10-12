<?php

	require_once(TOOLKIT . '/class.datasource.php');

	class datasourceprocess_gist_by_id extends Datasource
	{
		public $dsParamROOTELEMENT = 'process-gist-by-id';
		protected $errors = array();

		protected static $allowed_extensions = array('.xml', '.xsl', '.markdown', '.html', '.css', 'js');

		public function about(){
			return array(
				'name' => 'Process Gist by id',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'website' => 'http://dev/xpathr',
					'email' => 'm@rcosa.mp'),
				'version' => 'Symphony 2.2.3',
				'release-date' => '2011-10-10T12:34:59+00:00'
			);
		}

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-gist-by-id');
		}

		public function allowEditorToParse(){
			return false;
		}

		public function grab(&$param_pool=NULL){
			$update = Xpathr::needUpdate();

			try
			{
				$params = Symphony::Engine()->Page()->Env();
				$id = $params['url']['gist-id'];
				$revision = isset($params['url']['sha1']) ? $params['url']['sha1'] : null;

				$dir = Xpathr::getSnippetsDir($id, $revision). '/';
				if (!is_dir($dir) || $update) self::downloadGist($id, $revision);


				if (!is_dir($dir))
					throw new XpathrException('Folder does not exist.');

				if (!file_exists($dir. 'master.xml'))
					throw new XpathrException('Missing master.xml file.');

				if (!file_exists($dir. 'master.xsl'))
					throw new XpathrException('Missing master.xsl file.');

				// Grab cached data (if any)
				$cached = $dir. '.xpathr_result';
				if (!$update && file_exists($cached))
					return $this->send(file_get_contents($cached));


				set_error_handler(array($this, 'logErrors'));
				$this->errors = array();

				$xsl = new DOMDocument();
				$xsl->load($dir. 'master.xsl');

				if ($this->errors) $this->throwEx();

				$xml = new DOMDocument();
				$xml->load($dir. 'master.xml');

				if ($this->errors) $this->throwEx();

				$proc = new XSLTProcessor();
				$proc->importStylesheet($xsl);

				if ($this->errors) $this->throwEx();
				restore_error_handler();

				$processed = $proc->transformToXML($xml);

				// cache result
				file_put_contents($dir. '.xpathr_result', $processed);

			}
			catch(Exception $e){
				$result = new XMLElement($this->dsParamROOTELEMENT);
				$result->appendChild(new XMLElement('message', $e->getMessage()));

				if (!$this->errors) return $result;

				$errors = new XMLElement('errors');
				foreach ($this->errors as $e)
				{
					$e = new XMLElement('error', $e);
					$errors->appendChild($e);
				}

				$result->appendChild($errors);
				return $result;
			}

			return $this->send($processed);
		}


		public function logErrors($n, $msg, $file, $line)
        {
			$pos = strpos($msg, ']:');
			if ($pos !== false) $msg = substr($msg, $pos +2);

			$this->errors[] = $msg;
        }

        public static function downloadGist($id, $revision)
        {
        	$dir = Xpathr::getSnippetsDir($id, $revision). '/';
        	mkdir($dir, 0777, $recursive = true);

        	if (!is_dir($dir))
				throw new XpathrException('Unable to create folder.');

			$data = Xpathr::getRevision($id, $revision);
			if (!$data->files) return;

			foreach ($data->files as $f)
			{
				$ext = strrpos($f->filename, '.');
				if ($ext === false) continue;

				$ext = substr($f->filename, $ext);

				if (in_array($ext, self::$allowed_extensions))
					file_put_contents($dir. $f->filename, $f->content);
			}
        }

		public function send($str)
		{
			$result = new XMLElement($this->dsParamROOTELEMENT);
			$node = new XMLElement('result', htmlentities($str));

			$result->appendChild($node);
			return $result;
		}

		protected function throwEx()
		{
			throw new XpathrException('An error occurred.');
		}
	}
