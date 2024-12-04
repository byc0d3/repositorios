#!/bin/bash

# Define an array with the URLs of the repositories you want to clone
repos=(
	"git@github.com:byc0d3/repositorios.git"
	"git@github.com:byc0d3/tools.git"
	"git@github.com:byc0d3/workspaces.git"
	"git@github.com:byc0d3/cne.git"
)

# Loop through the array and clone each repository
for repo in "${repos[@]}"
do
	git clone "$repo"
done

echo "Todos los repositorios han sido clonados."
