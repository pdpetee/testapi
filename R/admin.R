library("DBI")
library("RPostgres")
library("plumber")
library("jose")
library("stringr")

# Use sessions instead don't save as global variables
# if dont store in cookies, the token will not be stored and the session will not be deleted if did not log out

con_ <<- NULL;
condata_ <<- NULL;
token_ <<- NULL;

#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*") # Or whatever
  plumber::forward()
}

#* @post /checktoken
checkToken <- function(token = token_){
  if (is.null(token)){
    return(FALSE);
  }
  else{
    con <- dbConnect(RPostgres::Postgres(),
                     dbname="login",
                     host="127.0.0.1",
                     port="5432",
                     user="postgres",
                     password="password")
    isTokenValid <- dbGetQuery(con, paste0("SELECT verifyjwt('", token, "')"))
    
    return(isTokenValid[[1]])
  }
}

#* @post /decodetoken
decodeToken <- function(token = token_){
  if (checkToken(token)){
    # Is this SAFE?????
    key <- charToRaw("secretkey")
    decodedjwt <- jwt_decode_hmac(token, secret = key)
    return(decodedjwt)
  }
}

authlogin <- function(){
  tryCatch({
    db_host <- "127.0.0.1"
    db_port <- "5432"
    db_user = "postgres"
    db_password = "password"
    db = "login"
    con <- dbConnect(RPostgres::Postgres(),
                     dbname=db,
                     host=db_host,
                     port=db_port,
                     user=db_user,
                     password=db_password)
    assign("con_", con, envir = .GlobalEnv)
    return(dbListTables(con))
  },
  error=function(cond){
    return("Unable to login")
  }
  )
}

#* @post /userlogin
function (username, password, con = con_){
  authlogin()
  if (!is.null(con)){
    dtfrm <- dbGetQuery(con, paste0("SELECT login('", username, "','", password,"');"))
    token <- gsub('"', '', dtfrm[[1]])
    assign("token_", token, envir = .GlobalEnv)
    return(token)
  }
}

#* @post /connectandgettables
datalogin <- function(db, token = token_){
  if (checkToken(token)){
    role <- decodeToken(token)$role
    db_host <- "127.0.0.1"
    db_port <- "5432"
    db_user = role
    db_password = "password"
    condata <- dbConnect(RPostgres::Postgres(),
                         dbname=db,
                         host=db_host,
                         port=db_port,
                         user=db_user,
                         password=db_password)
    assign("condata_", condata, envir = .GlobalEnv)
    return(dbListTables(condata))
  }
  else{
    return("Token is invalid")
  }
}

#* @post /getemployeeinfo
function(department, condata = condata_, token = token_){
  if (checkToken(token)){
    if (!is.null(condata)){
        userid <- decodeToken()$user_id
        dbGetQuery(condata, paste0("SET my.userid = ", userid))
        if (decodeToken()$role == "guest"){
          empinfo <- dbGetQuery(condata, paste0("SELECT name FROM ", department, ".employee;"))
        }
        else{
          empinfo <- dbGetQuery(condata, paste0("SELECT * FROM ", department, ".employee;"))
        }
        return(empinfo)
    }
    else{
      return("Login is invalid")
    }
  }
  return("Token is invalid")
}

#* @post /userlogout
function (token = token_){
  if (checkToken(token)){
    if (!is.null(con)){
      sessionToken <- decodeToken()$session_token
      dbGetQuery(con, paste0("SELECT logout('", sessionToken,"');"))
      assign("token_", NULL, envir = .GlobalEnv)
      return ("Successfully logged out")
    }
    return ("Authorization failed")
  }
  return("Token is invalid")
}