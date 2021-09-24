FROM adsl/ceph-dev:v1.0
RUN set -x; cd /ceph-src/ceph/ \
	&& mkdir -p ~/.ssh/ && chmod 0700 ~/.ssh && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts \
    && git -c core.sshCommand="ssh -i /ceph-src/ssh-key/id_rsa" pull --no-rebase origin ceph-dev \
    && ./do_cmake.sh \
    && cd build/ \
    && make -j64 \
    && make install -j64 \
    && cd .. \
    && rm -rf build /usr/bin/ceph_test*
