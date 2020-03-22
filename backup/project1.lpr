program project1;
uses wincrt, graph;

var gd, gm: smallint;
  volba, x1, y1, sirka, vyska: integer;

procedure pozadie(x1, y1, sirka, vyska: integer);
begin
  setfillstyle(1, lightgray);
  bar(x1, y1, x1 + sirka, y1 + vyska);
end;

procedure tlacitka(x1, y1, volba: integer);
var napisy: array[1..4] of string;
  i, sirka, vyska: integer;
begin
  napisy[1] := 'Darcek'; 
  napisy[2] := 'GIF';
  napisy[3] := 'Vcela a kvet';
  napisy[4] := 'Koniec';

  sirka := 150;
  vyska := 50;

  for i := 1 to length(napisy) do
  begin
    if(i = volba) then setcolor(black)
    else setcolor(white);
    line(x1, y1, x1 + sirka, y1);
    line(x1, y1, x1, y1 + vyska);
     
    if(i = volba) then setcolor(white)
    else setcolor(black);
    line(x1, y1 + vyska, x1 + sirka, y1 + vyska);
    line(x1 + sirka, y1, x1 + sirka, y1 + vyska);

    outtextxy(x1 + 10, y1 + vyska div 2, napisy[i]);

    y1 := y1 + vyska * 3 div 2;
  end;

  setcolor(white);
end;

procedure menu(x1, y1: integer; var volba: integer);
var ch: char;
begin
  setcolor(black);
  outtextxy(x1 + 10, y1 - 30, 'Moje vytvory');

  repeat
    tlacitka(x1, y1, volba);

    ch := readkey;

    case ch of
      #072: volba := volba - 1;
      #080: volba := volba + 1;
    end;

    if(volba > 4) then volba := 1;
    if(volba < 1) then volba := 4;

  until ch = chr(13);
end;

procedure platno(x1, y1: integer);
begin
  setfillstyle(1, white);
  bar(x1, y1, x1 + 610, y1 + 480);
end;

procedure darcek(x1, y1: integer);
var sirka, vyska, i, j, x, y: integer;
begin
  x1 := x1 + 150;
  y1 := y1 + 50;

  x := x1 + 10;
  y := y1 + 30;

  sirka := 200;
  vyska := 100;

  setfillstyle(1, yellow);
  bar(x1, y1, x1 + sirka - 40, y1 + vyska + 30);

  setcolor(red);
  outtextxy(x1 + sirka div 5 + 20, y1 + 10, '3WOW!');

  setfillstyle(1, lightgray);
  for i := 1 to 2 do
  begin
    for j := 1 to 3 do
    begin
      bar(x, y, x + sirka div 5, y + sirka div 5);
      x := x + sirka div 5 + 10;
    end;

    x := x1 + 10;
    y := y + sirka div 5 + 10;
  end;
end;

procedure vcela(x1, y1: integer);
var i: integer;
begin
  // hlava
  setfillstyle(1, yellow);
  setcolor(yellow);

  circle(x1 + 450, y1 + 150, 15);
  floodfill(x1 + 450, y1 + 150, yellow);

  // oci
  setcolor(black);
  circle(x1 + 445, y1 + 150, 3);
  circle(x1 + 455, y1 + 150, 3);

  // tykadla
  line(x1 + 445, y1 + 140, x1 + 440, y1 + 120);
  line(x1 + 455, y1 + 140, x1 + 460, y1 + 120);

  // telo
  for i := 1 to 7 do
  begin
    if(i mod 2 = 1) then
    begin
      setfillstyle(1, black);
      setcolor(black);

      circle(x1 + 450, y1 + 200, (8 - i) * 5);
      floodfill(x1 + 450, y1 + 200, black);
    end

    else
    begin
      setfillstyle(1, yellow);
      setcolor(yellow);

      circle(x1 + 450, y1 + 200, (8 - i) * 5);
      floodfill(x1 + 450, y1 + 200, yellow);
    end
  end;

end;

procedure kvet(x1, y1: integer);
var i: integer;
begin
  // lupene
  setcolor(cyan);
  setlinestyle(0, 0, 3);
  for i := 1 to 60 do
    line(x1 + 150 + round(cos(i * 6 * pi / 180) * 100),
         y1 + 200 + round(sin(i * 6 * pi / 180) * 100),
         x1 + 150 + round(cos(i * 6 * pi / 180) * 50),
         y1 + 200 + round(sin(i * 6 * pi / 180) * 50));

  //stonka
  setcolor(green);
  setlinestyle(0, 0, 5);
  line(x1 + 150, y1 + 200, x1 + 150, y1 + 450);

  // zlty stred
  setcolor(yellow);
  circle(x1 + 150, y1 + 200, 50);
  setfillstyle(1, yellow);
  floodfill(x1 + 150, y1 + 200, yellow);
end;

procedure vcelaKvet(x1, y1: integer; animovat: boolean);
var i: integer;
  pole: array[1..100000] of byte;
begin
  kvet(x1, y1);

  if(animovat) then
    for i := 1 to 20 do
    begin
      getimage(x1 + 410, y1 + 100, x1 + 490, y1 + 350, pole);
      vcela(x1, y1);
      putimage(x1 + 410, y1 + 100, pole, normalput);
      x1 := x1 - 10;
    end
  else vcela(x1, y1);

  setlinestyle(0, 0, 1);
end;

begin
  gd := Detect;
  initgraph(gd, gm, '');

  volba := 1;
  x1 := 100;
  y1 := 100; 
  sirka := 800;
  vyska := 500; 

  pozadie(x1, y1, sirka, vyska);
  platno(x1 + 175, y1 + 10);

  repeat
    menu(x1 + 10, y1 + vyska div 7, volba);
    pozadie(x1, y1, sirka, vyska);
    platno(x1 + 175, y1 + 10);

    case volba of
      1: darcek(x1 + 175, y1 + 10);
      2: vcelaKvet(x1 + 175, y1 + 10, true);
      3: vcelaKvet(x1 + 175, y1 + 10, false);
    end;
  until volba = 4;

  closegraph();
end.

