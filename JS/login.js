var usernametv = document.getElementById("username_TV")
var passwordtv = document.getElementById("password_TV")
var loginbtn = document.getElementById("login_BTN")

loginbtn.addEventListener("click", function(){

    username = usernametv.value
    password = passwordtv.value
    if (username != "" && password != ""){
        var request = new XMLHttpRequest();
        request.open('POST', `http://10.0.2.2:9000/userlogin?username=${username}&password=${password}`, true)
        request.onload = function(){
            var data = JSON.parse(this.response)
            if (request.status >= 200 && request.status < 400) {
                console.log(data);
                alert(`Login successful. Your key is ${data}`) // Won't actually show this
                document.cookie = `jwt=${data}`
                location.replace("data.html")
            }
            else{
                console.log('error')
                alert(`Incorrect login`)
            }
        }
        request.send()
    }
    else{
        alert("Please enter a username/ password");
    }
})    
