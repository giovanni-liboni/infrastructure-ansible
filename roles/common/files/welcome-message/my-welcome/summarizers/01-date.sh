function dateSummarizer() {
	echo -n "\033[34m"
	date
}

registerSummarizer "Date" dateSummarizer
