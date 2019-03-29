#!/usr/bin/env bash

category=$1

# Array contains function
array_contains () {
  local seeking=$1
  shift
  local array=("$@")
  in=0
  for element in "${array[@]}"; do
    if [[ $element == $seeking ]]; then
        in=1
        break
    fi
  done
  echo $in
}

# List installed packages
installed_packages=($(apm ls -i -b | sed 's/\(.*\)@.*/\1/'))

# List packages to install
package_list=($(cat ./packages.json | jq -c -r ".${category}[]"))
echo "Going to install the following packages: "${package_list[@]}

for row in ${package_list[@]}; do
  installed=$(array_contains $row "${installed_packages[@]}")
  if [[ $installed -eq 0 ]]; then
    echo "Installing $row..."
    apm install $row
  else
    echo "$row already installed. Skipping..."
  fi
done
