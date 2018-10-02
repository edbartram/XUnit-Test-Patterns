// http://xunitpatterns.com/Dummy%20Object.html

component extends="testbox.system.BaseSpec" {

	public void function testInvoice_addLineItem_noECS() {
		var QUANTITY = 1;
		var product = new TestDoubles.Product( getUniqueNumberAsString(), getUniqueNumber() );
		var state = new TestDoubles.State( "West Dakota", "WD" );
		var city = new TestDoubles.City( "Centreville", state );
		var address = new TestDoubles.Address( "123 Blake St.", city, "12345" );
		var customer= new TestDoubles.Customer( getUniqueNumberAsString(), getUniqueNumberAsString(), address );
		var invoice = new TestDoubles.Invoice( customer );

		// Exercise
		invoice.addItemQuantity( product, QUANTITY );

		// Verify
		var lineItems = invoice.getLineItems();
		$assert.isEqual( arrayLen( lineItems ), 1 );
		var actualItem = lineItems[ 1 ];
		var expectedItem = new TestDoubles.LineItem( invoice, product, QUANTITY );
		$assert.isEqual( expectedItem, actualItem );
	}

	public void function testInvoice_addLineItem_DO() {
		var QUANTITY = 1;
		var product = new TestDoubles.Product( "Dummy Product Name", getUniqueNumber() );
		var invoice = new TestDoubles.Invoice( new CustomerDummy() );

		// Exercise
		invoice.addItemQuantity( product, QUANTITY );

		// Verify
		var lineItems = invoice.getLineItems();
		$assert.isEqual( arrayLen( lineItems ), 1 );
		var actualItem = lineItems[ 1 ];
		var expectedItem = new TestDoubles.LineItem( invoice, product, QUANTITY );
		$assert.isEqual( expectedItem, actualItem );
	}

	public void function testInvoice_addLineItem_TestBox() {
		var customerDummy = createStub( implements="TestDoubles.iCustomer" );
		customerDummy.$( "getZone" ).$throws( message="This should never be called!" );
		// var zone = customerDummy.getZone( "" );

		var invoice = new TestDoubles.Invoice( customerDummy );

		var QUANTITY = 1;
		var product = new TestDoubles.Product( "Dummy Product Name", getUniqueNumber() );

		// Exercise
		invoice.addItemQuantity( product, QUANTITY );

		// Verify
		var lineItems = invoice.getLineItems();
		$assert.isEqual( arrayLen( lineItems ), 1 );
		var actualItem = lineItems[ 1 ];
		var expectedItem = new TestDoubles.LineItem( invoice, product, QUANTITY );
		$assert.isEqual( expectedItem, actualItem );
	}


	/* ==================================================================================================== */
	/* Helper functions assumed, not shown in book examples                                                 */
	/* ==================================================================================================== */

	private numeric function getUniqueNumber() {
		return 1;
	}

	private numeric function getUniqueNumberAsString() {
		return "1";
	}
}