component { // implements="AuditLog" {

	// Fields into which we record actual usage info
	variables.date = "";
	variables.user = "";
	variables.actionCode = "";
	variables.detail = "";

	variables.numberOfCalls = 0;

	// Recording implementation of real AuditLog interface:
	public void function logMessage( required string date, required string user, required string actionCode, required string detail ) {
		variables.date = arguments.date;
		variables.user = arguments.user;
		variables.actionCode = arguments.actionCode;
		variables.detail = arguments.detail;
		variables.numberOfCalls++;
	}

	// Retrieval Interface:
	public string function getDate() {
		return variables.date;
	}

	public string function getUser() {
		return variables.user;
	}

	public string function getActionCode() {
		return variables.actionCode;
	}

	public string function getDetail() {
		return variables.detail;
	}

	public numeric function getNumberOfCalls() {
		return variables.numberOfCalls;
	}

}