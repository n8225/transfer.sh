FROM golang:1.11-alpine as build
LABEL maintainer="Remco Verhoef <remco@dutchcoders.io>"

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/dutchcoders/transfer.sh

# build & install server
RUN go build -o /go/bin/transfersh github.com/dutchcoders/transfer.sh

FROM scratch
COPY --from=build /go/bin/transfersh /go/bin/transfersh

ENTRYPOINT ["/go/bin/transfersh", "--listener", ":9090"]

EXPOSE 9090
