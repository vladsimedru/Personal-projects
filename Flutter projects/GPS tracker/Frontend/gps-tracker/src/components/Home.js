import React, { useState, useEffect} from "react";
import Map from "./Map";
import {Button } from "react-bootstrap";
import "react-bootstrap/dist/react-bootstrap.min.js";
import "./Home.css";
import axios from "axios";
import {Marker} from "google-maps-react";
import Navigator from "../Nav";

function Home() {
  const [isLogged,setIsLogged]=useState(false)
  const [userAuth, setUserAuth] = useState({});
  const [username, setUsername] = useState();
  const [startDate, setStartDate] = useState(new Date());
  const [endDate, setEndDate] = useState(new Date());
  const [options, setOptions] = useState([]);
  const [userSelected,setUserSelected]=useState({});
  const [locations,setLocations]=useState([])
  const [locationsSubmitted,setLocationsSubmitted]=useState(false)

  useEffect(() => {
    const loggedInUser = localStorage.getItem("userAuth");
    if (loggedInUser) {
      const userAuth = JSON.parse(loggedInUser);
      setUserAuth(userAuth);
      setIsLogged(true);
      axios({
        method: "GET",
        url: "http://localhost:8080/users/users",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        auth: userAuth,
      })
        .then((response) => {
          console.log("useEff render");
          const options = response.data.map((option) => (
            <option key={option.id}
            value={option.id}>
              {option.email}
            </option>
          ));
          setOptions(options);
        })
        .catch((err) => {
          console.log(err);
        });
    } else {
      console.log("user is not logged");
    }
    console.log(userSelected)
  }, [userSelected]); 

  const searchHandler = e => {
    console.log(userAuth)
    const userId=userSelected
    axios({
      method: 'POST',
      url:'http://localhost:8080/locations/findByUserIdAndDate', 
      data: JSON.stringify({userId,startDate,endDate }), 
      auth:userAuth,
      headers:{'Content-Type': 'application/json; charset=utf-8'}
  })   
      .then(response=>{
        if (response.request.status === 200){
         console.log("locatiile")
         console.log(response.data)
         const locations = response.data.map((location) => (
               <Marker
               // key={location.id}
                position={{ lat: `${location.latitude}`, lng: `${location.longitude}` }}
              />))  
          setLocationsSubmitted(true)   
          setLocations(locations)     
        } 
        else{
          console.log(response.request.error) 
        }
      })
      .catch((err) => {
        console.log(err);
      });
  }

  return (
    <div>
      <Navigator></Navigator>
      <div className="top">
        <h2 style={{marginTop:"5px"}}>Welcome , let's search</h2>
        <div className="search">
          <div paddingX={3} marginTop={3}>
            <text>Username</text>
            <select value={userSelected} onChange={(e)=>setUserSelected(e.target.value)} >{options}</select>
          </div>
          <div>
            <text>Start date</text>
            <input
              type="date"
              value={startDate}
              onChange={(e) => setStartDate(e.target.value)}
            ></input>
          </div>
          <div>
            <text>End date</text>
            <input
              type="date"
              value={endDate}
              onChange={(e) => setEndDate(e.target.value)}
            ></input>
          </div>
        </div>
        <div style={{padding:'8px'}}>
          <Button onClick={searchHandler}>Search</Button>
        </div>
      </div>
      <div className="map">
        <Map locationsSubmitted={locationsSubmitted} locations={locations}></Map>
      </div>
    </div>
  );
}

export default Home;
