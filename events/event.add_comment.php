<?php

	require_once(TOOLKIT . '/class.event.php');
	require_once EXTENSIONS. '/xpathr/lib/class.xpathr.php';

	class eventadd_comment extends Event
	{
		const ROOTELEMENT = 'add-comment';

		public static function about()
		{
			return array(
				'name' => 'Add Comment',
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
			if(isset($_POST['action']['add-comment'])) return $this->__trigger();
		}

		protected function __trigger()
		{
			$params  = Symphony::Engine()->Page()->_param;
			$id = $params['gist-id'];

			$comment = $_POST['comment'];
			Xpathr::addComment($id, $comment);
		}
	}
