package com.cd.datalib;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cd.attachment.Attachment;
import com.cd.attachment.AttachmentService;
import com.cd.dao.GridData;
import com.cd.login.LoginSessionKey;
import com.cd.login.LoginUser;
import com.cd.user.PrivilegeService;
import com.cd.web.WebUtil;

@Controller
@RequestMapping(value = "datalib/")
public class DataLibAction {

	@Autowired
	@Qualifier("DataLibService")
	DataLibService dataLibService;

	@Autowired
    @Qualifier("AttachmentService")
    private AttachmentService attachmentService;

	@Autowired
    @Qualifier("PrivilegeService")
    private PrivilegeService privilegeService;

	final private static String P_VIEW = "VIEW";
	final private static String P_UPLOAD = "UPLOAD";
	final private static String P_DOWNLOAD = "DOWNLOAD";

	final private String prefix = "/datalib/";

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	@RequestMapping(value = "main")
	public String main() {
		return this.prefix + "main";
    }

	@RequestMapping(value = "dataLibGrid")
	public String dataLibGrid(DataLib dataLib, HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> geLeMap = new HashMap<String, String>(10);

		String sampleQuantityStart = request.getParameter("sampleQuantityStart");
		String sampleQuantityEnd   = request.getParameter("sampleQuantityEnd");
		geLeMap.put("sampleQuantityStart", sampleQuantityStart);
		geLeMap.put("sampleQuantityEnd", sampleQuantityEnd);

		String auraRateStart = request.getParameter("auraRateStart");
		String auraRateEnd   = request.getParameter("auraRateEnd");
		geLeMap.put("auraRateStart", auraRateStart);
		geLeMap.put("auraRateEnd", auraRateEnd);

		String activationEnergyStart = request.getParameter("activationEnergyStart");
		String activationEnergyEnd   = request.getParameter("activationEnergyEnd");
		geLeMap.put("activationEnergyStart", activationEnergyStart);
		geLeMap.put("activationEnergyEnd", activationEnergyEnd);

		String preExponentialFactorStart = request.getParameter("preExponentialFactorStart");
		String preExponentialFactorEnd   = request.getParameter("preExponentialFactorEnd");
		geLeMap.put("preExponentialFactorStart", preExponentialFactorStart);
		geLeMap.put("preExponentialFactorEnd", preExponentialFactorEnd);

		String reactionOrderStart = request.getParameter("reactionOrderStart");
		String reactionOrderEnd   = request.getParameter("reactionOrderEnd");
		geLeMap.put("reactionOrderStart", reactionOrderStart);
		geLeMap.put("reactionOrderEnd", reactionOrderEnd);

		String reactiontStart = request.getParameter("reactiontStart");
		String reactiontEnd   = request.getParameter("reactiontEnd");
		geLeMap.put("reactiontStart", reactiontStart);
		geLeMap.put("reactiontEnd", reactiontEnd);

		String reactionTimeStart = request.getParameter("reactionTimeStart");
		String reactionTimeEnd   = request.getParameter("reactionTimeEnd");
		geLeMap.put("reactionTimeStart", reactionTimeStart);
		geLeMap.put("reactionTimeEnd", reactionTimeEnd);

		String negativePressureStart = request.getParameter("negativePressureStart");
		String negativePressureEnd   = request.getParameter("negativePressureEnd");
		geLeMap.put("negativePressureStart", negativePressureStart);
		geLeMap.put("negativePressureEnd", negativePressureEnd);

		String forwardPressureStart = request.getParameter("forwardPressureStart");
		String forwardPressureEnd   = request.getParameter("forwardPressureEnd");
		geLeMap.put("forwardPressureStart", forwardPressureStart);
		geLeMap.put("forwardPressureEnd", forwardPressureEnd);


		String uploadTimeStart = request.getParameter("uploadTimeStart");
		String uploadTimeEnd = request.getParameter("uploadTimeEnd");

		String start = request.getParameter("start");
		String limit = request.getParameter("limit");

		GridData<DataLib> grid = this.dataLibService.getDataLibListByType(dataLib, uploadTimeStart, uploadTimeEnd, geLeMap, start, limit);

        request.setAttribute("gridData", grid);


		// 确定是否有“上传”数据的权限
        LoginUser user = (LoginUser) request.getSession(true).getAttribute(LoginSessionKey.LOGIN_SESSION_KEY);
        boolean canUpload = this.privilegeService.isHavePrivilege(user.getUserId(), dataLib.getLibType(), P_UPLOAD);
        request.setAttribute("canUpload", canUpload);

		// 确定是否有“下载”数据的权限
        boolean canDownload = this.privilegeService.isHavePrivilege(user.getUserId(), dataLib.getLibType(), P_DOWNLOAD);
        request.setAttribute("canDownload", canDownload);

		return this.prefix + "dataLibGrid";
    }

	@RequestMapping(value = "createDataLib")
	public void createDataLib(DataLib dataLib, HttpServletRequest request, HttpServletResponse response) {
		JSONObject obj = new JSONObject();

		try {
			String[] originalDataFileIdArr = request.getParameterValues("originalDataFileIdStr");
			if (null != originalDataFileIdArr) {
				String   originalDataFileIdStr = "";
				String   originalDataFileNameStr = "";
				String   seprator = ",";
				int len = originalDataFileIdArr.length;
				for (int i = 0; i < len; i++) {
					if (i == len - 1) {
						seprator = "";
					}
					originalDataFileIdStr += (originalDataFileIdArr[i] + seprator);
					Attachment attachment = this.attachmentService.getAttachmentIndex(originalDataFileIdArr[i]);
					originalDataFileNameStr += (attachment.getFileName() + seprator);
				}
				dataLib.setOriginalDataFileIds(originalDataFileIdStr);
				dataLib.setOriginalDataFileNames(originalDataFileNameStr);
			}

			if (StringUtils.isNotEmpty(dataLib.getPhysicalParamFileId())) {
				Attachment attachment = this.attachmentService.getAttachmentIndex(dataLib.getPhysicalParamFileId());
				dataLib.setPhysicalParamFileName(attachment.getFileName());
			}

			if (StringUtils.isNotEmpty(dataLib.getChartFileId())) {
				Attachment attachment = this.attachmentService.getAttachmentIndex(dataLib.getChartFileId());
				dataLib.setChartFileName(attachment.getFileName());
			}

			if (StringUtils.isEmpty(dataLib.getAuthor())) {
				LoginUser user = (LoginUser) request.getSession(true).getAttribute(LoginSessionKey.LOGIN_SESSION_KEY);
				dataLib.setAuthor(user.getUserName());
			}
			if (null == dataLib.getUploadTime()) {
				dataLib.setUploadTime(new Date());
			}

			this.dataLibService.createDataLib(dataLib);
		} catch (Exception e) {
			e.printStackTrace();

			obj.put("success", false);
			obj.put("msg", "新建数据失败。");
			WebUtil.writeTOPage(response, obj);

			return;
		}

		obj.put("success", true);
		WebUtil.writeTOPage(response, obj);
	}

	@RequestMapping(value="deleteDataLib")
    public void deleteDataLib(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        this.dataLibService.deleteDataLib(id);

        JSONObject obj = new JSONObject();
        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }

	@RequestMapping(value="toUpdateDataLib")
    public String toUpdateDataLib(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        DataLib dataLib = this.dataLibService.getDataLib(id);
        if (StringUtils.isNotEmpty(dataLib.getPhysicalParamFileId())) {
        	Attachment attachment = this.attachmentService.getAttachmentIndex(dataLib.getPhysicalParamFileId());
			attachment.setFileSize(this.formatFileSize(attachment.getFileSize()));
        	request.setAttribute("physicalParamFile", attachment);
        }

        if (StringUtils.isNotEmpty(dataLib.getChartFileId())) {
        	Attachment attachment = this.attachmentService.getAttachmentIndex(dataLib.getChartFileId());
			attachment.setFileSize(this.formatFileSize(attachment.getFileSize()));
        	request.setAttribute("chartFile", attachment);
        }

		List<Attachment> originalDatas = new ArrayList<Attachment>();
        if (StringUtils.isNotEmpty(dataLib.getOriginalDataFileIds())) {
        	String ids = dataLib.getOriginalDataFileIds();
        	String[] idArr = StringUtils.split(ids, ',');
        	for (String fileId : idArr) {
        		Attachment attachment = this.attachmentService.getAttachmentIndex(fileId);
				attachment.setFileSize(this.formatFileSize(attachment.getFileSize()));
        		originalDatas.add(attachment);
			}
        }
		request.setAttribute("originalDataFileList", originalDatas);

        request.setAttribute("dataLib", dataLib);
		return this.prefix + "updateDataLib";
    }

	@RequestMapping(value="updateDataLib")
    public void updateDataLib(DataLib dataLib, HttpServletRequest request, HttpServletResponse response) {
        JSONObject obj = new JSONObject();

		try {
			String[] originalDataFileIdArr = request.getParameterValues("originalDataFileIdStr");
			if (null != originalDataFileIdArr) {
				String originalDataFileIdStr = "";
				String originalDataFileNameStr = "";
				String   seprator = ",";
				int len = originalDataFileIdArr.length;
				for (int i = 0; i < len; i++) {
					if (i == len - 1) {
						seprator = "";
					}
					originalDataFileIdStr += (originalDataFileIdArr[i] + seprator);
					Attachment attachment = this.attachmentService.getAttachmentIndex(originalDataFileIdArr[i]);
					originalDataFileNameStr += (attachment.getFileName() + seprator);
				}
				dataLib.setOriginalDataFileIds(originalDataFileIdStr);
				dataLib.setOriginalDataFileNames(originalDataFileNameStr);
			}

			if (StringUtils.isNotEmpty(dataLib.getPhysicalParamFileId())) {
				Attachment attachment = this.attachmentService.getAttachmentIndex(dataLib.getPhysicalParamFileId());
				dataLib.setPhysicalParamFileName(attachment.getFileName());
			}

			if (StringUtils.isNotEmpty(dataLib.getChartFileId())) {
				Attachment attachment = this.attachmentService.getAttachmentIndex(dataLib.getChartFileId());
				dataLib.setChartFileName(attachment.getFileName());
			}

			if (StringUtils.isEmpty(dataLib.getAuthor())) {
				LoginUser user = (LoginUser) request.getSession(true).getAttribute(LoginSessionKey.LOGIN_SESSION_KEY);
				dataLib.setAuthor(user.getUserName());
			}
			if (null == dataLib.getUploadTime()) {
				dataLib.setUploadTime(new Date());
			}

			this.dataLibService.updateDataLib(dataLib);
		} catch (Exception e) {
			e.printStackTrace();

			obj.put("success", false);
			obj.put("msg", "修改数据失败。");
			WebUtil.writeTOPage(response, obj);

			return;
		}

        obj.put("success", true);
        WebUtil.writeTOPage(response, obj);
    }

	@RequestMapping(value="gotoDataLibReport")
    public String gotoDataLibReport(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        DataLib dataLib = this.dataLibService.getDataLib(id);
        if (StringUtils.isNotEmpty(dataLib.getPhysicalParamFileId())) {
        	Attachment attachment = this.attachmentService.getAttachmentIndex(dataLib.getPhysicalParamFileId());
			attachment.setFileSize(this.formatFileSize(attachment.getFileSize()));
        	request.setAttribute("physicalParamFile", attachment);
        }

        if (StringUtils.isNotEmpty(dataLib.getChartFileId())) {
        	Attachment attachment = this.attachmentService.getAttachmentIndex(dataLib.getChartFileId());
			attachment.setFileSize(this.formatFileSize(attachment.getFileSize()));
        	request.setAttribute("chartFile", attachment);
        }

		List<Attachment> originalDatas = new ArrayList<Attachment>();
        if (StringUtils.isNotEmpty(dataLib.getOriginalDataFileIds())) {
        	String ids = dataLib.getOriginalDataFileIds();
        	String[] idArr = StringUtils.split(ids, ',');
        	for (String fileId : idArr) {
        		Attachment attachment = this.attachmentService.getAttachmentIndex(fileId);
				attachment.setFileSize(this.formatFileSize(attachment.getFileSize()));
        		originalDatas.add(attachment);
			}
        }
		request.setAttribute("originalDataFileList", originalDatas);
		request.setAttribute("dataLib", dataLib);

		boolean flag = StringUtils.isNotEmpty(request.getParameter("download"));
		request.setAttribute("downloadFlag", flag);

		String fileName = dataLib.getThinKind() + "_" + new SimpleDateFormat("yyyyMMdd").format(new Date());
		request.setAttribute("fileName", fileName);

		return this.prefix + "dataReport_1";
    }

	private String formatFileSize(String sizeInByte) {
		float sizeInFloat = Float.parseFloat(sizeInByte);
		float size = sizeInFloat/(1024 * 1024 * 1024);
		String sizeText = null;
        if(size < 1) {
            size = sizeInFloat/(1024 * 1024);
            if(size < 1) {
                size = sizeInFloat/(1024);
                if(size < 1) {
					sizeText = Math.ceil(size) + "B";
                } else {
					sizeText = Math.round(size) + "K";
                }
            } else {
				sizeText = Math.round(size) + "M";
            }
        } else {
			sizeText = Math.round(size) + "G";
        }

        return sizeText;
	}
}
