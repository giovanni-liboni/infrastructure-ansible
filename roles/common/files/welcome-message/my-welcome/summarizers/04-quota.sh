function quotaSummarizer() {
	# Get current quota information in MB (integers) and % of total
	quota_used=$(quota -lgs | grep '/dev/' | sed 's/      \/dev\/[a-z]\+[0-9] \+\([0-9]\+\?\)M.*/\1/')
	quota_total=$(quota -lgs | grep '/dev/' | sed 's/      \/dev\/[a-z]\+[0-9] \+[0-9]\+\?M \+\([0-9]\+\?\)M.*/\1/')
	quota_free=$(( $quota_total - $quota_used ))
	quota_percentage=$(( $quota_used * 100 / $quota_total ))
	
	echo "Used \033[34m$quota_used MB\033[0m of \033[34m$quota_total MB\033[0m (\033[34m$quota_percentage %\033[0m)"
	echo "\033[34m$quota_free MB\033[0m available"
}

registerSummarizer "Quota" quotaSummarizer
