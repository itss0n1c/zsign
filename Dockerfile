FROM debian:bookworm-slim AS build


RUN apt update && apt install -y git g++ pkg-config libssl-dev libminizip-dev build-essential openssl zlib1g-dev
RUN git clone https://github.com/zhlynn/zsign.git /zsign
WORKDIR /zsign/build/linux
RUN mkdir -p /zsign/bin
RUN make clean && make

FROM debian:bookworm

RUN apt update && apt install -y libminizip-dev libssl3
COPY --from=build /zsign/bin/zsign /usr/local/bin/zsign
RUN chmod +x /usr/local/bin/zsign
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

LABEL org.opencontainers.image.source=https://github.com/itss0n1c/zsign

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/local/bin/zsign"]