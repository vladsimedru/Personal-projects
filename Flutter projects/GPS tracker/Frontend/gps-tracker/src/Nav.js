import React from "react";
import { Link } from "react-router-dom";
import { Nav,Form, Button, FormControl, Navbar, NavDropdown } from "react-bootstrap";

function Navigator() {
  return (
    <Navbar bg="night" expand="lg">
    <Navbar.Brand href="#home">Gps-Tracker</Navbar.Brand>
    <Navbar.Toggle aria-controls="basic-navbar-nav" />
    <Navbar.Collapse id="basic-navbar-nav">
      <Nav className="mr-auto">
        <Nav.Link href="/home">Home</Nav.Link>
        <Nav.Link href="/users">Users</Nav.Link>
        <Nav.Link href="/about">About us</Nav.Link>
        <NavDropdown title="Me" id="basic-nav-dropdown">
          <NavDropdown.Item href="/myaccount">My account</NavDropdown.Item>
          <NavDropdown.Divider />
          <NavDropdown.Item href="/logout">Log out</NavDropdown.Item>
        </NavDropdown>
      </Nav>
    </Navbar.Collapse>
  </Navbar>
  );
}

export default Navigator;
