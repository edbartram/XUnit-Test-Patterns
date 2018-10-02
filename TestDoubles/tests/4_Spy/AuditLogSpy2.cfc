component accessors=true { // implements="AuditLog" {

	// Fields into which we record actual usage info
	property name="date" type="string";
	property name="user" type="string";
	property name="actionCode" type="string";
	property name="detail" type="string";

	property name="numberOfCalls" type="numeric";

	public any function init() {
		setNumberOfCalls( 0 );

		return this;
	}

	// Recording implementation of real AuditLog interface:
	public void function logMessage( required string date, required string user, required string actionCode, required string detail ) {
		setDate( arguments.date );
		setUser( arguments.user );
		setActionCode( arguments.actionCode );
		setDetail( arguments.detail );

		variables.numberOfCalls++;
	}

}