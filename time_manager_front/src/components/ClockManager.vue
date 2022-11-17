<template>
    <div id="clock_container">
        <p>Don't forget to clock</p>
        <button id="clock_manager_clock_button" class="btn_style_1">Clock</button>
    </div>

</template>

<script>

    import axios from 'axios'
    import "../static/modal_create_user.css"
    import "../static/utils.css"
    import { show_error } from './ErrorBar.vue'


    export default {
        name: "ClockManagerComponent",
        data() { 
            return {
                user : Object,
            }
        },
        methods: {
            async init_clock_manager(){
                console.log('clock manager component inited')
                document.getElementById('clock_manager_clock_button').addEventListener('click',this.clock)
            },

            async clock(){
                let token = JSON.parse(localStorage.getItem('token'))
                let config = {headers: {'Authorization': `Bearer ${token}`}}
                var date = new Date()
                var currentTime = date.getFullYear()+'-'+('0'+(date.getMonth()+1)).slice(-2)+'-'+('0'+date.getDate()).slice(-2)+' '+('0'+date.getHours()).slice(-2)+':'+('0'+date.getMinutes()).slice(-2)+':'+('0'+date.getSeconds()).slice(-2)
                await axios.get("http://localhost:4000/api/clock/", config).then(async (res) => {
                    let lastClock = res.data.data[0]
                    let token = JSON.parse(localStorage.getItem('token'))
                    let config = {headers: {'Authorization': `Bearer ${token}`}}
                    console.log(lastClock)
                    if (lastClock && lastClock.status){
                        console.log(lastClock.time)
                        console.log(currentTime)
                        await axios.post("http://localhost:4000/api/workingtimes/",{ "start": lastClock.time, "end": currentTime}, config)
                        await axios.post("http://localhost:4000/api/clock", { "status": false, "time": currentTime}, config)
                    }
                    else {
                        console.log("else")
                        await axios.post("http://localhost:4000/api/clock/", {"status": true, "time": currentTime}, config)
                    }    
                }).catch(function (error) {
                    show_error(0, error.toJSON())
                });
            },
        },

        mounted() {
            this.init_clock_manager()
        },
    }
    
</script>

<style>
#clock_container{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: white;
    background-color: #2B2E38;
    margin: 0 18vw 1vh 18vw;
    padding: 0 0 1vh 0;
    border-radius: 15px;
    box-shadow: rgba(50, 50, 93, 0.25) 0px 13px 27px -5px, rgba(0, 0, 0, 0.3) 0px 8px 16px -8px;
}

#clock_container>p{
    font-size: 1.2em;
}

</style>