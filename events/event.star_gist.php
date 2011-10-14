<?php

	require_once(TOOLKIT . '/class.event.php');
	require_once EXTENSIONS. '/xpathr/lib/class.xpathr.php';

	class eventstar_gist extends Event
	{
		const ROOTELEMENT = 'star-gist';

		public static function about()
		{
			return array(
				'name' => 'Star/Unstar Gist',
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
			if (isset($_POST['action']['star-gist']) || isset($_POST['action']['unstar-gist']))
				return $this->__trigger();
		}

		protected function __trigger()
		{
			$params  = Symphony::Engine()->Page()->_param;
			$id = $params['gist-id'];

			$action = 'star';
			if (isset($_POST['action']['unstar-gist']))
				$action = 'unstar';

			Xpathr::starGist($id, $action);
		}
	}
