FROM runpod/stable-diffusion:web-ui-12.0.0

# move the venv from /workspace/venv to /workspace/web-ui/venv
# (remember that is was moved from /worspace/venv to /venv before)
RUN cd /stable-diffusion-webui && \
    git fetch -ap && git pull origin master && \
    rm -rf /venv

# copy adjusted requirements.txt
COPY web-ui/requirements.txt /stable-diffusion-webui/requirements.txt

# copy install script
COPY web-ui/install.py /stable-diffusion-webui/install.py

# create a new venv
RUN mkdir -p /workspace/web-ui && \
    cd /workspace/web-ui && python -m venv venv && \
    source /workspace/web-ui/venv/bin/activate && \
    cp /stable-diffusion-webui/requirements.txt /workspace/web-ui/requirements.txt && \
    python -m pip install -r /workspace/web-ui/requirements.txt && \
    # run install script
    mv /stable-diffusion-webui /workspace/web-ui/stable-diffusion-webui && \
    cd /workspace/web-ui/stable-diffusion-webui && \
    source /workspace/web-ui/venv/bin/activate && \
    export COMMANDLINE_ARGS="--reinstall-xformers --reinstall-torch --skip-torch-cuda-test" && \
    python install.py && \
    # clenaup
    mv /workspace/web-ui /web-ui && \
    # rm unnecessary models/folders
    rm -rf /web-ui/stable-diffusion-webui/models/Stable-diffusion \
    /web-ui/stable-diffusion-webui/models/Lora \
    /web-ui/stable-diffusion-webui/models/hypernetworks \
    /web-ui/stable-diffusion-webui/models/ControlNet \
    /web-ui/stable-diffusion-webui/models/VAE \
    /web-ui/stable-diffusion-webui/models/VAE-approx \
    /web-ui/stable-diffusion-webui/embeddings

# add our relauner.py and webui-user.sh
COPY web-ui/relauncher.py /web-ui/stable-diffusion-webui/relauncher.py
COPY web-ui/webui-user.sh /web-ui/stable-diffusion-webui/webui-user.sh

# add our custom start scripts.sh
COPY web-ui/pre_start.sh /pre_start.sh

# add our stop.sh script
COPY stop.sh /stop.sh
