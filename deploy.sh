#!/bin/bash

# Divine AI Teams Landing Page - Deployment Script
# This script helps you deploy to GitHub Pages

echo "🚀 Divine AI Teams - Deployment Helper"
echo "========================================"
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "📦 Initializing Git repository..."
    git init
    git branch -M main
else
    echo "✅ Git repository already initialized"
fi

# Check for remote
if ! git remote get-url origin &>/dev/null; then
    echo ""
    echo "❓ Enter your GitHub repository URL:"
    echo "   Example: https://github.com/YOUR_USERNAME/divine-ai-teams.git"
    read -r repo_url
    git remote add origin "$repo_url"
    echo "✅ Remote added: $repo_url"
else
    echo "✅ Remote already configured: $(git remote get-url origin)"
fi

# Stage all files
echo ""
echo "📝 Staging files..."
git add .

# Commit
echo ""
echo "💾 Creating commit..."
git commit -m "Deploy: Divine AI Teams landing page"

# Push
echo ""
echo "🚢 Pushing to GitHub..."
git push -u origin main

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📋 Next Steps:"
echo "1. Go to your GitHub repository"
echo "2. Settings > Pages"
echo "3. Source: Deploy from branch 'main'"
echo "4. Wait 2-3 minutes for deployment"
echo "5. Visit: https://YOUR_USERNAME.github.io/divine-ai-teams/"
echo ""
echo "🌐 Custom Domain Setup:"
echo "Add CNAME record in DNS:"
echo "   Type: CNAME"
echo "   Name: divineteams"
echo "   Value: YOUR_USERNAME.github.io"
echo ""
