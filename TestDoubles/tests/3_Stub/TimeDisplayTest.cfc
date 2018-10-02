// http://xunitpatterns.com/Test%20Stub.html

component extends="testbox.system.BaseSpec" {

public void function testDisplayCurrentTime_AtMidnight() {
	var timeDisplay = new TestDoubles.TimeDisplay();

	var actualTimeString = timeDisplay.getCurrentTimeAsHtmlFragment();

	var expectedTimeString = '<span class="tinyBoldText">Midnight</span>';
	$assert.isEqual( expectedTimeString, actualTimeString );
}

	public void function testDisplayCurrentTime_whenever() {
		// fixture setup
		var timeDisplay = new TestDoubles.TimeDisplay();

		// exercise sut
		var actualTime = timeDisplay.getCurrentTimeAsHtmlFragment();

		// verify outcome
		var time = new TestDoubles.TimeProvider();
		var expectedTime = '<span class="tinyBoldText">';
		if ( time.getHourOfDay() == 0 && time.getMinute() <= 1 ) {
			expectedTime &= "Midnight";
		} else if ( time.getHourOfDay() == 12 && time.getMinute() == 0 ) {
			expectedTime &= "Noon";
		} else {
			expectedTime &= timeFormat( time.getTime(), "h:mm tt" );
		}
		expectedTime &= "</span>";
		$assert.isEqual( expectedTime, actualTime );
	 }


	 public void function testDisplayCurrentTime_withStub() {
		// Fixture setup:
		// Test Double configuration
		var timeProviderStub = new TimeProviderStub();
		timeProviderStub.setHours( 0 );
		timeProviderStub.setMinutes( 0 );

		// Instantiate SUT:
		var timeDisplay = new TestDoubles.TimeDisplay();

		// Test Double installation
		timeDisplay.setTimeProvider( timeProviderStub );

		// exercise sut
		var actualTimeString = timeDisplay.getCurrentTimeAsHtmlFragment();

		// verify outcome
		var expectedTimeString = '<span class="tinyBoldText">Midnight</span>';
		$assert.isEqual( expectedTimeString, actualTimeString );
	 }

	 public function testStubTimeProvider() {
		var timeProviderStub = createStub( extends="TestDoubles.TimeProvider" );

		timeProviderStub.$property( propertyName="hours", mock=3 );
		timeProviderStub.$property( propertyName="minutes", mock=14 );
		timeProviderStub.$( method="getHourOfDay", returns=25 );

		$assert.isEqual( 3, timeProviderStub.getHours() );
		$assert.isEqual( 14, timeProviderStub.getMinutes() );
		$assert.isEqual( 25, timeProviderStub.getHourOfDay() );
	}
}