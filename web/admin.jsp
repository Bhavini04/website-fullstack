<html>
    <style>
              .logintab{
                  font-size:20px;
                  font-family: berlin sans fb;  
                  color:white; 
                  box-shadow: 12px  10px  15px  black;    
                  
              }
              .fieldtheme{
                  width:250px;
                  height: 30px;
                  font-size:15px;
              }
              .btntheme{
                  width:100px;
                  height: 30px;
                  font-size:15px;
                  background-color:black;
                  color:white;
                  text-transform: uppercase;
                  font-family: berlin sans fb;  
                  align:center;
              }
              
    </style>
    <body>
            
            <form action="Admlogincode.jsp">
            <table  class="logintab"  cellspacing="10px" align="center"  cellpadding='2'>
                <tr>
                    <td>USERNAME</td>
                </tr>
                <tr>
                    <td><input type="text" placeholder="enter username"  class="fieldtheme" name="unm"></td>
                </tr>
                <tr>
                    <td>PASSWORD</td>
                </tr>
                <tr>
                    <td><input type="password" placeholder="enter password"  class="fieldtheme" name="pass"></td>
                </tr>
                
    
                
                <tr align='center'>
                    <td>
<input type="submit"  value="login"  class="btntheme">
                    </td>
                </tr>
            </table>
                </form>
    </body>
</html>
    