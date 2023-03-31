//
//  WeatherModel.swift
//  Weather2
//
//  Created by Almat Kairatov on 27.03.2023.
//

import Foundation

struct Weather: Decodable {
    let now: Int
    let now_dt: String
    let yesterday: Yesterday?
    let geo_object: GeoObject?
    let info: Info?
    let fact: Fact?
    let forecasts: [Forecast]?
}
// MARK: - Forecast
struct Forecast: Decodable {
    let date: String?
    let date_ts, week: Int?
    let sunrise, sunset, rise_begin, set_end: String?
    let moon_code: Int?
    let moon_text: String?
    let parts: Parts?
    let hours: [Fact]?
    //    let biomet: Biomet?
    
    init(){
        date = nil
        date_ts = nil
        week = nil
        sunrise = nil
        sunset = nil
        rise_begin = nil
        set_end = nil
        moon_code = nil
        moon_text = nil
        parts = nil
        hours = nil
    }
//    init(){
//        date = ""
//        date_ts = 0
//        week = 0
//        sunrise = ""
//        sunset = ""
//        rise_begin = ""
//        set_end = ""
//        moon_code = 0
//        moon_text = ""
//        parts = Parts()
//        hours = [Fact]()
//    }
}

// MARK: - Parts
struct Parts: Codable {
    let  evening, night, day_short, morning, day, night_short: Day?
    init(){
        night = nil
        day_short = nil
        morning = nil
        day = nil
        night_short = nil
        evening = nil
    }
}
struct Day: Codable {
    let _source: String?
    let temp_min, temp_avg, temp_max: Int?
    let wind_speed, wind_gust: Double?
    let wind_dir: String?
    let pressure_mm, pressure_pa, humidity, soil_temp: Int?
    let soil_moisture: Double?
    let prec_mm, prec_prob, prec_period: Int?
    let cloudness: Double?
    let prec_type, prec_strength: Int?
    let condition: String?
    let uv_index: Int?
    let feels_like: Int?
    let daytime: String?
    let polar: Bool?
    let fresh_snow_mm: Int?
    let temp: Int?
    
    init() {
        _source = nil
        temp_min = nil
        temp_avg = nil
        temp_max = nil
        wind_speed = nil
        wind_gust = nil
        wind_dir = nil
        pressure_mm = nil
        pressure_pa = nil
        humidity = nil
        soil_temp = nil
        soil_moisture = nil
        cloudness = nil
        prec_mm = nil
        prec_prob = nil
        prec_period = nil
        prec_type = nil
        prec_strength = nil
        condition = nil
        uv_index = nil
        feels_like = nil
        daytime = nil
        polar = nil
        fresh_snow_mm = nil
        temp = nil
    }
}
// MARK: - Fact
struct Fact: Codable {
    let obs_time, uptime: Int?
    let temp, feels_like: Int?
    let condition: String?
    let cloudness: Double?
    let prec_type, prec_prob: Int?
    let prec_strength: Double?
    let is_thunder: Bool?
    let wind_speed: Double?
    let wind_dir: String?
    let pressure_mm, pressure_pa, humidity: Int?
    let daytime: String?
    let polar: Bool?
    let season, source: String?
    let soil_moisture: Double?
    let soil_temp, uv_index: Int?
    let wind_gust: Double?
    let hour: String?
    let hour_ts: Int?
    let prec_mm: Double?
    let prec_period: Int?
    let temp_water: Int?
    init() {
        obs_time = nil
        uptime = nil
        temp = nil
        feels_like = 0
        cloudness = 0.0
        prec_type = 0
        prec_prob = 0
        prec_strength = 0.0
        is_thunder = false
        wind_speed = 0.0
        pressure_mm = 0
        pressure_pa = 0
        humidity = 0
        polar = nil
        season = nil
        source = nil
        soil_moisture = 0.0
        soil_temp = 0
        uv_index = 0
        wind_gust = 0.0
        hour = nil
        hour_ts = nil
        prec_mm = nil
        prec_period = nil
        wind_dir = ""
        daytime = ""
        condition = nil
        temp_water = nil
    }
}

enum Condition: String {
    case clear = "Ясно"
    case partlyCloudy = "Малооблачно"
    case cloudy = "Облачно с прояснениями"
    case overcast = "Пасмурно"
    case drizzle = "Морось"
    case lightRain = "Возможен небольшой дождь"
    case rain = "Ожидается дождь"
    case moderateRain = "Ожидается умеренно сильный дождь"
    case heavyRain = "Сильный дождь"
    case continuousHeavyRain = "Ожидается длительный сильный дождь"
    case showers = "Ожидается ливень"
    case wetSnow = "Ожидается дождь со снегом"
    case lightSnow = "Возможен небольшой снег"
    case snow = "Ожидается снег"
    case snowShowers = "Ожидаетсяснегопад"
    case hail = "Возможен град"
    case thunderstorm = "гроза"
    case thunderstormWithRain = "Ожидаетсядождь с грозой"
    case thunderstormWithHail = "Возможен гроза с градом"

    static func fromString(_ string: String) -> Condition? {
        switch string {
        case "clear":
            return .clear
        case "partlyCloudy":
            return .partlyCloudy
        case "cloudy":
            return .cloudy
        case "overcast":
            return .overcast
        case "drizzle":
            return .drizzle
        case "lightRain":
            return .lightRain
        case "rain":
            return .rain
        case "moderateRain":
            return .moderateRain
        case "heavyRain":
            return .heavyRain
        case "continuousHeavyRain":
            return .continuousHeavyRain
        case "showers":
            return .showers
        case "wetSnow":
            return .wetSnow
        case "lightSnow":
            return .lightSnow
        case "snow":
            return .snow
        case "snowShowers":
            return .snowShowers
        case "hail":
            return .hail
        case "thunderstorm":
            return .thunderstorm
        case "thunderstormWithRain":
            return .thunderstormWithRain
        case "thunderstormWithHail":
            return .thunderstormWithHail
        default:
            return nil
        }
    }
}

enum Daytime: String, Codable {
    case d = "d"
    case n = "n"
}

enum Icon: String, Codable {
    case bknD = "bkn_d"
    case ovc = "ovc"
    case skcD = "skc_d"
    case skcN = "skc_n"
}

enum WindDir: String, Codable {
    case e = "e"
    case n = "n"
    case ne = "ne"
    case nw = "nw"
    case s = "s"
    case se = "se"
    case sw = "sw"
    case w = "w"
}

struct Info: Decodable {
    let n: Bool?
    let geoid: Int?
    let url: String?
    let lat, lon: Double?
    let tzinfo: Tzinfo?
    let def_pressure_mm, def_pressure_pa: Int?
    let slug: String?
    let zoom: Int?
    let nr, ns, nsr, p: Bool?
    let f, _h: Bool?
    
    init() {
        self.n = false
        self.geoid = 0
        self.url = ""
        self.lat = 0
        self.lon = 0
        self.def_pressure_mm = 0
        self.def_pressure_pa = 0
        self.slug = ""
        self.zoom = 0
        self.nr = false
        self.ns = false
        self.nsr = false
        self.p = false
        self.f = false
        self._h = false
        self.tzinfo = Tzinfo(name: "", abbr: "", dst: false, offset: 0)
    }
}
struct Tzinfo: Codable {
    let name, abbr: String?
    let dst: Bool?
    let offset: Int?
}
struct GeoObject: Decodable {
    let locality, province, country: Country?
//    let province: Country
//    let country: Country
    
    init() {
        locality = nil
        province = nil
        country = nil
    }
}

struct Country: Decodable {
    let id: Int?
    let name: String?
    
    init(){
        id = nil
        name = nil
        
    }
}
struct Yesterday: Codable {
    let temp: Int?
    init() {
        self.temp = nil
    }
}
