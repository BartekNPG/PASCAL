program listadwukierunkowa;                  //chyba wszystko dziala
uses
crt;

type pLista = ^element;
  element = record
    content : string;
    next : pLista;
    prev : pLista;
  end;

var
    list_start, list_end, to_delete : pLista;
    ch : char;
    s, spom : string;
    n, all_elements : byte;

procedure show(var list_start : pLista);
var n: byte;
    tmp : pLista;
begin
  n:= 1;
  tmp := list_start;
  write('LISTA: ');
  while tmp <> nil do
    begin
        write(n,'. ');
        write(tmp^.content,'  ');
        tmp := tmp^.next;
        n:=n+1;
   end;
end;

function count(var list_start : pLista; n : byte) : pLista;
var i : byte;
    tmp: pLista;
begin
  i:=1;
  tmp := list_start;
  while (i<n) do
    begin
        tmp := tmp^.next;
        i:=i+1;
    end;
  count := tmp;

  writeln(count^.content);
end;

function count_all(var list_start : pLista) : byte;
var i : byte;
    tmp: pLista;
begin
  i:=1;
  tmp := list_start;
  while (tmp^.next <> nil) do
    begin
        tmp := tmp^.next;
        i:=i+1;
    end;
  count_all := i;


end;

procedure push_at_end(var list_end : pLista; s: string);    //dodawanie na koncu

  var nowy : pLista;
begin
   new(nowy);
   nowy^.next := nil;
   nowy^.prev := nil;
   nowy^.content := s;
  if list_start = nil then
  begin
   list_start := nowy;
   list_end := nowy;
 end
  else
  begin
    list_end^.next := nowy;
    nowy^.prev := list_end;
    list_end := nowy;
  end;
end;

procedure push_at_start(var list_start : pLista; s: string);    //dodawanie na list_startatku

  var nowy, tmp : pLista;
begin
   new(nowy);
   nowy^.next := nil;
   nowy^.prev := nil;
   nowy^.content := s;
  if list_start = nil then
  begin
   list_start := nowy;
   list_end := nowy;
 end
  else
  begin
    list_start^.prev := nowy;
    nowy^.next := list_start;
    list_start := nowy;
  end;
end;

procedure push_after_element(var list_start : pLista; s: string; spom : string);    //dodawanie ZA elementem

  var nowy, tmp : pLista;

begin
   new(nowy);
   nowy^.content := s;
   tmp := list_start;
   while (tmp^.content <> spom) do
     begin
        if (tmp^.next = nil) then
           begin
            writeln('                  >> Nie ma takiego elementu!');
            break;
           end;
      tmp := tmp^.next;
    end;
      if (tmp^.content = spom) then
      begin
        nowy^.next:=tmp^.next;
        nowy^.prev := tmp;
        if(tmp^.next <> nil) then tmp^.next^.prev := nowy
        else nowy^.next := nil;
        tmp^.next:=nowy;
        if (nowy^.next = nil) then
        list_end := nowy;
        writeln('dodano: ',s);
      end;
  end;

procedure push_before_element(var list_start : pLista; s: string; spom : string);    //dodawanie PRZED elementem
var nowy, tmp : pLista;

begin
 new(nowy);
 nowy^.content := s;
 tmp := list_start;
 while (tmp^.content <> spom) do
   begin
      if (tmp^.next = nil) then
         begin
          writeln('                  >> Nie ma takiego elementu!');
          break;
         end;
    tmp := tmp^.next;
  end;
    if (tmp^.content = spom) then
    begin
      nowy^.next:=tmp;
      if(tmp^.prev <> nil) then tmp^.prev^.next := nowy
      else nowy^.prev := nil;
      tmp^.prev:=nowy;
      if (nowy^.prev = nil) then
      list_start := nowy;
      writeln('dodano: ',s);
    end;
end;

procedure pop(var list_start : pLista);                  //opcje: pierwszy, ostatni, wybrany
var tmp: pLista;
begin
  if list_start <> nil then
  begin
  tmp := list_start;
  list_start := list_start^.next;
  writeln('usunieto: ',tmp^.content);
  dispose(tmp);
  end
  else writeln ('                  >> Lista jest pusta!');
end;

procedure pop_last(var list_end : pLista);                  //opcje: pierwszy, ostatni, wybrany
var tmp: pLista;
begin
  if list_start <> nil then
  begin
  tmp := list_end;
  list_end := list_end^.prev;
  writeln('usunieto: ',tmp^.content);
  dispose(tmp);
  end
  else writeln ('                  >> Lista jest pusta!');
end;

procedure pop_any(var to_delete: pLista);
var tmp : pLista;
begin
  tmp:=to_delete;

  if tmp^.prev = nil then
               list_start := tmp^.next
  else tmp^.prev^.next:=tmp^.next;

  if tmp^.next = nil then
               list_end := tmp^.prev
  else tmp^.next^.prev:=tmp^.prev;


    writeln('                  >> usunieto: ',to_delete^.content);
    dispose(tmp);
  end ;

procedure find(var list_start: pLista; s:string);
var tmp, help : pLista;
    n, i : byte;
    begin
     tmp:=list_start;
     n:=1;
     i:=0;

  {      while (tmp^.content <> s) do
         begin
           tmp := tmp^.next;
           n:=n+1;
         end;
         writeln('szukany element znajduje sie na ', n,' pozycji');
       end;   }
      begin
       repeat
         if tmp^.content = s then
         begin
          writeln('szukany element znajduje sie na ', n,' pozycji');
          i:=i+1;
         end;
          tmp := tmp^.next;
         n:=n+1;
         if (i=0) then
         writeln('nie znaleziono elementu');
       until (tmp=nil);
      end;
    end;

begin
list_start := nil;
list_end:= nil;

repeat
   writeln();
   writeln('||===========================||');
   writeln('||    Dodaj do listy - 1     ||');
   writeln('||     usun z listy - 2      ||');
   writeln('||  wyswietl stan listy - 3  ||');
   writeln('||     szukaj elementu - 4   ||');
   writeln('||===========================||');
   ch:=ReadKey; {Read ScanCode}
   case ch of
   #49 :                 // 1 - dodaj
         begin

           writeln('    ________________________');
           writeln('   //  Dodaj na koncu - 1  \\ ');
           writeln('  //  Dodaj na list_startatku - 2 \\');
           writeln(' //  Dodaj za elementem - 3  \\');
           writeln('//  Dodaj przed elementem - 4 \\');
           writeln('//       pokaz stan - 5        \\');
           writeln('================================');
           ch:=ReadKey;
           case ch of
           #49:
               begin                                       //na list_end
                 write('Podaj element do dodania: ');
                 repeat
                   readln(s);
                 until (length(s)<>0);
                 push_at_end(list_end, s);
                 writeln('dodano: ',s);
               end;
           #50:
               begin                                       // na list_startatek
                 write('Podaj element do dodania: ');
                 repeat
                   readln(s);
                 until (length(s)<>0);
                 push_at_start(list_start, s);
                 writeln('dodano: ',s);
               end;
           #51:
               begin                                       // za element
                 if list_start = nil then
                    writeln('                  >> lista jest pusta!')
                 else
                   begin
                     show(list_start);
                     writeln();
                     write('Podaj element do dodania: ');
                     repeat
                       readln(s);
                     until (length(s)<>0);
                     writeln();
                     write('za ktorym elementem mam wstawic nowy? (podaj jego zawartosc): ');
                     readln(spom);
                     push_after_element(list_start,s,spom);

                   end;
               end;
           #52:
               begin                                       // przed element
                 if list_start=nil then writeln('                  >> lista jest pusta!')
                 else
                   begin
                     show(list_start);
                     writeln();
                     write('Podaj element do dodania: ');
                     repeat
                       readln(s);
                     until (length(s)<>0);
                     writeln();
                     write('Przed ktorym elementem mam wstawic nowy? (podaj jego zawartosc): ');
                     readln(spom);
                   push_before_element(list_start,s,spom);
                  end;
               end;
           #53:
               begin
                 clrscr;
                 writeln();
                 show(list_start);
                 readln();
                 clrscr();
               end;
           end;
          // readln();
          // clrscr;
         end;
   #50 :                 // 2 - zdejmij
         begin
           if (list_start<>nil) then
           begin
             show(list_start);
             writeln();
             repeat
               write('ktory element chcesz usunac? (podaj indeks): ');
               readln(n);
               all_elements:=count_all(list_start);
               if (n<=all_elements) then
               begin
                    to_delete := count(list_start,n);
                    pop_any(to_delete);
               end
               else writeln('nie ma takiego elementu');
             until (n<=all_elements);
           //  pop_last(list_end);
            //pop(list_start);
           end
           else writeln('                  >> Lista jest pusta!');
         end;
   #51 :                  // 3 - stan
         begin
           clrscr;
           writeln();
           show(list_start);
           readln();
           clrscr();
         end;
   #52: begin
         if list_start=nil then
            writeln('                  >> lista jest pusta!')
         else
           begin
            writeln('czego szukasz?');
            show(list_start);
            writeln();
            readln(s);
            find(list_start,s);
           end;
        end;

   end;
    //#27 : WriteLn('ESC');
  until (ch=#27); {Esc}
     readln();
end.




