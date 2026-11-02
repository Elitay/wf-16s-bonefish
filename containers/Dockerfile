# Layer bonefish onto the official wf-metagenomics image used by wf-16s.
# Build from the repository root:
#   docker build -t wf-16s-bonefish:latest -f containers/Dockerfile containers/
ARG WF_META_SHA=sha38db033c15c74ae7cac3c609fdfe2c8d2a53ef6f
ARG BONEFISH_VERSION=v0.4.0

FROM debian:bookworm-slim AS bonefish-bin
ARG BONEFISH_VERSION=v0.4.0
ARG TARGETARCH=amd64
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates wget tar \
    && rm -rf /var/lib/apt/lists/* \
    && case "${TARGETARCH}" in \
         amd64) bfarch=x86_64 ;; \
         arm64) bfarch=arm64 ;; \
         *) echo "unsupported TARGETARCH=${TARGETARCH}" >&2; exit 1 ;; \
       esac \
    && wget -O /tmp/bf.tgz "https://github.com/DylanCosto/bonefish/releases/download/${BONEFISH_VERSION}/bonefish-${BONEFISH_VERSION}-linux-${bfarch}.tar.gz" \
    && tar -xzf /tmp/bf.tgz -C /tmp \
    && install -m 0755 "/tmp/bonefish-${BONEFISH_VERSION}-linux-${bfarch}/bonefish" /usr/local/bin/bonefish \
    && /usr/local/bin/bonefish --version

FROM ontresearch/wf-metagenomics:${WF_META_SHA}
COPY --from=bonefish-bin /usr/local/bin/bonefish /usr/local/bin/bonefish
RUN bonefish --version && minimap2 --version
