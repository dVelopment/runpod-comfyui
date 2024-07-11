FROM dvelopment/runpod-comfyui:automatic1111 as web-ui

FROM dvelopment/runpod-comfyui:comfyui

# add our pre_start.sh
COPY comfy-ui/pre_start.sh /pre_start_comfy-ui.sh
COPY web-ui/pre_start.sh /pre_start_web-ui.sh

# add automatic1111
COPY --from=web-ui /web-ui /web-ui
COPY --from=web-ui /cn-models /cn-models

# add the combined pre_start.sh script
COPY combined/pre_start.sh /pre_start.sh
