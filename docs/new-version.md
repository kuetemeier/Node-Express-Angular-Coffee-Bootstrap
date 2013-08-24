# Create a new version

Just some thoughts to be reminded, when creating a new version in github.

* Edit master branch (or create version branch)
* change version information in the following files:
    * (/package.json)
    * (/client/src/js/services.coffee)
* if not already exists, create version branch
    git checkout -b x.y.z
* make last changes and commit them
* push the branch to github
    git push origin x.y.z