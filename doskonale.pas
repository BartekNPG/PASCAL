program doskonale;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var
  i: integer;

function SumaDzielnikow(n: integer): integer;
var
  j: integer;
begin
     SumaDzielnikow:=0;
     for j:=1 to Round(n/2) do
     begin
       if (n mod j) = 0 then SumaDzielnikow := SumaDzielnikow + j;
     end;


end;

begin
   for i:=1 to 10000 do
       if SumaDzielnikow(i) = i then write(i, ', ');
   readln();





end.

