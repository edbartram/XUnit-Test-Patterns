component {
	public void function saveFlight() {
	}

	public array function readFlight( required string originCode ) {
		var airport = new TestDoubles.Airport( "YYC", "Dummy Name", "Dummy City" );

		var flight = new TestDoubles.Flight();
		flight.setOrigin( airport );

		return [ flight ];
	}
}