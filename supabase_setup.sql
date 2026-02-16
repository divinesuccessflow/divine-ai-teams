-- Divine AI Teams Applications Table
-- Run this in Supabase SQL Editor

-- Create table
CREATE TABLE IF NOT EXISTS divine_teams_applications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    
    -- Contact Information
    full_name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    company_name TEXT,
    website TEXT,
    
    -- Business Information
    industry TEXT NOT NULL,
    company_size TEXT NOT NULL,
    revenue TEXT NOT NULL,
    
    -- Qualification Questions
    challenge TEXT NOT NULL,
    tasks TEXT[] NOT NULL,
    hear_about TEXT NOT NULL,
    budget TEXT NOT NULL,
    
    -- Internal Fields
    status TEXT DEFAULT 'new' CHECK (status IN ('new', 'qualified', 'contacted', 'converted', 'rejected')),
    notes TEXT
);

-- Create index on email for faster lookups
CREATE INDEX IF NOT EXISTS idx_divine_teams_email ON divine_teams_applications(email);

-- Create index on created_at for sorting
CREATE INDEX IF NOT EXISTS idx_divine_teams_created ON divine_teams_applications(created_at DESC);

-- Create index on status for filtering
CREATE INDEX IF NOT EXISTS idx_divine_teams_status ON divine_teams_applications(status);

-- Enable Row Level Security
ALTER TABLE divine_teams_applications ENABLE ROW LEVEL SECURITY;

-- Policy: Anyone can insert (submit application)
CREATE POLICY "Anyone can submit application" ON divine_teams_applications
    FOR INSERT
    WITH CHECK (true);

-- Policy: Only authenticated users can read
CREATE POLICY "Only authenticated users can read applications" ON divine_teams_applications
    FOR SELECT
    USING (auth.role() = 'authenticated');

-- Policy: Only authenticated users can update
CREATE POLICY "Only authenticated users can update applications" ON divine_teams_applications
    FOR UPDATE
    USING (auth.role() = 'authenticated')
    WITH CHECK (auth.role() = 'authenticated');

-- Add comment to table
COMMENT ON TABLE divine_teams_applications IS 'Application submissions for Divine AI Teams landing page';

-- Success message
SELECT 'Divine Teams Applications table created successfully!' AS message;
