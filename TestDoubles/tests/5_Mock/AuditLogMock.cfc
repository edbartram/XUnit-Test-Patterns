component accessors=true  extends="testbox.system.BaseSpec" {

	property name="user" type="string";
	property name="actionCode" type="string";
	property name="detail" type="string";

	property name="expectedUser" type="string";
	property name="expectedActionCode" type="string";
	property name="expectedDetail" type="string";

	property name="expectedNumberCalls" type="numeric";
	property name="actualNumberCalls" type="numeric";
	property name="logMessageCalled" type="boolean";

	public any function init() {
		setActualNumberCalls( 0 );
		setLogMessageCalled( false );

		return this;
	}

	public void function logMessage(
		required string user,
		required string actionCode,
		required string detail
	) {
		setLogMessageCalled( true );

		variables.actualNumberCalls++;

		$assert.isEqual( getExpectedUser(), arguments.user );
		$assert.isEqual( getExpectedActionCode(), arguments.actionCode );
		$assert.isEqual( getExpectedDetail(), arguments.detail );
		$assert.isEqual( getExpectedNumberCalls(), variables.actualNumberCalls );
	}

	public void function setExpectedLogMessage(
		required string expectedUser,
		required string expectedActionCode,
		required string expectedDetail
	) {
		setExpectedUser( arguments.expectedUser );
		setExpectedActionCode( arguments.expectedActionCode );
		setExpectedDetail( arguments.expectedDetail );
	}

	public void function verify() {
		$assert.isTrue( getLogMessageCalled() );
	}
}