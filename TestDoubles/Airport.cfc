component accessors=true {

	property name="code" type="string";
	property name="name" type="string";
	property name="city" type="string";

	property name="flights" type="array" hint="array of Flight";

	public Airport function init( required string code, required string name, required string city ) {
		setCode( arguments.code );
		setName( arguments.name );
		setCity( arguments.city );

		setFlights( [] );

		return this;
	}

}