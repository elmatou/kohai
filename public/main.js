Highcharts.chart('puissance', {
  chart: {
    type: 'area',
    zoomType: 'xy',
    panKey: 'ctrl'
  },
  title: {
    text: 'Puissance électrique Consommée',
    align: 'left',
    margin: 0,
    x: 30
  },
  credits: { enabled: false },
  legend: { enabled: false },
  xAxis: {
    crosshair: true
  },
  yAxis: {
    crosshair: true,
    labels: { format: '{value} W' },
    title: { text: null }
  },
  tooltip: {
    positioner: function () {
      return { x: this.chart.chartWidth - this.label.width - 30 };
    },
    borderWidth: 0,
    backgroundColor: 'none',
    pointFormat: '{point.y}',
    headerFormat: '',
    shadow: false,
    style: { fontSize: '18px' },
    valueDecimals: 0,
    valueSuffix: ' ' + 'W'
  },
  plotOptions: {
    area: { fillOpacity: 0.3 }
  },
  data: {
    rowsURL: new URL('meter/2/indices', window.location.href).href,
    firstRowAsNames: false,
    dataRefreshRate: 20,
    enablePolling: true
  }
});


Highcharts.chart('consommation', {
  chart: {
    type: 'spline'
  },
  title: {
    text: 'Consommation électrique',
    align: 'left',
    margin: 0,
    x: 30
  },
  credits: { enabled: false },
  legend: { enabled: false },
  xAxis: {
    crosshair: true
  },
  yAxis: {
    crosshair: true,
    labels: { format: '{value} kWh' },
    title: { text: null }
  },
  tooltip: {
    positioner: function () {
      return { x: this.chart.chartWidth - this.label.width - 30 };
    },
    borderWidth: 0,
    backgroundColor: 'none',
    pointFormat: '{point.y}',
    headerFormat: '',
    shadow: false,
    style: { fontSize: '18px' },
    valueDecimals: 0,
    valueSuffix: ' ' + 'kWh'
  },
  plotOptions: {
    area: { fillOpacity: 0.3 }
  },
  data: {
    rowsURL: new URL('meter/1/indices', window.location.href).href,
    firstRowAsNames: false,
    dataRefreshRate: 20,
    enablePolling: true
  }
});
