# 베이스 이미지 선택 (JDK 17 사용)
FROM eclipse-temurin:21-jdk AS builder

# 작업 디렉토리 설정
WORKDIR /app

# 프로젝트 파일 복사
COPY . .

# Gradle 빌드 실행 (여기서는 bootJar 사용)
RUN ./gradlew clean bootJar

# 실행용 이미지
FROM eclipse-temurin:21-jdk
WORKDIR /app

# 빌드된 JAR 파일 복사
COPY --from=builder /app/build/libs/*.jar app.jar

# 실행할 명령어 설정
CMD ["java", "-jar", "app.jar"]
