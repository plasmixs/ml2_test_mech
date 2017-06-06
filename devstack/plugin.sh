#!/usr/bin/env bash
# plugin.sh - DevStack plugin.sh dispatch script

function install_test_mech {
	echo "Install test_mech"
    	setup_develop $DEST/ml2_test_mech
}

function init_test_mech {
	echo "Init test_mech"
}

function configure_test_mech {
	echo "Configure test_mech"
	#Q_ML2_PLUGIN_MECHANISM_DRIVERS+=',genericswitch'
	#populate_ml2_config /$Q_PLUGIN_CONF_FILE ml2 mechanism_drivers=$Q_ML2_PLUGIN_MECHANISM_DRIVERS
}

# check for service enabled
if is_service_enabled test_mech; then

	if [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
		# Set up system services
		echo_summary "Configuring system services Test_Mech"

	elif [[ "$1" == "stack" && "$2" == "install" ]]; then
		# Perform installation of service source
		echo_summary "Installing Test_Mech"
		install_test_mech

	elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
		# Configure after the other layer 1 and 2 services have been configured
		echo_summary "Configuring Test_Mech"
		configure_test_mech

	elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
		# Initialize and start the test_mech service
		echo_summary "Initializing Test_Mech"
		init_test_mech
	fi

	if [[ "$1" == "unstack" ]]; then
		# Shut down test_mech services
		# no-op
		:
	fi

	if [[ "$1" == "clean" ]]; then
		# Remove state and transient data
		# Remember clean.sh first calls unstack.sh
		# no-op
		:
	fi
fi
