

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
#' CustomerMaterialCorrespondenceViewServer()
CustomerMaterialCorrespondenceViewServer <- function(input,output,session,dms_token,erp_token) {
  text_flie_CustomerMaterialCorrespondence = tsui::var_file('text_flie_CustomerMaterialCorrespondence')


  shiny::observeEvent(input$btn_CustomerMaterialCorrespondence_Up,{
    if(is.null(text_flie_CustomerMaterialCorrespondence())){

      tsui::pop_notice('请先上传文件')
    }
    else{
      filename=text_flie_CustomerMaterialCorrespondence()
      data <- readxl::read_excel(filename, col_types = c("text", "text", "text",
                                                         "text", "text", "text", "text", "text",
                                                         "text", "text", "text", "text",
                                                         "text"))


      data = as.data.frame(data)

      data = tsdo::na_standard(data)


      tsda::db_writeTable2(token  = erp_token,table_name = 'rds_t_CustomerMaterialCorrespondence_input',r_object = data,append = TRUE)

      mdlJHReportItemPkg::CustomerMaterialCorrespondence_inputdelete(erp_token = erp_token)
      mdlJHReportItemPkg::CustomerMaterialCorrespondence_insert(erp_token = erp_token)
      mdlJHReportItemPkg::CustomerMaterialCorrespondence_truncate(erp_token = erp_token)


      tsui::pop_notice('上传成功')



    }

  })

  shiny::observeEvent(input$btn_CustomerMaterialCorrespondence_select,{



    data = mdlJHReportItemPkg::CustomerMaterialCorrespondence_select(erp_token  = erp_token)

    tsui::run_dataTable2(id ='CustomerMaterialCorrespondence_resultView' ,data =data )
    tsui::run_download_xlsx(id = 'dl_CustomerMaterialCorrespondence',data = data,filename = '客户物料对应表.xlsx')



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
#' CustomerMaterialCorrespondenceServer()
CustomerMaterialCorrespondenceServer <- function(input,output,session,dms_token,erp_token) {

  CustomerMaterialCorrespondenceViewServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
}









