.data											 ; dyrektywa .data wykorzystywana do inicjalizacji sta�ych danych u�wanych w programie
divider_value dq   003000000030000h				 ; divider_value -> sta�a warto�� 3 zapisania w postaci maski w celu wykonania dzielenia wektorowego typu Quad Word
alpha_mask dq      0ff000000ff000000h			 ; alpha_mask ->   maska kana�u przezroczysto�ci dla ka�dego piksela typu Quad Word
color_R_mask dq    00ff000000ff0000h			 ; color_R_mask -> maska koloru czerwonego dla ka�dego piksela typu Quad Word
.code
SepiaASM proc
									 ; G��wna procedura Sepia zajmuj�ca si� konwersj� obrazka na odcienie szaro�ci i wype�nienia sk�adowych piksela, aby otrzyma� efekt Sepii

push rbp										 ; zachowanie rejestru rbp na stos 
mov rbp, rsp									 ; zapis rejestru rsp do rbp.
push rdi									     ; zachowanie rejestru rdi na stos
push r12										 ; zachowanie rejestru r12 na stos
push r13										 ; zachowanie rejestru r13 na stos
push r14									     ; zachowanie rejestru r14 na stos
push rbx										 ; zachowanie rejestru rbx na stos

mov r14, qword ptr [rbp + 48]					 ; pobranie warot�ci 5. parametru do rejestru r14 zawieraj�cego warto�� g��bii Sepii. Jest to parametr pobrany ze stosu

mov r10, rcx									 ; �adownie adresu obrazka do rcx, aby go zapami�ta�

mov r11, rdx									 ; �adowanie poczatku tablicy do r11 na p�niejsze przetwarzanie tablicy

mov rcx, r8								         ; za�adowanie do rcx  ko�ca przedzia�u tablicy

mov r12, r9										 ; za�adowanie warto�ci wype�nienia  sepii do rejrestru r12

mov rdi, r10								     ; przenesienie adresu tablicy pikseli obrazka do rejestru rdi (rejestr indeksowy), aby obliczy� indeks od kt�rego b�dziemy zlicza� piksele

add rdi, rdx								     ; dodanie przesuniecia zwiazanego z podzialem na watki do rejestru rdi dodaj�c fo niego rejestr rdx, w rejestrze rdi aktualnie znajduje si� adres tablicy pikseli obrazka
 
sub rcx, rdx								     ; za�adowanie ilo�ci bit�w do przetworzenia, czyli koniec przedzia�u  - poczatek przedzia�u  do rejstru rcx  poprzez odj�cie rejestru rcx od rdx

movlps xmm0, color_R_mask						 ; �adowanie sta�ej maski koloru czerwonego R do rejestru xmm0, w celu po�niejszego zapisywania  danych sk�adowych piksela

vinsertf128 ymm0,ymm0, xmm0, 1					 ; �adowanie sta�ej maski koloru  czerwonego R do  dolnej cz�sci rejestru ymm0 z wykorzystaniem rejestru xmm0, aby wykonywa� operacje wektorowe na ca�ym rejestrze ymm0

movlps xmm1, divider_value					   	 ; �adowanie sta�ej maski liczby "3" (divider_value) dla warto�ci sk�adowych piksela  do rejestru xmm1, aby wykona� dzielenie przez sum� sk�adowych danego piksela

vinsertf128 ymm1,ymm1, xmm1,1					 ; �adowanie sta�ej maski liczby "3" (divider_value)  do dolnej cz�sci rejestru ymm1 z wykorzystaniem rejestru xmm1, aby wykonywa� operacje wektorowe na ca�ym rejestrze ymm1

movlps xmm2, alpha_mask							 ; �adowanie sta�ej maski przezroczysto�ci dla kana�u alpha do rejestru xmm2, aby zapami�ta� kana� przezroczysto�ci dla piksela

vinsertf128 ymm2, ymm2, xmm2, 1				     ; �adowanie sta�ej maski przezroczysto�ci do  dolnej cz�sci rejestru ymm2 z wykorzystaniem rejestru xmm2, aby  zapami�ta� kana� przezroczysto�ci dla 4 pikseli

vpshufd ymm0, ymm0, 00h						     ; ustawianie maski koloru czerwonego w ca�ym obszarze rejestru ymm0, pocz�wszy od pocz�tku rejestru ymm0.
                                                 ; w celu wykonania maskowania dla ca�ego rejestru z uwzgl�dnieniem odpowiedniego przesuni�cia na pocz�tek warto�ci
												
vpshufd ymm1, ymm1, 00h						     ; ustawianie dzielnika w ca�ym obszarze rejestru ymm1, pocz�wszy od pocz�tku rejestru ymm1
											     ; w celu wykonania maskowania dla ca�ego rejestru z uwzgl�dnieniem odpowiedniego przesuni�cia na pocz�tek warto�ci	

vpshufd ymm2, ymm2, 00h						     ; ustawianie maski kana�u przezroczysto�ci w ca�ym obszarze rejestru ymm2, pocz�wszy od pocz�tku rejestru ymm2
											     ; w celu wykonania maskowania dla ca�ego rejestru z uwzgl�dnieniem odpowiedniego przesuni�cia na pocz�tek warto�ci

vcvtdq2ps ymm3, ymm1					         ; zamiana warto�ci dzielnika 3 (divider_value) z typu int na float w celu wykonania dzielenia wektorowego przez liczby zmiennoprzecinkowe i zapami�tanie w rejestrze ymm3

average_loop:									 ; start p�tli wykonuj�cej odcienie szaro�ci algorytmu. Cz�� pierwsza wykonywania ca�ego algorytmu sepii

movdqu xmm10, [rdi]								 ; pobranie 4 pikseli z tablicy bajt�w obrazka  z rejestru rdi do xmm10, aby wykona� na nich operacje niezb�dne do wykonania algorytmu sepii 

add rdi, 16									     ; przesuniecie rejestru indeksowego o 16 pozycji do przodu, w celu pobrania nowych warto�ci z rejestru rdi

sub rcx, 16										 ; przesuniecie rejestru zliczaczj�vego o 16 pozycji do ty�u z rejestru rcx, aby nie wyj�� poza  zakres tablicy 


movdqu xmm9, [rdi]								 ;  pobranie kolejnych 4 pikseli z rejestru rdi do xmm9, aby wykona� na nich kolejne operacje niezb�dne do wykonania algorytmu sepii


vinsertf128 ymm4,ymm4,xmm10,0					 ; przesuniecie 4 pikseli do g�rnej cz�ci rejestru ymm4, aby p�niej wykona� na nich operacje wektorowe SIMD na 4 pikselach

vinsertf128 ymm4,ymm4,xmm9,1					 ; przsuniecie 4 piskeli do dolnej czesci rejestru ymm4, aby p�zniej wykona� operacje wektorowe SIMD na 4 pikselach

												 ; przetrzymywanie aktualnie 8 pikseli jednocze�nie w rejestrze ymm4
          
vmovaps ymm6, ymm4								 ; zapamietanie skladowych alpha 8 kolejnych pikseli w rejestrze ymm6, aby odpowiednio p�niej przekaza� warto�ci kana�u przezroczysto�ci do przetworzonych pikseli


vpand ymm6, ymm6, ymm2							 ; maskowanie kana�u przezroczysto�i 8 kolejnych pikseli w rejestrze ymm6, aby otrzyma� jedynie warto�ci sklad�wych piksela R,G,B

vmovaps ymm7,ymm4							     ; przepisanie 4 kolejnych pikseli bez kana�u przezroczysto�ci do rejestru ymm7 w celu wyci�gania z podanego rejestru odpowiednich sk�adowych piksela 

vpslldq ymm7,  ymm7 , 1							 ; logiczne przesuni�cie rejestru ymm7 o 2 warto�ci w zapisie szesnastkowym w lewo, kt�rym jest zadeklarowana wcze�niej sta�� maska koloru R, aby otrzyma� mask� koloru G
												 ; Wykorzystywana do maskowania kolor�w zielonych dla danego piksela i jednocze�nie przetrzymywanie tych warto�ci w podanej pozycji

vmovaps ymm8, ymm7								 ; zapami�tanie  rejstru ymm7 do ymm8, aby przechowywa� sta�� mask� koloru zielonego 


vpslldq  ymm8,ymm8, 1							 ; logiczne przesuni�cie rejestru ymm8 o 2 warto�ci w zapisie szesnastkowym w lewo, kt�rym jest zadeklarowana wcze�niej sta�� maska koloru G, aby otrzyma� mask� koloru B
												 ; Wykorzystywana do maskowania kolor�w niebieskich dla danego piksela i jednocze�nie przetrzymywanie tych warto�ci w podanej pozycji

												 
vpand ymm4, ymm4, ymm0						     ; zamaskowanie sk�adowych piksela A, G, B (A - kana� alhpa) rejestru ymm4 z wykorzystaniem maski kolory czerwonego z rejestru ymm0.W ten spos�b uzyskujemy same kolory czerwone R pikseli
												 
vpand ymm7,ymm7,ymm0							 ; zamaskowanie sk�adowych piksela A, R, B rejestru ymm7 z wykorzystaniem maski kolory czerwonego z rejestru ymm0. Uzyskujemy same kolory zielony G pikseli
 
vpand ymm8, ymm8, ymm0						     ; zamaskowanie sk�adowych piksela A, R, B rejestru ymm8 z wykorzystaniem maski kolory czerwonego z rejestru ymm0. Uzyskujemy same kolory zielony B piksei
												 
vpaddd ymm5, ymm4, ymm7		 					 ; zsumowanie rejestr�w ymm4 i ymm7 do rejestru ymm5. Uzyskujemy zsumowane kolry czerwone R i zielone G ( R+G). W celu wykonania �redniej arytmetycznej sk�adowych piksela.

vpaddd ymm5,ymm5, ymm8							 ; zsumowanie rejestr�w ymm5 i ymm8 do rejestru ymm5. Uzyskujemy sum� kolory czerwonego i zielonego oraz koloru niebieskiego (R+G+B). Mo�na dzi�ki temu  obliczy� �redni� arytemetyczn� piksela.

												
vcvtdq2ps ymm7, ymm5						     ; zamiana warto�ci int rejestru ymm6 na float do rejestru ymm7 w celu  wykonania dzielenia wektorowego  dzielenie warto�ci 3 kolejnych skladowcyh pikseli przez wartosc sta�ej maski dzielnika 3 (divider_value), 
												
vdivps ymm7, ymm7, ymm3							 ; wykonanie dzielenia wektorowego w celu otrzymania �redniej arytmetycznej (R+G+B) / 3, dzielenie wektorowe rejestru  ymm7 przez rejestr sta�ego dzienika 3 (divider_value) (rejestr ymm3 ) do rejestru ymm7
												 
											     
vcvtps2dq ymm5,ymm7								 ; zamiana warto�ci float rejestru ymm7 na int do rejstru ymm5, aby p�niej m�c zapisywa� warto�ci do tablicy bajt�w

vmovaps ymm7, ymm5								 ; przniesienie rejstru ymm5 do rejestru ymm7, aby zapami�ta� warto�ci �redniej arytmetycznej pikseli do p�niejszego przetwarzania

vpslldq ymm5,ymm5, 1							 ; logiczne przesuni�cie rejestru ymm5 ( aktualne obliczone �rednie arytmetyczne pikseli) o 2 warto�ci szesnastkowe w celu wpisania warto�ci X na odpowiedni� pozycj�, gdzie X = (R + B + G ) / 3 do rejestr ymm5 
											     ; reprezentacja warto�ci w rejestrze ymm5: 0,X,X,X

vpor ymm7,ymm7,ymm5							     ; logiczna operacja OR na rejestrze ymm5 i ymm7 do rejestru ymm7, w celu ustalenia pozycji piksela na odpowiednim bicie
                                                 ; Wykonywana w celu ustalenia 2 pierwszych pozycji dla  pikseli

vpslldq ymm5,ymm5, 1					         ; logiczne przesuni�cie rejestru ymm5 o 2 warto�ci szesnastkowo w celu wpisania warto�ci X wyja�nionych powy�ej na odpowiedni� pozycj�
									

vpor ymm7, ymm7, ymm5							 ; logiczna operacja OR na rejestrze ymm5 i ymm7 do rejestru ymm7, w celu ustalenia pozycji piksela na odpowiednim bicie
												 ; Wykonywana w celu ustalenia 2 ostatnich pozycji dla  pikseli				
																			
												 ; przepisanie watosci kanalu alpha				
vpor ymm7, ymm7, ymm6							 ; logiczny OR na rejestrze ymm7 i ymm5 w celu przepisanie do rejestru ymm7 warto�ci kana�u alpha z rejestru ymm6 na odpowiedni� pozycj� dla pikseli

sub rdi, 16									     ;  przesuniecie rejestru indeksowego o 16 pozycji do ty�u, w  celu po�niejszgeo odpowiedniego umieszczenia pikseli  w tablicy obrazka na starszej pozycji tablicy.


vextractf128 xmm9,ymm7,0						 ; przepisanie dolnej cz�ci rejestru ymm7 do rejestru xmm10 w celu wpisania wynikowych warto�ci do tablicy ( 4 piksele)

movdqu [rdi], xmm9								 ; przesuni�cie warto�ci wynikowych pikseli z rejestru xmm10 do rejestru indeksowego rdi, gdzie s� one zapisywane do tablicy 

add rdi, 16										  ; przesuni�cie rdi o 16 do przodu w celu umieszczenia pikseli  w tablicy obrazka na starszej pozycji tablicy

vextractf128 xmm10, ymm7,1						 ; przepisanie g�rnej cz�ci rejestru ymm7 do rejestru xmm10 w celu wpisania wynikowych warto�ci do tablicy ( 4 piksele)

movdqu [rdi], xmm10								 ; przesuni�cie warto�ci wynikowych pikseli z rejestru xmm10 do rejestru indeksowego rdi, gdzie s� one zapisywane do obrazka

add rdi, 16										 ; przesuni�cie rdi o 16, aby znajdowa� si� na w�a�ciwej pozycji obrazka w trakcie przetwarzania pikseli

sub rcx, 16										 ; odj�cie od indeksu zliczaj�cejgo  rcx 16, aby nie wyj�� poza zakres tablicy

cmp rcx, 31										 ; sprawdzenie czy przekroczono rozmiar tablicy i zako�czono zliczanie

jle prepare										 ; je�eli  zosta� przekoroczny rozmiar tablicy przygotowujemy do wype�nienia obrazka efektem sepii

jmp average_loop								 ; bezwarunkowy skok do p�tli licz�cej �redni� arytmetyczn�, czyli powr�t do wykonywania pierwszej cz�ci algorytmu



												 ; ZAKO�CZONO PIERWSZ� P�TL� I OBLICZONO ODCIENIE SZARO�CI 
												
												 ; USTAWIANIE POCZ�TKOWYCH WARTO��I DLA OBLICZENIA EFEKTU SEPII 
												 ; OPERACJE B�D� SI� TU SKLADA�Y NA: USTAWIENIE POCZ�TKOWYCH WARTO�CI REJESTR�W ORAZ SPRAWDZANIU W P�TLI CZY DANA WARTO�� SPE�NIA PODANE INSTRUKCJE WARUNKOWE
												 ; TAK JAK W J�ZYKU WYSOKIEGO POZIOMU B�D� TUTAJ WYKONYWANA ITERACJA P�TLI CO 4. warto�ci
												
												
prepare:									     ; p�tla przygotowuj�cac do wype�nienia obrazka nadaj�cy efekt sepii. Przypisywanie warto�ci pocz�tkowych dla danych rejestr�w

mov rdi, r10									 ; przepisanie do rdi pocz�tku adresu obrazka

add rdi, r11									 ; �adowanie pocz�tku  zliczania element�w tablicy zwi�zanego z podzia�em na w�tki poprzez dodanie do rejestru rdi warto�ci pocz�tkowej tablicy rejestru r11

mov rcx, r8										 ; za�adowanie do rcx ilo�ci bajt�w do przetworzenia

sub rcx, r11									 ; odj�cie przesuni�cia (offsetu) zwi�zanego z podzia�em na w�tki z rejestru rcx poprzez odj�cie ko�ca przedzia�u zliczania z rejestru r11

mov r12, 255									 ; za�adowanie do rejestru r12 warto�ci 255, aby sprawdza� czy nie przekroczono maksymalnej dozwolonej warto�ci piksela

mov r13, r12								     ; zapami�tanie warto�ci rejestru r12 do rejestru r13, w celu p�niejszego wykorzystania rejestru r12 ( warto�ci 255)
              					     
sub r13, r9									     ; odj�cie od rejestru 13 warto�ci spod rejestru r9. 255 - x, gdzie x to warto�� zadanej przez u�ytkownika efektu wype�nienia. Wykorzystywana do sprawdzenia czy warto�� wype�nienia sepii nie przekracza 255

sub r13, r9			    						 ; kolejne odj�cie do rejestru r13 warto�ci spod rejestru r9 wynikaj�cego z algorytmu Sepii

cmp rax, r13	                                 ; por�wnanie rejestru rcx z r13 czy warto�� wype�nienia nie przekracza maksymalnej warto�ci 255



ja max_red_first								 ; skok w przypadku przekroczenia maskymalnej warto�ci 255

add rax,r9										 ; je�eli nie przekroczono mmaksymalnej warto�ci dodajemy warto�� wype�nienia do akumulatora rax dla czerwonej sk�adowej  piksela

add rax,r9										 ; drugi raz dodajemy do akumulatora warto�� wype�nienia, poniewa� wynika to z algorytmu

jmp tone_loop	   							     ; skok bezwarunkowy do etykiety kontynuj�cej wype�nienia pikseli, poprzez pobranie kolejnego piksela

max_red_first:				    				 ; etykieta w przypadku przekroczenia maskymalnej warto�ci 255

mov rax, r12									 ; za�adowanie do  sk�adowej czerwonej  piksela warto�ci maksymalnej 255, poniewa� wsp�czynnik wype�nienia przekroczy� maksymaln� warto�� 255
											    
tone_loop:										 ; p�tla wykonuj�ca  wype�nienia piksela dla obrazka efektem Sepii i jego kontunuacja z pocz�tkowej p�tli

mov al, [rdi]									 ; przepisanie warto�ci sk��dowej niebieskiej piksela do akumulatora al

cmp rax, r14									 ; por�wnanie warot�ci sk�adowej niebieskiej piksela tablicy obrazka z warto�ci� parametru g��bi obrazka

jle min_blue									 ; je�eli warto�� sk�adowej niebieskiej jest mniejsza ni� parametru g��bii to ustaw warto�� sk�adowej na 0 poprzez skok do etykiety min_blue

sub rax, r14									 ; warto�� sk�adowej jest wi�ksza ni� parametru g��bii, nowa warto�� sk��dowej niebieskiej piksela to jej warto�� pomniejszona o podany parametr g��bi. Otrzmujemy j� poprzez odj�cie jej od parametru g�ebi

jmp continue_blue								 ; skok do etykiety  ustawiaj�cej obliczon� warto�� sk�adowej niebieskiej w tablicy obrazka oraz pobieraj�ca now� warto�� do akumulatora do wykonania przez pozosta�e instrukcje procedury

min_blue:										 ; etykieta min_blue, w kt�rej zostanie  ustawiona  warto�� 0 akuulatora, kt�ra wynika z aglorytmu g��bii. Nast�pnie zostanie przypisana jako warto�� nowej sk�adowej niebieskiej obrazka podana warto�� z akumulatora.

xor rax, rax									 ; operacja logiczna XOR, aby wyzerowa� akumulator i uzyska� warto�� 0 wynikaj�cej z algorytmu Sepii i wspisa� do sk�adowej piksela

continue_blue:								     ; etykieta zajmuj�ca si� ustawianiem warot�ci sk��dowych niebieskich piksela dla obrazka, aby otrzyma� efekt g��bii Sepii

mov [rdi], al									 ; przepisanie warto�ci przetworzonej sk�adowej niebieskiej piksela z akumulatora do tablicy obrazka

mov al, [rdi+1]								     ; przesuni�cie do akumulatora al warto�ci obrazka

mov r13, r12								     ; przesuni�cie do r13 warto�ci 255, w celu sprawdzenia czy nie przekroczono maskymalnej dopuszczalnej warto�ci

sub r13,r9										 ; odj�cie od rejestru 13 warto�ci spod rejestru r9. 255 - x, gdzie x to warto�� zadanej przez u�ytkownika efektu wype�nienia

cmp rax, r13								     ; por�wanie z akumulatorem rax czy przekroczono maksymaln� warto�� 255

ja max_green									 ; skok w przypadku przekroczenia maskymalnej warto�ci 255

add rax, r9										 ; je�eli nie przekroczono mmaksymalnej warto�ci dodajemy warto�� wype�nienia do akumulatora rax dla zielonej sk�adwoej  piksela

jmp continue_green								 ; skok do etykiety kontynuj�cej wype�nianie sk�adowej zielonej piksela

max_green:										 ; etykieta wpisuj�ca maksymaln� warto�� 255 dla koloru zielonego, poniewa� przekroczy� maksymaln� dopuszczaln� warto��

mov rax,r12										 ; wpisujemy do  akumulatora rax warto�� 255  z rejestru r12 dla sk�adowej zielonej piksela, wynika to z algorytmu

continue_green:									 ; etykieta do kontynuowania efektu wype�niania i wsadzenia warto�ci obliczonego wype�nienia do tablicy

mov [rdi+1],al									 ; przesuni�cia warto�ci akumulatora al do adresu obrazka, gdzie akumulator zawiera obliczon� warto�� wype�nienia

mov al,[rdi+2]				    				 ; pobranie kolejnej warto�ci piksela do akumulatora al, aby wykona� obliczanie algorytmu dla dalszych pikseli

mov r13, r12								     ; przesuni�cie do r13 warto�ci 255, aby sprawdzi� czy nie przekorczono maskymalnej warto�ci

sub r13, r9										 ; odj�cie od rejestru 13 warto�ci spod rejestru r9. 255 - x, gdzie x to warto�� zadanej przez u�ytkownika efektu wype�nienia

sub r13, r9			    					     ; kolejne odj�cie do rejestru r13 warto�ci spod rejestru r9 wynikaj�cego z algorytmu

cmp rax, r13									 ; por�wanie z akumulatorem rax czy przekroczono maksymaln� warto�� 255

ja max_red										 ; skok w przypadku przekroczenia maskymalnej warto�ci 255


add rax,r9										 ; je�eli nie przekroczono mmaksymalnej warto�ci dodajemy warto�� wype�nienia do akumulatora rax warto�� sk�adowej czerwonej piksela

add rax,r9								         ; drugi raz dodajemy do akumulatora warto�� wype�nienia


jmp continue_red	   						     ; skok bezwarunkowy do etykiety kontynuj�cej wype�nienia sk�adowej czrwonej piksela

max_red:				    					 ; etykieta w przypadku przekroczenia maskymalnej warto�ci 255

mov rax, r12								     ; wpisujemy do  akumulatora rax warto�� 255  z rejestru r12 dla sk�adowej czerownej piksela, poniewa� przekroczono maksymaln� dopuszczaln� warto��

continue_red:			   						 ; etykieta do kontynowania efektu wype�niania i wsadzenia warto�ci obliczonego wype�nienia do tablicy

mov [rdi+2], al								     ; przesuni�cia warto�ci akumulatora al do adresu obrazka, gdzie akumulator zawiera obliczon� warto�� wype�nienia

add rdi, 4									     ; przesuni�cie o 4 bity ( 1 piksel) do przodu warto�ci  rejestru indeksowego, gdzie znajduj� si� adres obrazka

sub rcx, 4									     ; odj�cie do warto�ci rejestru zliczaj�cego 4 ( 1 piksel), aby nie wyj�� poza zareks tablicy

cmp rcx, 3									     ; sprawdzenie czy zako�czono zliczanie

jle koniec									     ; je�eli warto�� poni�ej zera albo r�wna zeru skocz do etykiety koniec, zako�czono zliczanie dla drugiej cz�ci algorytmu

jmp tone_loop 									 ; skok bezwarunkowy do p�tli zewn�trznej wykonuj�cej g��wny proces wype�niania obrazka, poniewa� nie zako�czono przekszta�cania obrazka 
  
koniec:											 ; etykieta, w kt�rej ko�czymy wykonywanie naszego przetwarzania obrazka 

mov rcx, r10									 ; przywr�cenie pocz�tkowej warto�ci adresu tablicy obrazka do rejestru zliczeniowego, aby nie narazi� si� na nieodpowiedni odczyt warto�ci z rejestru zliczeniowego przez j�zyk wysokiego poziomu

												 ; zako�czenie algorytmu i powr�cenie warto�ci stanu stosu
pop rbx											 ; odczytanie rejestru rbx ze stosu 
pop r14											 ; odczytanie rejestru r14 ze stosu
pop r13											 ; odczytanie rejestru r13 ze stosu
pop r12											 ; odczytanie rejestru r12 ze stosu
pop rdi											 ; odczytanie rejestru rdi ze stosu
pop rbp											 ; odczytanie rejestru rbp ze stosu

ret											     ; powr�t z  g��wnej procedury Sepia

SepiaASM endp
end