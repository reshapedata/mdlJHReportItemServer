

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
#' TemplateListViewServer()
TemplateListViewServer <- function(input,output,session,dms_token,erp_token) {
  text_flie_TemplateList = tsui::var_file('text_flie_TemplateList')


  shiny::observeEvent(input$btn_TemplateList_Up,{
    if(is.null(text_flie_TemplateList())){

      tsui::pop_notice('请先上传文件')
    }
    else{
      filename=text_flie_TemplateList()
      data <- readxl::read_excel(filename,
                                 col_types = c("text", "text", "numeric"))


      data = as.data.frame(data)

      data = tsdo::na_standard(data)


      tsda::db_writeTable2(token  = erp_token,table_name = 'rds_t_TemplateList_input',r_object = data,append = TRUE)

      mdlJHReportItemPkg::TemplateList_inputdelete(erp_token = erp_token)
      mdlJHReportItemPkg::TemplateList_insert(erp_token = erp_token)
      mdlJHReportItemPkg::TemplateList_truncate(erp_token = erp_token)


      tsui::pop_notice('上传成功')



    }

  })

  shiny::observeEvent(input$btn_TemplateList_select,{



    data = mdlJHReportItemPkg::TemplateList_select(erp_token  = erp_token)

    tsui::run_dataTable2(id ='TemplateList_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_TemplateList',data = data,filename = '模板清单.xlsx')



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
#' TemplateListServer()
TemplateListServer <- function(input,output,session,dms_token,erp_token) {

  TemplateListViewServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
}









