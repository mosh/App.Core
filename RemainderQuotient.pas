namespace iOSApp.Core;

uses
  Foundation;

type

  RemainderQuotient = public class
  public
    property Remainder:Integer;
    property Quotient:Integer;

    class method getRemainderQuotient(number:Integer; divideBy:Integer):RemainderQuotient;
    begin
      var info := new RemainderQuotient;

      info.Quotient := Integer(number/divideBy);
      info.Remainder := number mod divideBy;

      exit info;
    end;

  end;

end.