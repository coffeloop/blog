#####################################################################
#                            Build Stage                            #
#####################################################################
FROM hugomods/hugo:exts-0.145.0 as builder
# Base URL
ARG HUGO_BASEURL='https://pedroblog.coolify01.homelab.local/'
ENV HUGO_BASEURL=${HUGO_BASEURL}
# Build site
COPY . /src
RUN hugo --minify --gc

#####################################################################
#                            Final Stage                            #
#####################################################################
FROM hugomods/hugo:nginx
# Copy the generated files to keep the image as small as possible.
COPY --from=builder /src/public /site