// http://xunitpatterns.com/Test%20Spy.html

component extends="testbox.system.BaseSpec" {

	public void function testRemoveFlight() {
		// setup
		var expectedFlightDto = createARegisteredFlight();
		var flightManagementFacade = new TestDoubles.FlightManagementFacadeImpl();

		// exercise
		flightManagementFacade.removeFlight( expectedFlightDto.getFlightNumber() );

		// verify
		$assert.isFalse( flightManagementFacade.flightExists( expectedFlightDto.getFlightNumber() ) );
	}

	public void function testRemoveFlightLogging_recordingSpy() {
		var REMOVE_FLIGHT_ACTION_CODE = "RF";
		var TEST_USER_NAME = "Ed";

		// setup
		var expectedFlightDto = createAnUnregFlight();
		var flightManagementFacade = new TestDoubles.FlightManagementFacadeImpl();

		// Test Double setup
		var auditLogSpy = new AuditLogSpy();
		flightManagementFacade.setAuditLog( auditLogSpy );

		// exercise
		flightManagementFacade.removeFlight( expectedFlightDto.getFlightNumber() );

		// verify
		$assert.isFalse( flightManagementFacade.flightExists( expectedFlightDto.getFlightNumber() ) );
		$assert.isEqual( 1, auditLogSpy.getNumberOfCalls() );
		$assert.isEqual( REMOVE_FLIGHT_ACTION_CODE, auditLogSpy.getActionCode() );
		$assert.isEqual( getTodaysDateWithoutTime(), auditLogSpy.getDate() );
		$assert.isEqual( TEST_USER_NAME, auditLogSpy.getUser() );
		$assert.isEqual( expectedFlightDto.getFlightNumber(), auditLogSpy.getDetail() );
	 }

	 public function testSpyAuditLog() {
		// setup
		var auditLogStub = createStub( extends="TestDoubles.AuditLog" );
		auditLogStub.init();
		auditLogStub.$( "logMessage" );

		var flightManagementFacade = new TestDoubles.FlightManagementFacadeImpl();
		flightManagementFacade.setAuditLog( auditLogStub );

		// exercise
		flightManagementFacade.removeFlight( "Dummy Flight Number" );
		var numberOfCalls = auditLogStub.$count( "logMessage" );

		// verify
		$assert.isEqual( 1, numberOfCalls );
	}

	public function testSpyMakePublic() {
		var flightMgmt = new TestDoubles.FlightManagementFacadeImpl();
		prepareMock( flightMgmt );
		makePublic( flightMgmt, "myPrivateMethod" );

		var results = flightMgmt.myPrivateMethod();

		$assert.isNotEmpty( results );
	}


	/* ==================================================================================================== */
	/* Helper functions assumed, not shown in book examples                                                 */
	/* ==================================================================================================== */

	private struct function createARegisteredFlight() {
		var flightDtoFake = createStub();
		var getFlightNumber = "Fake Flight Number";
		flightDtoFake.$( method="getFlightNumber", returns=getFlightNumber );

		return flightDtoFake;
	}

	private struct function createAnUnregFlight() {
		var flightDtoFake = createStub();
		var getFlightNumber = "Fake Flight Number";
		flightDtoFake.$( method="getFlightNumber", returns=getFlightNumber );

		return flightDtoFake;
	}

	private string function getTodaysDateWithoutTime() {
		return dateFormat( now() );
	}

}