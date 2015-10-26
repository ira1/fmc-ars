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
              fontSize: '.75rem'
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
  var data = <%= @musicians_by_counties.to_json.html_safe %>,
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
      text:'Income Allocation',
        style: {
          fontSize:'1em'
        }
    },
    subtitle: null,
    xAxis: {
      categories: ['Live performance', 'Teaching', 'Salaried player', 'Session work', 'Compositions', 'Sound recordings', 'Merch', 'Other']
    },
    yAxis: {
      maxPadding: .15,
      title: {
        text: 'Avg. % of Income'
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
      data: <%= @avg_pct_incomes.to_json.html_safe %>
			//[<%= @AvgPctLive.to_i %>, <%= @AvgPctTeach.to_i %> , <%= @AvgPctSalary.to_i %>, <%= @AvgPctSession.to_i %>,<%= @AvgPctComposition.to_i %>,<%= @AvgPctRecord.to_i %>,<%= @AvgPctMerch.to_i %>,<%= @AvgPctOther.to_i%>]
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
			name: 'Income direct from music',
			color: '#00748F',
			borderWidth: 0,
			type: 'column',
			data: <%= @music_inc_by_age.as_json %>
    },{
			name: 'Non-music income',
			color: '#CCCCCC',
			borderWidth: 0,
			type: 'column',
      data: <%= @nonmusic_inc_by_age.as_json %>
    }],
		yAxis: {
      reversedStacks: false,
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
				id: 'ageincomeplotline',
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

//Construct Parameters for URL for sharing
function makeURLparms() {
	var conjunct="";
	var urlparms="/?"; 
	$("input[name^='utf'],input:radio:checked").each( function () { 
	 urlparms += conjunct+$(this).attr('name')+"="+$(this).val();
	 conjunct='&';
	});
	$("#ft,#trained,.f_facets input[id^=gender_]").each( function () { 
	 urlparms+=conjunct+$(this).attr('name')+"="+$(this).prop('checked');
	 conjunct='&';
	});
	return urlparms;
}

//Set UI to reflect  NCount
//First, hide the TOOLOW messaging, and then decide if it needs to be shown :
$('#toolow_warning').hide();

//These 2 function also fired on ajax callback potentially:
function setSampleSizeWarn() {
  $('#toolow_warning').hide();
  $('#outputs').removeClass("toolow");
	$('.low_n_size_message').html("and is a statistically small sample size from which to draw conclusions");
  $('.current_n_size').addClass('very_low');
  console.log('setSampleSizeWarn');
}

function setSampleSizeAlert() {
  console.log('setSampleSizeAlert');
  $('#toolow_warning').show();
	$('#outputs').addClass("toolow");
	$('.current_n_size').removeClass('very_low');
  $('.low_n_size_message').html("");
}
//on page load, set UI to reflect nCount
var serverNCount=parseInt($('#facets .total_n_count_from_ajax:first-child').text().replace(',',''));
console.log(serverNCount);
if (serverNCount < 101 ) {
  setSampleSizeAlert(); 
} else if (serverNCount > 100 && serverNCount < 401) {
  setSampleSizeWarn();
} 

//Set title tag for SEO and bookmarking and sharing
function setLabels() {
  //Also set the mobile label tags that display showing current filter state for all future ajax calls:
  var title_text='Survey results: '
  //Get GENRE
  var genre=$('input[name=mgenre]:checked').parent().text();
  var genre_html='<span class="label">'+genre+'</span>';
  //Get experience
  var careerexp='';
  var careerexp_html='';
  if ($('input[name=careerexp]:checked').val()!='ALL') {
    var careertext=$('input[name=careerexp]:checked').parent().text();
    careerexp='[ '+careertext+' ]';
    careerexp_html='<span class="label">'+careertext+'</span>';
  }
  //Get emi group / income
  var emigroup='';
  var emigroup_html='';
  if ($('input[name=emigroup]:checked').val()!='ALL') {
    var emigrouptext=$('input[name=emigroup]:checked').parent().text();
    emigroup='[ '+emigrouptext+' ]';
    emigroup_html='<span class="label">'+emigrouptext+'</span>';
  }
  //Get GEnders
  var genders='';
  var genders_html='';
  if ($('#gender_facet input[type=checkbox]:checked').length!=$('#gender_facet input[type=checkbox]').length) {
    //append each gender
    genders='[Genders=';
    genders_html='<span class="label">Genders=';
    $('#gender_facet input[type=checkbox]:checked').each(function(i){
        genders=genders+'['+$(this).parent().text()+']';
        genders_html=genders_html+'['+$(this).parent().text()+']';
    });
    //Close tags
    genders=genders+']';
    genders_html=genders_html+'</span>';
  }
  //Educated in music?
  var trained='';
  var trained_html='';
  if ($('#trained').is(':checked')==true) {
    trained='[ Educated in Music ]';
    trained_html='<span class="label">Educated in Music</span>';
  }
  
  //Get FullTime status
  var ft='';
  var ft_html='';
  if ($('#ft').is(':checked')==true) {
    ft='[ Full Time Musicians Only ]';
    ft_html='<span class="label">Full Time Musicians Only</span>';
  }
  //Get ROLES
  var requiredRoles =[];
  var excludedRoles =[];
  var roles =[];
  var roles_required = '';
  var roles_required_html = '';
  var roles_excluded = '';
  var roles_excluded_html = '';
  //First, get required roles - populate an array of included and excluded, each:
  $('.toggle_radio label.require.clicked').each(function(){
    requiredRoles.push($(this).closest('tr').prev().find('td span:first-child').text());
  });  
  $('.toggle_radio label.exclude.clicked').each(function(){
    excludedRoles.push($(this).closest('tr').prev('tr').find('td span:first-child').text());
  });  
  roles_required=requiredRoles.join(',');
  if (roles_required!='') {
    roles_required_html = '<span class="label"><span title="Required" class="fa fa-circle"></span> Roles ['+roles_required+']</span>';
    roles_required = '[Required roles: '+roles_required+']';
  }
  roles_excluded=excludedRoles.join(',');
  if (roles_excluded!='') {
    roles_excluded_html = '<span class="label"><span title="Exlcuded" class="fa fa-circle-o"></span> Roles: ['+roles_excluded+']</span>';
    roles_excluded = '[Excluded roles: '+roles_excluded+']';
  }
  //Empty the arrays now so refresh work
  requiredRoles.length=0;
  excludedRoles.length=0;
  //Now compute the title:
  title_text = title_text + genre + roles_required + roles_excluded + ft + careerexp + emigroup + trained + genders;
  $('.current_filter_state').html(genre_html + roles_required_html + roles_excluded_html + ft_html + careerexp_html + emigroup_html + trained_html + genders_html);
  $('title').text(title_text);
}
//end set labels

function setScrollPositionAfterSubmit() { 
    //the mobile facet menu and back button is visible, therefore return user to top of screen:
    $('body').animate({
        scrollTop: ($("#mobile_menu_toggle").offset().top - 5)
    }, 250);  
}
// Automatic form submission
$('form.f_facets input').change(function(){
  gray_out_facets();
  count_number_of_genders();
  setLabels();
  $('#outputs').addClass('feedbackWhileAjaxProcessing');
	window.history.pushState( {} , 'Survey Results', makeURLparms() );
  $('form.f_facets').submit();
});
//Mobile nav toggle to hide and show filters on mobile
$("#mobile_menu_toggle a.facets_on").on("click",function(e) {
  e.preventDefault();
  $('#facets').show();
  $("#outputs, .about_survey, #masthead, header, footer, .reset_link, #facets form > h5").hide();
  $("a.facets_on").addClass('hide_filtering_affordance');
  $(".hide_exit_filtering_affordance").removeClass('none');
});
//Mobile : hide filters and show data wituh back button
$("#mobile_menu_toggle a.facets_off").on("click",function(e) {
  e.preventDefault();
  $('#facets').hide();
  $("#outputs, .about_survey, #masthead, header, footer, .reset_link, .reset_link, #facets form > h5").fadeIn(200,function() {  
    $(window).resize(); //Highcharts need to be redrawn in mobile
  });
  $("a.facets_on").removeClass('hide_filtering_affordance');
  $(".hide_exit_filtering_affordance").addClass('none');
  setScrollPositionAfterSubmit();
});
//slightly gray out facets values not currently selected
function gray_out_facets() {
  $('#facets label input[type=checkbox]:not(:checked), #facets label input[type=radio]:not(:checked)').parent().addClass('unselected_filter');
  $('#facets label input[type=checkbox]:checked, #facets label input[type=radio]:checked').parent().removeClass('unselected_filter');
}
gray_out_facets();

function count_number_of_genders() {
  //in case it was hidden
  var cnt=$('#gender_facet input:checked').length;
  //if no boxes checked, check them all:
  if (cnt==0) {
    $('#gender_facet input[type=checkbox]').prop('checked',true);
    cnt=$('#gender_facet input:checked').length;
  } 
}
function selectRoleRadios() { 
  $('#role_facet .toggle_radio label').removeClass('clicked');
  $('#role_facet .toggle_radio input:checked').each(function() {
    var theClassName=$(this).attr('class').replace('toggle_option','').replace(' ','');
    var labelTag='label.'+theClassName;
    $(this).closest('tr').find(labelTag).addClass('clicked'); 
  });
}
$('#role_facet .toggle_radio label').on('click',function(){
  $(this).closest('tr').find('label').removeClass('clicked');
  $(this).addClass('clicked'); 
});
//Run on page load:
count_number_of_genders();
setLabels(); 
selectRoleRadios();
//tooltips

/**
* touchHover.js
*
* Create tooltips on mouseover or on click (for supporting touch interfaces).
*
* @author C. Scott Asbach
*/



/**
 * store the value of and then remove the title attributes from the
 * abbreviations (thus removing the default tooltip functionality of
   * the abbreviations)
 */
$('abbr').each(function(){		

	$(this).data('title',$(this).attr('title'));
	$(this).removeAttr('title');

});

  /**
 * when abbreviations are mouseover-ed show a tooltip with the data from the title attribute
 */
 
$('abbr').mouseover(function() {		

	// first remove all existing abbreviation tooltips
	$('abbr').next('.tooltip').remove();
	// create the tooltip
	$(this).after('<span class="tooltip"><span><span>' + $(this).data('title') + '</span><span class="fa fa-close fa-2x"></span></span></span>');

	// position the tooltip 4 pixels above and 4 pixels to the left of the abbreviation
	if ($("a.facets_on").is(':visible') || $('.hide_exit_filtering_affordance').is(':visible')) {
  	//its mobile layout, so treat tip like this:
  	
  	$(this).next().addClass('mobileTooltip');
  	$(this).next().on('click',function(){
      $(this).removeClass('mobileToolTip');
      $(this).hide();
    });

	} else {
  	//desktop layout

  	var left = $(this).position().left + $(this).width() + 4;
  	var top = $(this).position().top - 4;
  	$(this).next().css('left',left);
  	$(this).next().css('top',top);				
  }
});

  /**
 * when abbreviations are clicked trigger their mouseover event then fade the tooltip
 * (this is friendly to touch interfaces)
 */
$('abbr').click(function(){

	$(this).mouseover();

	// after a slight 2 second fade, fade out the tooltip for 1 second
	$(this).next().animate({opacity: 0.9},{duration: 2000, complete: function(){
		$(this).fadeOut(1000);
	}});

});

/**
 * Remove the tooltip on abbreviation mouseout
 */
$('abbr').mouseout(function(){

	$(this).next('.tooltip').remove();				

});	
//END TOOLTIPS

//mobile menu
$('header .fa-bars').on('click',function(){
  $('body').toggleClass('openedNav');
  $('#section-sub-footer, #page > *:not(header),.feedback,.page-title-container').toggleClass('hidden');
});

</script>
