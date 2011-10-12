<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcerevision_by_sha1 extends Datasource{

		protected static $run = false;

		public $dsParamROOTELEMENT = 'revision-by-sha1';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '1';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'yes';
		public $dsParamREQUIREDPARAM = '$gist-id';
		public $dsParamPARAMOUTPUT = 'system:id';
		public $dsParamSORT = 'created-at';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'3' => '{$sha1}',
				'7' => '{$ds-gist-by-id}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'created-at'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-gist-by-id');
		}

		public function about(){
			return array(
				'name' => 'Revision by sha1',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'website' => 'http://dev/xpathr',
					'email' => 'm@rcosa.mp'),
				'version' => 'Symphony 2.2.3',
				'release-date' => '2011-10-07T15:29:19+00:00'
			);
		}

		public function getSource(){
			return '2';
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

				$id = current($param_pool['ds-gist-by-id']);
				$revision = $data->history[0];
				$entry_id = null;

				if (isset($param_pool['ds-revision-by-sha1']) && !$update)
					$entry_id = end($param_pool['ds-revision-by-sha1']);

				$fields = array(
					'gist' => $id,
					'sha1' => $revision->version,
					'created-at' => $revision->committed_at
				);


				XpathrEvent::setSource(2);
				$e = new XpathrEvent();
				$e->run($fields, $entry_id);

				if (!$entry_id)
					$param_pool['new-revision-id'] = $e->getLastId();

				// run ds again
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
