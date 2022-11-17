<template>
    <div id="logout_container">
        <button id="btn-logout" class="btn_style_2">Logout</button>
    </div>
    
</template>

<script>
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
          document.getElementById('btn-logout').addEventListener('click', logout)
        }
    }
   
    export function logout(){
        localStorage.removeItem('current_user')
        document.getElementById('login_container').style.display = "block"
        document.getElementById('dashboard_container').style.display = "none"
    }
    
    
</script>

<style>
</style>