# Build the manager binary
FROM golang:1.21 as builder

WORKDIR /workspace
# Copy the Go Modules manifests
COPY ./ ./

# Build
#RUN make proto-gen-all
RUN  make vendor
RUN  make build_user

CMD "h b"

# RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o builds/user cmd/user/main.go

FROM scratch
COPY --from=builder /workspace/builds/user .

CMD [ "./user" ]
