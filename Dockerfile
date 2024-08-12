FROM rust:alpine

RUN apk update
RUN apk add --no-cache musl-dev

WORKDIR /app

COPY ./Cargo.toml ./Cargo.lock .
COPY ./src ./src
COPY ./src/web_interface/static ./RELEASE
COPY ./migrations ./migrations

RUN cargo build --release
RUN cp ./target/release/livectf ./RELEASE

WORKDIR /app/RELEASE

RUN adduser -S livectf
USER livectf

CMD ./livectf
