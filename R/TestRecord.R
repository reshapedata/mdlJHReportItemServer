

#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' TestRecordViewServer()
TestRecordViewServer <- function(input,output,session,dms_token,erp_token) {
  text_flie_TestRecord = tsui::var_file('text_flie_TestRecord')


  shiny::observeEvent(input$btn_TestRecord_Up,{
    if(is.null(text_flie_TestRecord())){

      tsui::pop_notice('请先上传文件')
    }
    else{
      filename=text_flie_TestRecord()
      data <- readxl::read_excel(filename,
                                 col_types = c("text", "text", "text",
                                               "text", "text", "text", "text",
                                               "text", "text", "text",
                                               "text", "text", "text", "text",
                                               "text", "text", "text", "text",
                                               "text", "text", "text"))


      data = as.data.frame(data)

      data = tsdo::na_standard(data)


      tsda::db_writeTable2(token  = erp_token,table_name = 'rds_t_TestRecord_input',r_object = data,append = TRUE)

      mdlJHReportItemPkg::TestRecord_inputdelete(erp_token = erp_token)

      mdlJHReportItemPkg::TestRecord_delete(erp_token = erp_token)
      mdlJHReportItemPkg::TestRecord_insert(erp_token = erp_token)
      mdlJHReportItemPkg::TestRecord_truncate(erp_token = erp_token)


      tsui::pop_notice('上传成功')



    }

  })

  shiny::observeEvent(input$btn_TestRecord_select,{



    data = mdlJHReportItemPkg::TestRecord_select(erp_token  = erp_token)

    tsui::run_dataTable2(id ='TestRecord_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_TestRecord',data = data,filename = '检测记录.xlsx')



  })
  shiny::observeEvent(input$btn_RPAtask_select,{


    data = mdlJHReportItemPkg::RPAtask_select(erp_token =erp_token )

    tsui::run_dataTable2(id ='TestRecord_resultView' ,data =data )


  })





}



#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param erp_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' TestRecordServer()
TestRecordServer <- function(input,output,session,dms_token,erp_token) {

  TestRecordViewServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
}









