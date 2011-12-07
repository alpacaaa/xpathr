<?php

	require_once(TOOLKIT . '/class.event.php');

	Class eventview_gist extends Event{

		const ROOTELEMENT = 'view-gist';

		public $eParamFILTERS = array(
			
		);

		public static function about(){
			return array(
				'name' => 'View Gist',
				'author' => array(
					'name' => 'Stephen Bau',
					'website' => 'http://domain7.com/',
					'email' => 'stephen@domain7.com'),
				'version' => 'Symphony 2.2.5',
				'release-date' => '2011-12-05T00:02:00+00:00',
				'trigger-condition' => 'action[view-gist]'
			);
		}

		public static function allowEditorToParse(){
			return false;
		}

		public static function documentation(){
			return '
				<h3>View Gist</h3>
				<p>An event to redirect on submit.</p>';
		}

		public function load(){
			if(isset($_POST['action']['view-gist'])) return $this->__trigger();
		}

		protected function __trigger(){
			if(isset($_POST['gist-id'])) {
				$gist_id = $_POST['gist-id'];
				$gist_url = 'https://gist.github.com/';
				
				if(strpos($gist_id, $gist_url) !== false) {
					$gist_id = str_replace($gist_url, '', $gist_id);
				}
				redirect(URL . '/view/' . $gist_id . '/');
			}
		}

	}
