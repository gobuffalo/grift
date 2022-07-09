TAGS ?= ""
GO_BIN ?= "go"

install:
	$(GO_BIN) install -tags ${TAGS} -v ./.

tidy:
	$(GO_BIN) mod tidy

test:
	$(GO_BIN) test -cover -race -tags ${TAGS} ./...

cov:
	$(GO_BIN) test -coverprofile cover.out -tags ${TAGS} ./...
	$(GO_BIN) tool cover -html cover.out

lint:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.2
	golangci-lint run --enable-all

update:
	rm go.*
	$(GO_BIN) mod init github.com/gobuffalo/grift
	$(GO_BIN) mod tidy
	make test
