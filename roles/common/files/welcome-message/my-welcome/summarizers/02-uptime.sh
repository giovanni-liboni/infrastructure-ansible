function uptimeSummarizer() {
	# Get the uptime in seconds depending on the kernel
	if [[ "$(uname -s)" == 'Darwin' ]]; then
		# OS X
		# kern.boottime is an absolute timestamp
		bootTime="$(sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//g')"
		currentTime="$(date +%s)"
		uptime="$(($currentTime - $bootTime))"
	elif [[ -f /proc/uptime ]]; then
		# Linux
		uptime="$(cat /proc/uptime)"
		uptime="${uptime%%.*}"
	else
		# We don't have a handler for that
		# If you need one, please create an issue at
		# https://github.com/lukasbestle/my-welcome/issues
		echo "\033[31mUnsupported environment, can't get uptime. :(\033[0m"
		exit 1
	fi
	
	# Parse into units
	seconds="$((uptime % 60))"
	minutes="$((uptime / 60 % 60))"
	hours="$((  uptime / 60 / 60 % 24))"
	days="$((   uptime / 60 / 60 / 24 % 30))"
	months="$(( uptime / 60 / 60 / 24 / 30 % 12))"
	years="$((  uptime / 60 / 60 / 24 / 30 / 12))"
	
	# Output depending on the scale of the uptime
	if [[ years -ge 1 ]]; then
		outputYears=true
		outputMonths=true
		outputDays=true
	elif [[ months -ge 1 ]]; then
		outputMonths=true
		outputDays=true
	elif [[ days -ge 1 ]]; then
		outputDays=true
		outputHours=true
		outputMinutes=true
	elif [[ hours -ge 1 ]]; then
		outputHours=true
		outputMinutes=true
	elif [[ minutes -ge 1 ]]; then
		outputMinutes=true
		outputSeconds=true
	else
		outputSeconds=true
	fi
	
	# Output each element
	output=''
	if [[ "$outputYears" == true ]]; then
		output+="\033[34m$years"
		if [[ "$years" == 1 ]]; then
			output+=' year\033[0m\n'
		else
			output+=' years\033[0m\n'
		fi
	fi
	
	if [[ "$outputMonths" == true ]]; then
		output+="\033[34m$months"
		if [[ "$months" == 1 ]]; then
			output+=' month\033[0m\n'
		else
			output+=' months\033[0m\n'
		fi
	fi
	
	if [[ "$outputDays" == true ]]; then
		output+="\033[34m$days"
		if [[ "$days" == 1 ]]; then
			output+=' day\033[0m\n'
		else
			output+=' days\033[0m\n'
		fi
	fi
	
	if [[ "$outputHours" == true ]]; then
		output+="\033[34m$hours"
		if [[ "$hours" == 1 ]]; then
			output+=' hour\033[0m\n'
		else
			output+=' hours\033[0m\n'
		fi
	fi
	
	if [[ "$outputMinutes" == true ]]; then
		output+="\033[34m$minutes"
		if [[ "$minutes" == 1 ]]; then
			output+=' minute\033[0m\n'
		else
			output+=' minutes\033[0m\n'
		fi
	fi
	
	if [[ "$outputSeconds" == true ]]; then
		output+="\033[34m$seconds"
		if [[ "$seconds" == 1 ]]; then
			output+=' second\033[0m\n'
		else
			output+=' seconds\033[0m\n'
		fi
	fi
	
	# Replace newlines with a comma
	echo "Host up for $(echo -ne "$output" | paste -s -d ';' - | sed "s/\;/\, /g")"
}

registerSummarizer "Uptime" uptimeSummarizer
