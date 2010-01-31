using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Data;

namespace Persistence
{
    public class Db: IDisposable
    {
        SqlConnection con;

        public Db(){}

        public bool Open( string connectionString )
        {
            if (con == null)
            {
                con = new SqlConnection(connectionString);
            }

            if (con.State == ConnectionState.Closed)
            {
                con.Open();
                return true;
            }

            return false;
        }

        public bool Close()
        {
            if (con == null)
            {
                return false;
            }

            if (con.State != ConnectionState.Closed)
            {
                con.Close();
                return true;
            }

            return false;
        }

        public SqlTransaction StartTransaction(IsolationLevel isolationLevel)
        {
            if (con == null || con.State == ConnectionState.Closed) throw new InvalidOperationException();

            return con.BeginTransaction(isolationLevel);
        }


        public void StopTransaction( SqlTransaction trans )
        {
            if (trans == null) return;
            trans.Rollback();
        }


        public void SaveTransaction(SqlTransaction trans)
        {
            if (trans == null) return;
            trans.Commit();
        }


        public void Dispose()
        {
            Close();
        }

        SqlCommand CreateCommand(string sqlStat, SqlParameter[] prams, CommandType cmdType, SqlTransaction transaction )
        {
            if (con.State != ConnectionState.Open) con.Open();

            SqlCommand cmd = new SqlCommand(sqlStat, con);
            cmd.CommandType = cmdType;

            if (transaction != null)
            {
                cmd.Transaction = transaction;
            }

            if (prams != null)
            {
                cmd.Parameters.AddRange(prams);
            }

            cmd.Parameters.Add(new SqlParameter("ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, false, 0, 0, string.Empty, DataRowVersion.Default, null));

            return (cmd);
        }

        SqlCommand CreateCommand(string sqlStat, SqlParameter[] prams, CommandType cmdType)
        {
            return CreateCommand(sqlStat, prams, cmdType, null);
        }

        public int Exec(string sqlStat, SqlParameter[] prams, CommandType cmdType, SqlTransaction trans)
        {
            using (SqlCommand cmd = CreateCommand(sqlStat, prams, cmdType, trans))
            {
                return cmd.ExecuteNonQuery();
            }
            
        }

        public int Exec(string sqlStat, SqlParameter[] prams, CommandType cmdType)
        {
            return Exec(sqlStat, prams, cmdType, null);
        }

        public int ExecProc(string procName, SqlParameter[] prams, SqlTransaction trans)
        {

            using (SqlCommand cmd = CreateCommand(procName, prams, CommandType.StoredProcedure, trans))
            {
                cmd.ExecuteNonQuery();
                return (int)cmd.Parameters["ReturnValue"].Value;
            }
        }

        public int ExecProc(string procName, SqlParameter[] prams)
        {
          return ExecProc( procName, prams, null );
        }

        public int ExecProc(string procName, SqlTransaction trans)
        {
            return (ExecProc(procName, (SqlParameter[])null, trans));
        }

        public int ExecProc(string procName)
        {
            return ExecProc( procName, (SqlTransaction)null );
        }

        public void ExecProc(string procName, out SqlDataReader dataReader, SqlTransaction trans)
        {
            using (SqlCommand cmd = CreateCommand(procName, null, CommandType.StoredProcedure, trans))
            {
                dataReader = cmd.ExecuteReader();
            }
        }

        public void ExecProc(string procName, out SqlDataReader dataReader)
        {
            ExecProc(procName, out dataReader, null );
        }

        public void ExecProc(string procName, SqlParameter[] prams, out SqlDataReader dataReader, SqlTransaction trans)
        {
            using (SqlCommand cmd = CreateCommand(procName, prams, CommandType.StoredProcedure, trans))
            {
                dataReader = cmd.ExecuteReader();
            }
        }

        public void ExecProc(string procName, SqlParameter[] prams, out SqlDataReader dataReader)
        {
            ExecProc(procName, prams, out dataReader, null);
        }

        public void RecordSet(string sqlStat, out SqlDataReader dataReader)
        {
            RecordSet(sqlStat, null, out dataReader);
        }

        public void RecordSet(string sqlStat, SqlParameter[] prams, out SqlDataReader dataReader)
        {
            using (SqlCommand cmd = CreateCommand(sqlStat, prams, CommandType.Text))
            {
                dataReader = cmd.ExecuteReader( );
            }
        }

        SqlParameter MakeParam(string ParamName, SqlDbType DbType, Int32 Size, ParameterDirection Direction, object Value)
        {
            SqlParameter param;

            if (Size > 0)
                param = new SqlParameter(ParamName, DbType, Size);
            else
                param = new SqlParameter(ParamName, DbType);

            if (Direction == ParameterDirection.Output && Value != null)
            {
                Direction = ParameterDirection.InputOutput;
            }
            param.Direction = Direction;

            if (Value != null)
                param.Value = Value;

            return param;
        }

        public SqlParameter MakeInParam(string ParamName, SqlDbType DbType, int Size, object Value)
        {
            return MakeParam(ParamName, DbType, Size, ParameterDirection.Input, Value);
        }

        public SqlParameter MakeOutParam(string ParamName, SqlDbType DbType, int Size)
        {
            return MakeParam(ParamName, DbType, Size, ParameterDirection.Output, null);
        }
    }
}
