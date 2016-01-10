program trojkatPROSTY;

uses crt;

var h,i,j:integer;
var tab:array[1..15] of integer;

begin
write('Podaj wysokosc trojkata: ');
readln(h);

for i := 0 to h do
begin
    tab[i] := 1;
    for j := i-1 downto 1 do
    begin
        tab[j] := tab[j] + tab[j-1];
    end;
    if i mod 2 = 1 then
       write('   ');
    for j := Trunc(i/2) downto 1 do begin
        write(tab[j]:5,' ');
    end;
    write(1:5);
    writeln;
end;

readln;

end.

