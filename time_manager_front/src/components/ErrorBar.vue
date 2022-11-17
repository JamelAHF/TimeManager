<template>
    <div id="error_container">
        <div id="error_content"></div>
    </div>
</template>

<script>

    const CODE_TO_COLOR = ["#FE4B4B", "#44803F", "#FFEC5C"]
    export default 
    {
        name: 'ErrorComponent',

    }
   /* eslint-disable */
    export function show_error(code, content){
        console.log(code, content)
        document.getElementById('error_container').style.display = "block"
        document.getElementById('error_container').style.backgroundColor = CODE_TO_COLOR[code]
        document.getElementById('error_content').innerText = content

        console.log(document.getElementById('error_content').innerText)
        setTimeout(() => {
            document.getElementById('error_container').style.display = "none"
        }, 2000)
    }
</script>

<style>

#error_container{
    display: none;
    position: absolute;
    top: 5vh;
    left: 15vw;
    width: 70vw;
    height: 7vh;
    font-size: 1.3em;
    text-align: center;
    color: whitesmoke;
    border: 15px;
    box-shadow: rgba(0, 0, 0, 0.25) 0px 14px 28px, rgba(0, 0, 0, 0.22) 0px 10px 10px;
    height: auto;
    padding: 1vh 0;
    border-radius: 5px;
    border: 1px solid rgba(0,0,0,0.9);
}
</style>