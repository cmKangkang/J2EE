<%--
  Created by IntelliJ IDEA.
  User: RKK
  Date: 2020/11/1
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <script src="https://cdn.staticfile.org/react/16.4.0/umd/react.development.js"></script>
    <script src="https://cdn.staticfile.org/react-dom/16.4.0/umd/react-dom.development.js"></script>
    <script src="https://cdn.staticfile.org/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdn.staticfile.org/jquery/2.1.4/jquery.min.js"></script>
</head>
<body>
${userID},${userPWD}
<div id="root"></div>
</body>
<script type="text/babel">
    class Demo extends React.Component{
        constructor(props) {
            super(props);
            this.state={
                id:props.id,
            }
        }
        render(){
            return(
            <div className="demo">
                这是测试id：{this.state.id}
            </div>
            )
        }
    }
    ReactDOM.render(<Demo id={${userID}}/>,
        document.getElementById("root")
    )
</script>
</html>
