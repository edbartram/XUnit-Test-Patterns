component implements="TestDoubles.iCustomer" {

	public TestDoubles.iCustomer function init() {
		 // Real simple; nothing to initialize!
		return this;
	}

	public numeric function getZone() {
		throw( message="This should never be called!" );
	 }

}