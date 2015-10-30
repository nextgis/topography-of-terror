# topography-of-terror
Mapping part and geodata for Topograhy of terror project by Memorial.

For cross domain requests to NGW use proxy.
NGINX example:

location /identify {
	proxy_pass http://serverNGW.com/feature_layer/identify;
}

location /layers {
	 proxy_pass http://serverNGW.com/resource/0/child;
}

location /sources {
	proxy_pass http://1serverNGW.com/api/resource;
}
