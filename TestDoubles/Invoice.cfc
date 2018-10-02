component accessors=true {

	property name="customer" type="any" hint="can either be Customer or CustomerDummy";
	property name="product" type="Product";
	property name="quantity" type="numeric";
	property name="zone" type="numeric";

	public Invoice function init( required iCustomer customer ) {
		setCustomer( arguments.customer );

		return this;
	}

	public void function addItemQuantity( required Product product, required numeric quantity ) {
		setProduct( arguments.product );
		setQuantity( arguments.quantity );
	}

	public array function getLineItems() {
		var lineItem = new LineItem( this, getProduct(), getQuantity() );
		return [ lineItem ];
	}
}