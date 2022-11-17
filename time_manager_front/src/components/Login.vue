<template>
    <div class="container">
      <div>
        <h2 class="mb-3">Login</h2>
        <div class="input mt-4">
            <div class="input">
            <label for="username">Username</label>
            <input
            class="form-control"
            type="username"
            name="username"
            placeholder="username123"
            id="user_username"
            />
            </div>
            <label for="email">Password</label>
            <input
            class="form-control"
            type="text"
            name="email"
            placeholder="Password..."
            id="user_mail"
            />
        </div>
        
        <button class="btn_style_1" id="login_button">
            Login
        </button>
        </div>
    </div>
</template>

<script>
  import axios from 'axios';
  import { show_error } from './ErrorBar.vue';
  import WorkingTimesVue from './WorkingTimes.vue';
    export default 
    {
        data() 
        {
            return {
            email: "",
            username: "",
            };
        },
        name: 'LoginCompnent',
        mounted(){
          document.getElementById('login_button').addEventListener('click', verify_user)
        }
    }
    
    async function verify_user(){
        let username = document.getElementById('user_username').value
        let password = document.getElementById('user_mail').value
        console.log(username, password)
        await axios.post("http://localhost:4000/api/auth/users/login/", {"username": username, "password": password}).then(async (res) => {
          if(res.data.success){
            let token = res.data.token
            localStorage.setItem('token', JSON.stringify(token))
            let config = {headers: {'Authorization': `Bearer ${token}`}}
            await axios.get("http://localhost:4000/api/user/", config).then((res) => {
              localStorage.setItem('current_user', JSON.stringify(res.data.data))
            })
            let user = JSON.parse(localStorage.getItem('current_user'))
            console.log(user)
            console.log(user)
            document.getElementById('dashboard_container').style.display = "block"
            document.getElementById('login_container').style.display = "none"
            document.getElementById('user_username_container').innerHTML = user.username
            document.getElementById('user_email_container').innerHTML = user.email
            document.getElementById('user_team_container').innerHTML = user.team_id.name
            document.getElementById('user_group_container').innerHTML = (user.group != undefined) ? user.group.name : "No group"
            await WorkingTimesVue.methods.on_user_load()
          }
          else{
            localStorage.setItem('current_user', null)
            show_error(0, "Username or email is invalid")
          }
        }).catch(function () {
          show_error(0, "Username or email is invalid")
        });

    }
   
    
    
</script>

<style>

/* CUSTOM STYLE */
#content {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border: 1px solid lightgray;
  padding: 4rem 4rem;
  border-radius: 5px;
  background: #fefefe;
}
.background {
  width: 100vw;
  height: 100vh;
  position: absolute;
  background: rgb(250, 250, 250);
}
.navbar {
  background: #fafafa;
  position: absolute;
  top: 0;
  width: 100vw;
  height: 70px;
  box-shadow: 6.7px 6.7px 5.3px rgba(0, 0, 0, 0.028),
    22.3px 22.3px 17.9px rgba(0, 0, 0, 0.042),
    100px 100px 80px rgba(0, 0, 0, 0.07);
}
.nav {
  width: 80%;
  min-width: 400px;
  margin: auto;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  background: #fafafa;
}
#name_project {
  font-weight: 700;
}
.container {
  margin-top: 5vh;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid black;
  border-radius: 45px;
  text-align: center;
  background-color: #10131A;
  padding-bottom: 2vh;
}
.input {
  display: flex;
  flex-direction: column;
  margin-bottom: 15px;
  width: 20vw;
  
}
.input > label {
  text-align: start;
  margin-top: 1vh;
}
.input > input {
  margin-top: 6px;
  height: 38px !important;
  background-color: #1E222D;
  border: none;
  color: white;
  padding-left: 0.5vw;
  margin-top: 0.8vh;
}

.input > input:active{
  border: 1px solid black;
}
/* From uiverse.io */
.btn-pers {
  position: relative;
  left: 20%;
  padding: 1em 2.5em;
  font-size: 12px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 700;
  color: #000;
  background-color: #fff;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  transform: translateX(-50%);
}
.btn-pers:hover {
  background-color: #0646f5;
  box-shadow: 0px 15px 20px rgba(49, 134, 245, 0.4);
  color: #fff;
}
.btn-pers:active {
  transform: translate(-50%, -1px);
}
/*  */
.alternative-option {
  text-align: center;
}
.alternative-option > span {
  color: #0d6efd;
  cursor: pointer;
}
#sign_out {
  position: relative;
  left: 50%;
  transform: translateX(-50%);
}

#login_button{
  margin-top: 1vh;
}

</style>