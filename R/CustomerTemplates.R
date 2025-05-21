

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
#' CustomerTemplatesViewServer()
CustomerTemplatesViewServer <- function(input,output,session,dms_token,erp_token) {
  text_flie_CustomerTemplates = tsui::var_file('text_flie_CustomerTemplates')


  shiny::observeEvent(input$btn_CustomerTemplates_Up,{
    if(is.null(text_flie_CustomerTemplates())){

      tsui::pop_notice('请先上传文件')
    }
    else{
      filename=text_flie_CustomerTemplates()
      data <- readxl::read_excel(filename,
                                 col_types =c("text", "text", "text",
                                              "text", "text", "text", "text", "text"))


      data = as.data.frame(data)

      data = tsdo::na_standard(data)


      tsda::db_writeTable2(token  = erp_token,table_name = 'rds_t_CustomerTemplates_input',r_object = data,append = TRUE)

      mdlJHReportItemPkg::CustomerTemplates_inputdelete(erp_token = erp_token)

      mdlJHReportItemPkg::CustomerTemplates_delete(erp_token = erp_token)
      mdlJHReportItemPkg::CustomerTemplates_insert(erp_token = erp_token)
      mdlJHReportItemPkg::CustomerTemplates_truncate(erp_token = erp_token)


      tsui::pop_notice('上传成功')



    }

  })

  shiny::observeEvent(input$btn_CustomerTemplates_select,{



    data = mdlJHReportItemPkg::CustomerTemplates_select(erp_token  = erp_token)

    tsui::run_dataTable2(id ='CustomerTemplates_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_CustomerTemplates',data = data,filename = '客户对应模板表.xlsx')



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
#' CustomerTemplatesServer()
CustomerTemplatesServer <- function(input,output,session,dms_token,erp_token) {

  CustomerTemplatesViewServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
}









