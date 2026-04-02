#!/usr/bin/env sh

TITLE_WIDTH=15
SLEEP_INTERVAL=0.1

player_args() {
  if playerctl --player=spotify status >/dev/null 2>&1; then
    printf '%s' '--player=spotify'
    return
  fi

  return 1
}

get_field() {
  field="$1"
  shift
  playerctl "$@" metadata --format "{{ ${field} }}" 2>/dev/null | head -n1
}

get_status() {
  playerctl "$@" status 2>/dev/null | head -n1
}

char_len() {
  perl -CS -Mutf8 -e 'use Encode qw(decode); my $s = decode("UTF-8", join("", <>)); print length($s);' <<EOF
$1
EOF
}

truncate_text() {
  perl -CS -Mutf8 -e '
    use Encode qw(decode encode);
    my ($width, $text) = @ARGV;
    my $decoded = decode("UTF-8", $text);
    print encode("UTF-8", substr($decoded, 0, $width));
  ' "$1" "$2"
}

marquee() {
  text="$1"
  offset="$2"

  if [ -z "$text" ]; then
    printf '%-*s' "$TITLE_WIDTH" ""
    return
  fi

  len=$(char_len "$text")
  if [ "$len" -le "$TITLE_WIDTH" ]; then
    printf '%-*s' "$TITLE_WIDTH" "$text"
    return
  fi

  perl -CS -Mutf8 -e '
    use Encode qw(decode encode);
    my ($text, $offset, $width) = @ARGV;
    my $decoded = decode("UTF-8", $text);
    my $padded = $decoded . q{   } . $decoded;
    my $len = length($decoded);
    my $start = $offset % ($len + 3);
    print encode("UTF-8", substr($padded, $start, $width));
  ' "$text" "$offset" "$TITLE_WIDTH"
}

render() {
  player="$(player_args)" || {
    printf '  No media  \n'
    return
  }

  if [ -n "$player" ]; then
    set -- "$player"
  else
    set --
  fi

  status="$(get_status "$@")"
  title="$(get_field title "$@")"

  if [ -z "$title" ]; then
    printf '  No media  \n'
    return
  fi

  if [ "$status" = "Playing" ]; then
    title_text="$(marquee "$title" "$offset")"
    title_fmt='%{F#d0d0d0}'
  else
    title_text="$(truncate_text "$TITLE_WIDTH" "$title")"
    title_fmt='%{F#88d0d0d0}'
  fi

  prev='%{A1:playerctl --player=spotify previous:}%{F#88d0d0d0}  %{F-}%{A}'
  middle_text="󰎇 ${title_text}"
  toggle="%{A1:playerctl --player=spotify play-pause:}${title_fmt}${middle_text}%{F-}%{A}"
  next='%{A1:playerctl --player=spotify next:}%{F#88d0d0d0}  %{F-}%{A}'

  printf ' %s %s %s \n' "$prev" "$toggle" "$next"
}

offset=0
while :; do
  render

  player="$(player_args)" || {
    sleep "$SLEEP_INTERVAL"
    continue
  }

  if [ -n "$player" ]; then
    set -- "$player"
  else
    set --
  fi

  status="$(get_status "$@")"
  title="$(get_field title "$@")"

  if [ "$status" = "Playing" ] && [ -n "$title" ] && [ "$(char_len "$title")" -gt "$TITLE_WIDTH" ]; then
    offset=$((offset + 1))
  else
    offset=0
  fi

  sleep "$SLEEP_INTERVAL"
done
