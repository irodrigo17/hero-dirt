# Hero Dirt

A single-page web app for tracking rainfall to help mountain bikers find perfect trail conditions.

## Project Structure

```
index.html           # Complete web app (HTML/CSS/JS, no build step)
manifest.json        # PWA manifest for Add to Home Screen
sw.js                # Service worker for offline caching
icon.svg             # App icon (rain cloud)
supabase-schema.sql  # Database schema (places table + RLS policies)
README.md            # Documentation
```

## Tech Stack

- **Single file:** All HTML, CSS, and JavaScript inline in `index.html`
- **No build step:** Open in browser or deploy to any static host
- **Leaflet** (CDN): Interactive map rendering and layer management
- **Supabase**: Auth (email magic link) and PostgreSQL database for cloud sync
- **Open-Meteo API** (free, no key): Daily precipitation data
- **Photon/Komoot** (free, no key): Forward geocoding with proximity bias
- **Nominatim/OpenStreetMap**: Reverse geocoding
- **CARTO Voyager Tiles**: Base map layer
- **localStorage**: Offline fallback for saved places
- **PWA**: Service worker + manifest for iOS Add to Home Screen

## Features

- User accounts with email magic link auth (Supabase)
- Saved places sync to cloud, accessible across devices
- Place search with proximity bias, full-screen results page with infinite scroll
- Click-to-inspect, saved places with custom names
- Rainfall summary: 1d/2d/3d/7d totals + days since last rain
- Color-coded heatmap overlay with bilinear interpolation (12x8 grid upscaled to 180x120 canvas)
- Mobile responsive with bottom tab bar and iOS safe area support
- PWA: installable on iOS Home Screen for persistent storage and offline use
- IP-based geolocation to center map on user's area

## Running

Serve via a local HTTP server (required for Supabase auth and CORS):

```
python3 -m http.server 8000
```

Then open `http://localhost:8000`.

## Supabase Setup

The app uses Supabase for auth and data. To set up:

1. Create a project at supabase.com
2. Run `supabase-schema.sql` in the SQL Editor
3. Run `GRANT SELECT, INSERT, UPDATE, DELETE ON public.places TO authenticated;`
4. Set Site URL in Authentication > URL Configuration
5. Update `SUPABASE_URL` and `SUPABASE_ANON_KEY` in `index.html`
