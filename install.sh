#!/usr/bin/env bash

category=$1

# Array contains function
array_contains () {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${array[@]}"; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}

# List installed packages
# WIP installed_packages=$(apm ls -i -b | sed 's/')

package_list=$(cat ./packages.json | jq -c -r ".${category}[]")
echo "Going to install the following packages: "$package_list

for row in $package_list; do
  #array_contains installed_packages $row && echo yes || echo no
  apm install $row
done
