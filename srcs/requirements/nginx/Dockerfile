FROM alpine:3.20

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/CN=jlaazouz.42.fr"

COPY /nginx.conf /etc/nginx/http.d/nginx.conf

CMD	[ "nginx", "-g", "daemon off;" ]