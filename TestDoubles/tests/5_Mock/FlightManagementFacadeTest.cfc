// http://xunitpatterns.com/Mock%20Object.html

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


	 public void function testRemoveFlight_Mock() {
		var REMOVE_FLIGHT_ACTION_CODE = "RF";
		var TEST_USER_NAME = "Ed";

		// setup
		var expectedFlightDto = createAnUnregFlight();

		// mock configuration
		var auditLogMock = new AuditLogMock();
		auditLogMock.setExpectedLogMessage(
			TEST_USER_NAME,
			REMOVE_FLIGHT_ACTION_CODE,
			expectedFlightDto.getFlightNumber()
		);
		auditLogMock.setExpectedNumberCalls( 1 );

		// mock installation
		var flightManagementFacade = new TestDoubles.FlightManagementFacadeImpl();
		flightManagementFacade.setAuditLog( auditLogMock );

		// exercise
		flightManagementFacade.removeFlight( expectedFlightDto.getFlightNumber() );

		// verify
		$assert.isFalse( flightManagementFacade.flightExists( expectedFlightDto.getFlightNumber() ) );
		auditLogMock.verify();
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

}