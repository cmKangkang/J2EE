<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live</title>
    <link rel="icon" href="../icon/logo-stackoverflow.svg"/>
    <script src="https://cdn.staticfile.org/react/16.4.0/umd/react.development.js"></script>
    <script src="https://cdn.staticfile.org/react-dom/16.4.0/umd/react-dom.development.js"></script>
    <script src="https://cdn.staticfile.org/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdn.staticfile.org/jquery/2.1.4/jquery.min.js"></script>
    <link href="https://vjs.zencdn.net/7.0.3/video-js.css" rel="stylesheet">
    <script src="https://vjs.zencdn.net/7.0.3/video.js"></script>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../css/live-style.css" type="text/css"></link>
</head>
<body>
<div id="root"></div>
</body>
<script type="text/babel">
    class TopDock extends React.Component{
        constructor(props) {
            super(props);
            this.state={
                uname:props.uname,
                cname:props.cname,
                ctname:props.ctname,
            }
        }
        render(){
            return(
                <div className="top-dock">
                    <div className="app-name"><h4>CoursePro</h4></div>
                    <div className="course-zone">
                        <img className="icon" src="../icon/logo-stackoverflow.svg"/>
                        <p>{this.state.cname}  {this.state.ctname}</p>
                    </div>
                    <div className="user-zone">
                        <img className="icon" src="../icon/logo-github.svg"/>
                        <span className="course-name">{this.state.uname}</span>
                    </div>
                </div>
            );
        }
    }

    class VideoLive extends React.Component{
        constructor(props) {
            super(props);
            this.state={
                cid:props.cid,
                cname:props.cname,
                ctname:props.ctname,
                live_src:props.live_src,
            }
        }

        render(){
            return(
                <div className="video-live">
                    <video id="live" className="video-js vjs-default-skin vjs-big-play-centered" controls autoPlay preload="auto" width="100%" height="100%" data-setup='{}'>
                        <source id="source" src={this.state.live_src}  type="application/x-mpegURL"/>
                    </video>
                </div>
            )
        }
    }


    class Live extends React.Component{
        constructor(props) {
            super(props);
            this.state={
                uid:props.uid,
                uname:props.uname,
                cid:props.cid,
                cname:props.cname,
                ctid:props.ctid,
                ctname:props.ctname,
                live_src:"",
            }
        }

        render(){
            return(
                <React.Fragment>
                    <TopDock uname={this.state.uname} cname={this.state.cname} ctname={this.state.ctname}/>
                    <div className="main-root">
                        <VideoLive cid={this.state.cid} cname={this.state.cname} ctname={this.state.ctname} live_src={this.state.live_src}/>
                        <iframe src="../chat/mychat.html" id="mychat"></iframe>
                    </div>
                </React.Fragment>
            );
        }

        componentWillMount(){
            //获取播放源
            var json={cID:this.state.cid};
            $.ajax({
                url:"/user/getsrc",
                type:"post",
                data:json,
                async:false,
                success:(ret)=>{
                    console.log(ret);
                    this.setState({
                        live_src:ret.liveSrc,
                    });
                    console.log(ret.liveSrc,this.state.live_src);
                    console.log(this.state.live_src);

                },
                erro:()=>{
                    alert("Stream address not found.");
                }
            })
        }
    }

    var uid=${uid};
    var uname="${uname}";
    var cid=${cid};
    var cname="${cname}";
    var ctid=${ctid};
    var ctname="${ctname}";

    ReactDOM.render(
        <Live uid={uid}
        uname={uname}
        cid={cid}
        cname={cname}
        ctid={ctid}
        ctname={ctname}/>,
        document.getElementById("root")
    )

    function getUname(){
        return uname;
    }

    function getCTname(){
        return ctname;
    }
</script>
</html>
