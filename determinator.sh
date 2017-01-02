#! /bin/bash
#
# Interactive script to determine password-types by asking a series of questions, and give format-advice correspondingly.
#
# VERSION: 1.00

###################################################################################################
# INIIALIALISATION
###################################################################################################

###
# VARIABLES
#
	VALUED='null'
	HACKABLE='null'
	FREQUENT='null'
	ADVICE='null'
	ANSWER="null"
	PASSWDCAT=0

###
# FUNCTIONS
#

	function QUESTION {
		until [ "$ANSWER" == "y" ] || [ "$ANSWER" == "n" ]; do
			case $1 in
				valued)
					echo -en 'Is the protected stuff      VALUED? [y/n]: '
					VALUED="$ANSWER"
				;;
				hackable)
					echo -en 'Is the context (website)  HACKABLE? [y/n]: '
					HACKABLE="$ANSWER"
				;;
				frequent)
					echo -en 'Is the password used     FREQUETLY? [y/n]: '
					FREQUENT="$ANSWER"
				;;
				*)
					echo -en 'Please use (valued|hackable|frequent)'
				;;
			esac
			read -n 1 ANSWER
			echo
			if [ "$ANSWER" != "y" ] && [ "$ANSWER" != "n" ]; then
				echo -e "\a > Answer with either: 'y' or 'n'!"
			else
				case $1 in
					valued)
						VALUED="$ANSWER"
						PASSWDCAT=$[$PASSWDCAT + 4]
					;;
					hackable)
						HACKABLE="$ANSWER"
						PASSWDCAT=$[$PASSWDCAT + 2]
					;;
					frequent)
						FREQUENT="$ANSWER"
						PASSWDCAT=$[$PASSWDCAT + 1]
					;;
				esac
			fi
		done
		ANSWER="null"
	}

###################################################################################################
# LOGIC
###################################################################################################

###
# Introduction
#
	clear
	echo 'PASSWORD TYPE DETERMINATOR'
	echo

###
# Questions (function)
#
	QUESTION frequent
	if [ "$FREQUENT" != "n" ]; then
		QUESTION valued
		QUESTION hackable
	fi

###
# Resulting advice
#
	if [ "$VALUED" == "y" ]; then
		VALUEDRESULT="COMPLEX"
	elif [ "$VALUED" == "n" ]; then
		VALUEDRESULT="SIMPLE"
	fi
	if [ "$HACKABLE" == "y" ]; then
		HACKABLERESULT=""
	elif [ "$HACKABLE" == "n" ]; then
		HACKABLERESULT="(exeption possible)"
	fi
	if [ "$FREQUENT" == "y" ]; then
		FREQUENTRESULT="SYSTEMATIC"
	elif [ "$FREQUENT" == "n" ]; then
		FREQUENTRESULT="RANDOM"
	fi

###
# Advice presentation
#

	ADVICE="$VALUEDRESULT $FREQUENTRESULT $HACKABLERESULT"
	echo
	echo ">>> $ADVICE"
