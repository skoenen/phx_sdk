FROM alpine:latest

RUN apk add elixir erlang nodejs git \
 && mix local.hex \
 && mix archive.install hex phx_new

RUN tmpdir=$(mktemp -d) \
 && git clone https://github.com/lexical-lsp/lexical.git "${tmpdir}/lexical" \
 && cd "${tmpdir}/lexical" \
 && mix deps.get \
 && mix package \
 && cp -r _build/dev/package/lexical /usr/local/lib/ \
 && ln -s /usr/local/lib/lexical/bin/start_lexical.sh /usr/local/bin/lexical \
 && chmod +x /usr/local/lib/lexical/start_lexical.sh
