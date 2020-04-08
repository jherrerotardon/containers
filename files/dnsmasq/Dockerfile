FROM alpine:latest

LABEL mantainer='jherrero.tardon@gmail.com'

RUN apk add --no-cache dnsmasq

EXPOSE 53

CMD ["dnsmasq", "--no-daemon"]
