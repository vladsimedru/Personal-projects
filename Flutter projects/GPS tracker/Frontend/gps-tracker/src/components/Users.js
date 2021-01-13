import React, { useState, useEffect, useCallback } from "react";
import axios from "axios";
import Navigator from "../Nav";
import { ListGroup, Button } from "react-bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import "./Users.css";

function Users() {
  const [userAuth, setUserAuth] = useState({});
  const [users, setUsers] = useState([]);
  const [usersIsLoaded, setUsersIsLoaded] = useState(false);
  const [refresh,setRefresh]=useState(0)

  const deleteUserHandler = useCallback((id) => {
    axios({
      method: "DELETE",
      url: `http://localhost:8080/users/delete/${id}`,
      auth: userAuth
    })
      .then((response) => {
        setRefresh(refresh+1)
      })
      .catch((err) => {
        console.log(err);
      });
  },[refresh]);

  const makeAdminHandler = useCallback((id) => {
    axios({
      method: "GET",
      url: `http://localhost:8080/users/roles/admin/${id}`,
      auth: userAuth
    })
      .then((response) => {
        setRefresh(refresh+1)
      })
      .catch((err) => {
        console.log(err);
      });
  },[]);

  const deleteAdminRoleHandler = useCallback((id) => {
    axios({
      method: "GET",
      url: `http://localhost:8080/users/roles/basicUser/${id}`,
      auth: userAuth
    })
      .then((response) => {
        setRefresh(refresh+1)
      })
      .catch((err) => {
        console.log(err);
      });
  },[]);

  useEffect(() => {
    const loggedInUser = localStorage.getItem("userAuth");
    if (loggedInUser) {
      const userAuth = JSON.parse(loggedInUser);
      setUserAuth(userAuth);
      axios({
        method: "GET",
        url: "http://localhost:8080/users/users",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        auth: userAuth,
      })
        .then((response) => {
          console.log("useEff render");
          const users = response.data.map((user) => (
            <ListGroup.Item
              className={"user"}
              key={user.id}
              value={user.id}
              variant={"success"}
            >
              {user.email}
              <div className={"buttons"} >
                <Button onClick={()=>{user.roles.length>1?deleteAdminRoleHandler(user.id):makeAdminHandler(user.id)}} style={{marginRight:'15px'}}>{user.roles.length>1?"Remove Admin Role":"Make Admin"}</Button>
                <Button onClick={()=>deleteUserHandler(user.id)}>Delete user</Button>
              </div>
            </ListGroup.Item>
          ));
          setUsersIsLoaded(true);
          setUsers(users);
        })
        .catch((err) => {
          console.log(err);
        });
    } else {
      console.log("user is not logged");
    }
  }, [refresh]);

  return (
    <div>
      <Navigator></Navigator>
      <ListGroup >{usersIsLoaded ? users:"Loading.."}</ListGroup>
    </div>
  );
}

export default Users;
