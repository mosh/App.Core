namespace iOSApp.Core;

uses
  Foundation;

type

  APIUrls = public class
  protected
    domain:NSString;

  public
    constructor;
    begin
      inherited;
      //domain:= 'moshine.com/sailinglog';
      domain := 'http://192.168.0.10:60679';

    end;

    constructor WithUrl(url:String);
    begin
      inherited constructor;
      domain := url;
    end;

  end;

end.