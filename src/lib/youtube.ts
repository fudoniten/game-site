/**
 * YouTube's auto-generated "uploads" playlist ID is derivable from a channel ID
 * by swapping the leading "UC" for "UU". Embedding that playlist (as
 * videoseries) shows the channel's most recent upload first, with no API
 * key and no server-side fetch required.
 */
export function uploadsPlaylistId(channelId: string): string | null {
  if (!channelId || !channelId.startsWith('UC')) return null;
  return `UU${channelId.slice(2)}`;
}
