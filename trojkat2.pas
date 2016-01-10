program trojkat2;

function silnia(n: integer) : integer;
begin
     if n<2 then silnia:=1
     else
       silnia:=n*silnia(n-1);
end;

function DwumianN(m, n: integer) : real;
begin
     DwumianN := silnia(m) / (silnia(m-n)*silnia(n));

end;

procedure przerwa(n: integer);
var
  i : integer;
begin
     for i:=1 to n do
         write('   ');
end;

procedure TrojkatP(n: integer);
var
  i, j : integer;
begin
     for i:= 0 to n-1 do
     begin
       przerwa(n-i);
       for j:=0 to i do
           write(DwumianN(i,j):5:0, ' ');
       writeln();
     end;
end;

procedure TrojkatTPrawy(n: integer);
var
  i, j, k: integer;
begin
    k:=0;
    for i:=0 to n-1 do
    begin
      if (i mod 2 = 1) then przerwa(1);
      for j:=i-k to i do
          write(DwumianN(i,j):5:0, ' ');
      writeln();
      k := k + i mod 2;
    end;
end;

begin
  TrojkatP(11);
  writeln();
  TrojkatTPrawy(11);
  readln();
end.

