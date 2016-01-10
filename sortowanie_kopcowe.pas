program sortowanie_kopcowe;

//type
  //TElem = integer;

const N = 15;
var
T : array [1..N] of integer = (0,1,3,2,16,9,10,14,8,0,99,78,0,6,5);
i, j, k, m, x : integer;


procedure randomize();
begin
     Randomize;
     for i:=1 to N do T[i] := Random(100)
end;
procedure build_heap();

begin
     for i:=1 to N do
     begin
          j := i; k := (j div 2);
          x := T[i];

          while (k > 0) AND (T[k] < x) do
          begin
               T[j] := T[k];
               j := k; k := (j div 2);
          end;
          T[j] := x;
     end;
end;

procedure sort();
begin
     for i := N downto 1 do
     begin
          x := T[1]; T[1] := T[i]; T[i] := x;
          j := 1; k := 2;

          while k < i do
          begin
               if ((k+1 < i) AND (T[k+1] > T[k])) then m := k+1
               else m := k;
               if (T[m] <= T[j]) then k:=i
               else
                 begin
                   x := T[j]; T[j] := T[m]; T[m] := x;
                   j := m; k := 2*j;
                 end;
          end;
     end;
end;

begin

for i:=1 to N do write(T[i],' ');
build_heap();
writeln();
writeln();
for i:=1 to N do write(T[i],' ');
writeln();
writeln();
sort();
for i:=1 to N do write(T[i],' ');
readln();
readln();

end.

