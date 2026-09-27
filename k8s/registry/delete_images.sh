#!/bin/bash

# 레지스트리 주소 및 이미지 정보
REGISTRY_URL="http://192.168.233.133:5000"
IMAGE_NAME="spring-k8s-app"
TAG="latest"

# Accept 헤더
ACCEPT_HEADER="application/vnd.docker.distribution.manifest.v2+json"

echo "🔍 Digest 조회 중..."
DIGEST=$(curl -sI -H "Accept: $ACCEPT_HEADER" \
  $REGISTRY_URL/v2/$IMAGE_NAME/manifests/$TAG | \
  grep Docker-Content-Digest | awk '{print $2}' | tr -d $'\r')

if [ -z "$DIGEST" ]; then
  echo "❌ Digest 조회 실패: 태그가 존재하지 않거나 잘못된 요청입니다."
  exit 1
fi

echo "✅ Digest 확인: $DIGEST"

echo "🗑️ 이미지 삭제 요청 중..."
DELETE_RESPONSE=$(curl -s -X DELETE $REGISTRY_URL/v2/$IMAGE_NAME/manifests/$DIGEST)

if echo "$DELETE_RESPONSE" | grep -q "errors"; then
  echo "❌ 삭제 실패: $DELETE_RESPONSE"
  exit 1
else
  echo "✅ 이미지 삭제 성공: $IMAGE_NAME:$TAG"
fi

echo "📦 필요 시 Garbage Collection을 실행하세요:"
echo "docker exec <registry-container-name> registry garbage-collect /etc/docker/registry/config.yml"
