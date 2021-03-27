FROM ubuntu:latest AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV RISCV=/opt/riscv
ENV RISCV_BUILD=/tmp

ARG ARCH="rv32i"
ARG ABI="ilp32"

LABEL maintainer="ikanago@ikanago.dev"

WORKDIR $RISCV_BUILD

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    autoconf automake autotools-dev curl python3 \
    libmpc-dev libmpfr-dev libgmp-dev gawk \
    build-essential bison flex texinfo gperf \
    libtool patchutils bc zlib1g-dev libexpat-dev git \
    ca-certificates

RUN git clone https://github.com/riscv/riscv-gnu-toolchain.git

WORKDIR $RISCV_BUILD/riscv-gnu-toolchain

RUN ./configure --prefix=$RISCV --with-arch=$ARCH --with-abi=$ABI \
    && make -j

FROM ubuntu:latest

ENV RISCV=/opt/riscv
ENV PATH="$RISCV/bin:$PATH"

COPY --from=builder $RISCV $RISCV

CMD [ "/bin/bash", "-l" ]

