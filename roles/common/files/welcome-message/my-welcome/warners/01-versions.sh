###
# Fetches version strings of a bin in $PATH and of the latest package version,
# compares them and adds the result to $newVersions
#
# Globals:
#   $newVersions
# Arguments:
#   $package string Directory in /package/host/localhost/ of the package
#   $label   string User-readable label for the package
#   $parser  string A command to apply to the version string (like "node --version | sed ...")
# Returns:
#   None
###
newVersions=""
function checkForNewVersion {
	package="$1"
	label="$2"
	parser="$3"
	
	# Run the parser on the bin in $PATH and on the package bin
	currentVersion="$(eval $parser)"
	recommendedVersion="$(eval "/package/host/localhost/$package/bin/"$parser)"
	
	# Check if the two strings differ
	if [[ "$currentVersion" != "$recommendedVersion" ]]; then
		newVersions+="\033[34m$label\033[0m (\033[34m$currentVersion\033[0m -> \033[34m$recommendedVersion\033[0m)\n"
	fi
}

# ------------------
# Check for packages

# Ruby
checkForNewVersion "ruby" "Ruby" "ruby -v | sed 's/ruby \(.*\?\) (.*/\1/'"

# Node.js
checkForNewVersion "nodejs" "Node.js" "node -v | sed 's/v\([0-9]\+\.[0-9]\+\.[0-9]\+\)/\1/'"

# PHP
checkForNewVersion "php" "PHP" "php -v | grep 'built:' | sed 's/PHP \([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/'"

# ------
# Output

# Build a string for output if at least one version is outdated
if [[ -n "$newVersions" ]]; then
	echo -e "\033[1;35mThe recommended version for the following packages changed:\033[0m"
	echo -e "$newVersions"
fi
