component implements="iCustomer" {

	public iCustomer function init( required string uniqueNumberAsString, required numeric uniqueNumber, required Address address ) {
		return this;
	}

	public numeric function getZone() {
		return 0;
	}

}