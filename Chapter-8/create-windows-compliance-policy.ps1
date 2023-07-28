$name = "Windows Compliance Policy"
$description = "Windows Compliance Policy using GUI settings"
$groupid = "0000000-0000-0000-0000-000000000000"

$url = "https://graph.microsoft.com/beta/deviceManagement/deviceCompliancePolicies"

$json = @"
{
	"@odata.type": "#microsoft.graph.windows10CompliancePolicy",
	"activeFirewallRequired": true,
	"antiSpywareRequired": true,
	"antivirusRequired": true,
	"bitLockerEnabled": true,
	"codeIntegrityEnabled": true,
	"defenderEnabled": true,
	"description": "$description",
	"deviceThreatProtectionEnabled": false,
	"deviceThreatProtectionRequiredSecurityLevel": "unavailable",
	"displayName": "$name",
	"id": "00000000-0000-0000-0000-000000000000",
	"passwordRequiredType": "deviceDefault",
	"roleScopeTagIds": [
		"0"
	],
	"rtpEnabled": true,
	"scheduledActionsForRule": [
		{
			"ruleName": "PasswordRequired",
			"scheduledActionConfigurations": [
				{
					"actionType": "block",
					"gracePeriodHours": 12,
					"notificationMessageCCList": [],
					"notificationTemplateId": ""
				},
				{
					"actionType": "retire",
					"gracePeriodHours": 4320,
					"notificationMessageCCList": [],
					"notificationTemplateId": ""
				}
			]
		}
	],
	"secureBootEnabled": true,
	"signatureOutOfDate": true,
	"tpmRequired": true
}
"@

$compliance = invoke-mggraphrequest -uri $uri -json $json -method post -contenttype "application/json" -outputtype PSObject

$complianceid = $compliance.id

$assignurl = "https://graph.microsoft.com/beta/deviceManagement/deviceCompliancePolicies/$complianceid/assign"
$assignjson = @"
{
	"assignments": [
		{
			"target": {
				"@odata.type": "#microsoft.graph.groupAssignmentTarget",
				"groupId": "527ee8b8-b3e7-4bbf-9abf-45bdced10a0d"
			}
		}
	]
}
"@

invoke-mggraphrequest -uri $assignurl -json $assignjson -method post -contenttype "application/json" -outputtype PSObject