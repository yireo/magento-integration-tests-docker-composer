FROM php:8.3

RUN mkdir -p /tmp
RUN echo '<?php echo "It works";' > /tmp/index.php

CMD ["php", "-S", "0.0.0.0:9200", "/tmp"]

