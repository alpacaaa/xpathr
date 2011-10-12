<?php

	require_once(TOOLKIT . '/class.event.php');
	require_once EXTENSIONS. '/xpathr/lib/class.xpathr.php';

	class eventupdate_gist extends Event
	{
		const ROOTELEMENT = 'update-gist';

		public static function about()
		{
			return array(
				'name' => 'Update Gist',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'website' => 'http://dev/xpathr',
					'email' => 'm@rcosa.mp'),
				'version' => 'Symphony 2.2.3',
				'release-date' => '2011-10-11T08:45:23+00:00',
				'trigger-condition' => 'action[update-gist]'
			);
		}

		public static function allowEditorToParse()
		{
			return false;
		}

		public function load()
		{
			if(isset($_POST['action']['update-gist'])) return $this->__trigger();
		}

		protected function __trigger()
		{
			/*
			 *
			 * $_POST['files']['filename.xml'] = 'filecontent filecontent'
			 *
			 * $_POST['deletes']['file-to-delete.xml'] = 'any value, doesnt matter'
			 *
			 * $_POST['rename']['old-file-name.xml'] = 'new-file-name.xml'
			 *
			 * $_POST['new-file']['filename'] = 'add-a-new-file-filename.xml'
			 *
			 * $_POST['new-file']['content']  = 'the content of the new file'
			 *
			 */

			$files = array();
			if (isset($_POST['files'])) $files = $_POST['files'];

			$deletes = array();
			if (isset($_POST['deletes'])) $deletes = $_POST['deletes'];

			$rename = array();
			if (isset($_POST['rename'])) $rename = $_POST['rename'];


			if (isset($_POST['new-file']))
				$files[$_POST['new-file']['filename']] = $_POST['new-file']['content'];


			$options = compact('files', 'deletes', 'rename');
			$params  = Symphony::Engine()->Page()->_param;
			$id = $params['gist-id'];

			$id = Xpathr::updateGist($id, $options);
			if ($id) redirect(URL. '/view/'. $id. '?update');
		}
	}
