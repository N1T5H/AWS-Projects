# Automated AWS Config Reporting

## Overview
This project automates the generation of compliance reports for AWS resources that have been noncompliant for a specified period (e.g., 30 days). The system queries AWS Config for noncompliant resources, generates a CSV report, and emails it to stakeholders. 

## Architecture
- **AWS Config**: Tracks configuration changes and evaluates resources against compliance rules. 
- **AWS Config Aggregator**: Aggregates compliance data across multiple accounts or regions. 
- **Amazon EventBridge**: Schedules the Lambda function to run at a specific time. 
- **AWS Lambda**: Queries AWS Config, generates the CSV report, and sends it via email. 
- **Amazon SES**: Sends the compliance report to specified recipients. 

## Steps to Build
1. **Enable AWS Config**:  
   Enable AWS Config in your account or organization and create managed or custom rules to define compliance requirements.
2. **Create an Amazon SES Configuration**:  
   Verify the sender's email address in Amazon SES and configure SES to send emails.
3. **Develop the Lambda Function**:  
   Develop a Lambda function that:
   - Queries AWS Config for noncompliant resources using the AWS SDK.
   - Generates a CSV report containing details such as rule name and noncompliance counts.
   - Sends the CSV report via email using Amazon SES.
4. **Set Up EventBridge Rule**:  
   Configure an EventBridge rule to trigger the Lambda function on a defined schedule (e.g., daily or weekly), ensuring periodic report generation.
5. **Deploy Using AWS CloudFormation or CDK**:  
   Use AWS CloudFormation or the AWS CDK to define and deploy your infrastructure as code, making the process reproducible and manageable.

## Testing and Validation
- **Local Testing**: Test the Lambda function locally using mock data to verify the CSV generation and email functionality.
- **Deployment Testing**: Deploy the solution in a test environment and ensure:
  - AWS Config correctly identifies noncompliant resources.
  - The CSV report is generated accurately.
  - The email is sent with the report attached.

## Benefits
- **Efficiency**: Automates compliance reporting, reducing manual effort.
- **Visibility**: Provides insights into long-term noncompliance trends.
- **Communication**: Keeps stakeholders informed about resource configurations regularly.

## License
This project is licensed under the MIT License.
