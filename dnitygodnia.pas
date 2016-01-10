program dnitygodnia;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, sysutils
  { you can add units after this };

function GetDay(d,m,y: integer): integer;
var n : integer;
begin
     n := 6 + d + (y - 1900) + (y - 1900) div 4;

  case m of
    4,7: ;
    1, 10: n:=n+1;
    5: n:= n+2;
    8: n:=n+3;
    2, 3, 11: n:=n+4;
    6: n:=n+5;
    9,12: n:=n+6;
  end;

  if ((y mod 4) = 0) AND (m<3) then n:=n-1;
  GetDay:=n mod 7;

end;

var i, j, ileDni: integer;
  date : TDateTime;
  rok, miesiac, ilosc : integer;

begin
  ileDni:=0;
  for i:=2007 to 2020 do
      for j:=1 to 12 do
          if GetDay(13,j,i)=5 then
          begin
            writeln(13,'.',j,'.',i);
            inc(ileDni);
          end;
  writeln('w sumie: ',ileDni);
  readln();
  writeln('---------------------');
  ilosc :=0;
  for rok:=2007 to 2020 do
      begin
        for miesiac:=1 to 12 do
            begin
              date := EncodeDate(rok,miesiac,13);
              if DayOfWeek(date) = 6 then
              begin
                inc(ilosc);
                writeln(13,'.',miesiac,'.',rok);
              end;
            end;
      end;
   writeln('w sumie: ', ilosc);
   readln();

end.

