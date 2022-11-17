<template>
    <div id="working_time_graph_container">
        <div id="graph_selector_container">
            
            <div class="nav_selector_graph_container">
                <p>Graph type selector</p>
                <div class="btn_selector_graph_container">
                    <button id="btn_bar_chart" class="btn_style_1">Bar</button>
                    <button id="btn_pie_chart" class="btn_style_1">Pie</button>
                </div>
            </div>
            <div class="nav_selector_graph_container">
                <p>Working time selector</p>
                <div id="graph_selector_bar_container" class="btn_selector_graph_container">
                    <button class="btn_style_1" id="my_working_time">Mine</button>
                    <button class="btn_style_1" id="btn_bar_team">My team</button>
                </div>
                <div id="graph_selector_pie_container" class="btn_selector_graph_container">
                    <button class="btn_style_1" id="btn_pie_team">My team</button>
                </div>
            </div>
            <div class="nav_selector_graph_container">
                <p>Period selector</p>
                <select id="time_interval_graph" default="Weekly" class="custom_select">
                    <option value="Weekly">Weekly</option>
                </select>
            </div>
        </div>
        
        
        <div id="chart_bar_container" class="chart_container">
            <canvas id="myChart"></canvas>
        </div>
        <div id="chart_pie_container" class="chart_container">
            <canvas id="myChart_pie"></canvas>
        </div>
        
    </div>
</template>



<script>
    /* eslint-disable */
    //<BarChart :chart-data="{datasets: [{data: [1, 2, 3]}], labels: ['Jan', 'Feb', 'Mar']}" :height="200"></BarChart>
    //import axios from 'axios'

    
    
    import axios from 'axios'
    import set_graph_bar from '../static/chart.js'
    import set_graph_pie from '../static/chart_pie.js'
    import {show_error} from './ErrorBar.vue'
    var strptime = require('micro-strptime').strptime;
    var strftime = require('strftime')
    
    var instance_bar = null
    var instance_pie = null

    const COLOR_PIE = ["#082b95", "#003C57", "#531882", "#5e2657", "#896790", "#fcb814", "#008640", "#896790"]

    export default {
        name: 'WorkingTimeDataComponent',
        props: {},
        mounted(){
            console.log(instance_pie)
            
            document.getElementById('my_working_time').addEventListener('click', get_working_time_user)
            document.getElementById('btn_bar_chart').addEventListener('click', handle_chart.bind(this, "chart_bar_container"))
            document.getElementById('btn_pie_chart').addEventListener('click', handle_chart.bind(this, "chart_pie_container"))
            document.getElementById('btn_pie_team').addEventListener('click', get_working_time_by_team.bind(this, "pie"))
            document.getElementById('btn_bar_team').addEventListener('click', get_working_time_by_team.bind(this, "bar"))
            get_working_time_user()

        }
    }

    async function get_working_time_user(){
        let start = ""
        let end = ""
        let user_id = JSON.parse(localStorage.getItem('current_user'))

        if(!user_id)
            return
        user_id = user_id.id
        let scale = 0
        let interval_type = document.getElementById('time_interval_graph').value
        let pie_hour = 0
        let pie_label = []
        switch(interval_type){
            case "Weekly":{
                scale = 7
                start = Date.now()
                console.log(start - 10, (scale*24*60*60*1000))
                let delta_start = start - Math.ceil(start / 86400000)  * 86400000
                start = new Date( start - delta_start - (scale*24*60*60*1000))

                console.log(start)
                start = strftime("%Y-%m-%d %H:%M:%S", start)
                end = new Date(Date.now() - delta_start + 86400000)
                end = strftime("%Y-%m-%d %H:%M:%S", end)
                pie_hour = 35
                pie_label = ["Time worked", "Theorical week"]
                break;
            }
                
        }
        let token = JSON.parse(localStorage.getItem('token'))
        let config = {headers: {'Authorization': `Bearer ${token}`}}
        await axios.post("http://localhost:4000/api/workingtimes/get_interval", {"user": user_id, "start_date": start, "end_date": end}, config).then((res) => {
            let data_list = res.data.data   
            let data_graph = new Array()
            let label_list = new Array()
            for(let i=0; i<scale; i++){
                data_graph.push(0)
                label_list.unshift(getDayName(Date.now() - i * 86400000))
            }
            console.log(label_list)
            
            let value_pie = 0
            for(let data of data_list){
                let start_date_formatted = strptime(data.start, "%Y-%m-%dT%H:%M:%SZ")
                let end_date_formatted = strptime(data.end, "%Y-%m-%dT%H:%M:%SZ")
                let delta_time = start_date_formatted - strptime(start, "%Y-%m-%d %H:%M:%S")
                
                let index = Math.ceil(delta_time / 60 / 60 / 24 / 1000) -1
                value_pie += (end_date_formatted - start_date_formatted) / 60 / 60 / 1000 
                
                data_graph[index] += (end_date_formatted - start_date_formatted) / 60 / 60 / 1000
            }
            update_chart_bar(create_obj_graph_bar([data_graph, []]), label_list)
            console.log(pie_hour, pie_label, value_pie)
        }).catch(function (error) {
            show_error(0, error.toJSON())
        });
    }

    async function get_working_time_by_team(graph_type){
        let start = ""
        let end = ""
        let scale = 0
        let interval_type = document.getElementById('time_interval_graph').value
        let pie_label = []
        let team = 1
        switch(interval_type){
            case "Weekly":{
                scale = 7
                start = Date.now()
                console.log(start - 10, (scale*24*60*60*1000))
                let delta_start = start - Math.ceil(start / 86400000)  * 86400000
                start = new Date( start - delta_start - (scale*24*60*60*1000))

                console.log(start)
                start = strftime("%Y-%m-%d %H:%M:%S", start)
                end = new Date(Date.now() - delta_start + 86400000)
                end = strftime("%Y-%m-%d %H:%M:%S", end)
                break;
            }
                
        }
        let token = JSON.parse(localStorage.getItem('token'))
        let config = {headers: {'Authorization': `Bearer ${token}`}}
        await axios.post("http://localhost:4000/api/workingtimes/get_interval_team", {"team": team, "start_date": start, "end_date": end}, config).then((res) => {
            let data_list = res.data.data
            let data_graph = new Object()
            let init_tab = [0, 0, 0, 0, 0, 0, 0]
            let label_list = []
            
            console.log(init_tab, 'ok', init_tab[0])
            
            for(let i=0; i<scale; i++){
                label_list.unshift(getDayName(Date.now() - i * 86400000))
            }

            console.log(init_tab, init_tab[0])
            let value_pie = {}
            for(let data of data_list){
                let start_date_formatted = strptime(data.start, "%Y-%m-%dT%H:%M:%SZ")
                let end_date_formatted = strptime(data.end, "%Y-%m-%dT%H:%M:%SZ")
                let delta_time = start_date_formatted - strptime(start, "%Y-%m-%d %H:%M:%S")
                
                let index = Math.ceil(delta_time / 60 / 60 / 24 / 1000) -1
                value_pie[data.user] = (data.user in value_pie) ? value_pie[data.user] + (end_date_formatted - start_date_formatted) / 60 / 60 / 1000 : (end_date_formatted - start_date_formatted) / 60 / 60 / 1000

                if(!pie_label.includes(data.user))
                    pie_label.push(data.user)
                console.log(data.user in data_graph, (end_date_formatted - start_date_formatted) / 60 / 60 / 1000, data.user, index, data_graph)
                if(data.user in data_graph)
                    data_graph[data.user][index] += (end_date_formatted - start_date_formatted) / 60 / 60 / 1000
                    
                else{
                    data_graph[data.user] = [0, 0, 0, 0, 0, 0, 0]
                    console.log('init_tab', data_graph)
                    data_graph[data.user][index] += (end_date_formatted - start_date_formatted) / 60 / 60 / 1000
                }
            }

            
            console.log('RES -- ', data_graph)
            if(graph_type == "bar")
                update_chart_bar(create_obj_graph_team(data_graph), label_list)
            else
                update_pie_chart(create_obj_graph_team_pie(value_pie), pie_label)
        }).catch(function (error) {
            show_error(0, error)
        });
    }

    function getDayName(date){
        const local = "fr-FR"
        return new Date(date).toLocaleDateString(local, {weekday: 'long'})
    }

    function update_chart_bar(dataset_values_list, labels){
        console.log(instance_bar, labels)
        if(instance_bar != null)
            instance_bar.destroy()
            
        instance_bar = set_graph_bar(dataset_values_list, labels)
    }

    function update_pie_chart(dataset, labels){
        console.log(dataset, labels)
        if(instance_pie != null)
            instance_pie.destroy()
        
        instance_pie = set_graph_pie(dataset, labels)
    }

    function create_obj_graph_bar(dataset_value_list){
        let color = ""
        let label = ""
        let index = 0
        let res = []
        for(let value_list of dataset_value_list){
            if(index == 0){
                color = "rgba(65, 130, 242, 0.9)"
                label = "Day hours"
            }

            else{
                color = "rgba(242, 130, 65, 0.9)"
                label = "Night hours"
            }

            res.push({
                label: label,
                backgroundColor: color,
                data: value_list,
                maxBarThickness: 80
            })
            index++
        }
        return res
    }

    function create_obj_graph_team(dataset_value_list){
        let color = ""
        let label = ""
        let res = []
        let cpt = 0
        
        for(let key in dataset_value_list){
            label = key
            color = COLOR_PIE[cpt]
            cpt++;

            res.push({
                label: label,
                backgroundColor: color,
                data: dataset_value_list[key],
                maxBarThickness: 80
            })
        }
        return res
    }

    function create_obj_graph_team_pie(dataset_value_list){
        let res = {
            data: [],
            backgroundColor: [],
            label: ""
        }
        let cpt = 0
        res.label = "Worked hours"
        for(let key in dataset_value_list){
            res.data.push(dataset_value_list[key])
            res.backgroundColor.push(COLOR_PIE[cpt])
            cpt++;
        }
        return [res]
    }

    function handle_chart(chart_id){
        let chart_container_list = document.getElementsByClassName('chart_container')
        for(let chart_container of chart_container_list){
            console.log(chart_container)
            if(chart_container.id == chart_id){
                let type = chart_id.split('_')[1];
                let selector_container_id = "graph_selector_" + type + "_container"
                chart_container.style.display = "block"
                for(let selector_node of document.getElementById('graph_selector_bar_container').parentNode.getElementsByClassName('btn_selector_graph_container'))
                    selector_node.style.display = (selector_node.id == selector_container_id) ? "flex" : "none"
                get_working_time_by_team("pie")
            }
            else
                chart_container.style.display = "none"
        }
    }

  

</script>

<style>

#chart_container{
    margin: 0 10vw;
    height: 60vh;
}

#update_chart_container{
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 2vh;
}

#graph_selector_container{
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    height: 10vh;
    margin-bottom: 3vh;
}

#graph_selector_pie_container{
    display: none;
}

#chart_pie_container{
    display: none;
    height: 53vh;
    margin: 3vh 1vw;
}

#chart_bar_container{
    height: 54vh;
    margin: 0 5vw
}

.btn_selector_graph_container{
    display: flex;
    justify-content: space-around;
    flex-direction: row;
    width: 70%;
}

.nav_selector_graph_container{
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    flex: 1
}
</style>
