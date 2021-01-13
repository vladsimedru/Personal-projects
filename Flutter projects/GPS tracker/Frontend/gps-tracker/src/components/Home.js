import React, { useState, useEffect } from "react";
import Map from "./Map";
import {
  Button,
  InputGroup,
  FormControl,
  Dropdown,
  DropdownButton,
} from "react-bootstrap";
import "react-bootstrap/dist/react-bootstrap.min.js";
import "./Home.css";
import axios from "axios";
import { Marker } from "google-maps-react";
import Navigator from "../Nav";

function Home() {
  const [isLogged, setIsLogged] = useState(false);
  const [userAuth, setUserAuth] = useState({});
  const [username, setUsername] = useState();
  const [users, setUsers] = useState([]);
  const [startDate, setStartDate] = useState(new Date());
  const [endDate, setEndDate] = useState(new Date());
  const [options, setOptions] = useState([]);
  const [userSelected, setUserSelected] = useState(0);
  const [locations, setLocations] = useState([]);
  const [locationsSubmitted, setLocationsSubmitted] = useState(false);

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
          let users = [];
          for (var i = 0; i < response.data.length; i++) {
            users.push(response.data[i]);
          }
          setUsers(users);
          console.log("ASDSa");
          console.log(users);
          const options = response.data.map((option) => (
            <option key={option.id} value={option.id}>
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
    console.log(userSelected);
  }, [userSelected]);

  const searchHandler = (e) => {
    console.log(userAuth);
    const userId = userSelected;
    axios({
      method: "POST",
      url: "http://localhost:8080/locations/findByUserIdAndDate",
      data: JSON.stringify({ userId, startDate, endDate }),
      auth: userAuth,
      headers: { "Content-Type": "application/json; charset=utf-8" },
    })
      .then((response) => {
        if (response.request.status === 200) {
          console.log("locatiile");
          console.log(response.data);
          const locations = response.data.map((location) => (
            <Marker
              // key={location.id}
              position={{
                lat: `${location.latitude}`,
                lng: `${location.longitude}`,
              }}
            />
          ));
          setLocationsSubmitted(true);
          setLocations(locations);
        } else {
          console.log(response.request.error);
        }
      })
      .catch((err) => {
        console.log(err);
      });
  };

  return (
    <div>
      <Navigator></Navigator>
      <div className="top">
        <div style={{ marginTop: "20px" }} className="search">
          <div paddingX={3} marginTop={3}>
            <text>Username</text>
            <select
              value={userSelected}
              onChange={(e) => setUserSelected(e.target.value)}
            >
              {options}
            </select>
          </div>
          <div>
            <InputGroup className="mb-3">
              <InputGroup.Prepend>
                <InputGroup.Text id="basic-addon1">Start Date</InputGroup.Text>
              </InputGroup.Prepend>
              <FormControl
                type="date"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
                placeholder="Username"
                aria-label="Username"
                aria-describedby="basic-addon1"
              />
            </InputGroup>
          </div>
          <div>
            <InputGroup className="mb-3">
              <InputGroup.Prepend>
                <InputGroup.Text id="basic-addon1">End Date</InputGroup.Text>
              </InputGroup.Prepend>
              <FormControl
                type="date"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
                placeholder="Username"
                aria-label="Username"
                aria-describedby="basic-addon1"
              />
            </InputGroup>
          </div>
          <div>
            <Button onClick={searchHandler}>Search</Button>
          </div>
        </div>
      </div>
      <div className="map">
        <Map
          locationsSubmitted={locationsSubmitted}
          locations={locations}
        ></Map>
      </div>
    </div>
  );
}

export default Home;
