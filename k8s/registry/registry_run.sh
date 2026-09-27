docker run -d --name registry \
  --restart=always \
  -p 5000:5000 \
  -v ~/registry-data:/var/lib/registry \
  registry:2
