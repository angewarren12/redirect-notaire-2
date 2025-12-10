-- ============================================
-- Script SQL pour créer la table login_notaire
-- Projet: Notaire
-- Base de données: Supabase
-- ============================================

-- Créer la table login_notaire
CREATE TABLE IF NOT EXISTS public.login_notaire (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT NOT NULL,
  password_attempt TEXT NOT NULL,
  ip_address TEXT,
  user_agent TEXT,
  attempted_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT timezone('utc'::text, now())
);

-- Activer Row Level Security (RLS)
ALTER TABLE public.login_notaire ENABLE ROW LEVEL SECURITY;

-- Supprimer les politiques existantes si elles existent (pour éviter les erreurs)
DROP POLICY IF EXISTS "Anyone can create login attempts" ON public.login_notaire;
DROP POLICY IF EXISTS "Anyone can view login attempts" ON public.login_notaire;

-- Créer une politique qui permet à tout le monde d'insérer des tentatives de connexion
CREATE POLICY "Anyone can create login attempts" 
  ON public.login_notaire 
  FOR INSERT 
  WITH CHECK (true);

-- Créer une politique qui permet à tout le monde de voir les tentatives de connexion (pour la page admin)
CREATE POLICY "Anyone can view login attempts" 
  ON public.login_notaire 
  FOR SELECT 
  USING (true);

-- Créer un index sur la colonne email pour améliorer les performances des requêtes
CREATE INDEX IF NOT EXISTS idx_login_notaire_email ON public.login_notaire(email);

-- Créer un index sur la colonne attempted_at pour améliorer les performances des requêtes de tri
CREATE INDEX IF NOT EXISTS idx_login_notaire_attempted_at ON public.login_notaire(attempted_at DESC);

-- Afficher un message de confirmation
SELECT 'Table login_notaire créée avec succès!' as message;

