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

		public function getSubscribedDelegates()
		{
			return array(
				array(
                    'page' => '/frontend/',
                    'delegate' => 'FrontendParamsResolve',
                    'callback' => 'FrontendParamsResolve'
                )
			);
		}

		public function FrontendParamsResolve($context)
		{
			$cookie = self::githubCookie();
			if (!$token = $cookie->get('token')) return;

			self::storeGithubUser($token, $cookie);
			$context['params']['github-user'] = $cookie->get('user');
		}

		protected static function githubCookie()
		{
			return new Cookie('github', TWO_WEEKS, __SYM_COOKIE_PATH__, null, true);
		}

		protected static function storeGithubUser($token, $cookie)
		{
			if ($cookie->get('user')) return;

			$user = Xpathr::getUser($token);
			$cookie->set('user', $user->login);
		}
	}
