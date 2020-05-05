FROM selenium/standalone-chrome:latest
USER root

# (working directory containing all the files- /home/Vivo_BibTexLoader ? find the path)
WORKDIR /path/to/Vivo_BibTexLoader

ENV DISPLAY ":99.0"

COPY . home/
# SHELL ["bash", "-c"]

RUN sudo apt-get update \
&& apt-get install -y curl \
&& apt-get install -y python3-pip \
&& apt-get install -y unzip \
&& apt-get install xvfb xserver-xephyr vnc4server
# && apt-get install -y curl unzip xvfb libxi6 libgconf-2-4

# Install display
RUN pip3 install pyvirtualdisplay

# Install chromedriver for Selenium
RUN wget https://chromedriver.storage.googleapis.com/2.31/chromedriver_linux64.zip 
RUN unzip chromedriver_linux64.zip && mv chromedriver /usr/bin/chromedriver
RUN chown root:root /usr/bin/chromedriver \
&& chmod +x /usr/bin/chromedriver
# && chmod +x /usr/local/bin/chromedriver

# Install chromedriver dependencies
RUN apt-get install -y libglib2.0-0 \
&& apt-get install -y libnss3 \
&& apt-get install -y libgconf-2-4 \
&& apt-get install -y libfontconfig1


CMD python3 home/getbibtex.py /path/to/Downloads