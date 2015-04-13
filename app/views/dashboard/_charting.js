<% genre_text=["All Others", "Classical", "Jazz", "Rock", "Country"] %>
<script>


$(function () {


    var data = <%= @MusiciansByCounties.to_json.html_safe %>,
        countiesMap = Highcharts.geojson(Highcharts.maps['countries/us/us-all-all']),
	lines = Highcharts.geojson(Highcharts.maps['countries/us/us-all-all'], 'mapline'),
	options;

    // Add state acronym for tooltip
    Highcharts.each(countiesMap, function (mapPoint) {
        mapPoint.name = mapPoint.name + ' (' + mapPoint.properties['hc-key'].substr(3, 2).toUpperCase()+ ')';
    });

    options = {
        chart : {
//            borderWidth : 1//,
//            marginRight: 50 // for the legend
        },

        title : {
            text : null// 'Largest Clusters of Musicians'
        },
        subtitle : {
            text : 'Distribution of filtered group by zipcode'
        },

        legend: {
            title: {
                text: "Musicians By County",
                style: {
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
                }
            },
            floating: false,
        },
		credits: {
			enabled: false
		},
        mapNavigation: {
            enabled: true,
			buttonOptions: {
				verticalAlign: 'bottom'
			}
        },

        colorAxis: { 
			minColor: '#F6B179',
            maxColor: '#FF2C2E'
        },
		
        plotOptions: {
            mapline: {
                showInLegend: false,
                enableMouseTracking: false
            }
        },

        series : [{
            mapData : countiesMap,
            data: data,
            joinBy: 'fips',
            name: 'County of',
            tooltip: {
                valueSuffix: ' musicians'
            },
            borderWidth: 0.5,
			allAreas: false,
            states: {
                hover: {
                    color: '#bada55'
                }
            }
        }, {
            type: 'mapline',
            name: 'State borders',
            data: [lines[0]],
            color: 'silver'
        }, {
            type: 'mapline',
            name: 'Separator',
            data: [lines[1],lines[2]],
            color: 'silver'
        }]
    };
	
    // Instantiate the map
    $('#concentrationmap').highcharts('Map', options);
});



$(function () { 
    $('#annincbycat').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
			text:null
        },
		subtitle:{
			text: 'Income by Category'
		},
        xAxis: {
            categories: ['Live performance', 'Teaching', 'Salaried player', 'Session work', 'Compositions', 'Sound recordings', 'Merch', 'Other']
        },
        yAxis: {
            title: {
                text: 'Ave % of Income'
            },
            labels: {
            	enabled: true
            }			
        },
        tooltip: {
			headerFormat: '{point.key}:<br>',
			pointFormat: "{point.y:,.0f}% of music-related income",
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true,
					crop: false,
					overflow: 'none',
					format: '{y}%'
                }
            }
        },
		legend: {
			enabled: false
		},
		credits: {
			enabled: false
		},
        series: [{
            name: '% of Income',
			color: '#00748F',
            data: [<%= @AvgPctLive.to_i %>, <%= @AvgPctTeach.to_i %> , <%= @AvgPctSalary.to_i %>, <%= @AvgPctSession.to_i %>,<%= @AvgPctComposition.to_i %>,<%= @AvgPctRecord.to_i %>,<%= @AvgPctMerch.to_i %>,<%= @AvgPctOther.to_i%>]
        }]
    });
});

$(function () { 
    $('#anninctrend').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
			text: null
		},
		subtitle:{
			text: 'Income Trend by Category'
		},
		tooltipnot: {
			enabled: false
		},
        xAxis: {
            categories: ['Live performance', 'Teaching', 'Salaried player', 'Session work', 'Compositions', 'Sound recordings', 'Merch' ],
            labels: {
                enabled: true
            }
        },
        yAxis: {
            title: {
                text: '# of Musicians noting trend'
            },
            labels: {
            	enabled: true
            }
        },
        tooltip: {
			headerFormat: '{series.name}<br>{point.key}:<br>',
			pointFormat: '{point.y:,.0f} people',
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true,
					crop: false,
					overflow: 'none',
					x: -2,
					y: -2,
					format: '{point.options.delt}'
                }
            }
        },
		legend: {
			enabled: false
		},
		credits: {
			enabled: false
		},
        series: [{           
				name: 'Decreased',
				negativeColor: '#c81c1f',
				color: '#c81c1f',
				data: [<%= @DecrIncLive.to_i %>, <%= @DecrIncTeach.to_i %> , <%= @DecrIncSalary.to_i %>, <%= @DecrIncSession.to_i %>,<%= @DecrIncComposition.to_i %>,<%= @DecrIncRecording.to_i %>,<%= @DecrIncMerch.to_i %>]
			}, 
			{
	            name: 'Increased',
	            negativeColor: '#c81c1f',
				color: '#579333',
					
				data: [
					{y: <%= @IncrIncLive.to_i %>,delt:'<%= delta_percent_to_s(@IncrIncLive, @DecrIncLive) %>'},
					{y: <%= @IncrIncTeach.to_i %>,delt:'<%= delta_percent_to_s(@IncrIncTeach, @DecrIncTeach) %>'},
					{y: <%= @IncrIncSalary.to_i %>,delt:'<%= delta_percent_to_s(@IncrIncSalary, @DecrIncSalary) %>'},
					{y: <%= @IncrIncSession.to_i %>,delt:'<%= delta_percent_to_s(@IncrIncSession, @DecrIncSession) %>'},
					{y: <%= @IncrIncComposition.to_i %>,delt:'<%= delta_percent_to_s(@IncrIncComposition, @DecrIncComposition) %>'},
					{y: <%= @IncrIncRecording.to_i %>,delt:'<%= delta_percent_to_s(@IncrIncRecording, @DecrIncRecording) %>'},
					{y: <%= @IncrIncMerch.to_i %>,delt:'<%= delta_percent_to_s(@IncrIncMerch, @DecrIncMerch) %>'}]
        }]
    });
});

$(function () {
    $('#ageincomechart').highcharts({
        chart: {
            type: 'column',
			marginTop: 40
        },
        title: {
			text:null
        },
		subtitle:{
			text: null
		},
		credits: {
			enabled: false
		},
        xAxis: {
			title: {
				text: 'Age Strata (years)'
			},
            categories: ['18-29','30-39','40-49','50-59','60+']
        },
        plotOptions: {
            series: {
                stacking: 'normal'
			}
        },
        series: [{
			name: 'Non-Music income',
			color: '#CCCCCC',
			borderWidth: 0,
			type: 'column',
            data: <%= @NonMusicIncbyAge.as_json %>

        }, {
			name: 'Income direct from music',
			color: '#00748F',
			borderWidth: 0,
			type: 'column',
			data: <%= @MusicIncbyAge.as_json %>
        }],
		yAxis: {
			title: {
				text: 'Total Gross Income'
			},
			stackLabels: {
				enabled: true,
				format: '${total:,.0f}'
			},
			plotLines: [{
			    color: '#00748F', // Color value
			    dashStyle: 'Dash', // Style of the plot line. Default to solid
			    value: <%= @AvgEMI %>, // Value of where the line will appear
				width: '2', // Width of the line    
				zIndex: 4,
                label: {
                    text: '<%= number_to_currency(@AvgEMI, :precision=>0) %>',
                    align: 'left'
                }
				
			  }]
		},
        tooltip: {
			headerFormat: '{point.key} years old<br>',
            pointFormat: 'Average {series.name}: $<b>{point.y}</b><br/>',
			zIndex: 5
        }
    });
});

$(function () {
//	if 'true' == '<%= params.has_key?(:mgenre) %>' && 'ALL' != '<%= params[:mgenre]%>' {
    $('#genreincomechart').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: null
        },
        subtitle: {
            text: null
        },
        xAxis: { 
            categories: ['Live performance','Teaching','Salaried player','Session work','Compositions','Sound recordings','Merchandise and branding','Other'],
            title: {
                text: null
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Pct of Income'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
			headerFormat: '{series.name}<br/>{point.key}:',
			pointFormat: "{point.y:,.1f}%",
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true,
					crop: false,
					overflow: 'none',
					format: '{y}%'
                }
            }
        },
        legend: {
            labelFormatter: function () {
                return this.name + ' (EMI='+this.options.emi+')';
            },
            layout: 'vertical',
            align: 'center',
            verticalAlign: 'top',
			reversed: true,
            x: -0,
            y: 0,
            floating: false,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        credits: {
            enabled: false
        },
        series: [{
            name: 'Non-<%= genre_text[params[:mgenre].to_i] %> Genres',
			emi: '<%= number_to_currency(@AvgEMI_antigenre, :precision=>0) %>',
			color: '#FF7D2C',
            data: <%= if @AntiGenrePcts then @AntiGenrePcts.map {|x| number_with_precision(x,:precision=>2,:significant=>true).to_f}.to_json.html_safe else [] end %>
			
        }, {
            name: '<%= genre_text[params[:mgenre].to_i] %> Genre',
			emi: '<%= number_to_currency(@AvgEMI, :precision=>0) %>',
			color: '#00748F',
            data: <%= if @GenrePcts then @GenrePcts.map {|x| number_with_precision(x,:precision=>2,:significant=>true).to_f}.to_json.html_safe else [] end  %>
        }]
    });
	//}
});

$(function () {
    $('#genresingroupchart').highcharts({
        chart: {
			type: 'bar'//,
//            plotBackgroundColor: null //,
//            plotBorderWidth: null,
//            plotShadow: false
        },
        title: {
            text: null
        },
		subtitle: {
			text: null
		},
        tooltip: {
            pointFormat: '<b>{point.y}</b> musicians'
        },
        xAxis: {
            categories: ['Classical','Jazz','Rock','Country','All others','No answer']
		},
		yAxis: {
			title: {
				text: '# of musicians'
			}
		},
		legend: {
			enabled: false
		},
        plotOptions: {
            bar: {
				//overflow: 'none',
				//size: '100%',
                dataLabels: {
					//distance: -55,
					//distance: 15,
					distance: 5,
                    format: '<b>{point.short}</b><br>{point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        credits: {
            enabled: false
        },
        series: [{
            name: '# of Musicians',
			color: '#00748F',
            data: <%= @GenreSeries.to_json.html_safe %>
        }]
    });
});

$(function () {
    $('#roleschart').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
			text: null
        },
		yAxis: {
			title: {
				text: '# of musicians'
			}
		},
		legend: {
			enabled: false
		},
		credits: {
			enabled: false
		},
        xAxis: {
            categories: ['Composer','Recording Artist','Salaried Player','Performer','Session player','Teacher'],
			labels: {
				rotation: 0
			}
        },

        plotOptions: {
			bar: {
                dataLabels: {
                    enabled: true
                }
			}
        },

        series: [{
			name: '# of musicians',
			color: '#00748F',
			data: [<%= @Composers %>,<%= @RecordingArtists %>, <%= @Salarieds %>, <%= @Performers %>, <%= @SessionPlayers %>, <%= @Teachers %>]
        }],

        tooltip: {
            pointFormat: '{point.y} musicians'
        }
    });
});

// Automatic form submission
$('form.f_facets input').change(function(){
  $('form.f_facets').submit();
});
//Mobile nav toggle to hide and show filters on mobile
$("#mobile_menu_toggle a.facets_on").on("click",function(e) {
  e.preventDefault();
  $('#facets').show();
  $("#outputs, .about_survey, #masthead, header, footer, .reset_link").hide();
  $("a.facets_on").addClass('hide_filtering_affordance');
  $(".hide_exit_filtering_affordance").removeClass('none');
});
//Mobile : hide filters and show data wituh back button
$("#mobile_menu_toggle a.facets_off").on("click",function(e) {
  e.preventDefault();
  $('#facets').hide();
  $("#outputs, .about_survey, #masthead, header, footer, .reset_link").show()
  $("a.facets_on").removeClass('hide_filtering_affordance');
  $(".hide_exit_filtering_affordance").addClass('none');
});
</script>
