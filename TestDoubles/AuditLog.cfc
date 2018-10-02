component accessors=true {

	property name="user" type="string";
	property name="actionCode" type="string";
	property name="detail" type="string";

	public any function init() {
		return this;
	}

	public void function logMessage( required string user, required string actionCode, required string detail ) {
		setUser( arguments.user );
		setActionCode( arguments.actionCode );
		setDetail( arguments.detail );
	}

}