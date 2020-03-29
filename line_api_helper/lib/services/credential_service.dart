class Credential {
  String channelAccessToken;
  String channelSecret;
  Credential({String channelAccessToken, String channelSecret}) {
    this.channelAccessToken = channelAccessToken;
    this.channelSecret = channelSecret;
  }
}

Credential credential = new Credential();
