program kolejka;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };

type
  pItem = ^element;
    element=record
      id: integer;
      next : pItem;
    end;
var
  Head, Tail: pItem;
procedure push(number : integer);            // dodajemy na koncu
var
  tmp, nowy :pItem;
begin
   new(nowy);
   nowy^.id:=number;
   nowy^.next:=nil;

   tmp:=Head;
   if Head=nil then
   Head := nowy
   else
   begin
   while tmp^.next <> nil do
         tmp:=tmp^.next;
   tmp^.next:=nowy;

   end;


end;

procedure pop();                  //kolejka - usuwamy z poczatku
var tmp: pItem;
begin
   tmp := Head;
   Head := Head^.next;
   dispose(tmp);

end;

procedure show();
var tmp :pItem;
begin
   tmp := Head;
   while tmp<>nil do
   begin
     write(tmp^.id,' ');
     tmp:=tmp^.next;
   end;
   writeln();
end;

begin
  Head := nil;
  Tail := nil;
  push(1);
  push(2);
  push(3);
  push(4);
  push(5);
  show();
  pop();
  pop();
  show();
  push(1);
  show();
  readln();

end.

