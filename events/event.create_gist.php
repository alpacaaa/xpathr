<?php

	require_once(TOOLKIT . '/class.event.php');
	require_once EXTENSIONS. '/xpathr/lib/class.xpathr.php';

	class eventcreate_gist extends Event
	{
		const ROOTELEMENT = 'create-gist';

		public static function about()
		{
			return array(
				'name' => 'Create Gist',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'website' => 'http://dev/xpathr',
					'email' => 'm@rcosa.mp'),
				'version' => 'Symphony 2.2.3',
				'release-date' => '2011-10-07T15:09:08+00:00',
				'trigger-condition' => 'action[save-gist]'
			);
		}

		public static function allowEditorToParse()
		{
			return false;
		}

		public function load()
		{
			if(isset($_POST['action']['create-gist'])) return $this->__trigger();
		}

		protected function __trigger()
		{
			$xml = $_POST['xml'];
			$xsl = $_POST['xsl'];

			$id = Xpathr::createGist($xml, $xsl);
			if ($id) redirect(URL. '/view/'. $id);

			//die('error!');
		}
	}
