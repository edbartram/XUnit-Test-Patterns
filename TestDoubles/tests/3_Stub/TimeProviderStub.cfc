component {

	property name="myTime" type="string";

	public TimeProviderStub function init( numeric hours=0, numeric minutes=0 ) {
		setTime( arguments.hours, arguments.minutes );

		return this;
	}

	// Configuration Interface:
	public void function setTime( required numeric hours, required numeric minutes ) {
		variables.myTime = createTime( arguments.hours, arguments.minutes, 0 );
	}

	// Interface used by SUT
	public string function getTime() {
		// @return The last time that was set:
		return myTime;
	}

	public string function setHours( required numeric hours ) {
		setTime( arguments.hours, minute( getTime() ), second( getTime() ) );
	}

	public string function setMinutes( required numeric minutes ) {
		setTime( hour( getTime() ), arguments.minutes, second( getTime() ) );
	}

}