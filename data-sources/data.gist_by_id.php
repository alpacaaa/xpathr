<?php

	require_once(TOOLKIT . '/class.datasource.php');
	require_once EXTENSIONS. '/xpathr/lib/class.xpathr.php';

	Class datasourcegist_by_id extends Datasource{

		protected static $run = false;

		public $dsParamROOTELEMENT = 'gist-by-id';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '1';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'yes';
		public $dsParamREQUIREDPARAM = '$gist-id';
		public $dsParamPARAMOUTPUT = 'system:id';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public $dsParamFILTERS = array(
				'1' => '{$gist-id}',
		);

		public $dsParamINCLUDEDELEMENTS = array(
				'title', 'user', 'revisions-list', 'forks-list'
		);


		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}

		public function about(){
			return array(
				'name' => 'Gist by id',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'website' => 'http://dev/xpathr',
					'email' => 'm@rcosa.mp'),
				'version' => 'Symphony 2.2.3',
				'release-date' => '2011-10-07T15:27:47+00:00'
			);
		}

		public function getSource(){
			return '1';
		}

		public function allowEditorToParse(){
			return false;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);
			$update = Xpathr::needUpdate();

			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');

				/* Force update */
				if ($update && !self::$run)
					throw new FrontendPageNotFoundException();
			}
			catch(FrontendPageNotFoundException $e){
				/* Grab gist from github! */
				if (self::$run)
					FrontendPageNotFoundExceptionHandler::render($e);

				self::$run = true;
				$params = Symphony::Engine()->Page()->Env();
				$id = $params['url']['gist-id'];

				try {
					$data = Xpathr::getGist($id);
				} catch (XpathrException $ex)
				{
					// Gist not found .-.
					$result = $this->emptyXMLSet();
					return $result;
				}

				$entry_id = null;
				$revisions_list = null;
				$forks_list = null;

				// Gist has already been saved?
				if (isset($param_pool['ds-gist-by-id']))
					$entry_id = current($param_pool['ds-gist-by-id']);

				if (!$params['url']['sha1'])
				{
					// store revisions list
					$list = array();
					foreach ($data->history as $rev)
					{
						$attributes = array(
							'version' => $rev->version,
							'committed-at' => $rev->committed_at
						);

						$changes = new XMLElement('changes', null, (array) $rev->change_status);
						$node = new XMLElement('revision', null, $attributes);
						
						$node->appendChild($changes);
						$list[] = $node->generate();
					}

					$revisions_list = join("\n", $list);


					// store forks list
					if (!$data->forks) $data->forks = array();

					$list = array();
					foreach ($data->forks as $f)
					{
						$attributes = array(
							'id' => $f->id,
							'user' => $f->user->login,
							'updated-at' => $f->updated_at
							
						);

						$node = new XMLElement('fork', null, $attributes);
						$list[] = $node->generate();
					}

					$forks_list = join("\n", $list);
				}

				// Gist exists!
				$fields = array(
					'gist-id' => $id,
					'user' => $data->user->login,
					'title' => $data->description,
					'revisions-list' => $revisions_list,
					'forks-list' => $forks_list
				);


				XpathrEvent::setSource(1);
				$e = new XpathrEvent();
				$e->run($fields, $entry_id);

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
