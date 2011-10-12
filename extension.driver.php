<?php

	require_once EXTENSIONS. '/xpathr/lib/class.xpathr.php';

	class extension_xpathr extends Extension
	{
		public function about()
		{
			return array(
				'name' => 'Xpathr',
				'version' => '0.1',
				'author' => array(
					'name'  => 'Marco Sampellegrini',
					'email' => 'm@rcosa.mp'
				)
			);
		}
	}
