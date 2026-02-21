-- Supabase Database Setup for KRMU Student Ambassador Portal
-- Run this SQL in your Supabase SQL Editor

-- Create students table
CREATE TABLE IF NOT EXISTS students (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  roll_number TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL UNIQUE,
  mobile TEXT NOT NULL,
  course TEXT NOT NULL,
  semester TEXT NOT NULL,
  cgpa TEXT NOT NULL,
  backlog TEXT NOT NULL DEFAULT 'No',
  backlog_details TEXT,
  discipline_issue TEXT NOT NULL DEFAULT 'No',
  photo TEXT,
  email_verified BOOLEAN DEFAULT FALSE,
  mobile_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create admins table for admin login
CREATE TABLE IF NOT EXISTS admins (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE admins ENABLE ROW LEVEL SECURITY;

-- Create policies for students
CREATE POLICY "Enable read access for all users" ON students
  FOR SELECT USING (true);

CREATE POLICY "Enable insert for all users" ON students
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable update for all users" ON students
  FOR UPDATE USING (true);

CREATE POLICY "Enable delete for all users" ON students
  FOR DELETE USING (true);

-- Create policies for admins
CREATE POLICY "Enable read access for admins" ON admins
  FOR SELECT USING (true);

CREATE POLICY "Enable insert for admins" ON admins
  FOR INSERT WITH CHECK (true);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_students_email ON students(email);
CREATE INDEX IF NOT EXISTS idx_students_roll_number ON students(roll_number);
CREATE INDEX IF NOT EXISTS idx_students_course ON students(course);
CREATE INDEX IF NOT EXISTS idx_admins_email ON admins(email);

-- Insert admin user
INSERT INTO admins (email, password, name) VALUES 
('sunita.sharma@krmangalam.edu.in', 'Admin@krmu.sunita', 'Sunita Sharma');
