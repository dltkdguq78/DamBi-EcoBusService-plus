class ChangeLocation{

  String regionname(String region){
    if(region == '경상북도') {
      return '경북';
    }
    else if(region == '경상남도') {
      return '경남';
    }
    else if(region == '전라북도') {
      return '전북';
    }
    else if(region == '전라남도') {
      return '전남';
    }
    else if(region == '충청북도') {
      return '충북';
    }
    else if(region == '충청남도') {
      return '충남';
    }
    else if(region == '강원도') {
      return '강원';
    }
    else if(region == '제주도') {
      return '제주';
    }
    else if(region == '서울특별시') {
      return '서울';
    }
    else if(region == '대전광역시') {
      return '대전';
    }
    else if(region == '광주광역시') {
      return '광주';
    }
    else if(region == '인천광역시') {
      return '인천';
    }
    else if(region == '대구광역시') {
      return '대구';
    }
    else if(region == '부산광역시') {
      return '부산';
    }
    else if(region == '울산광역시') {
      return '울산';
    }
    else if(region == '세종특별자치시') {
      return '세종';
    }
    else{
      if(region.contains("시") && region != "광양시" && region != "경주시" && region != "양산시" && region != "김해시"){
        return region.substring(0, region.length-1);
      }
      else{
        return region;
      }
    }
  }
}