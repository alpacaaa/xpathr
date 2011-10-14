

# Xpathr

A very basic explanation of the extension and what does it provide.

### Preliminary notes
The extension assumes the following url parameters to be present in your pages.

1. `gist-id` The id of the gist being viewed (or processed)
2. `sha1` The unique hash of the specific revision of a gist (not mandatory)


### Datasources
All datasources works almost the same way.

At first, the datasource will run as usual. If the data is found in the db, then it's returned.  
If the data can't be found then it's grabbed from github and stored in the db. The datasource is then run again.

You can force the db to update by appending `?update` to the url.


#### Process gist datasource
This datasource download the whole gist and store it in the filesystem.  
If the gist compiles, the result is stored as a file too.


### Events


#### Create gist
Expects `xml` and `xsl` fields to be sent via post and create a new gist.

#### Update gist
This one is a little tricky.

With this event you are able to:

1. Update existing files
2. Delete existing files
3. Rename existing files
4. Create new file

You can do multiple actions at once (i.e. renaming a file and deleting another one).

#### Update existing file

	<textarea name="files[my-filename.xml]"></textarea>
	<textarea name="files[nother-file.xml]"></textarea>
	<input type="submit" name="action[update-gist]" />

This will update both `my-filename.xml` and `nother-file.xml`.  
If you don't specifically send a file that's already stored it won't be 
deleted, it will just be retained as is, so you don't need to send the 
whole dataset everytime you make a change.


#### Delete existing file

	<input type="hidden" name="deletes[my-file-todelete.xml]" value="any value, really" />
	<input type="submit" name="action[update-gist]" />

This will remove the file `my-file-todelete.xml`.


#### Rename existing files

	<input type="text" name="rename[old-filename.xml]" value="new-filename.xml" />
	<input type="submit" name="action[update-gist]" />

This will rename `old-filename.xml` to `new-filename.xml`.


#### Create new file

	<input type="text" name="new-file[filename]" value="new-filename.xml" />
	<textarea name="new-file[content]"></textarea>
	<input type="submit" name="action[update-gist]" />

This will create a new file named `new-filename.xml`.




#### Fork a gist

	<input type="submit" name="action[fork-gist]" />

Fork the current `$gist-id`.




#### Star/Unstar a gist

	<input type="submit" name="action[star-gist]" value="Star this gist" />
	<input type="submit" name="action[unstar-gist]" value="Unstar this gist" />

Star/Unstar the current `$gist-id`.




#### Add a comment

	<textarea name="comment"></textarea>
	<input type="submit" name="action[add-comment]" />

Add a comment.



### Extra

To update gists you need a valid oauth token from github.  
The [github oauth token extension](https://github.com/symphony-dev/GitHubOAuth) provides 
an easy way to do that.
Just make sure the user has authenticated before making any changes (the extension is already integrated with it).

You might also need to register a github application to set the proper callbacks for your environment.  
Apps can be [registered here](https://github.com/account/applications) while you might find 
useful [this thread](http://symphony-cms.com/discuss/thread/78058/1/#position-9) to 
setup the oauth extension correctly.

