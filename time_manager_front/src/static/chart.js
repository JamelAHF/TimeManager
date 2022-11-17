import { Chart, registerables} from 'chart.js'
Chart.register(...registerables);


/* eslint-disable */    
export default function set_graph_bar(dataset_list, labels, width=400, height=600, id="chart_id", type="week"){

    let title = "Working times"
    let y_min = 0
    let step_size = 2

    let max = 0
    let tab_max = [0, 0, 0, 0, 0, 0, 0]
    for(let value_list of dataset_list){
        for(let index in value_list.data)
            tab_max[index] +=  value_list.data[index]
    }

    for(let val of tab_max)
        if(val > max)
            max = val

    max += 2
    step_size = Math.ceil(max/10)
    step_size = (step_size == 0) ? 1 : step_size

    if(type == "week"){
        y_min = 0,
        title = "Weekly Working time"
    }
    
    const ctx = document.getElementById('myChart').getContext('2d');
    
    return new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: dataset_list
        },
        options: {
            legend:{
                labels:{
                    fontColor: "white"
                }
            },
            maintainAspectRatio: false,
            plugins: {
                title: {
                    display: true,
                    text: title,
                    color: "rgb(230, 230, 230)"
                },
                legends: {
                    labels:{
                        fontColor: "rgba(230,230,230,1)",
                        font:{
                            size: 56
                        }
                    }
                }
            },
            scales: {
                xAxis: {
                    stacked: true,
                    grid: {
                        display: true,
                        color: "rgba(200,200,200,0.8)",
                        drawBorder: false,
                        lineWidth: 2
                    },
                    ticks: {
                        color: "rgba(255, 255, 255, 0.8)"
                    },
                },
                yAxis: {
                    stacked: true,
                    type: 'linear',
                    grid: {
                        color: "rgba(255,255,255,0.8)",
                        display: true,
                        drawBorder: true,
                    },
                    min: y_min,
                    max: max,
                    ticks: {
                        stepSize: step_size,
                        color: "rgba(255, 255, 255, 0.8)"
                    }
                }
            }  
        }
    });
}