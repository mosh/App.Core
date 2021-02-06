namespace iOSApp.Core;

{$IF TOFFEE OR DARWIN}
uses
  Foundation;
{$ENDIF}

type

  // Interface used to indicate View can receive
  IServiceEventReceiver = public interface

    {$IF TOFFEE OR DARWIN}
    method OnError(e:NSException);  {$IF TOFFEE} optional; {$ENDIF}
    {$ELSE}
    method OnError(e:Exception);  {$IF TOFFEE} optional; {$ENDIF}
    {$ENDIF}
  end;

end.