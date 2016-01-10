program systemytosamo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math, sysutils
  { you can add units after this };

function decToAny(liczba, podstawa: integer) : string;
const znak: string='0123456789ABCDEF';
begin
     result := '';
     repeat
     result := znak[(liczba mod podstawa)+1]+result;
     liczba := liczba div podstawa;
     until liczba = 0;
end;
function AnyToDec(liczba : string; podstawa: integer): integer;
var
  i, potega, wykladnik : integer;
begin
     liczba := AnsiUpperCase(liczba);
     result := 0;
     wykladnik := 0;

     for i:=Length(liczba) downto 1 do
     begin
       potega := trunc(intpower(podstawa,wykladnik));

       case liczba[i] of
            '0'..'9': result := (Ord(liczba[i])-Ord('0'))*potega + result;
            'A'..'F': result := (Ord(liczba[i])-Ord('A')+10)*potega + result;
       end;
       inc(wykladnik);
     end;
end;
const liczba: integer=5412;
var
  i : integer;
  tab : array [0..14] of string;
  value : string;

begin
   for i:=0 to 14 do
   begin
       writeln(liczba, ' > base ',i,' = ', DecToAny(liczba,i+2));
       tab[i]:=DecToAny(liczba,i+2);
   end;
   writeln();
   writeln('do dziesietnego');
   for i:=0 to 14 do
  begin
        value := tab[i];
        writeln(value,' > ',AnyToDec(value,i+2));
   end;
   readln();
end.

