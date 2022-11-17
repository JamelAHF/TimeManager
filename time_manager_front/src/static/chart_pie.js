import { Chart, registerables} from 'chart.js'
Chart.register(...registerables);

export default function set_graph_pie(dataset_list, labels, width=400, height=200, id="chart_id_pie", type="week"){
    let title = "Working times"
    if(type == "week" && title == ""){
        title = "Weekly Working time"
    }

    console.log(width, height, id)
    const ctx = document.getElementById('myChart_pie').getContext('2d');
    
    return new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: dataset_list
        },
        options: {
            maintainAspectRatio: false,
            plugins: {
                title: {
                    display: true,
                    text: title,
                    color: "rgb(200, 200, 200)"
                },
                legends: {
                    labels:{
                        color: "rgba(200,200,200,0.8)",
                        font:{
                            size: 56
                        }
                    }
                }
            },
            width: width,
            height: height,
            scales: {
                
            },
            borderColor: "##1E222D",
            borderWidth: 1,
        }
    });
}