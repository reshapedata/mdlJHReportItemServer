

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
#' ProductQualityViewServer()
ProductQualityViewServer <- function(input,output,session,dms_token,erp_token) {
  text_flie_ProductQuality = tsui::var_file('text_flie_ProductQuality')


  shiny::observeEvent(input$btn_ProductQuality_Up,{
    if(is.null(text_flie_ProductQuality())){

      tsui::pop_notice('请先上传文件')
    }
    else{
      filename=text_flie_ProductQuality()
      data <- readxl::read_excel(filename, col_types = c("text", "text", "text",
                                                           "text", "text", "text", "text", "text",
                                                           "text", "text", "text", "text", "text",
                                                           "text", "text", "text"))


      data = as.data.frame(data)

      data = tsdo::na_standard(data)


      tsda::db_writeTable2(token  = erp_token,table_name = 'rds_t_ProductQuality_input',r_object = data,append = TRUE)

      mdlJHReportItemPkg::ProductQuality_inputdelete(erp_token = erp_token)
      mdlJHReportItemPkg::ProductQuality_insert(erp_token = erp_token)
      mdlJHReportItemPkg::ProductQuality_truncate(erp_token = erp_token)


      tsui::pop_notice('上传成功')



    }

  })

  shiny::observeEvent(input$btn_ProductQuality_select,{



    data = mdlJHReportItemPkg::ProductQuality_select(erp_token  = erp_token)

    tsui::run_dataTable2(id ='ProductQuality_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_ProductQuality',data = data,filename = '产品质量基础表.xlsx')



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
#' ProductQualityServer()
ProductQualityServer <- function(input,output,session,dms_token,erp_token) {

  ProductQualityViewServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
}









