import React from 'react';
import './App.css';
import Signup from "./app/sign-up";
import ConfirmUserPage from "./app/example/confirmUserPage";
import HomePage from "./app/example/homePage";
import LoginPage from "./app/example/loginPage";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";


const App = () => {
    const isAuthenticated = () => {
        const accessToken = sessionStorage.getItem("accessToken");
        return !!accessToken;
    };

    return (
        <div className="App">
            <BrowserRouter>
                <Routes>
                    <Route
                        path="/"
                        element={
                            isAuthenticated() ? (
                                <Navigate replace to="/home"/>
                            ) : (
                                <Navigate replace to="/login"/>
                            )
                        }
                    />
                    <Route path="/login" element={<LoginPage/>}/>
                    <Route path="/confirm" element={<ConfirmUserPage/>}/>
                    <Route
                        path="/home"
                        element={
                            isAuthenticated() ? <HomePage/> : <Navigate replace to="/login"/>
                        }
                    />
                </Routes>
            </BrowserRouter>
    </div>
        );
        };


            function App2() {
            return (
            <div className="App">

            <Signup></Signup>
        {/*<MyPlants></MyPlants>*/}
        </div>
    );
}

export default App;
