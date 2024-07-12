FROM runpod/stable-diffusion:comfy-ui-5.0.0

# we don't need the default models
RUN rm -rf /comfy-models

# install comfy-cli and re-install ComfyUI
RUN apt-get update && apt-get install -y \
    --no-install-recommends google-perftools \
    build-essential python3.10-dev \
    python3.10-venv libgl1 libglib2.0-0 bc \
    unzip aria2 && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* \ && \
    rm -rf /ComfyUI && mkdir -p /workspace/comfy-ui && \
    cd /workspace/comfy-ui && python -m venv venv && \
    source /workspace/comfy-ui/venv/bin/activate && \
    # Fooocus_Nodes requires pip<24.1
    pip install pip==24.0 && \
    pip install comfy-cli

RUN cd /workspace/comfy-ui && \
    source /workspace/comfy-ui/venv/bin/activate && \
    comfy --skip-prompt tracking disable

RUN cd /workspace/comfy-ui && \
    source /workspace/comfy-ui/venv/bin/activate && \
    comfy --workspace /workspace/comfy-ui/ComfyUI \
    --skip-prompt install --nvidia && \
    comfy set-default /workspace/comfy-ui/ComfyUI

RUN cd /workspace/comfy-ui && \
    source /workspace/comfy-ui/venv/bin/activate && \
    comfy node install cg-use-everywhere \
    ComfyUI-Impact-Pack \
    ComfyUI_UltimateSDUpscale \
    ComfyUI_IPAdapter_plus \
    comfyui-faceless-node \
    ComfyUI-Inspire-Pack \
    efficiency-nodes-comfyui \
    facerestore_cf \
    Fooocus_Nodes \
    hd_node \
    ComfyUI-KJNodes \
    ComfyUI-Book-Tools \
    ComfyUI-Image-Saver \
    ComfyUI-Loopchain \
    ComfyUI-PNG-Metadata \
    ComfyUI-SaveImageWithMetaData \
    ComfyUI-YoloWorld-EfficientSAM \
    ComfyUI_Custom_Nodes_AlekPet \
    ComfyUI_essentials \
    comfy-image-saver \
    comfyui-dynamicprompts \
    comfyui-prompt-reader-node \
    ComfyUI_InstantID \
    comfyui-reactor-node

# rm from /workspace
RUN mv /workspace/comfy-ui /comfy-ui

COPY comfy-ui/extra_model_paths.yaml /comfy-ui/ComfyUI/extra_model_paths.yaml

# add our pre_start.sh
COPY comfy-ui/pre_start.sh /pre_start.sh

# add our stop.sh script
COPY stop.sh /stop.sh
