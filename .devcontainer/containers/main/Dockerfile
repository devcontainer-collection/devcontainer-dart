FROM dart:stable

RUN apt-get update && apt-get install -y \
    nano \
    git \
    curl \
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# RUN ...any other commands you want to run in the container

# 작업 디렉터리 설정 (마운트된 코드 사용할 것이므로 복사 X)
WORKDIR /workspace

# 기본 실행 명령 (컨테이너가 종료되지 않도록 tail 사용)
CMD [ "tail", "-f", "/dev/null" ]
