function usersSummarizer() {
	# Get number of users (integer)
	num_users=$(find /home -maxdepth 1 -mindepth 1 -type d | wc -l)
		
	# Output
	echo "Users on this host: \033[34m$num_users\033[0m"
}

registerSummarizer "Users" usersSummarizer
