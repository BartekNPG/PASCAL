program systemy;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math, sysutils
  { you can add units after this };

function DecToAny(liczba, podstawa :integer) : string;
const znak: string='0123456789ABCDEF';
begin
     result := '';
     repeat
       result := znak[(liczba mod podstawa)+1]+result;
       liczba := liczba div podstawa;
     until liczba=0;
end;

function AnyToDec(liczba : string; podstawa: integer): integer;
var
  i, potega, wykladnik : integer;
begin
     liczba := AnsiUpperCase(liczba);
     result := 0;
     wykladnik:=0;

     for i:=Length(liczba) downto 1 do
     begin
         potega:=trunc((intpower(podstawa, wykladnik)));

         case liczba[i] of
              '0'..'9': result := (Ord(liczba[i])-Ord('0'))*potega+result;
              'A'..'F': result := (Ord(liczba[i])-Ord('A')+10)*potega+result;
         end;
         inc(wykladnik);
     end;
end;




const liczba: integer=143;
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

//program systemybothways;
//uses
//Math, sysutils;
//
// var
//liczba, n: integer;
//liczba2: string;
//
//x: byte;
//
//
//
//function decToAny(liczba:integer; podstawa: integer) : string;  {dziesietny do dowolnego}
//
////var
//     //result: string;
//const znak: string='0123456789ABCDEF';
//
//begin
//
//     result:='';
//      repeat
//        result:=znak[(liczba mod podstawa)+1]+result;
//        liczba:=liczba div podstawa;
//      until (liczba=0);
//      writeln(result);
//end;
//
//function anyToDec(liczba2: string; podstawa: integer): integer;
//var
//     i, M: integer;
//     j, n, petla, power: integer;
//
//
//begin
//  liczba2:=AnsiUpperCase(liczba2);
//  result:=0;
//  M:=1;
//  n:=0;
//
//    for i:=length(liczba2) downto 1 do
//    begin
//           power:=Trunc(intpower(podstawa, n));
//          case liczba2[i] of
//              '0'..'9': result:=(Ord(liczba2[i])-Ord('0'))*power+result;             //zamiast potegi *M pozniej M:=M shl 4;
//              'A'..'F': result:=((Ord(liczba2[i])-Ord('A'))+10)*power+result;
//          end;
//          n:=n+1;
//    end;
//  anyToDec:=result;
//end;
//
//
//
//begin
//  repeat
//  write('podaj liczbe: ');
//  //readln(liczba2);
//  writeln(anyToDec('8F', 16));
//  //writeln(anyToDec(liczba2, 8));
//  writeln();
//  x:=1;
//
//
//
//
//{  write('w systemie 16: ');
//  convert(liczba, 16);
//  write('w systemie 8: ');
//  convert(liczba, 8);
//  write('w systemie 2: ');
//  convert(liczba, 2);  }
//
//
//  //writeln('nacisnij 0 aby wyjsc');
//  //readln(x);
//  until (x=0)
//end.



