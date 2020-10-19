# Steam Dedicated Server Docker Template

A repo to save time setting up new docker images.

## Usage

1. Create a new repo from this template (see [here](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template)).
2. Run `sed -i -e 's/GAME_NAME/<name of your game, or an abbreviation>/g' Dockerfile`
3. Go through the `Dockerfile` and address all the comments prepended with `SETUP:`
4. Rewrite this `README` file
