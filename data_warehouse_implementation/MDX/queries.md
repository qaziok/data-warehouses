# KPIs

1. Co roku roku średni czas dostarczania przesyłek od momentu
umieszczenia jej w paczkomacie przez nadawcę, do momentu
umieszczenia paczki w sortowni docelowej zmniejszy się o 10%.
    * value
    ```
    [Measures].[sredni_czas_realizacji]
    ```
    * goal
    ```
    (KPIVALUE("Średni czas dostarczenia"),[Data].[hierarhia_daty].currentMember.prevMember) * 0.9
    ```
    * status
    ```
    IIf (KPIVALUE( "Średni czas dostarczenia" ) < KPIGoal("Średni czas dostarczenia"), 1, -1)
    ```
    * trend
    ```
    IIf (KPIVALUE("Średni czas dostarczenia") < (KPIVALUE("Średni czas dostarczenia"), [Data].[hierarhia_daty].currentMember.prevMember), 1, -1)
    ```

2. Co roku liczba przewiezionych paczek w odpowiadających miesiącach zwiększy się o 8%.
* value
    ```
    [Measures].[ilosc_paczek]
    ```
    * goal
    ```
    (KPIVALUE("Liczba przewiezionych paczek"),[Data].[hierarhia_daty].currentMember.lag(12)) * 1.08
    ```
    * status
    ```
    IIf (KPIVALUE( "Liczba przewiezionych paczek" ) > KPIGoal("Liczba przewiezionych paczek"), 1, -1)
    ```
    * trend
    ```
    IIf (KPIVALUE("Liczba przewiezionych paczek") > (KPIVALUE("Liczba przewiezionych paczek"), [Data].[hierarhia_daty].currentMember.lag(12)), 1, -1)
    ```

# Zapytania MDX

## Dlaczego powstają opóźnienia w transporcie paczek między sortowniami:

1. Porównaj zlecenia paczek na podstawie czasu i odległości pokonanych na każdym etapie transportu, z rozdzieleniem na rozmiary paczek.
```
SELECT NON EMPTY { [Zlecenie].[Id Zlecenie].children*[Paczka].[Rozmiar].children*[Paczka].[Waga].children  } ON ROWS,
{ [Measures].[Czas Realizacji], [Measures].[Odleglosc] } ON COLUMNS
FROM [OutPostdw]
```

2. Jaki wpływ ma wiek pracownika na czas realizacji etapu?
```
SELECT { [Pracownik].[Wiek].children } ON ROWS,
{ [Measures].[sredni_czas_obslugi_paczki] } ON COLUMNS FROM [OutPostdw]
```

3. Jaki wpływ ma wynagrodzenie pracownika na czas realizacji etapu?
```
SELECT { [Pracownik].[Wynagrodzenie].children } ON ROWS,
{ [Measures].[sredni_czas_obslugi_paczki] } ON COLUMNS FROM [OutPostdw]
```

4. Jaki wpływ ma rozmiar paczek na czas realizacji etapu?
```
SELECT { [Paczka].[Rozmiar].children } ON ROWS,
{ [Measures].[sredni_czas_obslugi_paczki] } ON COLUMNS FROM [OutPostdw]
```

5. Jaki wpływ ma masa paczek na czas realizacji etapu?
```
SELECT { [Paczka].[Waga].children } ON ROWS,
{ [Measures].[sredni_czas_obslugi_paczki] } ON COLUMNS FROM [OutPostdw]
```

## Gdzie warto otworzyć nową sortownię?

1. Porównaj najczęciej transportowane rozmiary paczek w określonych regionach.
```
SELECT { (EXCEPT( [Miejsce].[Region].children, {[Miejsce].[Region].&[None]}), [Measures].[ilosc_paczek]) } ON ROWS,
{ [Paczka].[Rozmiar].children } ON COLUMNS FROM [OutPostdw]
```

2. Które sortownie mają największy średni czas obsługi paczki?
```
SELECT { TOPCOUNT([Miejsce].[Nr Miejse].children,3,[Measures].[sredni_czas_obslugi_paczki]) } ON ROWS,
{ [Measures].[sredni_czas_obslugi_paczki] } ON COLUMNS
FROM [OutPostdw] WHERE [Miejsce].[Typ].&[sortownia]
```

3. Które sortownie obsługują najwięcej paczek?
```
SELECT { TOPCOUNT([Miejsce].[Nr Miejse].children,3,[Measures].[ilosc_paczek]) } ON ROWS,
{ [Measures].[ilosc_paczek] } ON COLUMNS
FROM [OutPostdw] WHERE [Miejsce].[Typ].&[sortownia]
```

4. Które sortownie mają największy średni staż pracownika?
```
SELECT { TOPCOUNT([Miejsce].[Nr Miejse].children,3,[Measures].[sredni_staz_pracownika]) } ON ROWS,
{ [Measures].[sredni_staz_pracownika] } ON COLUMNS
FROM [OutPostdw] WHERE [Miejsce].[Typ].&[sortownia]
```

5. Które sortownie obsługują najwięcej paczek w stosunku do ilości pracowników?
```
WITH
MEMBER [Measures].[Stosunek] AS '[Measures].[liczba_pracownikow] / [Measures].[ilosc_paczek]'
SELECT { TOPCOUNT([Miejsce].[Nr Miejse].children,3,[Measures].[Stosunek]) } ON ROWS,
{ [Measures].[Stosunek], [Measures].[liczba_pracownikow], [Measures].[ilosc_paczek] } ON COLUMNS
FROM [OutPostdw] WHERE [Miejsce].[Typ].&[sortownia]
```

## Extra

```
with member [Measures].[Średnia liczba przepracowanych dni w regionie] as
AVG( [Miejsce].[hierarhia_lokalizacji_miejsca].CurrentMember.children, [Measures].[liczba_przepracowanuch_dni_w_sortowni] )
SELECT {  [Measures].[Średnia liczba przepracowanych dni w regionie] } on rows,
{ [Miejsce].[hierarhia_lokalizacji_miejsca].[Region] } on columns from [OutPostdw] where [Miejsce].[Typ].&[sortownia]
```

```
select NON EMPTY [Pracownik].[Nr Pracownika].children*[Data].[Miesiac].children on rows,
[Measures].[liczba_przepracowanuch_dni_w_sortowni] on columns
from  [OutPostdw]
```
