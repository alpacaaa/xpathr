<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcefiles_by_revision extends Datasource{

		protected static $run = false;

		public $dsParamROOTELEMENT = 'files-by-revision';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'no';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'yes';
		public $dsParamREQUIREDPARAM = '$gist-id';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		public $dsParamHTMLENCODE = 'yes';

		public $dsParamFILTERS = array(
				'8' => '{$ds-revision-by-sha1}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'filename',
				'content'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-revision-by-sha1');
		}

		public function about(){
			return array(
				'name' => 'Files by Revision',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'website' => 'http://dev/xpathr',
					'email' => 'm@rcosa.mp'),
				'version' => 'Symphony 2.2.3',
				'release-date' => '2011-10-07T15:29:08+00:00'
			);
		}

		public function getSource(){
			return '3';
		}

		public function allowEditorToParse(){
			return false;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);
			$update = Xpathr::needUpdate();

			try{
				/* Force update */
				if ($update && !self::$run)
					throw new FrontendPageNotFoundException();

				include(TOOLKIT . '/data-sources/datasource.section.php');
			}
			catch(FrontendPageNotFoundException $e){
				if (self::$run)
					FrontendPageNotFoundExceptionHandler::render($e);

				self::$run = true;
				$params = Symphony::Engine()->Page()->Env();

				$id = $params['url']['gist-id'];
				$sha1 = null;

				if (isset($params['url']['sha1']))
					$sha1 = $params['url']['sha1'];

				try {
					$data = Xpathr::getRevision($id, $sha1);
				} catch (XpathrException $ex)
				{
					$result = $this->emptyXMLSet();
					return $result;
				}

				$revision_id = isset($param_pool['new-revision-id']) ?
								$param_pool['new-revision-id'] :
								end($param_pool['ds-revision-by-sha1']);


				$files = (array) $data->files;

				foreach ($files as $f)
				{
					$fields = array(
						'revision' => $revision_id,
						'filename' => $f->filename,
						'content' => $f->content
					);

					XpathrEvent::setSource(3);
					$e = new XpathrEvent();
					$e->run($fields);
				}

				return $this->grab($param_pool);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();


			return $result;
		}

	}
