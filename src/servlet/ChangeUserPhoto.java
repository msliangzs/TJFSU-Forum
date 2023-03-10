package servlet;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangeUserPhoto extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ChangeUserPhoto() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doDelete method of the servlet. <br>
	 * 
	 * This method is called when a HTTP delete request is received.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // ????????????
		response.setCharacterEncoding("utf-8"); // ????????????
		response.setContentType("text/html;charset=utf-8");
		
		int uId = Integer.parseInt(request.getParameter("uId")); // ????????id
		String photoUrl = request.getParameter("avatar_file");		//??????????
		System.out.println(photoUrl);
		
		HttpSession session = request.getSession(); // ????session????
		PrintWriter out = response.getWriter(); // ??????????

		int MAX_SIZE = 102400 * 102400; // ??????????????????????
		String rootPath; // ????????????????????
		DataInputStream in = null; // ??????????????
		FileOutputStream fileOut = null;
		String remoteAddr = request.getRemoteAddr(); // ????????????????????
		String serverName = request.getServerName(); // ????????????????
		String realPath = request.getRealPath("/");// ????????????????????????
		realPath = realPath.substring(0, realPath.lastIndexOf("\\"));
		//rootPath = "F:\\githubproject\\????????\\WebRoot\\img\\UserPhoto"; // ??????????????????
		rootPath = realPath + "\\img\\UserPhoto\\"; // ??????????????????
		out.println("??????????????????" + rootPath);
		
		String contentType = request.getContentType(); // ????????????????????????
		try {
			if (contentType.indexOf("multipart/form-data") >= 0) {
				in = new DataInputStream(request.getInputStream()); // ??????????????
				int formDataLength = request.getContentLength();
				if (formDataLength > MAX_SIZE) {
					out.println("<P>??????????????????????????" + MAX_SIZE + "</p>");
					return;
				}
				byte dataBytes[] = new byte[formDataLength]; // ??????????????????
				int byteRead = 0;
				int totalBytesRead = 0;
				while (totalBytesRead < formDataLength) { // ????????????????byte????
					byteRead = in.read(dataBytes, totalBytesRead,
							formDataLength);
					totalBytesRead += byteRead;
				}
				String file = new String(dataBytes); // ????byte??????????????
				String saveFile = file	.substring(file.indexOf("filename=\"") + 10); // ??????????????????????
				saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
				saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,	saveFile.indexOf("\""));
				int lastIndex = contentType.lastIndexOf("=");
				String boundary = contentType.substring(lastIndex + 1,contentType.length());// ????????????????????
				String fileName = rootPath + saveFile;
				int pos;
				pos = file.indexOf("filename=\"");
				pos = file.indexOf("\n", pos) + 1;
				pos = file.indexOf("\n", pos) + 1;
				pos = file.indexOf("\n", pos) + 1;
				int boundaryLocation = file.indexOf(boundary, pos) - 4;
				int startPos = ((file.substring(0, pos)).getBytes()).length;// ????????????????????????
				int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length; // ????????????????????????
				File checkFile = new File(fileName); // ????????????????????
				if (checkFile.exists()) {
					out.println("<p>" + saveFile + "????????????.</p>");
				}
				File fileDir = new File(rootPath);// ??????????????????????????
				if (!fileDir.exists()) {
					fileDir.mkdirs();
				}
				fileOut = new FileOutputStream(fileName); // ????????????????
				fileOut.write(dataBytes, startPos, (endPos - startPos)); // ??????????????
				fileOut.close();
				out.println("<P><font color=red size=5>" + saveFile
						+ "????????????.</font></p>");
			} else {
				String content = request.getContentType();
				out.println("<p>????????????????????multipart/form-data</p>");
			}
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage());
		}
/*
		response.getWriter().print("forward:<br />"); // ????????????
		getServletConfig().getServletContext().getRequestDispatcher("/usermessage2.jsp?uId=" + uId).forward(request, response);
*/
		out.flush();
		out.close();
	}

	/**
	 * The doPut method of the servlet. <br>
	 * 
	 * This method is called when a HTTP put request is received.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Put your code here
	}

	/**
	 * Returns information about the servlet, such as author, version, and
	 * copyright.
	 * 
	 * @return String information about this servlet
	 */
	public String getServletInfo() {
		return "This is my default servlet created by Eclipse";
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
