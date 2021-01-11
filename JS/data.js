var companytv = document.getElementById("company_TV")
var departmenttv = document.getElementById("department_TV")
var resulttv = document.getElementById("result_TV")
var submitbtn = document.getElementById("submit_BTN")
var token = getCookie("jwt")
var request = new XMLHttpRequest();

submitbtn.addEventListener("click", function(){
    
    var company = companytv.value;
    var department = departmenttv.value;
    if (company != "" && department != ""){
        request.open('POST', `http://10.0.2.2:9000/connectandgettables?db=${company}&token=${token}`, true)
        request.onload = function(){
            var data = this.response
            if (request.status >= 200 && request.status < 400) {
                console.log(data);
                var request2 = new XMLHttpRequest();
                request2.open('POST', `http://10.0.2.2:9000/getemployeeinfo?department=${department}&${token}`, true)
                request2.onload = function(){
                    var data2 = this.response
                    resulttv.innerHTML = data2
                }
                request2.send()
            }
            else{
                console.log(data)
                resulttv.innerHTML = "Unable to connect to company database"
            }
        }
        request.send()
    }
})

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) == ' ') {
        c = c.substring(1);
      }
      if (c.indexOf(name) == 0) {
        return c.substring(name.length, c.length);
      }
    }
    return "";
  }