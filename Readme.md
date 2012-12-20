# Setting up
Setup is a fairly straightforward task if you've ever used our particular blend of technologies before. If you haven't, you're in for a treat hopefully!

## Fulfilling Installation requirements
You will need the following set up:
* node.js
* git
* npm

Everything else is bundled with the application itself, or pulled in via npm.

## Getting the Repository
If you have git:

    git clone https://github.com/jkuetemeier/Node-Express-Angular-Coffee-Bootstrap.git

Then lets nagivate into the repo:

    cd Node-Express-Angular-Coffee-Bootstrap

## Pulling in Dependencies
Since we're in the root directory of the repo, we can tell npm to install all of the neccessary dependencies.

    npm install

npm will read our `package.json` file to fetch everything we need.

For convienence, you should also install `coffee-script` globally:

    sudo npm install -g coffee-script

## Make a config
Due to security concerns, we don't include a configuration file, which contains all app-specific configuration details.
Thankfully, it's easy to make your own!

In `config.js`:

    module.exports = {
		port: $yourPortHere,
    	secret: $yourSecretHere,
    	cookieSecret: $yourCookieSecretHere
    };

## Test it out
Lets test our installation by executing `coffee app.coffee`

    $> coffee server.coffee
    Express server listening on port 8080

## Relax
You're done! Check back later for more exciting progress! Feel free to suggest improvements by opening an issue or submitting a pull request!

# Thanks
This Template was initially based on (forked from) the [Hoverbear/Angular-Coffee-Express](https://github.com/Hoverbear/Angular-Coffee-Express),
which saved me a lot of time. Thank you Andrew Hobden for doing a great job.

## Thanks the contributors to the following Open Source Technologies:

### Markdown
* Summary:

  > Markdown is a text-to-HTML conversion tool for web writers.
  > Markdown allows you to write using an easy-to-read,
  > easy-to-write plain text format, then convert it to structurally valid XHTML (or HTML).
* Site: [http://daringfireball.net/projects/markdown](http://daringfireball.net/projects/markdown)
* Doc: [http://daringfireball.net/projects/markdown/syntax](http://daringfireball.net/projects/markdown/syntax)
* Licence: [BSD-Style](http://daringfireball.net/projects/markdown/license)

### stylus
* Site: [http://learnboost.github.com/stylus/](http://learnboost.github.com/stylus/)
* Doc:
* GitHub: [https://github.com/learnboost/stylus](https://github.com/learnboost/stylus)

### ... and others

* coffee-script
* jade
* express
* node.js
* npm
* angular.js
* connect
* git
* linux

etc.