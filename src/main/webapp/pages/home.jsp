<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <META http-equiv=Content-Type content="text/html;charset=utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="icon" href="/icon/home-outline.svg"/>
    <script src="https://cdn.staticfile.org/react/16.4.0/umd/react.development.js"></script>
    <script src="https://cdn.staticfile.org/react-dom/16.4.0/umd/react-dom.development.js"></script>
    <script src="https://cdn.staticfile.org/babel-standalone/6.26.0/babel.min.js"></script>
    <script src="https://cdn.staticfile.org/jquery/2.1.4/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/style.css"  type="text/css"></link>
  </head>
<body>
  <div id="root">
  </div>
</body>

<script type="text/babel">
// 显示用户头像和用户名
class UserDock extends React.Component{
        constructor(props){
          super(props);
          this.state={
            name:props.name,
            img:"",//头像
          }
        }

        render(){
          return(
            <React.Fragment>
            <div className="appname">CoursePro</div>
            <div className="userzone">
                <img className="portrait" src="../icon/logo-github.svg"/>
                <span className="nickname">{this.state.name}</span>
            </div>
            </React.Fragment>
          );
        }
      }


/*===========================================================*/      
//课程显示部分
class CoursePage extends React.Component{
    constructor(props){
    super(props);
        this.state={
            id:props.id,//学生id
            name:props.name,
        }
    }

    render(){
        return(
            <div className="course-page">
                <UserCourse id={this.state.id} name={this.state.name}/>
                <Search id={this.state.id}/>
            </div>
        );
    }
}

//已选课程
class UserCourse extends React.Component{
    constructor(props){
        super(props);
        this.state={
            id:props.id,
            name:props.name,
            courses:[],//课程数组，存放信息
            type:true,//true代表一般界面，false代表删除
        }
    }

    render(){
        var btn;
        if(this.state.type) btn=<img src="../icon/trash-outline.svg" className="cbtn-switch" title="删除课程" onClick={this.handleTypeChange}/>;
        else btn=<img src="../icon/return-down-back-outline.svg" className="cbtn-switch" title="返回" onClick={this.handleTypeChange}/>
        return(
            <div className="user-course">
                <div className="title"><h4>已选课程列表</h4></div>
                <div className="container">
                    <div className="course-list">
                        {this.getList()}
                        {this.state.courses.map((el,index)=>{
                                return (
                                <CourseItem key={index} uid={this.state.id} uname={this.state.name} cid={el.cID} cname={el.cName} info={el.cInfo} tid={el.ctID} tname={el.ctName} type={this.state.type}/>
                            )
                        })}
                    </div>
                    <div className="cbtn-switch-zone">
                        <img src="../icon/reload-outline.svg" className="cbtn-switch" title="更新" onClick={this.handleUpdate}/>
                        {btn}
                    </div>
                </div>

            </div>
        );
    }

    getList(){
        if(this.state.courses.length<1){
            return  <span><p>这里居然空空如空空如也QAQ...</p></span>;
        }
    }

    componentDidMount(){
        //ajax获取课程表数据，将数据存入courses, work
        $.ajax({
            url:"/student/gcl2",
            type:"post",
            data:{userID:this.state.id},
            async:false,
            success:(data)=>{
                let courses=[];
                for(let key in data){
                    courses.push(data[key]);
                }
                this.setState({
                    courses:courses,
                });
            }
        })
    }

    handleUpdate=()=>{
        $.ajax({
            url:"/student/gcl2",
            type:"post",
            data:{userID:this.state.id},
            async:false,
            success:(data)=>{
                let courses=[];
                for(let key in data){
                    courses.push(data[key]);
                }
                this.setState({
                    courses:courses,
                });
            }
        });
    }

    handleTypeChange=()=>{
        var type=!this.state.type;
        this.setState({
            type:type,
        });
    }

}

//课程的显示模块
class CourseItem extends React.Component{
    constructor(props){
        super(props);
        this.state={
            uid:props.uid,
            uname:props.uname,
            cid:props.cid,
            cname:props.cname,
            tname:props.tname,
            tid:props.tid,
            info:props.info,
            type:props.type,//判断类别，是已加入还是待加入
        }
    }

    render(){
        var elem,tit;
        if(this.props.type==false)
            elem=<img src="../icon/close-circle-outline.svg" className="icon" onClick={this.deleteCourse} title="退出课程"/>
        tit= "info: "+this.state.info;
        return(
            <div className="cbtn" title={tit} onClick={this.handleClick} onDoubleClick={this.handleDbClick}>
                <div className="course-info">
                    <h4>{this.state.cname}</h4>
                    <p>{this.state.tname}</p>
                </div>
                <div className="cbtn-func">
                    {elem}
                </div>
            </div>
        );
    }

    handleDbClick=()=>{
        var json={
            uid:this.state.uid,
            uname:this.state.uname,
            cid:this.state.cid,
            cname:this.state.cname,
            ctid:this.state.tid,
            ctname:this.state.tname,
        }
        //双击进入直播间上课
        $.ajax({
            url:"/user/enterc",
            type:"post",
            data:json,
            async:false,
            success:()=>{
                window.open("live.jsp");
            },
        });
    }


    handleClick=()=>{
        //可能做成信息展示
    }

    deleteCourse=()=>{
        let json={
            uID:this.state.uid,
            cID:this.state.cid,
        };
        console.log(json.cID,json.uID);
        //ajax,完成删除操作，操作u_c表
        $.ajax({
            url:"/student/delc",
            data:json,
            type:"post",
            async:false,
            success:(ret)=>{}
        })
    }
}

//搜索课程的显示模块
class SCourseItem extends React.Component{
    constructor(props){
        super(props);
        this.state={
            uid:props.uid,
            cid:props.cid,
            cname:props.cname,
            tname:props.tname,
            tid:props.tid,
            time:props.time,
        }
    }

    render(){
        var tit;
        tit= "info: "+this.state.info;
        return(
            <div className="cbtn" title={tit} onClick={this.handleClick} >
                <div className="course-info">
                    <h4>{this.state.cname}</h4>
                    <p>{this.state.tname}</p>
                </div>
                <div className="cbtn-func">
                    <img src="../icon/add-circle-outline.svg" className="icon" onClick={this.addCourse} title="加入课程"/>
                </div>
            </div>
        );
    }


    addCourse=()=>{
        let json={
            uID:this.state.uid,
            cID:this.state.cid,
        };
        //ajax，完成加入操作，操作u_c表
        console.log("json:");
        console.log(this.state.uid);
        console.log(json.uID,json.cID);
        $.ajax({
            url:"/student/addc",
            data:json,
            type:"post",
            async:false,
            success:(ret)=>{}
        })
    }
}


class Search extends React.Component{
    constructor(props){
        super(props);
        this.state={
             id:props.id,
             key:"",//搜索关键词
             courses:[],//搜索结果
        };
    }

    render(){
        return(
            <div className="search-zone">
                <div className="search-bar">
                    <input type="text" value={this.state.key} onChange={this.handleChange} placeholder="输入搜索课程"/>
                    {/*<button onClick={this.doSearch}><i className="icon ion-search"></i></button>-->*/}
                    <img className="icon" src="../icon/search.svg" onClick={this.doSearch} title="搜索课程"/>
                </div>
                <div className="result-bar">
                    {this.state.courses.map((el,index)=>{
                        return (
                            <SCourseItem key={index+el.ctID} uid={this.state.id} cid={el.cID} cname={el.cName} time={el.cDate} tid={el.ctID} tname={el.ctName}/>
                        );
                    })}
                </div>
            </div>
        );
    }

    handleChange=(event)=>{
        this.setState({key:event.target.value});
    }

    doSearch=()=>{
        this.setState({courses:[]});
        var json={keyword:this.state.key};
        //ajax查询结果，返回结果存储到courses, didn't work yet
        $.ajax({
            url:"/student/search",
            type:"post",
            data:json,
            async:false,
            success:(ret)=>{
                console.log(ret);
                var courses=[];
                for(let idx in ret){
                    courses.push(ret[idx]);
                }

                this.setState({
                    courses:courses,
                });
            },
            erro:()=>{

            }
        })
    }
}


/*===========================================================*/
//用户信息部分
class UserPage extends React.Component{
    constructor(props){
      super(props);
      this.state={
        id:props.id,
        name:props.name,
        info:props.info,
        side:0,//0:显示信息；1：修改信息；2：修改密码
      }
    }

    render(){
      var elem;
      switch(this.state.side){
        case 1:elem=<EditInfo id={this.state.id} name={this.state.name} info={this.state.info} />;break;
        case 2:elem=<ChangePwd id={this.state.id} />;break;
        default:elem=<DispInfo id={this.state.id} name={this.state.name} info={this.state.info} />
      }
      return(
        <div className="user-page">
          <div className="user-menue">
              <img src="../icon/person-circle-outline.svg" className="menue-icon" title="个人信息" onClick={this.handleShowClick}/>
              <img src="../icon/create-outline.svg" className="menue-icon" title="修改个人信息" onClick={this.hanldeEditClick}/>
              <img src="../icon/key-outline.svg" className="menue-icon" title="修改密码" onClick={this.handlePwdClick}/>
          </div>
          <div className="funcside">
            {elem}
          </div>
        </div>
      );
    }

    componentDidMount(){
      //ajax获取信息？不用吧，由主页传参数过来
    }

    handleShowClick=()=>{
      this.setState({side:0});
    }
    hanldeEditClick=()=>{
      this.setState({side:1});
    }
    handlePwdClick=()=>{
      this.setState({side:2});
    }

  }

  // 显示信息页
  class DispInfo extends React.Component{
    constructor(props){
      super(props);
      this.state={
        id:props.id,
        name:props.name,
        info:props.info,
      }
    }
    render(){
      return(
          <React.Fragment>
              <img className="head" src="../icon/logo-github.svg"/>
              <h3>{this.state.name}</h3>
              <h5>{this.state.id}</h5>
              <p>{this.state.info}</p>
          </React.Fragment>
      );
    }

  }

  class EditInfo extends React.Component{
    constructor(props){
      super(props);
      // 修改name、info
      this.state={
        id:props.id,
        name:props.name,
        info:props.info,
      }
    }

    render(){
      return(
        <div className="ed-info">
            <div className="title"><h4>修改个人信息</h4></div>
            <span>
                <span>昵称:</span><br/>
                <input type="text" value={this.state.name} onChange={this.handleNameChange}/>
            </span>
            <span>
                <span>个人说明:</span><br/><br/>
                <textarea className="uinfo" rows="7" contentEditable="true" onChange={this.handleInfoChange} value={this.state.info} onChangeCapture={this.handleInfoChange}></textarea>
            </span>
        <button className="sub-btn" onClick={this.submit}>确认修改</button>
      </div>
      );
      
    }

    handleNameChange=(event)=>{
      this.setState({name:event.target.value});
    }
    handleInfoChange=(event)=>{
      this.setState({info:event.target.value});
    }

    //提交修改
    submit=()=>{
        var info=$("#uinfo").innerText;
      //更新用户信息
        var json={
            userID:this.state.id,
            userName:this.state.name,
            userInfo:this.state.info,
        };
        $.ajax({
            url:"/user/chinfo",
            type:"post",
            data:JSON.stringify(json),
            contentType:"application/json;character=utf-8",
            async:false,
            success:()=>{
            },
            erro:{},
        });
    }
  }

  class ChangePwd extends React.Component{
    constructor(props){
      super(props);
      //修改密码
      this.state={
        id:props.id,
        opwd:"",//老密码
        npwd:"",//新密码
        ncpwd:"",//确认密码
        legal:false,//为true表示确认密码与新密码相同
      }
    }

    render(){
      return(
        <div className="ed-pwd">
            <h4>修改账户密码</h4>
            <span>
            <span>请输入原密码</span>
            <input type="text" value={this.state.opwd} onChange={this.handleOldChange}/>
            </span>
            <span>
            <span>请输入新密码</span>
            <input type="text" value={this.state.npwd} onChange={this.handleNewChange}/>
            </span>
            <span>
            <span>请再次输入新密码</span>
            <input type="text" value={this.state.ncpwd} onChange={this.handleConChange}/>
            </span>
            <button className="sub-btn" onClick={this.submit}>确认修改</button>
        </div>
      );
    }

    handleOldChange=(event)=>{
      this.setState({
        opwd:event.target.value,
      });
    };

    handleNewChange=(event)=>{
      this.setState({
        npwd:event.target.value,
      })
    };

    handleConChange=(event)=>{
      this.setState({
        ncpwd:event.target.value,
      });
      if(this.state.npwd==this.state.ncpwd)
        this.setState({
          legal:true,
        });
    };

    submit=()=>{
      if(!this.state.legal)
      {
        alert("确认密码与新密码不同，请检查！");
        return;
      }
      var json={
          id:this.state.id,
          opwd:this.state.opwd,
          npwd:this.state.npwd,
      }
      //ajax,提交数据
      $.ajax({
          url:"/user/chpwd",
          data:json,
          async:true,
          type:"post",
      })
    }

  }


/*======================================================*/
//开设课程
  class TCoursePage extends React.Component{
    constructor(props){
      super(props);
      this.state={
        id:props.id,//作为老师的id
        name:props.name,
      }
    }

    render(){
      return(
        <div className="tcourse-page">
            <TCourse id={this.state.id} name={this.state.name}/>
        </div>
      );
    }
  }

  class TCourse extends React.Component{
    constructor(props){
      super(props);
      this.state={
        id:props.id,
        name:props.name,
        courses:[],//存放课程
        type:true,//true代表进入，false代表删除
      }
    }

    render(){
        var btn;
        if(this.state.type==true) btn=<img className="cbtn-switch" src="../icon/trash-outline.svg" onClick={this.handleTypeChange}/>;
        else btn=<img className="cbtn-switch" src="../icon/return-down-back-outline.svg" onClick={this.handleTypeChange}/>
      return(
        <React.Fragment>
          <div className="my-lecture">
              <div className="title"><h4>我开设的课程</h4></div>
              <div className="container">
                  <div className="course-list">
                      {this.state.courses.map((el,index)=>{
                          return(
                              <TCourseItem key={index} id={this.state.id} name={this.state.name} cid={el.cID} cname={el.cName} time={el.cDate} type={this.state.type}/>
                          )
                      })}
                  </div>
                  <div className="cbtn-switch-zone">{btn}</div>
              </div>
          </div>
          <NewCourse id={this.state.id} name={this.state.name}/>
        </React.Fragment>
      );
    }

    componentDidMount(){
        var json={ctID:this.state.id};
      //ajax获取课程数据，存到courses
      $.ajax({
          url:"/teacher/gcl",
          type:"post",
          async:false,
          data:json,
          success:(ret)=>{
              var courses=[];
              for (let key in ret) {
                  courses.push(ret[key]);
              }
              this.setState({
                  courses:courses,
              })
          },
          erro:()=>{
              alert("request failed")

          }
      })
    }

    handleTypeChange=()=>{
        var type=!this.state.type;
        this.setState({
            type:type,
        });
    }

    handleNewClick=()=>{
      //改变样式
    }

  }

  class TCourseItem extends React.Component{
    constructor(props){
        super(props);
        this.state={
            id:props.id,
            name:props.name,
            cid:props.cid,
            cname:props.cname,
            info:props.info,
            type:props.type,//true代表进入课堂，false代表删除课堂
        }
    }

    render(){
        var btn;
        if(this.props.type) btn=<img className="icon" src="../icon/log-in-outline.svg" onClick={this.beginClass}/>
        else btn=<img className="icon" src="../icon/backspace-outline.svg" onClick={this.deleteCourse}/>
        return(
            <div className="cbtn">
                <div className="cbtn-info">
                    <h5>{this.state.cname}</h5>
                    <p>{this.state.cid}</p>
                    <p>{this.state.time}</p>
                </div>
                <div className="cbtn-func">
                    {btn}
                </div>
            </div>
        );
    }

    deleteCourse=()=>{
        var json={cID:this.state.cid};
        console.log(json.cID);
        //ajax,完成删除操作，操作u_c表
        $.ajax({
            url:"/teacher/delc",
            type:"post",
            async:false,
            data:{cID:this.state.cid},
            success:()=>{},
            erro:()=>{},
        })
    }

    beginClass=()=>{
        //可alert提示输入数字口令，作为直播的推流地址，默认为课程id，采用默认就不需要alert了，数据库也无需修改。
        //该口令将被推送到服务器数据库，学生点击上课时将查询数据库进入直播间
        //生成直播间链接
        alert("开始直播前，请向预定的服务器推流哟 \ ^_^ /");
        var json={
            uid:this.state.id,
            uname:this.state.name,
            cid:this.state.cid,
            cname:this.state.cname,
            ctid:this.state.id,
            ctname:this.state.name,
        }
        //双击进入直播间上课
        $.ajax({
            url:"/user/enterc",
            type:"post",
            data:json,
            async:false,
            success:()=>{
                window.open("live.jsp");
            },
        });
    }
  }

  //以侧边栏形式
  class NewCourse extends React.Component{
    constructor(props){
      super(props);
      this.state={
        id:props.id,
        tname:props.name,
        cname:"",
        cid:"",//输入的整型数据
        info:"",
        disp:props.disp,//控制是否显示
      }
    }

    render(){
      return(
        <div className="new-course" style={{display:this.state.disp?"none":"flex"}}>
            <div className="title"><h4>创建课程</h4></div>
            <span>课程名:</span><input value={this.state.cname} onChange={this.handleNameChange}/>
            <span>课程号:</span><input value={this.state.cid} onChange={this.handleIdChange}/>
            <span>课程说明:</span><input value={this.state.info} onChange={this.handleInfoChange}/>
            <button className="sub-btn" onClick={this.CreateCourse}>创建课程</button>
        </div>
      );
    }

    componentWillReceiveProps(nextProps) {
      if (this.state.disp !== nextProps.disp) {
        this.setState({
          disp: newdata.disp,
        })
    }
  }

    handleNameChange=(event)=>{
      this.setState({
        cname:event.target.value,
      })
    }

    handleIdChange=(event)=>{
      this.setState({
        cid:event.target.value,
      })
    }

    handleInfoChange=(event)=>{
      this.setState({
        info:event.target.value,
      })
    }

    CreateCourse=()=>{
        let json={
            ctID:this.state.id,
            cName:this.state.cname,
            cInfo:this.state.info,
            cID:this.state.cid,
            ctName:this.state.tname,
        };
      //Ajax，上传：老师id，课程id，课程名，时间，信息。后端对u-c、course表进行操作，
        $.ajax({
            url:"/teacher/addc",
            type:"post",
            data:json,
            async:false,
        })
    }
    // componentWillRe
  }

  /*=====================================*/
  //主页面
  class Home extends React.Component{
    constructor(props){
      super(props);
      this.state={
        id:props.id,
        name:"",
        info:"",
      }
    }

    render(){
      return(
        <React.Fragment>
          <div className="top-dock">
            <UserDock id={this.state.id} name={this.state.name}/>
            <img src="../icon/settings-outline.svg" id="side-btn" onClick={this.onSideClick}/>
          </div>
          <div className="main-root">
            <div className="maintain">
              <CoursePage id={this.state.id} name={this.state.name}/>
              <UserPage id={this.state.id} name={this.state.name} info={this.state.info}/>
              <TCoursePage id={this.state.id} name={this.state.name}/>
            </div>
            <div className="sidebar_off">
                <div className="side-menue">
                    <img src="../icon/person-circle-outline.svg" className="side-btn" onClick={this.uClick}/>
                    <img src="../icon/home-outline.svg" className="side-btn" onClick={this.cClick}/>
                    <img src="../icon/document-attach-outline.svg" className="side-btn" onClick={this.tClick}/>
                </div>
            </div>
          </div>
        </React.Fragment>
      );
    }

    onSideClick=()=>{
      $(".sidebar_off").toggleClass("sidebar_on");
    }

    uClick=()=>{
      $(".user-page").css("display","flex");
      $(".course-page").css("display","none");
      $(".tcourse-page").css("display","none");
    }

    cClick=()=>{
      $(".user-page").css("display","none");
      $(".course-page").css("display","flex");
      $(".tcourse-page").css("display","none");
    }

    tClick=()=>{
      $(".user-page").css("display","none");
      $(".course-page").css("display","none");
      $(".tcourse-page").css("display","flex");
    }

    componentWillMount(){
        $.ajax({
            url:"/user/guinfo",
            type:"post",
            data:{userID:this.state.id},
            async:false,
            success:(ret)=>{
                console.log(ret.userName,ret.userInfo);
                this.setState({
                    name:ret.userName,
                    info:ret.userInfo
                });
                console.log(this.state.name);
            }
        });
    }
    componentDidMount(){
      $(".user-page").css("display","none");
      $(".course-page").css("display","flex");
      $(".tcourse-page").css("display","none");
    }

  }

  <%--var login=<div><h5>您未登录，请先<a href='./login.jsp'>登录</a>！</h5></div>;--%>
  <%--if(${userID})--%>
  <%--    alert(login);--%>
  // else {
    console.log(${userID});
      ReactDOM.render(
          <Home id={${userID}}/>,
          document.getElementById("root")
      );
  // }
</script>