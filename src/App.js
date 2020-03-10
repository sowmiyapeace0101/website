import React, { Component } from 'react';
import './App.css';
import Sidebar from './components/sidebar'
import Resume from './components/resume'

class App extends Component {
  render() {
    return (
      <div id="colorlib-page">
        <div id="container-wrap">
         	<Sidebar></Sidebar>
				<div id="colorlib-main">
          {/* <Resume></Resume> */}
        </div>
      	</div>
      </div>
    );
  }
}

export default App;
