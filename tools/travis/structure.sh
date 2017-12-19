docker run --rm -it \
-v $(pwd):/src \
-v $(pwd)/target/ubl-invoice:/target \
difi/vefa-structure:0.4.1 \
-p /src/structure/ubl-invoice -t /target
