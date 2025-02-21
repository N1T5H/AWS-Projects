import boto3
import csv
from datetime import datetime, timedelta

def lambda_handler(event, context):
    config = boto3.client('config')
    ses = boto3.client('ses')
    
    # Get non-compliant rules older than 30 days
    cutoff_date = datetime.now() - timedelta(days=30)
    
    response = config.get_compliance_details_by_config_rule(
        ComplianceTypes=['NON_COMPLIANT'],
        ConfigRuleName='YOUR_RULE_NAME',
        Limit=100
    )
    
    # Generate CSV report
    with open('/tmp/report.csv', 'w') as f:
        writer = csv.writer(f)
        writer.writerow(['Resource ID', 'Rule Name', 'Non-Compliant Since'])
        for result in response['EvaluationResults']:
            if result['ResultRecordedTime'] < cutoff_date:
                writer.writerow([
                    result['EvaluationResultIdentifier']['EvaluationResultQualifier']['ResourceId'],
                    result['EvaluationResultIdentifier']['EvaluationResultQualifier']['ConfigRuleName'],
                    result['ResultRecordedTime'].isoformat()
                ])
    
    # Send email via SES
    ses.send_email(
        Source='sender@example.com',
        Destination={'ToAddresses': ['recipient@example.com']},
        Message={
            'Subject': {'Data': 'Monthly Compliance Report'},
            'Body': {'Text': {'Data': 'Attached compliance report'}}
        },
        Attachments=[{
            'Filename': 'compliance-report.csv',
            'Data': open('/tmp/report.csv', 'rb').read()
        }]
    )
