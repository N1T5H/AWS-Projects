import os
import lambda_function.lambda_function as lambda_fn

def test_lambda_handler(monkeypatch):
# Dummy SES client.
class DummySESClient:
def send_raw_email(self, Source, Destinations, RawMessage):
return {'MessageId': 'dummy-message-id'}
# Dummy Config client.
class DummyConfigClient:
    def get_compliance_summary_by_config_rule(self):
        return {
            'ComplianceSummariesByConfigRule': [
                {
                    'ConfigRuleName': 'TestRule',
                    'Compliance': {
                        'ComplianceType': 'NON_COMPLIANT',
                        'NonCompliantResourceCount': 2
                    }
                }
            ]
        }

# Dummy boto3 client factory.
class DummyBoto3:
    def client(self, service_name):
        if service_name == 'ses':
            return DummySESClient()
        elif service_name == 'config':
            return DummyConfigClient()
        raise Exception("Unknown service")

# Patch boto3 in the lambda module.
monkeypatch.setattr(lambda_fn, 'boto3', DummyBoto3())

# Set environment variables for testing.
os.environ['SENDER_EMAIL'] = 'sender@example.com'
os.environ['RECIPIENT_EMAIL'] = 'recipient@example.com'

# Simulate Lambda invocation.
event = {}
context = {}
result = lambda_fn.lambda_handler(event, context)

assert result['statusCode'] == 200
assert result['body'] == 'Report sent successfully'
