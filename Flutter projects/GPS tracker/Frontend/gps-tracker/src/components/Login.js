import React,{useState} from 'react'

function Login() {

const [count, setCount] = useState(0)
const [username, setUsername]=useState('')
const [password,setPassword]=useState('')

console.log(username)
    return (
        <div> 
            <button onClick={()=>setCount(count+1)}>Count {count}</button>
            <div>
              <text>username</text>
              <input  onChange={e=>{setUsername(e.target.value)}}></input>
            </div>
            <div>
              <text>password</text>
              <input  onChange={e=>{setPassword(e.target.value)}}></input>
            </div>
            <button onClick={loginClickedHandler}></button>

            
        </div>
    )
}

export default Login
