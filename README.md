# Jasper's Games

A small static site listing Jasper's videogames (built with [FlowLab](https://flowlab.io)),
an about page, and his latest YouTube upload.

## Editing content

All content lives in two JSON files — no code changes needed for day-to-day updates.

### `src/data/games.json`

An array of games:

```json
{
  "id": "my-game",
  "name": "My Game",
  "banner": "/games/my-game.png",
  "description": "One or two sentences about the game.",
  "flowlabUrl": "https://flowlab.io/game/play/XXXXXXXXXX",
  "embeddable": true
}
```

- `id` — used in the game's URL (`/games/<id>/`), keep it URL-safe (lowercase, hyphens).
- `banner` — path to an image in `public/`. Drop the file in `public/games/` and point to it,
  e.g. `public/games/my-game.png` → `/games/my-game.png`.
- `flowlabUrl` — the game's page on FlowLab.
- `embeddable` — set to `true` to play the game in an iframe right on the game's page, or
  `false` to only show a "Play on FlowLab" button (use this if a game refuses to load in a
  frame).

### `src/data/site.json`

Site name, Jasper's bio/photo, and his YouTube channel:

```json
{
  "youtube": {
    "channelId": "UCxxxxxxxxxxxxxxxxxxxxxx",
    "channelUrl": "https://www.youtube.com/@handle"
  }
}
```

`channelId` is the `UC...` ID for the channel (not the `@handle`) — find it in the channel's
"Share channel" menu, or by viewing the channel page source and searching for `"channelId"`.
Leaving it blank shows a fallback message with a link to `channelUrl` instead. The latest-video
embed works by pointing at the channel's auto-generated "uploads" playlist, so it needs no API
key and no server-side fetching.

Add a photo to `public/` (e.g. `public/jasper.jpg`) and update `about.photo` to match.

## Development

```sh
npm install
npm run dev      # dev server at http://localhost:4321
npm run build    # outputs static files to dist/
npm run preview  # serve the production build locally
```

## Building with Nix

```sh
nix build
```

produces `./result`, a directory of static files (HTML/CSS/JS/images) ready to be served by
any web server — point Nginx, Caddy, `python -m http.server`, etc. at it.

If you add or update a dependency (`npm install <pkg>`), `package-lock.json` changes and the
pinned `npmDepsHash` in `flake.nix` will go stale. `nix build` will fail with a message showing
the hash it actually got — copy that into `npmDepsHash` in `flake.nix` and build again.
