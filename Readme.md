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

    git clone https://github.com/Hoverbear/Angular-Coffee-Express.git

Then lets nagivate into the repo:

    cd Angular-Coffee-Express

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
Thanks the contributors to the following Open Source Technologies:
* coffee-script
* express
* node.js
* npm
* angular.js
* connect
* git
* linux
* jade
