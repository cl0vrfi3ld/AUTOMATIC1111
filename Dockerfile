FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-runtime

WORKDIR /dockerx
COPY . .
RUN python -m venv venv
RUN source venv/bin/activate
RUN python -m pip install --upgrade pip wheel

# It's possible that you don't need "--precision full", dropping "--no-half" however crashes my drivers
ENV TORCH_COMMAND='pip install torch torchvision --extra-index-url https://download.pytorch.org/whl/rocm5.1.1' REQS_FILE='requirements.txt' 

ENTRYPOINT [ "python", "./launch.py" ]
CMD [ "--precision", "full", "--no-half" ]