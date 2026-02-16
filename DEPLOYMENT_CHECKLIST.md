# 🚀 Divine AI Teams - Deployment Checklist

Complete these steps to launch your landing page.

## ✅ Pre-Deployment Checklist

### 1. Supabase Database Setup
- [ ] Open [Supabase Dashboard](https://app.supabase.com)
- [ ] Navigate to SQL Editor
- [ ] Copy and run `supabase_setup.sql`
- [ ] Verify table created: Go to Table Editor > divine_teams_applications
- [ ] Get your **ANON KEY** from Settings > API > Project API keys
- [ ] Replace the key in `config.js` with your anon key

### 2. Local Testing
- [ ] Open `verify.html` in browser (double-click or use local server)
- [ ] Click "Run Verification"
- [ ] Click "Test Supabase Connection"
- [ ] All checks should be green (or yellow warning about anon key)
- [ ] Open `index.html` in browser
- [ ] Test the form submission
- [ ] Verify WhatsApp redirect works
- [ ] Check Supabase table for new entry

### 3. Content Review
- [ ] Read through all copy on index.html
- [ ] Verify pricing tiers are correct
- [ ] Check WhatsApp number: +91 98867 27839
- [ ] Verify all links work
- [ ] Test on mobile (Chrome DevTools > Device Mode)

### 4. GitHub Preparation
- [ ] Create new GitHub repository (public)
- [ ] Name suggestion: `divine-ai-teams-landing`
- [ ] Don't initialize with README (we have one)

### 5. Deploy to GitHub Pages
```bash
cd ~/clawd/Projects/Divine_AI_Teams_Landing
./deploy.sh
```

Or manually:
```bash
git init
git add .
git commit -m "Initial deploy: Divine AI Teams landing"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git
git push -u origin main
```

### 6. Enable GitHub Pages
- [ ] Go to repository Settings > Pages
- [ ] Source: Deploy from branch
- [ ] Branch: main
- [ ] Folder: / (root)
- [ ] Click Save
- [ ] Wait 2-3 minutes for deployment

### 7. Custom Domain Setup (Optional)
- [ ] Log in to your DNS provider
- [ ] Add CNAME record:
  - Type: CNAME
  - Name: divineteams
  - Target: YOUR_USERNAME.github.io
  - TTL: 3600 (or automatic)
- [ ] Wait 10-30 minutes for DNS propagation
- [ ] In GitHub repo Settings > Pages, add custom domain: `divineteams.divinesuccessflow.com`
- [ ] Check "Enforce HTTPS"

## 🧪 Post-Deployment Testing

### Live Site Testing
- [ ] Visit your GitHub Pages URL
- [ ] Test form submission with dummy data
- [ ] Verify WhatsApp redirect
- [ ] Check Supabase for new entry
- [ ] Test on real mobile device
- [ ] Test in different browsers (Chrome, Safari, Firefox)

### Performance Check
- [ ] Run Lighthouse audit (Chrome DevTools)
- [ ] Target: 90+ Performance, 100 Accessibility
- [ ] Test page load speed

### SEO Check
- [ ] Verify page title appears correctly in browser tab
- [ ] Check meta description
- [ ] Share link on WhatsApp/Telegram - verify preview card

## 📊 Monitoring Setup

### Supabase Dashboard
- [ ] Set up email notifications for new applications
- [ ] Create view for filtering by status
- [ ] Set up backup schedule

### Analytics (Optional)
- [ ] Add Google Analytics
- [ ] Add Facebook Pixel
- [ ] Add LinkedIn Insight Tag

## 🔒 Security Checklist

- [ ] Using ANON key (not service_role) in config.js
- [ ] RLS policies enabled on Supabase table
- [ ] HTTPS enforced on custom domain
- [ ] No sensitive data in JavaScript
- [ ] Form has basic validation

## 📱 Marketing Checklist

- [ ] Share link in Instagram bio
- [ ] Create QR code for link
- [ ] Add to all email signatures
- [ ] Post announcement on social media
- [ ] Send to email list

## 🐛 Troubleshooting

### Form submission fails
1. Check browser console for errors
2. Verify Supabase anon key in config.js
3. Check RLS policies in Supabase
4. Test with verify.html

### WhatsApp redirect doesn't work
1. Check phone number format in config.js (no + or spaces)
2. Verify URL encoding in app.js
3. Test WhatsApp link directly

### Custom domain not working
1. Wait 30 minutes for DNS propagation
2. Check DNS settings with: `dig divineteams.divinesuccessflow.com`
3. Remove and re-add custom domain in GitHub settings

### Table not found error
1. Go to Supabase SQL Editor
2. Run supabase_setup.sql again
3. Check table name: `divine_teams_applications`

## ✨ You're Done!

Your landing page is live! Now:
1. Monitor applications in Supabase
2. Follow up via WhatsApp within 24 hours
3. Track conversion rates
4. Iterate and improve

**Need help?** WhatsApp: +91 98867 27839
