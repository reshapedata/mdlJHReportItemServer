

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
  text_date_TestRecord = tsui::var_date('text_date_TestRecord')
  #处理COA报告
  #处理相关数据
  shiny::observeEvent(input$btn_coa_gen_sal,{
    info_coa = mdlJHReportItemr::coa_SyncAll(erpToken = erp_token,outputDir = outputDir,delete_localFiles = 1)
    if(info_coa){
      tsui::pop_notice(paste0("COA报告更新成功,更新",info_coa,"条记录"))
    }else{
      tsui::pop_notice(paste0("COA报告更新失败,没有待更新的数据或COA模板为空"))
    }

  })



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



  shiny::observeEvent(input$btn_coa_genByDate,{
    FDate = text_date_TestRecord()
    data = mdlJHReportItemPkg::COA_selectByDate(erp_token = erp_token,FDate = FDate)

    tsui::run_dataTable2(id ='TestRecord_resultView' ,data =data )

    tsui::run_download_xlsx(id = 'dl_TestRecordByDate',data = data,filename = 'COA按日期查询数据.xlsx')


  })
  shiny::observeEvent(input$btn_coa_genByMonth,{
    FDate = text_date_TestRecord()

    data = mdlJHReportItemPkg::COA_selectByMonth(erp_token = erp_token,FDate = FDate)

    tsui::run_dataTable2(id ='TestRecord_resultView' ,data =data )

    tsui::run_download_xlsx(id = 'dl_TestRecordByMonth',data = data,filename = 'COA按月查询数据.xlsx')



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









