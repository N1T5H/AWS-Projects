#!/usr/bin/env python3
import aws_cdk as cdk
from config_report_stack import ConfigReportStack

app = cdk.App()
ConfigReportStack(app, "ConfigReportStack")
app.synth()
