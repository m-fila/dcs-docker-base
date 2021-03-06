FROM debian:buster-slim
RUN apt-get update
RUN apt-get install -y cmake make gcc g++ python make git  && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
RUN git clone --recursive --branch v1.1.1  https://github.com/open62541/open62541.git
WORKDIR /opt/open62541
RUN cmake -H. -Bbuild \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo\
    -DUA_ENABLE_HISTORIZING=ON \
    -DUA_ENABLE_SUBSCRIPTIONS=ON \
    -DUA_ENABLE_SUBSCRIPTIONS_EVENTS=ON \
    -DUA_MULTITHREADING=150 \
    -DUA_NAMESPACE_ZERO=FULL
RUN cmake --build build --target install -j
EXPOSE 4840
