FILE_NAME_SANITIZE_REGEXP = /[^[:word:]\.\-\+\p{Han}\p{Hangul}\p{Hiragana}\p{Katakana}]/
BASE_DATE_FORMAT = '%d %b %Y'.freeze
SCAN_DATE_FORMAT = '%k:%M %b %d %Y'.freeze
HTTP_ERRORS = [
  EOFError,
  Errno::ECONNRESET,
  Errno::ECONNREFUSED,
  Errno::EINVAL,
  Net::HTTPBadResponse,
  Net::HTTPHeaderSyntaxError,
  Net::ProtocolError,
  Timeout::Error,
  SocketError,
].map(&:freeze)
