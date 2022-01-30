include .env
export
OPENAPI_VERSION ?= latest

default: build-client
openapi-spec:
	curl $(OPENAPI_URL) > openapi-spec

build-client: openapi-spec
	docker container run --rm -v ${PWD}:/app openapitools/openapi-generator-cli:$(OPENAPI_VERSION) \
		generate \
		$(OPENAPI_GENERATE_ARGS) \
		--config /app/config.yaml \
		--input-spec /app/openapi-spec \
		--generator-name php \
		--output /app \
		--git-host="$(GIT_HOST)" \
		--git-repo-id="$(GIT_REPO_ID)" \
		--git-user-id="$(GIT_USER_ID)"

.PHONY: build-client
