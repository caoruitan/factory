package com.cd.attachment;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cd.web.WebUtil;

@Controller
@RequestMapping(value="attachment/")
public class AttachmentAction {

	Date date = null;
	private static int BUF_SIZE = 40480;
	private static String ZIP_ENCODEING = "GBK";

    @Autowired
    @Qualifier("AttachmentService")
    private AttachmentService attachmentService;

    @SuppressWarnings("deprecation")
    @RequestMapping(value="uploadFile")
    public void uploadFile(@RequestParam("uploadFile") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {
        if(!file.isEmpty()){
            ServletContext sc = request.getSession().getServletContext();
			String dir = sc.getRealPath("/WEB-INF/attachment"); // 设定文件保存的目录
            Date curDate = new Date();
            String year = String.valueOf(curDate.getYear() + 1900);
            String mounth = String.valueOf(curDate.getMonth() + 1);
            String date = String.valueOf(curDate.getDate());
            String filePath = dir + "\\" + year + "\\" + mounth + "\\" + date;
			String fileName = file.getOriginalFilename(); // 得到上传时的文件名
            String fileType = fileName.split("\\.")[1];
            long fileSize = file.getSize();
            SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSSSSS");
            String newFileName = format.format(new Date(System.currentTimeMillis())) + UUID.randomUUID().toString().replace("-", "").substring(0, 20) + "." + fileType;
            FileUtils.writeByteArrayToFile(new File(filePath, newFileName), file.getBytes());
            Attachment attachment = this.attachmentService.createAttachmentIndex(fileName, filePath + "\\" + newFileName, String.valueOf(fileSize));
            JSONObject obj = new JSONObject();
            obj.put("success", true);
            obj.put("attachment", attachment);
            WebUtil.writeTOPage(response, obj);
        }
    }

    @RequestMapping(value="downloadFile")
    public void downloadFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fileId = request.getParameter("fileId");
        Attachment attachment = this.attachmentService.getAttachmentIndex(fileId);
        BufferedInputStream in = null;
        BufferedOutputStream out = null;
        try {
            File f = new File(attachment.getFilePath());
            response.setContentType("application/x-msdownload");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename=" + new String( attachment.getFileName().getBytes("gb2312"), "ISO8859-1" ) );
            response.setHeader("Content-Length", String.valueOf(f.length()));
            in = new BufferedInputStream(new FileInputStream(f));
            out = new BufferedOutputStream(response.getOutputStream());
            byte[] data = new byte[1024];
            int len = 0;
            while (-1 != (len=in.read(data, 0, data.length))) {
                out.write(data, 0, len);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.close();
            }
        }
    }

    @RequestMapping(value="downloadFileByZip")
    public void downloadFileByZip(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fileIds = request.getParameter("fileIds");
        String[] fileIdArr = StringUtils.split(fileIds, ",");

        this.date = new Date();
        ServletContext sc = request.getSession().getServletContext();
		String tmpDir = sc.getRealPath("/WEB-INF/ziptmp"); // 设定文件保存的目录

        BufferedInputStream in = null;
        BufferedOutputStream out = null;
        try {
        	String subDirPath = tmpDir + "\\" + this.date.getTime();
        	File subDir = new File(subDirPath);
        	if (! subDir.exists()) {
        		subDir.mkdir();
        	}

        	for (String fileId : fileIdArr) {
        		Attachment attachment = this.attachmentService.getAttachmentIndex(fileId);
        		File destFile = new File(subDirPath + "\\" + attachment.getFileName());
        		FileUtils.copyFile(new File(attachment.getFilePath()), destFile);
        	}

        	this.zip(tmpDir + "\\" + this.date.getTime() + ".zip", subDir);

        	File f = new File(tmpDir + "\\" + this.date.getTime() + ".zip");

            response.setContentType("application/x-msdownload");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename=" + this.date.getTime() + ".zip");
            response.setHeader("Content-Length", String.valueOf(f.length()));
            in = new BufferedInputStream(new FileInputStream(f));
            out = new BufferedOutputStream(response.getOutputStream());
            byte[] data = new byte[1024];
            int len = 0;
            while (-1 != (len=in.read(data, 0, data.length))) {
                out.write(data, 0, len);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.close();
            }
        }
    }


	/**
	 * 压缩文件或文件夹
	 *
	 * @param zipFileName
	 * @param inputFile
	 * @throws Exception
	 */
	private void zip(String zipFileName, File inputFile) throws Exception {
		// 未指定压缩文件名，默认为"ZipFile"
		if (zipFileName == null || zipFileName.equals("")) {
			zipFileName = "ZipFile";
		}

		// 添加".zip"后缀
		if (!zipFileName.endsWith(".zip")) {
			zipFileName += ".zip";
		}

		// 创建文件夹
		File f = null;
		String path = Pattern.compile("[\\/]").matcher(zipFileName).replaceAll(File.separator);
		int endIndex = path.lastIndexOf(File.separator);
		path = path.substring(0, endIndex);
		f = new File(path);
		if (! f.exists()) {
			f.mkdirs();
		}

		// 开始压缩
		{
			ZipOutputStream zos = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(zipFileName)));

			zos.setEncoding(ZIP_ENCODEING);
			this.compress(zos, inputFile, "");
			zos.close();
		}
	}

	/**
	 * 压缩一个文件夹或文件对象到已经打开的zip输出流 <b>不建议直接调用该方法</b>
	 *
	 * @param zos
	 * @param f
	 * @param fileName
	 * @throws Exception
	 */
	private void compress(ZipOutputStream zos, File f, String fileName)
			throws Exception {
		if (f.isDirectory()) {
			// 压缩文件夹
			File[] fl = f.listFiles();
			zos.putNextEntry(new ZipEntry(fileName + "/"));
			fileName = fileName.length() == 0 ? "" : fileName + "/";
			for (int i = 0; i < fl.length; i++) {
				this.compress(zos, fl[i], fileName + fl[i].getName());
			}
		} else {
			// 压缩文件
			zos.putNextEntry(new ZipEntry(fileName));
			FileInputStream fis = new FileInputStream(f);
			this.inStream2outStream(fis, zos);
			zos.flush();
			fis.close();
			zos.closeEntry();
		}
	}

	private void inStream2outStream(InputStream is, OutputStream os)
			throws IOException {
		BufferedInputStream bis = new BufferedInputStream(is);
		BufferedOutputStream bos = new BufferedOutputStream(os);
		int bytesRead = 0;
		for (byte[] buffer = new byte[BUF_SIZE]; ((bytesRead = bis.read(buffer, 0, BUF_SIZE)) != -1);) {
			bos.write(buffer, 0, bytesRead); // 将流写入
		}
	}
}
