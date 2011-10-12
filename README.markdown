# How to install

## Required extensions
1. [xpathr](https://github.com/alpacaaa/xpathr)
2. [github oauth](https://github.com/symphony-dev/GitHubOAuth)

## Steps to install
1. Install symphony as usual (init submodules too)
2. Install required extensions
3. Import workspace/xpathr.sql into db
4. Register a [github oauth application](https://github.com/account/applications)
using your domain url for both callback fields (things like `http://localhost/` are fine)
5. Configure github oauth extension using (replace `$root` where appropriate):
	
	Redirect URL (after confirmation): $root/symphony/extension/githuboauth/authorize/
	Redirect URL (after authentication): $root (but could be any value)
6. Make sure to have the `Gist` scope selected.


That should be it. Enjoy your brand new xpathr app ;)
