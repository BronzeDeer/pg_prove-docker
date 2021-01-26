FROM alpine:3.13.0 AS base

RUN apk add --no-cache bash perl perl-utils postgresql-client

FROM base AS build

RUN apk add --no-cache make postgresql-dev patch
RUN cpan App::cpanminus
RUN cpanm --no-wget TAP::Parser::SourceHandler::pgTAP

COPY pgtap /pgtap
WORKDIR /pgtap
RUN make
RUN make install
#RUN make installcheck

FROM base
COPY --from=build /usr/local/bin/pg_prove /usr/local/bin/pg_prove
#COPY --from=build /usr/local/lib/perl5 /usr/local/lib/perl5
#COPY --from=build /usr/share/perl5 /usr/share/perl5
COPY --from=build /usr/local/share/perl5 /usr/local/share/perl5
COPY --from=build /usr/share/postgresql/extension/*pgtap* /pgtap/
COPY --chown=root:root run.sh /run.sh

CMD [ "/run.sh" ]


