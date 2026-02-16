# 📋 Managing Applications - Quick Guide

## Viewing Applications

### Method 1: Supabase Dashboard (Recommended)
1. Go to [Supabase Dashboard](https://app.supabase.com)
2. Select your project
3. Click **Table Editor** in left sidebar
4. Select `divine_teams_applications` table
5. View all applications in a spreadsheet-like interface

### Method 2: SQL Queries
Run these in Supabase SQL Editor:

```sql
-- View all new applications (unprocessed)
SELECT 
    full_name,
    email,
    phone,
    company_name,
    industry,
    revenue,
    budget,
    created_at
FROM divine_teams_applications
WHERE status = 'new'
ORDER BY created_at DESC;

-- View applications by status
SELECT 
    status,
    COUNT(*) as count
FROM divine_teams_applications
GROUP BY status;

-- View high-value leads (revenue > $25K)
SELECT 
    full_name,
    email,
    phone,
    company_name,
    industry,
    revenue,
    budget,
    created_at
FROM divine_teams_applications
WHERE revenue IN ('$25K-$100K', '$100K-$500K', '$500K+')
AND status = 'new'
ORDER BY created_at DESC;

-- View by industry
SELECT 
    industry,
    COUNT(*) as applications,
    AVG(CASE 
        WHEN revenue = '$500K+' THEN 6
        WHEN revenue = '$100K-$500K' THEN 5
        WHEN revenue = '$25K-$100K' THEN 4
        WHEN revenue = '$5K-$25K' THEN 3
        WHEN revenue = 'Under $5K' THEN 2
        ELSE 1
    END) as avg_revenue_tier
FROM divine_teams_applications
GROUP BY industry
ORDER BY applications DESC;
```

## Application Workflow

### 1. New Application Arrives
- Check Supabase table (or set up email notification)
- Review application details
- Assess fit based on:
  - Revenue range
  - Budget
  - Industry
  - Company size
  - Challenges mentioned

### 2. Qualification
Update status based on assessment:

```sql
-- Mark as qualified
UPDATE divine_teams_applications
SET 
    status = 'qualified',
    notes = 'High-value lead. $100K+ revenue. Perfect fit.'
WHERE id = 'APPLICATION_ID';

-- Mark as rejected
UPDATE divine_teams_applications
SET 
    status = 'rejected',
    notes = 'Pre-revenue, budget too low'
WHERE id = 'APPLICATION_ID';
```

### 3. First Contact
- Reach out via WhatsApp within 24 hours
- Reference their specific challenges
- Offer to jump on a quick call

```sql
-- Mark as contacted
UPDATE divine_teams_applications
SET 
    status = 'contacted',
    notes = 'WhatsApp sent 2024-02-16. Waiting for response.'
WHERE id = 'APPLICATION_ID';
```

### 4. Conversion
- Client signs up
- Mark as converted

```sql
-- Mark as converted
UPDATE divine_teams_applications
SET 
    status = 'converted',
    notes = 'Signed up for Growth plan ($97/mo)'
WHERE id = 'APPLICATION_ID';
```

## Status Definitions

| Status | Meaning | Next Action |
|--------|---------|-------------|
| **new** | Just submitted, not reviewed | Review within 24h |
| **qualified** | Good fit, worth pursuing | Contact immediately |
| **contacted** | Reached out, waiting for response | Follow up in 2-3 days |
| **converted** | Became a customer | Onboard |
| **rejected** | Not a fit | No action needed |

## Lead Scoring

### Hot Lead (Contact Immediately)
- Revenue: $100K+/month
- Budget: $300+/month
- Company size: 11+ employees
- Tasks: 3+ selected
- Industry: SaaS, E-commerce, Agency

### Warm Lead (Contact Within 24h)
- Revenue: $25K-$100K/month
- Budget: $100-$300/month
- Company size: 2-10 employees
- Has specific challenges mentioned

### Cold Lead (Low Priority)
- Revenue: Pre-revenue or Under $5K
- Budget: Under $50/month
- Solo, no clear use case

## WhatsApp Message Templates

### First Contact (Hot Lead)
```
Hey [Name]! 👋

Just saw your application for Divine AI Teams.

[INDUSTRY] + [REVENUE RANGE] + [SPECIFIC CHALLENGE MENTIONED] = this could be a game-changer for you.

Got 15 minutes for a quick call? I can show you exactly how we'd build your custom AI team.

When works for you?
```

### First Contact (Warm Lead)
```
Hi [Name]!

Thanks for applying to Divine AI Teams.

I saw you're in [INDUSTRY] and dealing with [CHALLENGE].

We've worked with [SIMILAR COMPANIES] and helped them [SPECIFIC RESULT].

Want to jump on a quick call to see if we're a fit?
```

### Follow-up (After 3 Days)
```
Hey [Name],

Following up on my message from [DAY].

Still interested in getting an AI team set up for [COMPANY]?

Completely cool if timing's not right - just let me know 👍
```

## Export Applications

### To CSV (for Excel/Google Sheets)
In Supabase:
1. Click **Table Editor** > divine_teams_applications
2. Click **...** (three dots) top-right
3. **Export to CSV**

### To Notion/Airtable
Use Supabase API to sync:
```javascript
// Example: Fetch all new applications
const { data } = await supabase
    .from('divine_teams_applications')
    .select('*')
    .eq('status', 'new')
    .order('created_at', { ascending: false });

// Then sync to your tool of choice
```

## Set Up Email Notifications

### Using Supabase Functions
Create a function that triggers on new insert:

```sql
-- Create notification function
CREATE OR REPLACE FUNCTION notify_new_application()
RETURNS trigger AS $$
BEGIN
    -- Send webhook to your notification service
    -- Or use Supabase Edge Functions
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER on_application_created
    AFTER INSERT ON divine_teams_applications
    FOR EACH ROW
    EXECUTE FUNCTION notify_new_application();
```

## Analytics Queries

### Conversion Rate by Industry
```sql
SELECT 
    industry,
    COUNT(*) as total_applications,
    SUM(CASE WHEN status = 'converted' THEN 1 ELSE 0 END) as conversions,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'converted' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) as conversion_rate
FROM divine_teams_applications
GROUP BY industry
ORDER BY conversion_rate DESC;
```

### Applications Over Time
```sql
SELECT 
    DATE(created_at) as date,
    COUNT(*) as applications,
    SUM(CASE WHEN status = 'converted' THEN 1 ELSE 0 END) as conversions
FROM divine_teams_applications
WHERE created_at >= NOW() - INTERVAL '30 days'
GROUP BY DATE(created_at)
ORDER BY date DESC;
```

### Revenue Potential
```sql
SELECT 
    SUM(CASE 
        WHEN budget = '$1000+/mo' THEN 297  -- Likely Scale plan
        WHEN budget = '$300-$1000/mo' THEN 297
        WHEN budget = '$100-$300/mo' THEN 97
        WHEN budget = '$50-$100/mo' THEN 47
        ELSE 47
    END) as estimated_mrr
FROM divine_teams_applications
WHERE status IN ('qualified', 'contacted');
```

## Best Practices

1. **Respond within 24 hours** - Speed matters
2. **Personalize every message** - Reference their specific situation
3. **Follow up 2-3 times** - Don't give up after one message
4. **Track everything** - Update notes field with interaction history
5. **Learn from rejections** - Note why they didn't convert
6. **Celebrate conversions** - Track what worked

## Tools to Connect

- **Zapier**: Auto-send to Slack/Email on new application
- **Make.com**: Create complex workflows
- **n8n**: Self-hosted automation
- **ClickUp**: Sync applications as tasks

## Need Help?

WhatsApp: +91 98867 27839
