import './App.css';
import Login from './components/Login';
import Home from './components/Home';
import About from './components/About';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import Logout from './components/Logout';
import Navigator from './Nav';
import Users from './components/Users';
import MyAccount from './components/MyAccount';

function App() {
  
  return (

    <Router>
    <div className="App">
       <Switch>
        <Route path='/about' exact component={About} />
        <Route path='/home' exact component={Home} />
        <Route path='/login' exact component={Login} />
        <Route path='/users' exact component={Users} />
        <Route path='/myaccount' exact component={MyAccount} />
        <Route path='/logout' exact component={Logout} />
       </Switch>
    </div>
    </Router>
  );
}

export default App;
