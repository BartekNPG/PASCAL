program pascaltrojkat;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, crt
  { you can add units after this };
function factorial(n: integer): integer;
begin
     if n<2 then factorial := 1
     else factorial := n*factorial(n-1);

end;

function DwumianN(m, n: integer) : real;
begin
     DwumianN := factorial(m) / (factorial(m - n) * factorial(n));

end;

procedure Przerwa(n: integer);
var
  i: integer;
begin
     for i := 1 to n do write('   ');

end;

function PascalT(n: integer) : integer;
var i, j: integer;
begin
     for i:=0 to n-1 do
     begin
       Przerwa(n-i);
       for j:=0 to i do
         Write(DwumianN(i,j):5:0, ' ');
       Writeln();
     end;
end;

function PascalTRight(n : integer) : integer;
var
   i,j,k : integer;
begin
     k:=0;
     for i:=0 to n-1 do
     begin
       if (i mod 2) = 1 then Przerwa(1);
       for j:=i-k to i do
         Write(DwumianN(i,j):5:0, ' ');

       Writeln();
       k := k + i mod 2;
    end;
end;

var
   i: integer;
begin
    PascalT(10);
    writeln();
    PascalTRight(10);
    readln();



end.

