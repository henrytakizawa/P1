public class GeoRESTCallout {

    public static String postalCheck(String city, String zipcode){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://api.geonames.org/postalCodeLookupJSON?postalcode='+zipcode+'&country=US&username=hayhujac');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            Map<String, Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> postalCodeList = (List<Object>) resMap.get('postalcodes');
            Map<String, Object> postalCodeMap = (Map<String, Object>) postalCodeList[0];
            if (postalCodeMap.get('placeName') == city){
                return 'The Zipcode: ' + zipcode + ' is in ' + city;
            }else{
                return 'The Zipcode: ' + zipcode + ' is not in ' + city;
            }
        }
            return 'Error'; 
    }
}