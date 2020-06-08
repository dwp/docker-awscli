# dataworks-repo-template
Template repository for DataWorks GitHub

This repo contains the Makefile to fit the standard pattern.
This repo will be used as a base to create new non-Terraform repos, upon which the user runs make initial-commit, adding the githooks submodule, making the repo ready for use.

### Initialisation steps
Welcome to your new DataWorks GitHub repository.

Please run:  
`make initial-commit`
to begin using your repository.  

The `initial-commit` will create a PR adding the `dataworks-githooks` submodule to the `.githooks` folder.  For more info see: [dataworks-githooks](https://github.com/dwp/dataworks-githooks)