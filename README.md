# Projekt zespołowy grupa 1



## Temat projektu

Aplikacja mobilna dla systemów Android i iOS pozwalająca na geolokalizację
ulubionych zdjęć na podstawie API Google Maps.


## Opis i zakres projektu

Przedmiotem projektu jest zaprojektowanie, wykonanie, wdrożenie i
uruchomienie aplikacji działającej na urządzeniach mobilnych pracujących pod
systemami operacyjnymi Android oraz iOS, która wykorzystuje technologie
Flutter, Dart oraz system baz danych Firebase. Pozwala użytkownikowi na
wykonanie zdjęcia oraz oznaczenie jego lokalizacji.


## Cel projektu

Stworzenie użytecznej aplikacji spełniającej oczekiwania użytkownika z
przyjemnym w obsłudze interfejsem graficznym. Aplikacja powinna niemal
natychmiastowo reagować na interakcję, być zgodna z różnymi wersjami
systemów operacyjnych oraz być zoptymalizowana pod kątem wydajności i
skutecznie przetestowana. Główną funkcjonalnością jest wykonywanie zdjęć z
możliwością oznaczenia miejsca ich stworzenia oraz dodatkowo ma
zapewnienie zapisania danych w pamięci urządzenia.


## Wymagania funkcjonalne

- Logowanie i uwierzytelnianie – oczekiwane zachowanie: system
powinien pozwolić użytkownikowi na logowanie przy użyciu jego nazwy
użytkownika i hasła lub mailem oraz weryfikować ich poprawność.
- Wykonanie zdjęcia – system pozwala wykonać zdjęcie przy użyciu
aparatu urządzenia, a następnie wyświetla je na ekranie aplikacji.
- Oznaczenie lokalizacji – system daje możliwość dodania lokalizacji
wykonania zdjęcia oraz wyświetla ją użytkownikowi.
- Pobranie lokalizacji – system pobiera aktualną lokalizację użytkownika
oraz wyświetla ją na mapie.

## Wymagania niefunkcjonalne

- Aplikacja o niskiej zawodności – ograniczenie do minimum wyrzucanych błędów powodujących nieprzewidziane zachowanie aplikacji.
- Aplikacja powinna mieć kolor tła wszystkich ekranów HEX: #49362a
- Użyteczność – możliwość wykorzystania danych przechowywanych w aplikacji w innych projektach
- Wydajność – czas wyświetlania zdjęcia po wykonaniu nie powinien przekraczać 3 sekund.
- Optymalizacja – pisanie kodu w sposób maksymalizujący wydajność, czytelność oraz zgodny z konwencjami.


## Harmonogram prac

| Data zajęć | Opis zrealizowanych zagadnień |  
| 04.10.2023 | Karta projektu, podział zespołu i przydzielenie zadań. |  
| 11.10.2023 | Zapoznanie uczestników z technologiami i narzędziami pracy (w tym Android Studio), ramowy szkielet aplikacji. |  
| 18.10.2023 | Stworzenie warstwy UI i frontendu aplikacji. |  
| 25.10.2023 | Stworzenie bazy danych i połączeń między niższymi warstwami aplikacji. |  
| 08.11.2023 | Testowanie oprogramowania i eliminacja błędów (I). |  
| 15.11.2023 | Implementacja obsługi aparatu i odbiornika GPS urządzenia oraz podłączenie do API systemów Google. |  
| 22.11.2023 | Konwersja aplikacji z systemu Android na iOS. |  
| 29.11.2023 | Testowanie oprogramowania i eliminacja błędów (II). |  
| 06.12.2023 | Prezentacje końcowych wersji projektów, oddanie dokumentacji. |  
| 13.12.2023 | Końcowe zaliczenie projektu. |  

## Dodawanie plików

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/projekt-zespolowy-grupa-1/projekt-zespolowy-grupa-1.git
git branch -M main
git push -uf origin main
```
