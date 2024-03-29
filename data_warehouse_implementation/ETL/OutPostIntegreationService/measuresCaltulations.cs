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
