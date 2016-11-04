FROM marsmensch/docker-zcash

ENV ZCASH_VERSION v1.0.0
RUN rm /usr/local/bin/zcashd
RUN rm -rf /root/.zcash

RUN echo "check_certificate = off" > /root/.wgetrc && mkdir -p /opt/code/; cd /opt/code; \
  git clone ${GIT_URL} zcash && cd zcash && git checkout ${ZCASH_VERSION} && \
  ./zcutil/fetch-params.sh

RUN cd /opt/code/zcash && ./zcutil/build.sh -j4 && cd /opt/code/zcash/src
RUN rm -rf /usr/local/bin && mkdir -p /usr/local/bin
RUN cd /opt/code/zcash/src && /usr/bin/install -c zcashd zcash-tx zcash-cli zcash-gtest -t /usr/local/bin/
RUN rm -rf /opt/code/

ENTRYPOINT ["/usr/local/bin/zcashd"]

