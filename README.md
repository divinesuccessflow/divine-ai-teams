# Divine AI Teams Landing Page

High-converting landing page for Divine AI Teams - personalized AI agent teams for businesses.

## Features

- **Modern Dark Theme**: Dark background with gold/amber accents matching Surya brand
- **Mobile-First Design**: Fully responsive, optimized for all devices
- **Hormozi-Style Copy**: Bold, value-focused, transformation-oriented messaging
- **Supabase Integration**: Direct form submission to database with RLS policies
- **WhatsApp Integration**: Auto-redirect to WhatsApp after application
- **Production-Ready**: Clean code, fast loading, GitHub Pages deployable

## Setup Instructions

### 1. Supabase Database Setup

1. Go to [Supabase Dashboard](https://app.supabase.com)
2. Select your project: `https://tbhvbscfnhpobkigigxf.supabase.co`
3. Navigate to **SQL Editor**
4. Copy and paste the contents of `supabase_setup.sql`
5. Run the SQL script to create the table and policies

### 2. Get Supabase Anon Key

**IMPORTANT**: The current config uses a service_role key. For production security:

1. Go to Supabase Dashboard > Settings > API
2. Copy the **anon/public** key (NOT service_role)
3. Replace the key in `config.js`:

```javascript
SUPABASE_ANON_KEY: 'your_actual_anon_key_here'
```

### 3. Deploy to GitHub Pages

1. Create a new GitHub repository
2. Push this folder to the repository:

```bash
cd ~/clawd/Projects/Divine_AI_Teams_Landing
git init
git add .
git commit -m "Initial commit: Divine AI Teams landing page"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/divine-ai-teams.git
git push -u origin main
```

3. Enable GitHub Pages:
   - Go to repository Settings > Pages
   - Source: Deploy from branch
   - Branch: main / (root)
   - Save

4. Configure DNS:
   - Add CNAME record in your DNS provider:
     - Type: CNAME
     - Name: divineteams
     - Value: YOUR_USERNAME.github.io
   - GitHub will automatically use the CNAME file

### 4. Test the Application Flow

1. Visit the deployed site
2. Fill out the application form
3. Submit
4. Verify:
   - Success modal appears
   - WhatsApp redirect works
   - Data appears in Supabase table

## Files Structure

```
Divine_AI_Teams_Landing/
├── index.html           # Main landing page
├── styles.css           # Dark theme styling with gold accents
├── app.js               # Form handling and Supabase integration
├── config.js            # Supabase credentials
├── supabase_setup.sql   # Database table creation script
├── CNAME                # Custom domain configuration
└── README.md            # This file
```

## Application Form Fields

### Required Fields
- Full Name
- Email
- Phone/WhatsApp
- Industry (dropdown)
- Company Size (dropdown)
- Monthly Revenue Range (dropdown)
- Biggest Challenge (textarea)
- Tasks to Handle (multi-select checkboxes)
- How Did You Hear About Us (dropdown)
- Budget for AI Tools (dropdown)

### Database Fields
All form fields plus:
- `id` (UUID, auto-generated)
- `created_at` (timestamp, auto-generated)
- `status` (new/qualified/contacted/converted/rejected)
- `notes` (for internal use)

## Pricing Tiers

1. **Entry**: $47/mo - 3 AI agents
2. **Growth**: $97/mo - 10 AI agents (MOST POPULAR)
3. **Scale**: $297/mo - All 51+ AI agents
4. **Enterprise**: $2,500/mo - White-label solution

## Copy Style Guidelines

- Bold, confident, Hormozi-style
- Focus on VALUE and TRANSFORMATION
- Use specific numbers ("51 AI agents", "24-hour setup")
- No em dashes
- Short paragraphs, lots of white space

## Customization

### Change Colors
Edit CSS variables in `styles.css`:
```css
:root {
    --gold: #fbbf24;
    --gold-light: #fcd34d;
    --gold-dark: #f59e0b;
}
```

### Update WhatsApp Number
Edit `config.js`:
```javascript
WHATSAPP_NUMBER: '919886727839'
```

### Modify Form Fields
1. Update HTML in `index.html` (form section)
2. Update data collection in `app.js`
3. Update table schema in `supabase_setup.sql`

## Security Notes

- RLS (Row Level Security) enabled on Supabase table
- Anyone can INSERT (submit application)
- Only authenticated users can SELECT/UPDATE
- Use anon key (not service_role) in production
- All sensitive data server-side only

## Support

For issues or questions:
- WhatsApp: +91 98867 27839
- Part of Divine Success Flow

## License

© 2026 Divine AI Teams. All rights reserved.
