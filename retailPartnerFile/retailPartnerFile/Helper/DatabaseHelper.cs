﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Xml;

namespace retailPartnerFile.Helper
{
    public static class DatabaseHelper
    {
        static AppSettingsReader reader = new AppSettingsReader();


        static string connectionString = reader.GetValue("databaseConnectionString", typeof(string)).ToString();

        static DbConnection GetDatabaseConnection()
        {
            SqlConnection connection = new SqlConnection();
            try
            {
                connection.ConnectionString = connectionString;
                if (connection.State != ConnectionState.Open)
                {
                    connection.Open();
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (connection.State == ConnectionState.Closed)
                {
                    throw new Exception("Database connection is closed.");
                }
            }

            return connection;
        }

        public static IDataReader ExecuteReader(List<KeyValuePair<string, object>> parameters, string procedure)
        {
            IDataReader reader = null;
            IDbCommand command = null;
            try
            {
                using (command = new SqlCommand(procedure, (SqlConnection)GetDatabaseConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    foreach (var p in parameters)
                    {
                        SqlParameter param = new SqlParameter();
                        param.ParameterName = p.Key;
                        param.Value = p.Value;
                        param.SqlDbType = TypeToSqlDbType(p.Value.GetType());
                        command.Parameters.Add(param);
                    }
                    reader = command.ExecuteReader();
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                command.Dispose();
            }

            return reader;
        }

        public static object ExecuteNonQuery(List<KeyValuePair<string, object>> parameters, string procedure, Nullable<KeyValuePair<string, object>> outputParameter)
        {
            IDbCommand command = null;
            object result = null;

            try
            {

                using (command = new SqlCommand(procedure, (SqlConnection)GetDatabaseConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    foreach (var p in parameters)
                    {
                        SqlParameter param = new SqlParameter();
                        param.ParameterName = p.Key;
                        param.Value = p.Value;
                        param.SqlDbType = TypeToSqlDbType(p.Value.GetType());
                        command.Parameters.Add(param);
                    }


                    SqlParameter outputParam = new SqlParameter();
                    if (outputParameter.HasValue)
                    {
                        outputParam.ParameterName = outputParameter.Value.Key;
                        outputParam.Value = outputParameter.Value.Value;
                        outputParam.SqlDbType = TypeToSqlDbType(outputParameter.Value.Value.GetType());
                        outputParam.Direction = ParameterDirection.Output;
                        command.Parameters.Add(outputParam);
                    }

                    result = command.ExecuteNonQuery();

                    if (outputParam.Value != DBNull.Value)
                    {
                        result = outputParam.Value;
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                command.Dispose();
            }

            return result;
        }

        public static object ExecuteScalar(List<KeyValuePair<string, object>> parameters, string procedure, Nullable<KeyValuePair<string, object>> outputParameter)
        {
            IDbCommand command = null;
            object result = null;

            try
            {

                using (command = new SqlCommand(procedure, (SqlConnection)GetDatabaseConnection()))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    foreach (var p in parameters)
                    {
                        SqlParameter param = new SqlParameter();
                        param.ParameterName = p.Key;
                        param.Value = p.Value;
                        param.SqlDbType = TypeToSqlDbType(p.Value.GetType());
                        command.Parameters.Add(param);
                    }

                    SqlParameter outputParam = new SqlParameter();
                    if (outputParameter.HasValue)
                    {
                        outputParam.ParameterName = outputParameter.Value.Key;
                        outputParam.Value = outputParameter.Value.Value;
                        outputParam.SqlDbType = TypeToSqlDbType(outputParameter.Value.Value.GetType());
                        outputParam.Direction = ParameterDirection.Output;
                        command.Parameters.Add(outputParam);
                    }

                    result = command.ExecuteScalar();

                    if (outputParam.Value != DBNull.Value)
                    {
                        result = outputParam.Value;
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                command.Dispose();
            }

            return result;
        }

        internal static DataTable ExecutarDataTable(string query, Dictionary<string, string> parametros)
        {
            return new DataTable();
        }

        private static SqlDbType TypeToSqlDbType(Type t)
        {
            String name = t.Name;
            SqlDbType result = SqlDbType.VarChar; // default value
            try
            {
                if (name.Contains("16") || name.Contains("32") || name.Contains("64"))
                {
                    name = name.Substring(0, name.Length - 2);
                }
                result = (SqlDbType)Enum.Parse(typeof(SqlDbType), name, true);
            }
            catch (Exception)
            {
                // add error handling to suit your taste
            }

            return result;
        }

        public static XmlDocument ExecutarXmlReader(string query, string templateXsl)
        {
            return new XmlDocument();
        }

        internal static int ExecutarNonQuery(string query, Dictionary<string, string> parametros)
        {
            throw new NotImplementedException();
        }

        internal static DataTable ExecutarDataTable(string query)
        {
            throw new NotImplementedException();
        }
    }
}
