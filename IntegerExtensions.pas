namespace iOSApp.Core;

uses
  Foundation;

type

  IntegerExtensions = public extension class(Integer)
  public
    method AsMonthDay:String;
    begin
      case self of
        1,21,31:
        exit NSString.stringWithFormat('%dst', self);
        2,22:
        exit NSString.stringWithFormat('%dnd', self);
        3,23:
        exit NSString.stringWithFormat('%drd', self);
        else
          exit NSString.stringWithFormat('%dth', self);
      end;

    end;

    method ForDisplay: String;
    begin
      exit self.FormatIntegerForDisplay;
    end;

    method AsDuration: String;
    begin
      var someValue := self;
      exit someValue.FormatAsDuration;
    end;

    method FormatIntegerForDisplay:NSString;
    begin
      exit NSString.stringWithFormat('%d', self);
    end;

    method FormatAsDuration:NSString;
    begin
      var days:Integer;
      var hours:Integer;
      var minutes:Integer;

      var minutesInHour:=60;
      var minutesInDay:=60*24;

      if(self < minutesInHour)then
      begin
        exit NSString.stringWithFormat('%d minute(s)', self);
      end;

      var remainderQuotientValue : RemainderQuotient;

      if(self >= minutesInDay)then
      begin
        remainderQuotientValue := RemainderQuotient.getRemainderQuotient(self, minutesInDay);
        days := remainderQuotientValue.Quotient;
        self := remainderQuotientValue.Remainder;

      end;

      remainderQuotientValue := RemainderQuotient.getRemainderQuotient(self, minutesInHour);
      hours := remainderQuotientValue.Quotient;
      minutes := remainderQuotientValue.Remainder;

      if((hours = 0) and (days = 0)) then
      begin
        exit NSString.stringWithFormat('%d minute(s)', minutes);
      end
      else if (days = 0)then
      begin
        if(minutes = 0)then
        begin
          exit NSString.stringWithFormat('%d hour(s)', hours);
        end;
        exit NSString.stringWithFormat('%d hour(s) %d minute(s)', hours,minutes);
      end
      else
      begin
        if(minutes = 0)then
        begin
          exit NSString.stringWithFormat('%d day(s) %d hour(s)', days, hours);
        end;
        exit NSString.stringWithFormat('%d day(s) %d hour(s) %d minute(s)', days, hours,minutes);
      end;

    end;

  end;

end.