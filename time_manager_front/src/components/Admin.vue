<template>
    <div id="admin_panel_container">
        <span>Admin Panel</span>
        <nav id="admin_panel_nav_container">
            <span id="admin_panel_nav_user" class="admin_nav_selected">User</span>
            <span id="admin_panel_nav_team">Team</span>
            <span id="admin_panel_nav_group">Group</span>
        </nav>

        <div id="panel_admin_action_user_container" class="admin_action_container">
            <span id="admin_btn_list_user"><font-awesome-icon icon="fa-solid fa-list"></font-awesome-icon></span>
            <span id="admin_btn_create_user"><font-awesome-icon icon="fa-solid fa-square-plus" ></font-awesome-icon></span>
            <span id="admin_btn_update_user"><font-awesome-icon icon="fa-solid fa-pen-to-square" ></font-awesome-icon></span>
            <span id="admin_btn_delete_user"><font-awesome-icon icon="fa-solid fa-user-minus" ></font-awesome-icon></span>
        </div>
        <div id="panel_admin_action_team_container" class="admin_action_container">
            <span id="admin_btn_list_team"><font-awesome-icon icon="fa-solid fa-list"></font-awesome-icon></span>
            <span id="admin_btn_create_team"><font-awesome-icon icon="fa-solid fa-square-plus" ></font-awesome-icon></span>
            <span id="admin_btn_update_team"><font-awesome-icon icon="fa-solid fa-pen-to-square" ></font-awesome-icon></span>
            <span id="admin_btn_delete_team"><font-awesome-icon icon="fa-solid fa-user-minus" ></font-awesome-icon></span>
        </div>
        <div id="panel_admin_action_group_container" class="admin_action_container">
            <span id="admin_btn_list_group"><font-awesome-icon icon="fa-solid fa-list"></font-awesome-icon></span>
            <span id="admin_btn_create_group"><font-awesome-icon icon="fa-solid fa-square-plus" ></font-awesome-icon></span>
            <span id="admin_btn_update_group"><font-awesome-icon icon="fa-solid fa-pen-to-square" ></font-awesome-icon></span>
            <span id="admin_btn_delete_group"><font-awesome-icon icon="fa-solid fa-user-minus" ></font-awesome-icon></span>
        </div>  
    </div>

    <div id="admin_modal_create_user" class="modal">
        <div class="modal_content" id="admin_modal_create_user_content">
                <p>Create new user</p>
                <span class="modal_input_container">
                    <label for="admin_modal_create_user_username">Username</label>
                    <input id="admin_modal_create_user_username" type="text" placeholder="Username">
                </span>
                <span class="modal_input_container">
                    <label for="admin_modal_create_user_email">Email</label>
                    <input id="admin_modal_create_user_email" type="text" placeholder="Email...">
                </span>
                <span class="modal_input_container">
                    <label for="admin_modal_create_user_password">Password</label>
                    <input id="admin_modal_create_user_password" type="text" placeholder="Password...">
                </span>
                <span class="modal_input_container">
                    <label for="admin_modal_create_user_team">Team</label>
                    <input id="admin_modal_create_user_team" type="text" placeholder="Team...">
                </span>
                <span class="modal_input_container">
                    <label for="admin_modal_create_user_group">Group</label>
                    <input id="admin_modal_create_user_group" type="text" placeholder="Group...">
                </span>
                <button id="admin_modal_submit_create_user" class="btn_style_1">Submit</button>
        </div>
    </div>
</template>

<script>

    import "../static/utils.css"

    function init_admin(){
        console.log('tests')

        let nav_container = document.getElementById('admin_panel_nav_container')
        for(let span of nav_container.childNodes)
            span.addEventListener('click', handle_admin_nav)

        document.getElementById('admin_btn_create_user').addEventListener('click', handle_admin_modal.bind(this, "admin_modal_create_user"))

    }

    export default {
        name: 'AdminComponent',
        props: {},
        mounted(){
            init_admin()
        }
    }

    function handle_admin_modal(modal_id){
        let modal = document.getElementById(modal_id)
        if(modal.style.display == "none" || modal.style.display == ""){
            modal.style.display = "flex"
            window.addEventListener('click', handle_admin_clode_modal.bind(this, modal_id))
        }
    }

    function handle_admin_clode_modal(modal_id, event){
        console.log("Open modal", modal_id)
        let modal = document.getElementById(modal_id)
        if(event && event.target == modal){
            modal.style.display = "none"
            window.removeEventListener('click', handle_admin_clode_modal)
        }
    }

    function handle_admin_nav(event){
        let nav_container = document.getElementById('admin_panel_nav_container')
        console.log(event.target)
        if(document.getElementsByClassName('admin_nav_selected')[0] == event.target)
            return

        for(let span of nav_container.childNodes){
            let type = span.innerText.toLowerCase()
            console.log(type)
            let container_id = "panel_admin_action_" + type + "_container"
            if(span == event.target){
                span.classList.add('admin_nav_selected')
                document.getElementById(container_id).style.display = "flex"
            }
            else{
                span.classList.remove('admin_nav_selected')
                document.getElementById(container_id).style.display = "none"
            }
        }

        
    }
    
</script>

<style>

#admin_panel_container{
    background-color: #2B2E38;
    display: flex;
    flex-direction: column;
    height: 12vh;
    width: 15vw;
    margin: 1vh 0;
    border-radius: 5px;
}

#admin_panel_container>span{
    padding: 1.5vh 0;
    text-align: center;
}

#admin_panel_nav_container{
    display: flex;
    flex-direction: row;
}

#admin_panel_nav_container>span{
    color: white;
    text-align: center;
    flex:1;
    text-align: center;
    background-color: #10131A;
    cursor: pointer;
    padding: 0.5vh 0;
}

#panel_admin_action_user_container{
    display: flex;
}

.admin_nav_selected{
    color: #FF6700 !important;
    display: block;
    border: 1px solid #FF6700;
}


.admin_action_container{
    display: none;
    flex-direction: row;
    justify-content: space-around;
    flex: 1;
    align-items: center;
    color: #FF6700;
}

.admin_action_container>span{
    cursor: pointer;
}

</style>

