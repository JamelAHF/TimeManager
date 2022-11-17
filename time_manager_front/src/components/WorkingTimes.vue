<template>
    <div id="table_infos_container">   
        <span>
            <input id="wt_infos_head_input" type="search" placeholder="Search User..." autocomplete="off" class="custom_input_1">
        </span>
        <span id="wt_infos_head_title">Working Times</span>
        <span>
            <button id="btn_add_wt" class="btn_style_1 wt_infos_head_content">Add</button>
            <button id="btn_refresh_table" class="btn_style_refresh wt_infos_head_content"><font-awesome-icon id="icon_refresh" icon="fa fa-refresh"></font-awesome-icon></button>
        </span>
    </div>

    <div id="table_container">
        <table id="table_wt">
            <thead id="table_wt_head">
                <tr class="table_wt_row_th">
                    <th class="table_wt_th very_small_td">User</th>
                    <th class="table_wt_th medium_td">Start</th>
                    <th class="table_wt_th medium_td">End</th>
                    <th class="table_wt_th medium_td">Duration</th>
                    <th class="table_wt_th very_small_td">Update</th>
                    <th class="table_wt_th very_small_td">Drop</th>
                </tr>
            </thead>
             <tbody id="table_wt_body">

            </tbody>     
        </table>
    </div>
    <div id="modal_wt_create_container" class="modal">
        <div id="modal_wt_create_content" class="modal_content">
            <p>Declare new Working Time</p>
            <div id="modal_wt_create_input_container">
                <span class="modal_wt_input_container">
                    <label>Start time</label>
                    <input id="create_wt_start_input" class="custom_input_2" type="text" placeholder="YYYY-MM-DD HH:MM"/>
                </span>
                <span class="modal_wt_input_container">
                    <label>End time</label>
                    <input id="create_wt_end_input" class="custom_input_2" type="text" placeholder="YYYY-MM-DD HH:MM"/>
                </span>
                <span class="modal_wt_input_container">
                    <label>User Id</label>
                    <input id="create_wt_user_input" class="custom_input_2" type="text" placeholder="User ID"/>
                </span>
                <div class="submit_wt_container"><button class="btn_style_1" id="modal_wt_create_submit">Submit</button></div>
            </div>
        </div>
    </div>

    <div id="modal_wt_update_container" class="modal">
        <div id="modal_wt_update_content" class="modal_content">
            <p>Update Working Time</p>
            <div id="modal_wt_update_input_container">
                <span class="modal_wt_input_container">
                    <label>Start time</label>
                    <input id="update_wt_start_input" class="custom_input_2" type="text" placeholder="YYYY-MM-DD HH:MM"/>
                </span>
                <span class="modal_wt_input_container">
                    <label>End time</label>
                    <input id="update_wt_end_input" class="custom_input_2" type="text" placeholder="YYYY-MM-DD HH:MM"/>
                </span>
                <div class="submit_wt_container"><button class="btn_style_refresh" id="modal_wt_update_submit">Update</button></div>
            </div>
        </div>
    </div>


</template>

<script>
import axios from 'axios'
    import "../static/modal_create_user.css"
    import "../static/utils.css"
    import {show_error} from './ErrorBar.vue'
    var strptime = require('micro-strptime').strptime;
    import { dom } from '@fortawesome/fontawesome-svg-core'

    dom.watch() 
    export default {
        name: 'WorkingTimesComponent',
        components:{

        },
        props: {},
        data() { 
            return {
                userID : Array,
                userList : [],
                workingTimes: new Array(),
                currentWorkingTimeId : Number,
                current_wt_user_id: Number,
                searchKey: "",
                componentKey: 0
            } 
        },
        computed: {
            filteredUserList(){
            return this.userList.filter((user) => {
                return user.username.toLowerCase().includes(this.searchKey.toLowerCase());
            })
            },
            filteredWorkingTimes(){
                console.log("COMPUTED")
                return this.workingTimes.filter((wt) => {
                    console.log(wt)
                    return wt
                })
            },
        },

        methods:{
            async on_user_load(){
                let user = JSON.parse(localStorage.getItem('current_user', null))
                console.log("----", user)
                if(user==null)
                    return 1
                this.componentKey += 1;
                if(user.group.name == "admin"){
                    await this.getWorkingTimes()
                }
                else{
                    await this.getWorkingTimesByTeam()
                }
                console.log(this.workingTimes)
                await this.load_user_from_user_id_list()
                this.render_tbody(null)
            },

            async init_working_times_component(){
                document.getElementById('btn_add_wt').addEventListener('click', handle_modal_wt.bind(this, "modal_wt_create_container"))
                document.getElementById('modal_wt_create_submit').addEventListener('click', this.create_wt)
                document.getElementById('modal_wt_update_submit').addEventListener('click', this.edit_wt)
                document.getElementById('btn_refresh_table').addEventListener('click', this.on_user_load)
                document.getElementById('wt_infos_head_input').addEventListener('change', this.update_search_user)
            },
            

            async getWorkingTimes(){
                this.workingTimes = []
                let config = {headers: {'Authorization': `Bearer ${JSON.parse(localStorage.getItem('token'))}`}}
                await axios.get("http://localhost:4000/api/workingtimes/", config).then((res) => {
                    this.workingTimes = []
                    console.log(res.data.data)
                    for(let wt of res.data.data){
                        
                        this.workingTimes.push({
                            "id": wt.id,
                            "user": wt.user,
                            "start": format_date(wt.start),
                            "end": format_date(wt.end),
                            "duration": calc_duration(format_date(wt.start), format_date(wt.end))
                        })
                    }


                }).catch(function (error) {
                    show_error(0, error)
                });
            },

            async getWorkingTimesByTeam(){

                let team_id = JSON.parse(localStorage.getItem('current_user'))
                if(team_id == null)
                    return 0
                this.workingTimes = []
                team_id = team_id.team_id.id
                let config = {headers: {'Authorization': `Bearer ${JSON.parse(localStorage.getItem('token'))}`}}
                console.log("http://localhost:4000/api/workingtimes_by_team/" + String(team_id))
                await axios.get("http://localhost:4000/api/workingtimes_by_team/" + String(team_id), config).then((res) => {
                    console.log(res.data.data)
                    let res_temp = []
                    for(let wt of res.data.data){
                        
                        res_temp.push({
                            "id": wt.id,
                            "user": wt.user,
                            "start": format_date(wt.start),
                            "end": format_date(wt.end),
                            "duration": calc_duration(format_date(wt.start), format_date(wt.end))
                        })

                        this.workingTimes = res_temp
                    }

                    console.log(this.workingTimes)
                }).catch(function (error) {
                    show_error(0, error)
                });
            },
            
            async drop_wt(event){
                let td_node = event.target
                while(td_node.tagName != "TD")
                    td_node = td_node.parentNode
                const elemClickedId = td_node.getAttribute('wt_id')
                await axios.delete("http://localhost:4000/api/workingtimes/"+String(elemClickedId), {headers:{}}).then(() => {
                    show_error(1, "Working time sucessfully deleted")
                }).catch(function (error) {
                    show_error(0, error.toJSON())
                });
                this.on_user_load()
            },

            edit_wt_popup(wt_id, user_id, event){
                console.log(event, wt_id, user_id)
                let td_node = event.target
                while(td_node.tagName != "TR"){
                    td_node = td_node.parentNode
                    console.log('Fin ITE', td_node, td_node.tagName)
                }
                let child_list = td_node.children
                console.log(child_list)

                this.current_wt_user_id = user_id
                this.currentWorkingTimeId = wt_id
                document.getElementById('update_wt_start_input').value = child_list[1].innerText + ":00"
                document.getElementById('update_wt_end_input').value = child_list[2].innerText + ":00"
                handle_modal_wt("modal_wt_update_container")
            },

            async create_wt(){
                let start = document.getElementById('create_wt_start_input').value
                let end = document.getElementById('create_wt_end_input').value
                let user = document.getElementById('create_wt_user_input').value
                let token = JSON.parse(localStorage.getItem('token'))
                let config = {headers: {'Authorization': `Bearer ${token}`}}
                console.log({"user_id": user, "start": start, "end": end})
                axios.post("http://localhost:4000/api/workingtimes", {"user_id": user, "start": start, "end": end}, config).then((res) => {
                    console.log(res)
                    if(res.status == 200 || res.status == 201){
                        document.getElementById('modal_wt_create_container').style.display = "none"
                        window.removeEventListener('click', handle_clode_modal_wt)
                        this.on_user_load()

                    }
                }).catch(function (error) {
                    show_error(0, error.toJSON())
                });

            },

            async edit_wt(){
                let new_start = document.getElementById("update_wt_start_input").value
                let new_end = document.getElementById("update_wt_end_input").value
                console.log(new_start, new_end, this.currentWorkingTimeId)
                let token = JSON.parse(localStorage.getItem('token'))
                let config = {headers: {'Authorization': `Bearer ${token}`}}
                await axios.put("http://localhost:4000/api/workingtimes/"+ String(this.current_wt_user_id)+"/"+String(this.currentWorkingTimeId)+"/"+new_start+"/"+new_end, {}, config).then((res) => {
                    console.log(res)
                    if(res.status == 200){
                        document.getElementById('modal_wt_update_container').style.display = "none"
                        window.removeEventListener('click', handle_clode_modal_wt)
                        this.on_user_load()
                    }
                }).catch(function (error) {
                    show_error(0, error.toJSON())
                });
            },

            async render_tbody(wt_list){
                let list_to_render = (wt_list == null) ? this.workingTimes : wt_list
                let tbody = document.getElementById('table_wt_body')
                tbody.innerHTML = ""
                for(let wt of list_to_render){
                    let tr = document.createElement('tr')
                    tr.setAttribute('class', 'table_wt_row')

                    let td_user_id = document.createElement('td')
                    td_user_id.setAttribute('class', 'table_wt_td very_small_td')
                    td_user_id.innerText = this.get_username_from_user_id(wt.user)
                    tr.appendChild(td_user_id)

                    let td_start = document.createElement('td')
                    td_start.setAttribute('class', 'table_wt_td medium_td')
                    td_start.innerText = wt.start
                    tr.appendChild(td_start)

                    let td_end = document.createElement('td')
                    td_end.setAttribute('class', 'table_wt_td medium_td')
                    td_end.innerText = wt.end
                    tr.appendChild(td_end)

                    let td_duration = document.createElement('td')
                    td_duration.setAttribute('class', 'table_wt_td medium_td')
                    td_duration.innerText = wt.duration
                    tr.appendChild(td_duration)

                    let td_update = document.createElement('td')
                    td_update.setAttribute('class', 'wt_icon_container very_small_td')
                    td_update.setAttribute('wt_id', wt.id)
                    td_update.addEventListener('click', this.edit_wt_popup.bind(this, wt.id, wt.user))
                    let icon_update = document.createElement('i')
                    icon_update.setAttribute('class', 'fa-solid fa-pen-to-square')
                    td_update.appendChild(icon_update)
                    tr.appendChild(td_update)

                    let td_delete = document.createElement('td')
                    td_delete.setAttribute('class', 'wt_icon_container very_small_td')
                    td_delete.setAttribute('wt_id', wt.id)
                    td_delete.addEventListener('click', this.drop_wt)
                    let icon_delete = document.createElement('i')
                    icon_delete.setAttribute('class', "fa-solid fa-trash")
                    td_delete.appendChild(icon_delete)
                    tr.appendChild(td_delete)

                    tbody.appendChild(tr)
                }
                console.log("-- TABLE UPDATED --")
            },

            get_username_from_user_id(user_id){
                if(this.userList == undefined)
                    return null
                for(let user of this.userList){
                    console.log(user)
                    if(user.id == user_id)
                        return user.username
                }
                return null
            },

            update_search_user(event){
                let input = event.target
                let input_value = input.value
                this.render_tbody(this.workingTimes.filter((wt) => {
                    if(this.get_username_from_user_id(wt.user).includes(input_value))
                        return wt
                }))

            },

            async load_user_from_user_id_list(){
                let token = JSON.parse(localStorage.getItem('token'))
                let config = {headers: {'Authorization': `Bearer ${token}`}}

                let user_id_list = []
                for(let wt of this.workingTimes){
                    if(!user_id_list.includes(wt.user))
                        user_id_list.push(wt.user)
                }
                await axios.post("http://localhost:4000/api/user_list",{"user_id_list": user_id_list} , config).then((res) => {
                    console.log(res.data.data)
                    this.userList = res.data.data
                    console.log(this.userList)
                })
            }
        },

        mounted(){
            this.init_working_times_component()

            this.on_user_load()
        }
    }

    function format_date(date_str){
        return date_str.replace('T', ' ').replace('Z', ' ').slice(0, -4)
    }

    function calc_duration(start, end){
        let start_date = strptime(start, "%Y-%m-%d %H:%M")
        let end_date = strptime(end, "%Y-%m-%d %H:%M")
        let time_delta = end_date - start_date
        time_delta /= 1000
        let hours = Math.floor(time_delta / 60 / 60)
        time_delta -= (hours * 3600)

        let minutes = time_delta / 60

        let str_buff = ""
        if(hours > 0)
            str_buff += String(hours) + " hours "
        if(hours == 0 || minutes != 0)
            str_buff += String(minutes) + " minutes."

        return str_buff
    }

    function handle_modal_wt(modal_id){
        let modal = document.getElementById(modal_id)
        if(modal.style.display == "none" || modal.style.display == ""){
            modal.style.display = "flex"
            window.addEventListener('click', handle_clode_modal_wt.bind(this, modal_id))
        }
    }

    function handle_clode_modal_wt(modal_id, event){
        let modal = document.getElementById(modal_id)
        if(event && event.target == modal){
            modal.style.display = "none"
            window.removeEventListener('click', handle_clode_modal_wt)
        }
    }
</script>

<style>

#table_container{
    margin-top: 2vh;
}

#table_wt{
    width: 75vw;
    border-collapse: collapse;
    font: 1.2em;
    height: 20vh;
    overflow-y: auto;
    margin-left: 2.5vw;
    text-align: center;
    margin-top: 1vh;
}

#table_wt_caption{
    margin-top: 2vh;
    margin-bottom: 2vh;
    font-size: 1.5em;
}

#table_wt_head{
    background-color: #000000;
    height: 5.5vh;
    display: block;
}

#table_wt_body{
    border: 1px solid black;
    box-shadow: rgba(50, 50, 93, 0.25) 0px 13px 27px -5px, rgba(0, 0, 0, 0.3) 0px 8px 16px -8px;
    display: block;
    overflow-y: auto;
    height: 46vh;
    display: flex;
    flex-direction: column;
}
.table_wt_th{
    flex: 1;
    margin: auto 0;
    height: 5.5vh;
}

.table_wt_td{
    text-align: center;
    line-height: 1.2em;
    padding: 0.5vh 0vw;
    flex: 1;
    margin: 2.5vh 0;
    height: 3.5vh;
}

.table_wt_td:first-child{
    flex: 0.5;
}

.table_wt_row_th{
    background-color: #000000;
}

.table_wt_th{
    flex: 1;
    
}

.table_wt_th:first-child{
    flex: 0.5;
}

.table_wt_row:nth-child(2n + 1){
    background-color: #2B2E38;
}

.table_wt_row:nth-child(2n){
    background-color: #0F1118;
}

#wt_action_container{
    display: flex;
    flex-direction: row;
    justify-content: center;
    margin-top: 2vh;
}

.very_small_td{
    width: 5vw;
}

.medium_td{
    width: 20vw
}

.wt_icon_container{
    color: #FF6700;
    font-size: 1.2em;
    cursor: pointer;
}

#table_infos_container{
    display: flex;
    flex-direction: row;
    justify-content: center;
    text-align: center;
    align-items: center;
    margin-top: 3vh;
}

#table_infos_container>span{
    flex:1;
}

#wt_infos_head_title{
    font-size: 1.7em;
}

#modal_wt_create_content>p{
    font-size: 1.4em;
    font-weight: 400;
}


#modal_wt_create_input_container{
    display: flex;
    flex-direction: column;
}

#modal_wt_create_input_container>span{
    margin-top: 1vh;
}
#modal_wt_create_content{
    flex-direction: column;
    width: 40vw;
    padding: 2vh 1vw;
}

.submit_wt_container{
    margin: auto auto;
    margin-top: 2vh;
}

.modal_wt_input_container{
    margin-top: 1.2vh;
    display: flex;
    flex-direction: column;
}


.modal_wt_input_container>input{
    margin-top: 0.7vh;
}

#modal_wt_update_content>p{
    font-size: 1.4em;
    font-weight: 400;
}


#modal_wt_update_input_container{
    display: flex;
    flex-direction: column;
}

#modal_wt_update_input_container>span{
    margin-top: 1vh;
}
#modal_wt_update_content{
    flex-direction: column;
    width: 40vw;
    padding: 2vh 1vw;
}

#icon_refresh{
    font-size: 1em;
}

#btn_refresh_table{
    margin-left: 2vw;
}
</style>


