namespace iOSApp.Core;

uses
  Foundation;

type

  APIUrls = public class
  protected
    domain:NSString;

  public

    method init():id; override;
    begin
      self := inherited init;
      if(assigned(self))then
      begin
        //domain:= 'moshine.com/sailinglog';
        domain := 'http://192.168.0.10:60679';
      end;

      exit self;
    end;

    method initWithUrl(url:String):id;
    begin
      self := inherited init;
      if(assigned(self))then
      begin
        domain := url;
      end;

      exit self;

    end;

  end;

end.