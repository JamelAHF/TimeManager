 <template>
    <div id="modall_create_workingtime" class="modall">
        <div class="modall_content" id="modall_create_workingtime_content">
                <span class="modall_input_container">
                    <label for="modall_create_workingtime_user">User ID</label>
                    <input id="modall_create_workingtime_user" type="text" placeholder="Username">
                </span>
                <span class="modall_input_container">
                    <label for="modall_create_workingtime_start">Start</label>
                    <input id="modall_create_workingtime_start" type="text" placeholder="datetime start">
                </span>
                <span class="modall_input_container">
                    <label for="modall_create_workingtime_end">End</label>
                    <input id="modall_create_workingtime_end" type="text" placeholder="datetime end">
                </span>
                <button id="modall_submit_create_workingtime" class="btn_style_1">Submit</button>
        </div>
    </div>
</template>

<script>
    console.log('hello')
    import axios from 'axios'
    import "../static/modal_create_user.css"
    import "../static/utils.css"
    import { show_error } from './ErrorBar.vue'

    export default {
        name: 'WorkingTimeCompnent',
        props: {},
        methods:{
            init_workingtime_component(){
                console.log('workingTimes component inited')
                document.getElementById('modall_submit_create_workingtime').addEventListener('click', this.createWorkingTime)
            },

            async createWorkingTime(){
                console.log("okokokoko")
                let userid = document.getElementById('modall_create_workingtime_user').value
                console.log(document.getElementById('modall_create_workingtime_user'))
                let startdatetime = document.getElementById('modall_create_workingtime_start').value
                let enddatetime = document.getElementById('modall_create_workingtime_end').value
                console.log(userid, startdatetime,enddatetime)
                console.log("okokokoko")
                axios.post("http://localhost:4000/api/workingtimes", {"user": userid, "start": startdatetime, "end":enddatetime}).then((res) => {
                    console.log(res)
                }).catch(function (error) {
                    show_error(0, error.toJSON())
                });
                document.getElementById('create_wt').style.display = "none"
            }
        },

        mounted(){
            this.init_workingtime_component()
        }

    }

</script>

