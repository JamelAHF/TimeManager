<template>
  <ErrorComponent></ErrorComponent>
  <div id="page_container">
    <div id="login_container">
      <LoginComponent></LoginComponent>
    </div>

    <div id="dashboard_container">

      <div id="head_container">
        <div id="infos_container">
          <UserCompnent></UserCompnent>
          <AdminComponent></AdminComponent>
        </div>
        
        <nav id="nav_container">
          <span id="nav_home" class="nav_selected">Home</span>
          <span id="nav_graph">Graph</span>
        </nav>
      </div>
      

      <div id="home_container" class="content_container">
        <ClockManagerComponent></ClockManagerComponent>
        <WorkingTimesComponent></WorkingTimesComponent>
      </div>

      <div id="graph_container" class="content_container">
        <WorkingTimeDataComponent></WorkingTimeDataComponent>
      </div>
      
      
      
    </div>
  </div>

  

</template> 

<script>

import UserCompnent from './components/User.vue'
import WorkingTimeDataComponent from './components/WorkingTimeData.vue'
import LoginComponent from './components/Login.vue'
import ClockManagerComponent from './components/ClockManager.vue'
import WorkingTimesComponent from './components/WorkingTimes.vue'
import ErrorComponent from './components/ErrorBar.vue'
import AdminComponent from './components/Admin.vue'


export default {
  name: 'App',
  components: {
    UserCompnent,
    WorkingTimeDataComponent,
    LoginComponent,
    ClockManagerComponent,
    WorkingTimesComponent,
    ErrorComponent,
    AdminComponent

  },
  mounted(){
    init_app()
  }
}

function init_app(){
  document.getElementById('dashboard_container').style.display = "none"
  document.getElementById('login_container').style.display = "block"

  document.getElementById('nav_home').addEventListener('click', handle_nav.bind(this, "nav_home"))
  document.getElementById('nav_graph').addEventListener('click', handle_nav.bind(this, "nav_graph"))

} 

function handle_nav(nav_id){

  let home_container = document.getElementById('home_container')
  let graph_container = document.getElementById('graph_container')

  let nav_home = document.getElementById('nav_home')
  let nav_graph = document.getElementById('nav_graph')

  switch(nav_id){
    case "nav_home":{

      home_container.style.display = "block"
      graph_container.style.display = "none"

      nav_home.classList.add('nav_selected')
      nav_graph.classList.remove('nav_selected')

      break
    }
    case "nav_graph":{
      graph_container.style.display = "block"
      home_container.style.display = "none"
      nav_home.classList.remove('nav_selected')
      nav_graph.classList.add('nav_selected')

      break
    }
  }
}
</script>


<style>

body{
  margin: 0;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: white;
  background-color: #1E222D;
  width: 80vw;
  height: 100vh;
  padding: 0 10vw;
  overflow-x: hidden;
  overflow-y: hidden;

}

#head_container{
  display: flex;
  flex-direction: column;
  background-color: #10131A;
  padding: 1vh 0 0 0;
  margin-top: 2vh;
  border-top-left-radius: 15px;
  border-top-right-radius: 15px;
}

#infos_container{
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  align-items: center;
  margin-left: 5vw;
  height: 13vh;
}

#dashboard_container{
  display: 'none' !important;
  border-radius: 5px;
  box-shadow: rgba(0, 0, 0, 0.25) 0px 14px 28px, rgba(0, 0, 0, 0.22) 0px 10px 10px;
  
}

#login_container{
  display: 'block' !important
}

#nav_container{
  display: flex;
  flex-direction: row;
  background-color: #10131A;
  color: white;
  align-items: center;
  margin-top: 1vh

}

#nav_home{
  display: block;
  cursor: pointer;
  width: 50%;
  flex: 1;
  padding: 1vh 1vw;
  text-align: center;
  background-color: black;
}

#nav_graph{
  display: block;
  cursor: pointer;
  flex: 1;
  padding: 1vh 1vw;
  text-align: center;
  background-color: black;
}

.nav_selected{
  color: #FF6700;
  

  text-align: center;
  border: 1px solid #FF6700;
}

#home_container{
  display: block;
}

#graph_container{
  display: none;
}

.content_container{
  background-color: #10131A;
  height: 75vh;
  padding: 2vh 0 0 0;
  border-bottom-left-radius: 15px;
  border-bottom-right-radius: 15px
}
</style>
