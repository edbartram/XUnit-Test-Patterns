component accessors=true {

	property name="timeProvider";

	public TimeDisplay function init() {
		setTimeProvider( new TimeProvider() );

		return this;
	}

	public string function getCurrentTimeAsHtmlFragment() {
		var time = getTimeProvider().getTime();
		var html = '<span class="tinyBoldText">';

		if ( hour( time ) == 0 && minute( time ) <= 1 ) {
			html &= "Midnight";
		} else if ( hour( time ) == 12 && minute( time ) == 0 ) {
			html &= "Noon";
		} else {
			html &= timeFormat( time, "h:mm tt" );
		}

		html &= "</span>";

		return html;
	}

}