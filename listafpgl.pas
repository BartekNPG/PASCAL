program listafpgl;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, fgl
  { you can add units after this };
type
  TIntegerList = specialize TFPGList<Integer>;

function Comparer(const a,b : integer) : integer;
begin
  if a > b then exit(1);
  if a < b then exit(-1);
  if a = b then exit(0);
end;

var
  MyList : TIntegerList;
  i : integer;

begin
  MyList := TIntegerList.Create;
  Randomize;
  for i:=0 to 19 do
      MyList.Add(Random(19));
  for i:=0 to MyList.Count-1 do
      Write(MyList.Items[i],', ');
  writeln();
  MyList.Sort(@Comparer);

  for i:=0 to MyList.Count-1 do
      Write(MyList.Items[i],', ');
  readln();
  //usuwa ostatni(e) element
  MyList.Delete(MyList.Count-1);
  MyList.Delete(MyList.Count-1);
  MyList.Delete(MyList.Count-1);

  for i:=0 to MyList.Count-1 do
      Write(MyList.Items[i],', ');
  readln();

end.

