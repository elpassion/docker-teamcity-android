# docker-teamcity-android
TeamCity server &amp; agent containers for painless setup with Docker for Android Development.

### Setup

```
export SERVER_URL=http://<TEAMCITY_SERVER_URL>:8111
docker build -t teamcity-android-agent .
docker-compose up server agent
```