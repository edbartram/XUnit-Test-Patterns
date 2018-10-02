component accessors=true {

	property name="flightDAO";
	property name="auditLog";

	public FlightManagementFacadeImpl function init() {
		setFlightDAO( new FlightDAO() );

		setAuditLog( new AuditLog() );

		return this;
	}

	public Airport function createAirport( required string airportCode, required string name, required string nearbyCity ) {
		var airport = new Airport( code=arguments.airportCode, name=arguments.name, city=arguments.nearbyCity );

		return airport;
	}

	public void function createFlight( required Airport originAirport, required Airport destinationAirport ) {
		var originFlights = arguments.originAirport.getFlights();
		var destinationFlights = arguments.destinationAirport.getFlights();

		var flight = new Flight( origin=arguments.originAirport, destination=arguments.destinationAirport );

		arrayAppend( originFlights, flight );
		arrayAppend( destinationFlights, flight );

		getFlightDAO().saveFlight( arguments.originAirport, originFlights, arguments.destinationAirport, destinationFlights );
	}

	public any function getFlightsByOriginAirport( required Airport airport ) {
		return getFlightDAO().readFlight( originCode=arguments.airport.getCode() );
	}

	public void function removeFlight( required string flightNumber ) {
		getAuditLog().logMessage( "Ed", "RF", arguments.flightNumber );
	}

	public boolean function flightExists() {
		return false;
	}

	private string function myPrivateMethod() {
		return "this is a private method";
	}
}