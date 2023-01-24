private DateTime prevDateTime;
private int prevId = -1;
private double prevLon;
private double prevLat;



DateTime rowDateTime = Row.Data.Add(Row.Czas);
        if (prevId == Row.IDzlecenia)
        {
            Row.czasrealizacji = (prevDateTime - rowDateTime).TotalSeconds;
            double lat1 = Row.Geolokalizacjaszerokosc * 2 * Math.PI / 360;
            double lon1 = Row.Geolokalizacjadlugosc * 2 * Math.PI / 360;
            double lat2 = prevLat;
            double lon2 = prevLon;
            Row.pokonanaodleglosc = Math.Acos(Math.Sin(lat1) * Math.Sin(lat2) + Math.Cos(lat1) * Math.Cos(lat2) * Math.Cos(lon2 - lon1)) * 6371000;
        }
        prevDateTime = rowDateTime;
        prevId = Row.IDzlecenia;
        prevLat = Row.Geolokalizacjaszerokosc * 2 * Math.PI /360;
        prevLon = Row.Geolokalizacjadlugosc * 2 * Math.PI / 360;
		
		
		
		
        DateTime rowDateTime = Row.Data.Add(Row.Czas);
        if (prevId == Row.IDzlecenia)
        {
            Row.czasrealizacji = (prevDateTime - rowDateTime).TotalSeconds;

            double rad = Math.PI / 180;
            int r = 6371000; //m

            double rowLat = Row.Geolokalizacjaszerokosc;
            double rowLon = Row.Geolokalizacjadlugosc;
            double a = 0.5 - Math.Cos((prevLat - rowLat) * rad) / 2 + Math.Cos(prevLat * rad) * Math.Cos(rowLat * rad) * (1 - Math.Cos((prevLon - rowLon) * rad)) / 2;
            double distance = 2 * r * Math.Asin(Math.Sqrt(a));
            Row.pokonanaodleglosc = distance;
        }
        prevDateTime = rowDateTime;
        prevId = Row.IDzlecenia;
        prevLat = Row.Geolokalizacjaszerokosc;
        prevLon = Row.Geolokalizacjadlugosc;


50,86079; 17,4674
51,14942; 15,00835
273