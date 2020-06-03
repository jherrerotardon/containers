FROM debian

LABEL mantainer='jherrero.tardon@gmail.com'


RUN apt update && \
    apt install --no-install-recommends -y \
        exim4

COPY entrypoint.sh /bin/

EXPOSE 25

ENTRYPOINT ["/bin/entrypoint.sh"]

CMD ["exim", "-bd", "-q30m", "-v"]
