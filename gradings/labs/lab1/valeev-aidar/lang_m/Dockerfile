FROM mono

RUN mkdir -p /usr/src/app
ADD . /usr/src/app
WORKDIR /usr/src/app/src
RUN xbuild /t:clean&&xbuild /p:Configuration=Release
WORKDIR ../
RUN mono src/bin/Release/src.exe
