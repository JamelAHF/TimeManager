<template>
    <Text>okokokok</Text>
    <WorkingTimeComponent>
    </WorkingTimeComponent>

</template>

<script>
    import { Text } from "vue"
import "../static/modal_create_user.css"
    import "../static/utils.css"
    import WorkingTimeComponent from "./WorkingTime.vue"

    function init_test(){
        console.log('tests')
    }

    export default {
        name: 'TestComponent',
        props: {},
        components: {
            WorkingTimeComponent,
        },
        mounted(){
            init_test()
        }
    }
    
</script>

