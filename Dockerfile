# This Dockerfile builds a minimal Docker image that includes the OpenSSH client.
# It uses Alpine Linux as the base image and installs the OpenSSH client in a separate builder stage.
# The necessary files for the SSH client are then copied from the builder stage to the final image.
# The entry point for the Docker image is set to the SSH client executable.

# Use Alpine Linux as the base image
FROM alpine:latest AS builder

# Install OpenSSH client
RUN apk --no-cache add openssh-client \
	&& adduser -D -u 1000 user

# Create a minimal scratch image
FROM scratch

# Copy necessary files for the user and create a user with UID 1000
COPY --from=builder /etc/passwd /etc/passwd
USER 1000

# Copy necessary files for the SSH client
COPY --from=builder /etc/ssh/ /etc/ssh/
COPY --from=builder /usr/bin/ssh /usr/bin/
COPY --from=builder /lib/ld-musl-x86_64.so.1 /lib/libc.musl-x86_64.so.1 /lib/libcrypto.so.3 /lib/libz.so.1 /lib/libssl.so.3 /lib/

# Set the entry point for the SSH client
ENTRYPOINT ["/usr/bin/ssh"]
