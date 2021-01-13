import React, { useEffect } from "react";
import { Link } from "react-router-dom";
import {Button } from "react-bootstrap";

function Logout() {
  useEffect(() => {
    handleLogout();
  });

  const handleLogout = () => {
    localStorage.clear();
  };

  return (
    <div>
      Successful log out Do you want to come back?
      <Link to="/login">
        <Button onClick={handleLogout}>Login</Button>
      </Link>
    </div>
  );
}

export default Logout;
