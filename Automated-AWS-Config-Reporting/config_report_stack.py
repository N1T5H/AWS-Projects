from aws_cdk import (
    Stack,
    aws_lambda as _lambda,
    aws_events as events,
    aws_events_targets as targets
)

class ConfigReportStack(Stack):
    def __init__(self, scope, id, **kwargs):
        super().__init__(scope, id, **kwargs)
        
        # Create Lambda function
        report_lambda = _lambda.Function(
            self, "ConfigReporter",
            runtime=_lambda.Runtime.PYTHON_3_9,
            handler='lambda_function.lambda_handler',
            code=_lambda.Code.from_asset('lambda_function'),
            environment={
                'AWS_REGION': self.region
            }
        )
        
        # Add permissions
        report_lambda.add_to_role_policy(
            iam.PolicyStatement(
                actions=[
                    'config:GetComplianceDetailsByConfigRule',
                    'ses:SendEmail'
                ],
                resources=['*']
            )
        )
        
        # Schedule weekly execution
        events.Rule(
            self, "WeeklyTrigger",
            schedule=events.Schedule.cron(
                minute='0',
                hour='10',
                week_day='MON'
            ),
            targets=[targets.LambdaFunction(report_lambda)]
        )
