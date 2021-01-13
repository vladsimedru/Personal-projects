import React, { useState, useEffect } from "react";
import axios from "axios";
import Home from "./Home";
import { Link, Redirect, Route, useHistory } from "react-router-dom";
import { Button, Form } from "react-bootstrap";
import "./Login.css";

export const UserContext = React.createContext();

function Login() {
  const [count, setCount] = useState(0);
  const [email, setEmail] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loggedIn, setLoggedIn] = useState(false);
  const [user, setUser] = useState({});

  const history = useHistory();

  useEffect(() => {
    console.log("useEffect - upp doc title");
    document.title = `Login`;
  }, []);

  const loginHandler = (e) => {
    e.preventDefault();
    axios({
      method: "POST",
      url: "http://localhost:8080/users/login",
      data: JSON.stringify({ email, password }),
      headers: { "Content-Type": "application/json; charset=utf-8" },
    })
      .then((response) => {
        if (response.request.status === 200) {
          console.log(response);
          setLoggedIn(true);
          const user = { username, password };
          localStorage.setItem("userAuth", JSON.stringify(user));
          history.push({
            pathname: "/home",
            state: { detail: response.data },
          });
        } else {
          console.log(response.request.error);
        }
      })
      .catch((err) => {
        console.log(err);
      });
  };

  return (
    <div style={{ backgroundImage: "http://localhost:3000/background2.jpg" }}>
      <Form className="box">
        <h1>
          <span className="font-weight-bold">gps-tracker</span>.com
        </h1>
        <h3>We follow you,seriously</h3>
        <div className="login">
          <Form.Group controlId="formBasicEmail">
            <Form.Label>Email address</Form.Label>
            <Form.Control
              type="email"
              value={email}
              onChange={(e) => {
                setEmail(e.target.value);
                setUsername(e.target.value);
              }}
              placeholder="Enter email"
            />
            <Form.Text className="text-muted">
              We'll never share your email with anyone else.
            </Form.Text>
          </Form.Group>

          <Form.Group controlId="formBasicPassword">
            <Form.Label>Password</Form.Label>
            <Form.Control
              value={password}
              onChange={(e) => {
                setPassword(e.target.value);
              }}
              type="password"
              placeholder="Password"
            />
          </Form.Group>
          <Form.Group controlId="formBasicCheckbox">
            <Form.Check type="checkbox" label="Remember me" />
          </Form.Group>
          <Button onClick={loginHandler} variant="primary" type="submit">
            Login
          </Button>
        </div>
      </Form>
    </div>
  );
}

export default Login;
