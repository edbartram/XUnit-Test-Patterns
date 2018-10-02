component accessors="true" {

	property name="hours" type="numeric";
	property name="minutes" type="numeric";

	public TimeProvider function init() {
		setHours( hour( now() ) );
		setMinutes( minute( now() ) );

		return this;
	}

	public string function getTime() {
		return "#getHours()#:#getMinutes()#";
	}

	public string function getHourOfDay() {
		return hour( getTime() );
	}
}