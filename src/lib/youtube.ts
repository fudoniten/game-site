/**
 * Extracts the video ID from common YouTube URL shapes
 * (watch?v=, youtu.be/, embed/, shorts/) so a plain URL can be embedded.
 */
export function videoId(url: string): string | null {
  try {
    const parsed = new URL(url);
    if (parsed.hostname === 'youtu.be') {
      return parsed.pathname.slice(1) || null;
    }
    if (parsed.pathname.startsWith('/embed/') || parsed.pathname.startsWith('/shorts/')) {
      return parsed.pathname.split('/')[2] || null;
    }
    return parsed.searchParams.get('v');
  } catch {
    return null;
  }
}
