function ramSummarizer() {
	# Get current RAM usage in MB (integer)
	ram_used=$(ps -u $USER -o rss= | awk '{rss += $1} END {printf("%0.f", rss / 1000)}')
	
	echo "\033[34m$ram_used MB\033[0m used"
}

registerSummarizer "RAM" ramSummarizer
