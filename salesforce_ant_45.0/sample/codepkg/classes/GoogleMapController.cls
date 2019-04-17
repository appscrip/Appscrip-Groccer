public class GoogleMapController {

    public String getLocatioList() {
        return null;
    }


    public String getI() {
        return null;
    }


    public List<Map<String,Decimal>> locationList{get;set;}
    public Map<String , Decimal> locationMap; 
    public GoogleMapController(){
    
        locationList = new List<Map<String,Decimal>>();
        locationMap = new Map<String , Decimal>();
        locationMap.put('RTNAGAR-lat',13.0196);
        locationMap.put('RTNAGAR-long', 77.5968);
        locationList.add(locationMap);
    }



}