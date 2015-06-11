<% genre_text=["All Others", "Classical", "Jazz", "Rock", "Country"]
%>

<% if (!@genre_income_on) %>
	<script>
		$("#genreincome").slideUp();
	</script>
<% end %>

<% if (!@genre_bar_on) %>
	<script>
		$("#genresingroup").slideUp();
	</script>
<% end %>

<script>
	var standardBarWidth=12;
//GEO MAP OF MUSICIANS BY COUNTY
$ (function () {  
  Highcharts.setOptions({       
      legend: {
          itemStyle: {
              fontWeight: 'normal',
              fontSize: '.917em'
          }
      },
      lang: {
        thousandsSep: ','
      },
      title: {
        style: {
          fontSize:'1em'
        }
      },
      plotOptions: {
        series: {
            dataLabels: {
                style: {
                    fontWeight: 'normal'
                }
            }
        }
    }
         
  });
  var data = <%= @MusiciansByCounties.to_json.html_safe %>,
  countiesMap = Highcharts.geojson(Highcharts.maps['countries/us/us-all-all']),
  lines = Highcharts.geojson(Highcharts.maps['countries/us/us-all-all'], 'mapline'),
  options;
  // Add state acronym for tooltip
  Highcharts.each(countiesMap, function (mapPoint) {
    mapPoint.name = mapPoint.name + ' (' + mapPoint.properties['hc-key'].substr(3, 2).toUpperCase()+ ')';
  });  
  options = {
    title : {
      text : null// 'Largest Clusters of Musicians'
    },
    subtitle : {
      text : 'Distribution of Group by ZIP/County'
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
			minColor: '#98E6F8',
      maxColor: '#00748F'
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
 
//ANNUAL INCOME BY CATEGORY
 
$('#annincbycat').highcharts({
    chart: {
      type: 'bar'
    },
    title: {
      text:'Income by Category',
        style: {
          fontSize:'1em'
        }
    },
    subtitle: null,
    xAxis: {
      categories: ['Live performance', 'Teaching', 'Salaried orch. player', 'Session work', 'Compositions', 'Sound recordings', 'Merch', 'Other']
    },
    yAxis: {
      maxPadding: .1,
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
      series: {
        pointWidth: standardBarWidth
      },
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
 
//ANNUAL INCOME TREND UP OR DOWN
 
$('#anninctrend').highcharts({
    chart: {
      type: 'bar'
    },
    title: {
      text: 'Income Trend by Category'
    },
    subtitle:{
      text: null
    },
    tooltipnot: {
      enabled: false
    },
    xAxis: {
      categories: ['Live performance', 'Teaching', 'Salaried orch. player', 'Session work', 'Compositions', 'Sound recordings', 'Merch' ],
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
      series: {
        pointWidth: standardBarWidth
      },
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
			      data: [10,10,10,10,10,10,10]
      }, //      data: [<%= @DecrIncLive.to_i %>, <%= @DecrIncTeach.to_i %> , <%= @DecrIncSalary.to_i %>, <%= @DecrIncSession.to_i %>,<%= @DecrIncComposition.to_i %>,<%= @DecrIncRecording.to_i %>,<%= @DecrIncMerch.to_i %>]

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
        {y: <%= @IncrIncMerch.to_i %>,delt:'<%= delta_percent_to_s(@IncrIncMerch, @DecrIncMerch) %>'}
      ]
    }]
  });
 
//AGE VS INCOME CHART    
 
  $('#ageincomechart').highcharts({
    chart: {
        type: 'bar'
    },
    title: {
	    text:'Music vs. Non-Music Income by Age'
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
            stacking: 'normal',
            pointWidth: standardBarWidth
	    }
    },
    series: [{
			name: 'Non-music income',
			color: '#CCCCCC',
			borderWidth: 0,
			type: 'column',
      data: <%= @NonMusicIncbyAge.as_json %>
    },{
			name: 'Income direct from music',
			color: '#00748F',
			borderWidth: 0,
			type: 'column',
			data: <%= @MusicIncbyAge.as_json %>
    }],
		yAxis: {
      maxPadding: .3,
  		offset: 10,
			title: {
				text: 'Total Gross Income'
			},
			stackLabels: {
				enabled: true,
				format: '${total:,.0f}',
				style: {
  				fontWeight: 'normal'
				}
			},
			plotLines: [{
        color: '#FF7D2C', // Color value
        dashStyle: 'Dash', // Style of the plot line. Default to solid
        value: <%= @avg_emi %>, // Value of where the line will appear
        width: '2', // Width of the line    
        label: {
          text: 'Avg. EMI: <%= number_to_currency(@avg_emi, :precision=>0) %>',
          rotation: '0',
          verticalAlign: 'bottom',
          style: {
            textAlign: 'left',
            marginTop: '-1em',
            color: '#FF7D2C',
            fontSize: '.917em',
            fontWeight: 'bold'
          }
        }
		  }]
		},
    tooltip: {
			headerFormat: 'For musicians {point.key} years old:<br>',
      pointFormat: 'Avg. {series.name}: $<b>{point.y}</b><br/>',
			zIndex: 5
    }
  });
  // GENRE INCOME CHART
  //	if 'true' == '<%= params.has_key?(:mgenre) %>' && 'ALL' != '<%= params[:mgenre]%>' {
  $('#genreincomechart').highcharts({
    chart: {
      type: 'bar'
    },
    title: {
      text: 'Comparison of Revenue Streams Based on Genre'
    },
    subtitle: {
      text: null
    },
    xAxis: { 
      categories: ['Live performance','Teaching','Salaried orch. player','Session work','Compositions','Sound recordings','Merchandise and branding','Other'],
      title: {
          text: null
      }
    },
    yAxis: {
      maxPadding: .08,
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
      series: {
        pointWidth: standardBarWidth
      },
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
      verticalAlign: 'bottom',
      reversed: true,
      x: -0,
      y: 0,
      floating: false,
      borderWidth: 1,
      backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
    },
    credits: {
      enabled: false
    },
    series: [{
      name: 'Non-<%= genre_text[params[:mgenre].to_i] %> Genres',
      emi: '<%= number_to_currency(@antigenre_avg_emi, :precision=>0) %>',
      color: '#FF7D2C',
      data: <%= if @antigenre_pcts then @antigenre_pcts.map {|x| number_with_precision(x,:precision=>2,:significant=>true).to_f}.to_json.html_safe else [] end %>
	
    }, {
      name: '<%= genre_text[params[:mgenre].to_i] %> Genre',
			emi: '<%= number_to_currency(@avg_emi, :precision=>0) %>',
    	color: '#00748F',
      data: <%= if @genre_pcts then @genre_pcts.map {|x| number_with_precision(x,:precision=>2,:significant=>true).to_f}.to_json.html_safe else [] end  %>
    }]
  });
	//}
  //GENRES IN GROUP
  $('#genresingroupchart').highcharts({
    chart: {
			type: 'bar',
      paddingTop: '3em'
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
      headerFormat: "<strong>{point.y}</strong> musicians spend most of their <strong>time</strong> on {point.key}.",
      <% if FilterProfileName()=='All Musicians' %>
      pointFormat: ""
      <%else%> 
      pointFormat: '<br />...although they earn most of their <strong>income</strong> as<br /> <% if FilterProfileName()=='Other musicians' %>all-other-genres<% else %><%=FilterProfileName().downcase%><%end%>'
      <% end %>  
    },
    xAxis: {
      categories: ['Classical','Jazz','Rock','Country','All others','No answer'],
      title: {text: "I spend most of my time on..."}
		},
		yAxis: {
      maxPadding: .08,
			title: {
				text: '# of musicians '
		  }
		},
		legend: {
			enabled: false
		},
    plotOptions: {
      series: {
        pointWidth: standardBarWidth
      },
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

  //ROLES CHART
  /*$('#roleschart').highcharts({
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
      categories: ['Composer','Recording Artist','Salaried orch. player','Performer','Session player','Teacher'],
      labels: {
        rotation: 0
      }
    },
    plotOptions: {
      series: {
        pointWidth: standardBarWidth,
      },
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
  });*/
});

// Automatic form submission
$('form.f_facets input').change(function(){
  gray_out_facets();
  count_number_of_roles();
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
//slightly gray out facets values not currently selected
function gray_out_facets() {
  $('#facets label input[type=checkbox]:not(:checked), #facets label input[type=radio]:not(:checked)').parent().addClass('unselected_filter');
  $('#facets label input[type=checkbox]:checked, #facets label input[type=radio]:checked').parent().removeClass('unselected_filter');
}
gray_out_facets();
//Display the number of selected role checkboxes dynmamically
function showRegularMatchOptionIfHidden() {
  if ($('#exact_role_facet').not(':visible')) {
    $('#exact_role_facet').slideDown();
  }
  if ($('#roles_exact_false').parent().not(':visible')) {
    $('#roles_exact_false').prop('disabled',false).parent('label').removeClass('has_disabled_input');
  }
}
function count_number_of_roles() {
  //in case it was hidden
  var cnt=$('#role_facet input:checked').length;
  //if no boxes checked, check them all:
  if (cnt==0) {
    $('#role_facet input[type=checkbox]').prop('checked',true);
    cnt=$('#role_facet input:checked').length;
  }  
  //if all boxes checked:
  if (cnt==$('#role_facet input[type=checkbox]').length) {
    $('#exact_role_facet').slideUp();
  } else {
    //if one box checked
    if (cnt==1) {
      $('.roles_selected_phrase').text('this 1 role');
    } else {
      //if 2-4 boxes checked
      $('.roles_selected_phrase').text('these '+cnt+' roles');
    } 
    showRegularMatchOptionIfHidden();
  }
}
//Run on page load:
count_number_of_roles();
 
</script>
