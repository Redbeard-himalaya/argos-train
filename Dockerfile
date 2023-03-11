#FROM nvidia/cuda:11.8.0-devel-ubuntu22.04
FROM ubuntu@sha256:2adf22367284330af9f832ffefb717c78239f6251d9d0f58de50b86229ed1427

ARG USER_NAME=argosopentech

WORKDIR /home/${USER_NAME}
COPY bin/argos-train-init ./

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y sudo && \
    useradd -ms /bin/bash ${USER_NAME} && \
    passwd -d ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/${USER_NAME} && \
    usermod -aG sudo ${USER_NAME} && \
    chown -R ${USER_NAME}:${USER_NAME} . && \
    chmod 774 /home/${USER_NAME}/argos-train-init

USER ${USER_NAME}
CMD [ "/bin/bash" ]
