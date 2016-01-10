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
     //tmp := Tail;
     //while tmp <> nil do
     //begin
     //writeln('(',tmp^.index,')> ',tmp^.value);
     //tmp:=tmp^.prev;

     //end;
end;


procedure swap(a, b : pItem);
var
  p, n : pItem;
begin
if (a=nil) OR (b=nil) then exit();


   if a^.next=b then           //obok siebie
    begin
       a^.next:=b^.next;
       b^.prev:=a^.prev;


       if a^.next <> nil then
          a^.next^.prev:=a;

       if b^.prev <> nil then
          b^.prev^.next:=b;

       b^.next:=a;
       a^.prev:=b;
     end
    else
    begin
         p := b^.prev;
         n := b^.next;

         b^.prev:=a^.prev;
         b^.next:=a^.next;

         a^.prev:=p;
         a^.next:=n;

         if (a^.next <> nil) then
            a^.next^.prev := a;

         if a^.prev <> nil then
            a^.prev^.next := a;

         if b^.next <> nil then
            b^.next^.prev:=b;

         if b^.prev <> nil then
            b^.prev^.next:=b;
    end;
end;

function getPointer(number :integer): pItem;
var
  item : pItem;
begin
    item := Head;
    while (item^.value<> number) AND (item<>nil) do
          item:=item^.next;

    if item^.value=number then result:=item
    else result := nil;
end;

procedure addWithSort(number: integer);

  var nowy, tmp : pItem;

begin
   new(nowy);
   nowy^.value := number;
   nowy^.next:=nil;
   nowy^.prev:=nil;
   tmp := Head;

   if Head=nil then
   begin
      Head := nowy;
      Tail := nowy;
   end
   else
   begin
        while (nowy^.value>tmp^.value) do
        if (tmp^.next<> nil) then
           tmp:=tmp^.next
        else
        begin
          tmp^.next:=nowy;
          nowy^.prev:=tmp;
          Tail:=nowy;

       end;

   end;
       if tmp^.next=nil then
       begin
          tmp^.next:=nowy;
          nowy^.prev:=tmp;
          Tail:=nowy;
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

     //if tmp^.next=nil then
     //begin
     //   tmp^.next:=item;
     //   item^.prev:=tmp;
     //   item^.next:=nil;
     //   Tail := item;
     //end
     //else
     //begin
     //  n:=tmp^.next;
     //  tmp^.next:=item;
     //  item^.prev:=tmp;
     //  item^.next:=n;
     //end;
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

