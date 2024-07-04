FROM runpod/stable-diffusion:web-ui-12.0.0 as web-ui

FROM runpod/stable-diffusion:comfy-ui-5.0.0

# we don't need the default models
RUN rm -rf /comfy-models

# update dependencies for custom nodes
RUN cd /ComfyUI && \
    apt-get update && apt-get install -y \
    build-essential python3.10-dev \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && pip install insightface onnxruntime-gpu \
    spandrel kornia lpips filetype \
    simpleeval ufile

# update pip, ComfyUI and ComfyUI-Manager
RUN cd /ComfyUI && git fetch -ap && git pull origin master \
    && pip install --upgrade pip \
    && cd /ComfyUI/custom_nodes \
    && rm -Rf ComfyUI-Manager \
    && git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# install more custom_nodes
RUN cd /ComfyUI/custom_nodes  && \
    git clone https://github.com/chrisgoringe/cg-use-everywhere.git && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git && \
    git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git && \
    git clone https://github.com/jeffy5/comfyui-faceless-node.git && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    git clone https://github.com/ltdrdata/ComfyUI-Inspire-Pack.git && \
    git clone https://github.com/jags111/efficiency-nodes-comfyui.git && \
    git clone https://github.com/mav-rik/facerestore_cf.git && \
    git clone https://github.com/Seedsa/Fooocus_Nodes.git && \
    git clone https://github.com/xiaoxiaodesha/hd_node.git && \
    git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
    git clone https://github.com/Gourieff/comfyui-reactor-node

COPY extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml

# add automatic1111
COPY --from=web-ui /venv /web-ui/venv
COPY --from=web-ui /cn-models /web-ui/cn-models
COPY --from=web-ui /stable-diffusion-webui /web-ui/stable-diffusion-webui

# update automatic1111
RUN cd /web-ui/stable-diffusion-webui && \
    git status && git diff && \
    git fetch -ap && git pull origin master && \
    # cleanup unnecessary models
    rm -rf /web-ui/stable-diffusion-webui/models/Stable-diffusion && \
    rm -rf /web-ui/stable-diffusion-webui/models/Lora && \
    rm -rf /web-ui/stable-diffusion-webui/embeddings && \
    rm -rf /web-ui/stable-diffusion-webui/models/hypernetworks && \
    rm -rf /web-ui/stable-diffusion-webui/models/ControlNet && \
    rm -rf /web-ui/stable-diffusion-webui/models/VAE

# add our custom nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# add our relauner.py
COPY relauncher.py /web-ui/stable-diffusion-webui/relauncher.py

# add our custom pre_start.sh
COPY pre_start.sh /pre_start.sh
