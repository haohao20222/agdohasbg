using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Configuration;
namespace Maticsoft.DBUtility
{
    /// <summary>
    /// Copyright (C) 2011 Maticsoft 
    /// 数据访问基础类(基于SQLite)
    /// 可以用户可以修改满足自己项目的需要。
    /// </summary>
    public abstract class DbHelperSQLite
    {
        //数据库连接字符串(web.config来配置)，可以动态更改connectionString支持多数据库.		
        public static string connectionString = PubConstant.ConnectionString;
        public DbHelperSQLite()
        {
        }


        #region 公用方法
       
        
        
        #endregion

        #region  执行简单SQL语句

        



        #endregion

        #region 执行带参数的SQL语句


       

        #endregion

    

    }
}
