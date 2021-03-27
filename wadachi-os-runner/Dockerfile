FROM ikanag0/riscv-toolchain:latest AS dependency

FROM rust:latest

ENV RISCV=/opt/riscv

COPY --from=dependency $RISCV $RISCV

ENV NIGHTLY_VERSION=nightly-2021-02-16
ENV RISCV_TARGET=riscv32i-unknown-none-elf

RUN rustup toolchain install $NIGHTLY_VERSION \
    && rustup target add $RISCV_TARGET

CMD [ "cargo", "build" ]

