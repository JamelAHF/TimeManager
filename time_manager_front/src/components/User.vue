<template>
    <div id="user_container">
        <div id="user_head_container">
            <div id="user_infos_container">
                <span class="user_infos_sub_container">
                    <span id="user_username_container"></span>
                    <span id="user_email_container"></span>
                </span>
                <span class="user_infos_sub_container">
                    <span id="user_team_container"></span>
                    <span id="user_group_container"></span>
                </span>
            </div>

            <LogoutComponent></LogoutComponent>

        </div>
        
        <div id="user_action_container">
            <span id="btn_create_user"><font-awesome-icon icon="fa-solid fa-square-plus" ></font-awesome-icon></span>
            <span id="btn_update_user"><font-awesome-icon icon="fa-solid fa-pen-to-square" ></font-awesome-icon></span>
            <span id="btn_delete_user"><font-awesome-icon icon="fa-solid fa-user-minus" ></font-awesome-icon></span>
            
        </div>
        
    </div>

    

    <div id="modal_create_user" class="modal">
        <div class="modal_content" id="modal_create_user_content">
                <p>Create new user</p>
                <span class="modal_input_container">
                    <label for="modal_create_user_username">Username</label>
                    <input id="modal_create_user_username" type="text" placeholder="Username">
                </span>
                <span class="modal_input_container">
                    <label for="modal_create_user_email">Email</label>
                    <input id="modal_create_user_email" type="text" placeholder="Email...">
                </span>
                <span class="modal_input_container">
                    <label for="modal_create_user_password">Password</label>
                    <input id="modal_create_user_password" type="text" placeholder="Password...">
                </span>
                <span class="modal_input_container">
                    <label for="modal_create_user_team">Team</label>
                    <input id="modal_create_user_team" type="text" placeholder="Team...">
                </span>
                <span class="modal_input_container">
                    <label for="modal_create_user_group">Group</label>
                    <input id="modal_create_user_group" type="text" placeholder="Group...">
                </span>
                <button id="modal_submit_create_user" class="btn_style_1">Submit</button>
        </div>
    </div>
    
    <div id="modal_update_user" class="modal">
        <div class="modal_content" id="modal_update_user_content">
            <p>Update user information</p>
            <span class="modal_input_container">
                <label for="modal_update_user_username">Username</label>
                <input id="modal_update_user_username" type="text" placeholder="Username">
            </span>
            <span class="modal_input_container">
                <label for="modal_update_user_email">Email</label>
                <input id="modal_update_user_email" type="text" placeholder="email">
            </span>
            <button id="modal_submit_update_user" class="btn_style_1">Submit</button>
        </div>
    </div>

    <div id="modal_delete_user" class="modal">
        <div id="modal_delete_user_content" class="modal_content">
            <p>Delete my account ?</p>
            <div id="modal_delete_user_btn_container">
                <button id="btn_delete_user_no" class="btn_style_1">Cancel</button>
                <button id="btn_delete_user_yes" class="btn_style_1">Delete User</button>
            </div>
            
        </div>
    </div>
    
</template>

<script>
    import axios from 'axios'
    import "../static/modal_create_user.css"
    import "../static/utils.css"
    import LogoutComponent from "../components/Logout.vue"
    import {show_error} from './ErrorBar.vue'
    import {logout} from './Logout.vue'

    async function init_user_component(){
        // Action (Post update delete)
        document.getElementById('modal_submit_create_user').addEventListener('click', handle_user_action.bind(this, "create_user"))
        document.getElementById('btn_delete_user_yes').addEventListener('click', handle_user_action.bind(this, "delete_user"))
        document.getElementById('modal_submit_update_user').addEventListener('click', handle_user_action.bind(this, "update_user"))
        
        // Modal
        document.getElementById('btn_create_user').addEventListener('click', handle_modal_user.bind(this, "modal_create_user"))
        document.getElementById('btn_delete_user').addEventListener('click', handle_modal_user.bind(this, "modal_delete_user"))
        document.getElementById('btn_update_user').addEventListener('click', handle_modal_user.bind(this, "modal_update_user"))

        document.getElementById('btn_delete_user_no').addEventListener('click', function(){document.getElementById('modal_delete_user').style.display = "none"})
        init_user_infos()
        

        
    }

    function init_user_infos(){
        let user = JSON.parse(localStorage.getItem('current_user'))
        if(user != null){
            document.getElementById('user_username_container').innerHTML = user.username
            document.getElementById('user_email_container').innerHTML = user.email
            document.getElementById('user_team_container').innerHTML = user.team_id.name
            document.getElementById('user_group_container').innerHTML = (user.group_id != undefined) ? user.group_id.name : "No group"
        }
    }

    export default {
        name: 'UserCompnent',
        components:{
            LogoutComponent,
        },
        props: {},
        mounted(){init_user_component()}
    }
    

    function get_user(){

        let user = JSON.parse(localStorage.getItem('current_user'))
        return user
    }
    

    function create_user(){
        let token = JSON.parse(localStorage.getItem('token'))
        let config = {headers: {'Authorization': `Bearer ${token}`}}
        let username = document.getElementById('modal_create_user_username').value
        let email = document.getElementById('modal_create_user_email').value
        let password = document.getElementById('modal_create_user_password').value
        let team = document.getElementById('modal_create_user_team').value
        let group = document.getElementById('modal_create_user_group').value
        console.log(username, email, team, group)
        axios.post("http://localhost:4000/api/users/register",{"username": username, "email": email, "password": password, "team_id": team, "group_id": group}, config).then((res) => {
            console.log(res)
            if(res.status == 200)
                show_error(1, "New user created, Welcome ")
            else
                show_error(0, "Invalid fields")
        }).catch(function (error) {
            show_error(0, error)
        });

    }

    async function update_user(){
        let token = JSON.parse(localStorage.getItem('token'))
        let config = {headers: {'Authorization': `Bearer ${token}`}}
        let username = document.getElementById('modal_update_user_username').value
        let email = document.getElementById('modal_update_user_email').value
        let user = get_user()
        console.log(username, email)
        axios.put("http://localhost:4000/api/users/" + String(user.id) + "/", {"username": username, "email": email}, config).then((res) => {
            show_error(1, "Succesfully updated User")
            let new_user = res.data.data
            localStorage.setItem('current_user', JSON.stringify(new_user))
            init_user_infos()
            document.getElementById('modal_update_user').style.display = "none"
            window.removeEventListener('click', handle_close_modal_user)
        }).catch(function (error) {
            show_error(0, error.code, error.data)
        });
    }

    async function delete_user(){
        let token = JSON.parse(localStorage.getItem('token'))
        let config = {headers: {'Authorization': `Bearer ${token}`}}
        console.log("delete")
        let user = get_user()
        axios.delete("http://localhost:4000/api/users/" + String(user.id), config).then(() => {
            show_error(1, "User  sucessfully deleted")
            logout()
        }).catch(function (error) {
            show_error(0, error.toJSON())
        });
    }

    /*function set_user_infos(){ 
        let user = get_user()
        console.log(user, user.username, user.email)
        document.getElementById('user_username_container').innerText = user.username
        document.getElementById('user_email_container').innerText = user.email
    }*/

    function handle_user_action(action){
        switch(action){
            case "create_user":
                create_user()
                break
            case "delete_user":
                delete_user()
                break
            case "update_user":
                
                update_user()
                break
        }
    }


    async function handle_modal_user(type){
        
        console.log("handle_modal_user", type)
        switch(type){
            case "modal_create_user":
                open_modal_user(type)
                break
            case "modal_delete_user":
                
                open_modal_user(type)
                break
            case "modal_update_user":
                document.getElementById('modal_update_user_username').value = get_user().username
                document.getElementById('modal_update_user_email').value = get_user().email
                open_modal_user(type)
        }
    }

    function open_modal_user(modal_id){

        console.log(modal_id)
        let modal = document.getElementById(modal_id)
        console.log(modal, modal.style.display)
        if(modal.style.display == "none" || modal.style.display == ""){
            modal.style.display = "flex"
            setTimeout(function(){
                    window.addEventListener('click', handle_close_modal_user.bind(this, modal_id))
                }, 500)
        }
    }

    function handle_close_modal_user(modal_id, event){
        let modal = document.getElementById(modal_id)
        if(event.target == modal){
            modal.style.display = "none"
            window.removeEventListener('click', handle_close_modal_user)
        }
    }

</script>

