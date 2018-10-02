component {
	public void function saveFlight( required Airport originAirport, required array originFlights, required Airport destinationAirport, required array destinationFlights ) {

		// store airports in memory instead of database to simplify this example
		request.airport[ arguments.originAirport.getCode() ] = arguments.originAirport;
		request.airport[ arguments.originAirport.getCode() ].setFlights( arguments.originFlights );

		request.airport[ arguments.destinationAirport.getCode() ] = arguments.destinationAirport;
		request.airport[ arguments.destinationAirport.getCode() ].setFlights( arguments.destinationFlights );
	}

	public any function readFlight( required string originCode ) {
		return request.airport[ arguments.originCode ].getFlights();
	}
}