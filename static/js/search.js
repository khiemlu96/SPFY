var Search = React.createClass({ 
  getInitialState: function () {
    return {
      initial: true,
      displayDetail: false,
      displayQueryBuilder: true,
      detailData: {},
      columns: [],
      currentTable: "",
      currentColumn: "",
      currentColumnType: 0, // 1043 = string, 23 = int, 16 = bool, 1082 = date
      currentSearchParameter: 0,
      currentData: "",
      people: {}
    }
  },
  displayDetail: function (data) {
    this.setState({
      displayDetail: true,
      detailData: data
    });
  },
  closeDetail: function () {
    this.setState({displayDetail: false});
  },
  toggleQueryBuilder: function () {
    this.setState({
      displayQueryBuilder: !this.state.displayQueryBuilder
    })
  },
  writeToTable: function (data) {
    this.setState({
      people: data
    });
  },
  changeColumns: function (data) {
    this.setState({
      columns: data
    })
  },
  formatColumnName: function (column) {
    var columnSplit = column.split("_");
    var newColumn = [];
    columnSplit.forEach(function (word) {
      newColumn.push(word.charAt(0).toUpperCase() + word.substr(1));
    }); 
    return newColumn.join(" ");
  },
  getInitialData: function (data) {
    var handleColumns = this.changeColumns;
    var writeToTable = this.writeToTable;
    var formatColumnName = this.formatColumnName
    var url = "api/search/" + data;
    this.setState({
      currentTable: data
    });
    $.ajax({
      xhrFields: {
        withCredentials: true
      },
      beforeSend: function (xhr) {
        xhr.setRequestHeader('Authorization', localStorage.getItem("authorization"));
      },
      url: url,
      method: "GET",
      success: function (data) {
        var fields = data.result.fields;
        var columnNames = [];
        var formattedName = "";
        for(var i = 0; i < fields.length; i++) {
          formattedName = formatColumnName(fields[i].name);
          columnNames.push({name: formattedName, type: fields[i].dataTypeID});
        };
        handleColumns(columnNames);
        writeToTable(data.result.rows);
        console.log(data.result.rows)
      },
      error: function (xhr) {
        console.error(xhr);

        if (xhr.status === 401) {
          localStorage.removeItem("authorization");
        }
      }
    });
  },
  editPropColumn: function (data) {
    var jsonData = JSON.parse(data);
    var unformattedName = jsonData.name.toLowerCase().replace(" ", "_");
    this.setState({
      currentColumn: unformattedName,
      currentColumnType: jsonData.type,
      currentSearchParameter: 0
    });
  },
  editPropStatus: function (data) {
    this.setState({
      currentSearchParameter: data
    });
  },
  editPropText: function (data) {
    this.setState({
      currentData: data
    });
    this.state.currentData = data; // currently there's an issue with search not working
    // right if this isn't here - it's caused by the fact that setState is async so the 
    // search runs on the previous data, not the new one. This will be remedied soon.
    this.search();
  },
  performSearch: function(data) {
    this.setState({
      currentSearchParameter: data,
      currentData: "unused"
    });
    this.state.currentSearchParameter = data; // see above for why this is done
    this.state.currentData = "unused";
    this.search();
  },
  search: function (data) {
    var props = {
      column: this.state.currentColumn,
      columnType: this.state.currentColumnType,
      status: this.state.currentSearchParameter,
      data: this.state.currentData
    }
    if (props.column != "") {
      var url = "api/search/" + this.state.currentTable 
                       + ((props.data != "") ? 
                          "/" + JSON.stringify(props) : 
                          "");
      console.log(url);
      var writeToTable = this.writeToTable;
      $.ajax({
        xhrFields: {
          withCredentials: true
        },
        beforeSend: function (xhr) {
          xhr.setRequestHeader('Authorization', localStorage.getItem("authorization"));
        },
        url: url,
        method: "GET",
        success: function (data) {
          console.log(data.result.rows);
          writeToTable(data.result.rows);
        },
        error: function (xhr) {
          console.error(xhr);
          writeToTable({});

          if (xhr.status === 401) {
            localStorage.removeItem("authorization");
          }
        }
      });
    };
  },
  render: function () {
    return (
      <div className="searchMain">
        <QueryBuilderInterface selectTable={this.getInitialData} 
                               columns={this.state.columns}
                               display={this.state.displayQueryBuilder}
                               toggleBuilder={this.toggleQueryBuilder}
                               currentType={this.state.currentColumnType}
                               changeColumn={this.editPropColumn}
                               changeStatus={this.editPropStatus}
                               currentSearchParameter={this.state.currentSearchParameter}
                               changeInput={this.editPropText}
                               performSearch={this.performSearch} />
        <DetailPane hidden={this.state.displayDetail} 
                    detailData={this.state.detailData}
                    close={this.closeDetail}
                    format={this.formatColumnName} />
        <FilterTable people={this.state.people} 
                     headers={this.state.columns}
                     displayDetail={this.displayDetail}
                     extendWidth={this.state.displayQueryBuilder} />
        {/*<Footer />*/}
      </div>
    )
  }
});

var QueryBuilderInterface = React.createClass({
  getInitialState: function () {
    return {
      displaySelector: false,
      dropdownToDisplay: "string",
      inputToDisplay: "text",
      displayInput: false
    };
  },
  toggleSelector: function (data) {
    this.setState({
      displaySelector: data
    })
  },
  changeDropdown: function (data) {
    this.setState({
      dropdownToDisplay: data
    });
  },
  changeInput: function (data) {
    this.setState({
      inputToDisplay: data
    });
  },
  showInput: function (hasColumn) {
    if (hasColumn) {
      this.setState({
        displayInput: true
      });
    } else {
      this.setState({
        displayInput: false
      });
    };
  },
  render: function () {
    var classNames = "queryBuilderUI " + (this.props.display ? "" : "hidden"),
        closeClassName = "qbAccess " + (this.props.display ? "hidden" : "");
    return (
      <div>
        <div className={closeClassName} onClick={this.props.toggleBuilder}> 
          >
        </div>
        <div className={classNames}>
          <span id="qbClose" onClick={this.props.toggleBuilder}>Close</span>
          <ResourceSelector handleChange={this.props.selectTable} 
                            changeDisplay={this.toggleSelector} />
          <QueryBuilder columns={this.props.columns} 
                        currentType={this.props.currentType}
                        display={this.state.displaySelector}
                        displayInput={this.state.displayInput}
                        showInput={this.showInput}
                        currentSearchParameter={this.props.currentSearchParameter}
                        updateStatus={this.props.changeStatus}
                        changeColumn={this.props.changeColumn}
                        changeInput={this.props.changeInput}
                        performSearch={this.props.performSearch} />
          {/* <ViewManager /> */}
        </div>
      </div>
    )
  }
})

var ResourceSelector = React.createClass({
  handleChange: function (e) {
    if (e.target.value != "none") {
      this.props.handleChange(e.target.value);
      this.props.changeDisplay(true);
    } else {
      this.props.changeDisplay(false);
    }
  },
  render: function () {
    return (
      <div className="qbBlock">
        <h4 className="qbHeader">Resource</h4>
        <select className="qbSelect" onChange={this.handleChange}>
          <option value="none">Select a Resource.</option> 
          <option value="clients">Client</option>
        </select>
      </div>
    )
  }
});

var QueryBuilder = React.createClass({
  handleColumnChange: function (e) {
    if (e.target.value != "none") {
      this.props.showInput(true);
      this.props.changeColumn(e.target.value);
    };
  },
  handleStrictnessChange: function (e) {
    this.props.updateStatus(parseInt(e.target.value));
  },
  handleTextChange: function (e) {
    this.props.changeInput(e.target.value);
  },
  performSearch: function (e) {
    this.props.performSearch(parseInt(e.target.value));
  },
  render: function () {
    var columns = [];
    this.props.columns.forEach(function (columnName) {
      columns.push(
        <option value={JSON.stringify(columnName)} 
                key={JSON.stringify(columnName)}>{columnName.name}</option>
      )
    });
    var classNames = "qbBlock " + (this.props.display ? "" : "hidden"),
        inputClassNames = "qbText " + (this.props.displayInput ? "" : "hidden");
    // Consider: Exists vs not exists? What is required?
    var columnIsIntDropdown = 
      <select className="qbSelect" onChange={this.handleStrictnessChange} value={this.props.currentSearchParameter}>
        <option value="0">Is</option>
        <option value="1">Is Not</option>
        <option value="2">Is Greater Than</option>
        <option value="3">Is Less Than</option>
      </select>;
    var columnIsIntOrStringBox = 
      <input type="text" className={inputClassNames} onChange={this.handleTextChange} />;
    var columnIsStringDropdown = 
      <select className="qbSelect" onChange={this.handleStrictnessChange} value={this.props.currentSearchParameter}>
        <option value="0">Contains</option>
        <option value="1">Is Exactly</option>
      </select>;
    var columnIsBoolDropdown = 
      <select className="qbSelect" onChange={this.performSearch} value={this.props.currentSearchParameter}>
        <option value="0">Is True</option>
        <option value="1">Is False</option>
        <option value="2">Exists</option>
        <option value="3">Does Not Exist</option>
      </select>;
    var columnIsDateDropdown = 
      <select className="qbSelect" onChange={this.handleStrictnessChange} value={this.props.currentSearchParameter}>
        <option value="0">Is</option>
        <option value="2">Is Not</option>
        <option value="3">Is Between</option>
        <option value="3">Is Not Between</option>
        <option value="4">Is Before</option>
        <option value="5">Is After</option>
      </select>;
    //var columnIsDateBox = <DateDropdown />
    var selectedDropdown;
    var selectedInput;
    if (this.props.currentType === 1043) { // string 
      selectedDropdown = columnIsStringDropdown;
      selectedInput = columnIsIntOrStringBox;
    } else if (this.props.currentType === 23) { // int
      selectedDropdown = columnIsIntDropdown;
      selectedInput = columnIsIntOrStringBox;
    } else if (this.props.currentType === 16) { // bool
      selectedDropdown = columnIsBoolDropdown;
      selectedInput = <p></p>;
    } else if (this.props.currentType === 1082) { // date
      selectedDropdown = columnIsDateDropdown;
      selectedInput = <p></p>;
    } else {
      selectedDropdown = <p></p>;
      selectedInput = <p></p>;
    }
    return (
      <div className={classNames}>
        <h4 className="qbHeader">Build Search</h4>
        <select className="qbSelect" onChange={this.handleColumnChange}> 
          <option value="none">Select an Option to Filter By</option>
          {columns}
        </select>
        {selectedDropdown}
        {selectedInput}
      </div>
    )
  }
});

var ViewManager = React.createClass({
  render: function () {
    return (
      <div className="viewSaver">
        The view saver.
      </div>
    )
  }
});

var FilterTable = React.createClass({
   render: function () {
      var tableRows = [];
      for (var i = 0; i < this.props.people.length; i++) {
        var person = this.props.people[i];
        var isEven = (i % 2 === 0);
        var keyString = "tRow" + person["id"];
        tableRows.push(
          <FilterTableRow person={person} 
                          isEven={isEven}
                          key={keyString}
                          displayDetail={this.props.displayDetail} />
        )
      }
      var className = (this.props.extendWidth ? "filterTableExtend" : "filterTable");
      return (
        <div id="allowScroll">
          <table className={className}>
            <tbody>
              <FilterTableHeader header={this.props.headers}/>
              {tableRows}
            </tbody>
          </table>
        </div>
      )
   }
});

var FilterTableHeader = React.createClass({
  render: function () {
    var headers = [];
    this.props.header.forEach(function (header) {
      headers.push(<td key={header.name} className="ftHead ftCell">{header.name}</td>);
    })
    return (
      <tr className="ftRow">
        {headers}
      </tr>
    )
  }
});

var FilterTableRow = React.createClass({
  handleClick: function () {
    this.props.displayDetail(this.props.person);
  },
  render: function () {
    var colorClass = "";
    if (this.props.isEven) {
      colorClass = "ftEven";
    } else {
      colorClass = "ftOdd";
    };
    var classNames = "ftRow " + colorClass;
    var person = this.props.person;
    var info = [];
    var keyString;
    var targetText;
    for (var prop in person) {
      if (person.hasOwnProperty(prop)) {
        keyString = person["id"] + prop + person[prop];
        targetText = (person[prop] === null) ? "" : person[prop].toString();
        info.push(<td key={keyString} className={classNames}>{targetText}</td>)
      }
    };
    return (
      <tr key={person["id"]} className={classNames} onClick={this.handleClick}>
        {info}
      </tr>
    )
  }
});

var DetailPane = React.createClass({
  render: function () {
    var classNames = "detailPane " + (this.props.hidden ? "" : "hidden");
    var details = [];
    for (var key in this.props.detailData) {
      if (this.props.detailData.hasOwnProperty(key)) {
        details.push(<p key={key} className="dDetail">{this.props.format(key)} : {this.props.detailData[key]}</p>);
      }
    }
    return (
      <div className={classNames}>
        <span id="dClose" onClick={this.props.close}>Close</span>
        <div className="dInset">
          <p id="dHeader"> Details </p>
          {details}
        </div>
      </div>
    )
  }
});

var DateDropdown = React.createClass({
  render: function () {
    var date = moment().date(this.props.day)
                       .month(this.props.month)
                       .year(this.props.year) 
    var totalDays = date.daysInMonth();
    return (
      <div>
        <select name="birthMonth" defaultValue={date.month()} onChange={this.props.handleMonthChange}>
          <option value="0">January</option>
          <option value="1">February</option>
          <option value="2">March</option>
          <option value="3">April</option>
          <option value="4">May</option>
          <option value="5">June</option>
          <option value="6">July</option>
          <option value="7">August</option>
          <option value="8">September</option>
          <option value="9">October</option>
          <option value="10">November</option>
          <option value="11">December</option>
        </select>
        <DayDropdown handleDayChange={this.props.handleDayChange} 
                     totalDays={totalDays}
                     date={date.date()} />
        <YearDropdown handleYearChange={this.props.handleYearChange}
                      year={date.year()} />
        <span className={this.props.ageWarning}> Older than 25. </span>
      </div>
    )
  }
});

var DayDropdown = React.createClass({
  render: function () {
    var showTwentyNineth = (29 > this.props.totalDays) ? "hidden" : "";
    var showThirtieth = (30 > this.props.totalDays) ? "hidden" : "";
    var showThirtyFirst = (31 > this.props.totalDays) ? "hidden" : "";
    if ($("select[name='birthDay']").val() > this.props.totalDays) {
      $("select[name='birthDay']").val(this.props.totalDays);
    };
    return (
      <select name="birthDay" defaultValue={this.props.date} onChange={this.props.handleDayChange}>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option value="10">10</option>
          <option value="11">11</option>
          <option value="12">12</option>
          <option value="13">13</option>
          <option value="14">14</option>
          <option value="15">15</option>
          <option value="16">16</option>
          <option value="17">17</option>
          <option value="18">18</option>
          <option value="19">19</option>
          <option value="20">20</option>
          <option value="21">21</option>
          <option value="22">22</option>
          <option value="23">23</option>
          <option value="24">24</option>
          <option value="25">25</option>
          <option value="26">26</option>
          <option value="27">27</option>
          <option value="28">28</option>
          <option value="29" className={showTwentyNineth}>29</option>
          <option value="30" className={showThirtieth}>30</option>
          <option value="31" className={showThirtyFirst}>31</option>
        </select>
    )
  }
})

var YearDropdown = React.createClass({
  render: function () {
    var yearOptions = [];
    for(var i = this.props.year - 50; i <= this.props.year; i++) {
      yearOptions.push(<option key={i} value={i}>{i}</option>);
    }
    return (
      <select name="birthYear" defaultValue={this.props.year} onChange={this.props.handleYearChange}>
        {yearOptions}
      </select>
    )
  }
})


ReactDOM.render(
  <Search />,
  document.getElementById('dataBrowserContent')
);