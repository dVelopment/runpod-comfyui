FROM runpod/stable-diffusion:comfy-ui-5.0.0

# we don't need the default models
RUN rm -rf /comfy-models

# update dependencies for custom nodes
RUN cd /ComfyUI && \
    apt-get update && apt-get install -y \
    --no-install-recommends google-perftools \
    build-essential python3.10-dev \
    python3.10-venv libgl1 libglib2.0-0 bc \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && pip install insightface onnxruntime-gpu \
    spandrel kornia lpips filetype \
    simpleeval ufile \
    scipy>=1.10.0 httpx>=0.25.0

# update pip, ComfyUI and ComfyUI-Manager
RUN cd /ComfyUI && git fetch -ap && git pull origin master \
    # Fooocus_Nodes requires pip<24.1
    && pip install pip==24.0 \
    && cd /ComfyUI/custom_nodes \
    && rm -Rf ComfyUI-Manager \
    && git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# install more custom_nodes
RUN cd /ComfyUI/custom_nodes  && \
    git clone https://github.com/chrisgoringe/cg-use-everywhere.git && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git && \
    git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive && \
    git clone https://github.com/jeffy5/comfyui-faceless-node.git && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    git clone https://github.com/ltdrdata/ComfyUI-Inspire-Pack.git && \
    git clone https://github.com/jags111/efficiency-nodes-comfyui.git && \
    git clone https://github.com/mav-rik/facerestore_cf.git && \
    git clone https://github.com/Seedsa/Fooocus_Nodes.git && \
    git clone https://github.com/xiaoxiaodesha/hd_node.git && \
    git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
    git clone https://github.com/Big-Idea-Technology/ComfyUI-Book-Tools && \
    git clone  https://github.com/alexopus/ComfyUI-Image-Saver && \
    git clone https://github.com/Fannovel16/ComfyUI-Loopchain && \
    git clone https://github.com/romeobuilderotti/ComfyUI-PNG-Metadata && \
    git clone https://github.com/nkchocoai/ComfyUI-SaveImageWithMetaData && \
    git clone https://github.com/ZHO-ZHO-ZHO/ComfyUI-YoloWorld-EfficientSAM && \
    git clone https://github.com/AlekPet/ComfyUI_Custom_Nodes_AlekPet && \
    git clone https://github.com/cubiq/ComfyUI_essentials && \
    git clone https://github.com/giriss/comfy-image-saver && \
    git clone https://github.com/adieyal/comfyui-dynamicprompts && \
    git clone https://github.com/receyuki/comfyui-prompt-reader-node && \
    cd comfyui-prompt-reader-node && git submodule update --init --recursive && \
    cd ../ && \
    git clone https://github.com/meshmesh-io/mm-comfyui-loopback && \
    (cd ComfyUI-YoloWorld-EfficientSAM && pip install -r requirements.txt) && \
    (cd comfyui-dynamicprompts && pip install -r requirements.txt) && \
    pip install --upgrade inference albumentations && \
    pip install --pre torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/nightly/cu12

COPY comfy-ui/extra_model_paths.yaml /ComfyUI/extra_model_paths.yaml

# add our pre_start.sh
COPY comfy-ui/pre_start.sh /pre_start.sh

# add our stop.sh script
COPY stop.sh /stop.sh
