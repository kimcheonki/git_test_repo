#!/bin/bash

# 변수 설정
#APP_NAME=jihun/shoppingmall
APP_NAME=shoppingmall
VERSION=latest
#LOCAL_REGISTRY=192.168.233.173:1664
LOCAL_REGISTRY=localhost:5000

# 이미지 태깅
echo "🐳 Docker 이미지 빌드 중..."
docker build -t $APP_NAME:$VERSION .

echo "🏷️ 이미지 태그 변경 → $LOCAL_REGISTRY/$APP_NAME:$VERSION"
docker tag $APP_NAME:$VERSION $LOCAL_REGISTRY/$APP_NAME:$VERSION

# 이미지 푸시
echo "🚀 이미지 푸시 중..."
docker push $LOCAL_REGISTRY/$APP_NAME:$VERSION

echo "✅ 완료: $LOCAL_REGISTRY/$APP_NAME:$VERSION"
