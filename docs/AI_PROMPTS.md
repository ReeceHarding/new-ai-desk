# AI Prompts Guide

## Ticket Classification

### Intent Classification
```
Analyze the following customer message and classify its primary intent:
{message}

Possible intents:
- Technical Support
- Billing Question
- Feature Request
- Bug Report
- General Inquiry
```

### Priority Detection
```
Based on the following ticket content, determine the priority level:
{ticket_content}

Consider:
- Urgency of the issue
- Business impact
- Customer tier
- System stability

Return one of: Low, Medium, High, Critical
```

## Email Generation

### Follow-up Emails
```
Generate a follow-up email for a customer ticket with the following context:
- Last interaction: {last_message}
- Ticket age: {days_old}
- Status: {status}
- Previous actions: {actions}

The tone should be professional yet friendly, and include:
1. Acknowledgment of the situation
2. Update on progress
3. Next steps or request for information
4. Closing with clear call-to-action
```

### Summary Generation
```
Create a concise summary of the following ticket thread:
{thread}

Focus on:
- Core issue
- Steps taken
- Current status
- Pending actions
```

## Knowledge Base

### Article Suggestions
```
Based on the following ticket content:
{ticket_content}

Suggest relevant knowledge base articles that could help resolve the issue.
Consider:
- Technical keywords
- Common solutions
- Related problems
```

### Content Enhancement
```
Improve the following knowledge base article:
{article}

1. Add clear headers
2. Include step-by-step instructions
3. Add troubleshooting tips
4. Suggest related articles
``` 