// http://xunitpatterns.com/Mock%20Object.html

component extends="testbox.system.BaseSpec" {

	public void function testReadWrite() {
		// Setup:
		var flightManagementFacade = new TestDoubles.FlightManagementFacadeImpl();

		// Exercise:
		var YYC = flightManagementFacade.createAirport( "YYC", "Calgary", "Calgary" );
		var LAX = flightManagementFacade.createAirport( "LAX", "LAX Intl", "LA" );
		flightManagementFacade.createFlight( YYC, LAX );
		var flights = flightManagementFacade.getFlightsByOriginAirport( YYC );

		// Verify:
		$assert.isEqual( 1, arrayLen( flights ) );
		var flight = flights[ 1 ];
		$assert.isEqual( "YYC", flight.getOrigin().getCode() );
	 }


	 public void function testReadWrite_inMemory() {
		// Setup:
		var flightManagementFacade = new TestDoubles.FlightManagementFacadeImpl();

		// Test Double setup
		flightManagementFacade.setFlightDao( new FlightDAOFake() );

		// Exercise:
		var YYC = flightManagementFacade.createAirport( "YYC", "Calgary", "Calgary" );
		var LAX = flightManagementFacade.createAirport( "LAX", "LAX Intl", "LA" );
		flightManagementFacade.createFlight( YYC, LAX );
		var flights = flightManagementFacade.getFlightsByOriginAirport( YYC );

		// Verify:
		$assert.isEqual( 1, arrayLen( flights ) );
		var flight = flights[ 1 ];
		$assert.isEqual( "YYC", flight.getOrigin().getCode() );
	 }

	 public void function testReadWrite_TestBox() {
		// Setup:
		var flightManagementFacade = new TestDoubles.FlightManagementFacadeImpl();

		// Test Double setup
		//var airport = queryNew( "originCode, city", "VARCHAR, VARCHAR", [ [ "YYC", "Calgary" ], [ "LAX", "Los Angeles" ] ] );
		var airport = querySim( "originCode, city
			YYC | Calgary
			LAX | Los Angeles
			" );
		flightDAOFake = createStub();
		flightDAOFake.$( "saveFlight" );
		flightDAOFake.$( "readFlight", airport );
		flightManagementFacade.setFlightDao( flightDAOFake );
		// Technically readFlight() should return an array, but we want to demonstrate in-memory queries...

		// Exercise:
		var YYC = flightManagementFacade.createAirport( "YYC", "Calgary", "Calgary" );
		var LAX = flightManagementFacade.createAirport( "LAX", "LAX Intl", "LA" );
		flightManagementFacade.createFlight( YYC, LAX );
		var flights = flightManagementFacade.getFlightsByOriginAirport( YYC );

		// Verify:
		$assert.isNotEmpty( flights );
	 }
}