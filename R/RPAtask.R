

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
#' RPAtaskViewServer()
RPAtaskViewServer <- function(input,output,session,dms_token,erp_token) {


  shiny::observeEvent(input$btn_RPAtask_select,{


    data = mdlJHReportItemPkg::RPAtask_select(erp_token =erp_token )

    tsui::run_dataTable2(id ='RPAtask_resultView' ,data =data )


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
#' RPAtaskServer()
RPAtaskServer <- function(input,output,session,dms_token,erp_token) {

  RPAtaskViewServer(input = input,output = output,session=session,dms_token= dms_token,erp_token=erp_token)
}









