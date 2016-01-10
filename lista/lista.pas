program lista;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };

type pItem = ^element;
  element = record
    value : integer;
    index : integer;
    next, prev : pItem;
  end;
var
  Head, Tail, swapping : pItem;
  counter, i : integer;

procedure addAtTop(wartosc: integer);
var
  tmp, nowy : pItem;

begin
     new(nowy);
     inc(counter);
     nowy^.value:=wartosc;
     nowy^.index:=counter;
     nowy^.next:=Head;
     nowy^.prev:=nil;

     if Head <> nil then
        Head^.prev:=nowy
     else Tail := nowy;
     Head := nowy;
end;

procedure addAtBottom(wartosc : integer);
var tmp, nowy : pItem;
begin
     new(nowy);
     inc(counter);
     nowy^.value:=wartosc;
     nowy^.index:=counter;
     nowy^.next:=nil;
     nowy^.prev:=Tail;

     if Tail <> nil then
        Tail^.next:=nowy
     else
       Head := nowy;
     Tail := nowy;
end;

procedure show();
var
  tmp : pItem;
begin
     tmp := Head;
     if Head = nil then
        begin
          writeln('lista pusta');
          exit();
        end;
     while tmp <> nil do
     begin
           writeln('index: ',tmp^.index,'> ',tmp^.value);
           tmp := tmp^.next;
     end;

end;

procedure myBubbleSort();
var
  tmp : pItem;
  i,n, toSwap: integer;
begin
  n := counter;
  tmp := Head;
  //repeat
    for i:=1 to n do
    begin
      tmp:=Head;
      while tmp^.next<>nil do
      begin
          if tmp^.value > tmp^.next^.value then
          begin
            toSwap := tmp^.value;
            tmp^.value:=tmp^.next^.value;
            tmp^.next^.value:=toSwap;
          end;

          tmp:=tmp^.next;

      end;

    end;

end;

function GetMinElement(tmp : pItem): pItem;
var
  //tmp : pItem;
  minItem : pItem;
  minValue : integer;
begin
  //tmp:=Head;
  minValue := tmp^.value;
  minItem:=tmp;
  while tmp^.next<>nil do
  begin
    if tmp^.next^.value<minValue then
    begin
       minValue:=tmp^.next^.value;
       minItem:=tmp^.next;
    end;
    tmp:=tmp^.next;
  end;
  result := minItem;
end;
procedure mySelectionSort();
var
  tmp, min: pItem;
  i, Hold : integer;
begin
  tmp := Head;
   for i:=1 to counter do
   begin
        min := GetMinElement(tmp);
        Hold := tmp^.value;
        tmp^.value:=min^.value;
        min^.value:=Hold;
        tmp:=tmp^.next;
   end;
end;

procedure DeleteAll();
var
  tmp : pItem;
begin
     while Head <> nil do
     begin
       tmp := Head^.next;
       dispose(Head);
       Head := tmp;
     end;
Head := nil;
Tail := nil;
counter := 0;
end;

procedure pop(item : pItem);
begin
     if item^.prev <> nil then
        item^.prev^.next:=item^.next
     else Head := item^.next;
     if item^.next <> nil then
        item^.next^.prev:=item^.prev
     else Tail := item^.prev;
end;

procedure insert(item : pItem);
var
  tmp, n, p : pItem;
begin
     tmp := Head;
     while (tmp^.value<=item^.value) AND (tmp^.next<>nil) do
           tmp:=tmp^.next;

     if (tmp^.value>item^.value) then
     begin
       if tmp^.prev=nil then
       begin
          tmp^.prev:=item;
          item^.next:=tmp;
          item^.prev:=nil;
          Head:=item;
       end
       else
       begin
         p := tmp^.prev;
         p^.next:=item;
         tmp^.prev:=item;
         item^.next:=tmp;
         item^.prev:=p;
       end;
     end
     else
     begin
       tmp^.next:=item;
       item^.prev:=tmp;
       item^.next:=nil;
       Tail := item;
     end;

end;

procedure InsertionSort();
var
  tmp, toMove : pItem;
  i : integer;
  moved : boolean;
begin
     moved := true;
     //for i:=0 to counter+10 do
     //begin
     repeat
     if moved then tmp := Head;
     begin
          if tmp^.next<>nil then
          begin
            if (tmp^.value>tmp^.next^.value) then
            begin
               toMove := tmp;
               pop(tmp);
               insert(tmp);
               moved:=true;
            end
            else
            begin
              tmp:=tmp^.next;
              moved := false;
              if tmp^.next=nil then break;
            end;
          end;
     end;

     until false;
end;


begin
  Head := nil; Tail := nil;
  counter := 0;
  Randomize;

  writeln('przed sortowaniem babelkowym');
  for i:=0 to 19 do
      addAtBottom(Random(19));
  show();
  writeln();
  myBubbleSort();               //babelkowe
  writeln('po sortowaniu:');
  show();

  writeln('---------------');
  DeleteAll();
  writeln();
  writeln('przed sortowaniem przez wstawianie');

  for i:=0 to 19 do
      addAtBottom(Random(20));
  show();
  writeln();
  mySelectionSort();            //wybieranie
  writeln('po sortowaniu');
  show();
  DeleteAll();
  writeln();

   for i:=0 to 19 do
      addAtBottom(Random(19));
   show();
   writeln();
   InsertionSort();               //wstawianie
   show();






  readln();
end.

