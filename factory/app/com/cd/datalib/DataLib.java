package com.cd.datalib;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "DATALIB")
public class DataLib {
	/** 唯一标识ID */
	private String id;
	/** 所属库 */
	private String libType;
	/** 审核状态 */
	private String status;

	/** 反应物所属大类 */
	private String fatKind;
	/** 反应物所属小类 */
	private String thinKind;

	/** 反应物所属国别 */
	private String country;
	/** 反应物所属地区 */
	private String district;
	/** 反应物年龄 */
	private String age;
	/** 反应物物性参数——文件ID */
	private String physicalParamFileId;
	/** 反应物物性参数——文件名称 */
	private String physicalParamFileName;

	/** 仪器名称 */
	private String instrumentName;
	/** 仪器厂商 */
	private String instrumentVendor;
	/** 仪器型号 */
	private String instrumentType;
	/** 测试方法 */
	private String testMethod;
	/** 测试手段 */
	private String testWay;

	/** 样品量 */
	private BigDecimal sampleQuantity;
	/** 升温程序 */
	private String riseProgram;
	/** 气氛组成 */
	private String auraForm;
	/** 气体流量 */
	private BigDecimal auraRate;

	/** 催化剂种类 */
	private String catalystKind;
	/** 反应温度/还原温度 */
	private BigDecimal reactiont;
	/** 反应时间/还原时间 */
	private BigDecimal reactionTime;
	/** 负压 */
	private BigDecimal negativePressure;
	/** 偏压 */
	private BigDecimal forwardPressure;

	/** 动力学分析方法 */
	private String analyzeMethod;
	/** 图表——文件ID */
	private String chartFileId;
	/** 图表——文件名称 */
	private String chartFileName;
	/** 实际数值-活化能 */
	private BigDecimal activationEnergy;
	/** 实际数值-指前因子 */
	private BigDecimal preExponentialFactor;
	/** 实际数值-反应级数 */
	private BigDecimal reactionOrder;
	/** 原始数据——文件ID数组，以,分隔 */
	private String originalDataFileIds;
	/** 原始数据——文件名称数组，以,分隔 */
	private String originalDataFileNames;

	/** 作者 */
	private String author;
	/** 单位 */
	private String org;
	/** 上传时间 */
	private Date uploadTime;
	/** 联系信息 */
	private String linkInfo;

	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "guid")
	@Column(name = "ID", length = 50, nullable = false)
	public String getId() {
		return this.id;
	}

	@Column(name = "LIB_TYPE", length = 100, nullable = false)
	public String getLibType() {
		return this.libType;
	}

	@Column(name = "STATUS", length = 100, nullable = false)
	public String getStatus() {
		return this.status;
	}

	@Column(name = "FAT_KIND", length = 100, nullable = true)
	public String getFatKind() {
		return this.fatKind;
	}

	@Column(name = "THIN_KIND", length = 100, nullable = true)
	public String getThinKind() {
		return this.thinKind;
	}

	@Column(name = "COUNTRY", length = 100, nullable = true)
	public String getCountry() {
		return this.country;
	}

	@Column(name = "DISTRICT", length = 100, nullable = true)
	public String getDistrict() {
		return this.district;
	}

	@Column(name = "AGE", length = 100, nullable = true)
	public String getAge() {
		return this.age;
	}

	@Column(name = "PHYSICALPARAM_FILEID", length = 100, nullable = true)
	public String getPhysicalParamFileId() {
		return this.physicalParamFileId;
	}

	@Column(name = "PHYSICALPARAM_FILENAME", length = 100, nullable = true)
	public String getPhysicalParamFileName() {
		return this.physicalParamFileName;
	}

	@Column(name = "INSTRUMENT_NAME", length = 100, nullable = true)
	public String getInstrumentName() {
		return this.instrumentName;
	}

	@Column(name = "INSTRUMENT_VENDOR", length = 100, nullable = true)
	public String getInstrumentVendor() {
		return this.instrumentVendor;
	}

	@Column(name = "INSTRUMENT_TYPE", length = 100, nullable = true)
	public String getInstrumentType() {
		return this.instrumentType;
	}

	@Column(name = "TEST_METHOD", length = 100, nullable = true)
	public String getTestMethod() {
		return this.testMethod;
	}

	@Column(name = "TEST_WAY", length = 100, nullable = true)
	public String getTestWay() {
		return this.testWay;
	}

	@Column(name = "SAMPLE_QUANTITY", length = 100, nullable = true)
	public BigDecimal getSampleQuantity() {
		return this.sampleQuantity;
	}

	@Column(name = "RISE_PROGRAM", length = 100, nullable = true)
	public String getRiseProgram() {
		return this.riseProgram;
	}

	@Column(name = "AURA_FORM", length = 100, nullable = true)
	public String getAuraForm() {
		return this.auraForm;
	}

	@Column(name = "AURA_RATE", length = 100, nullable = true)
	public BigDecimal getAuraRate() {
		return this.auraRate;
	}
	@Column(name = "CATALYST_KIND", length = 100, nullable = true)
	public String getCatalystKind() {
		return this.catalystKind;
	}
	@Column(name = "REACTION_T", length = 100, nullable = true)
	public BigDecimal getReactiont() {
		return this.reactiont;
	}
	@Column(name = "REACTION_TIME", length = 100, nullable = true)
	public BigDecimal getReactionTime() {
		return this.reactionTime;
	}
	@Column(name = "FORWARD_PRESSURE", length = 100, nullable = true)
	public BigDecimal getForwardPressure() {
		return this.forwardPressure;
	}
	@Column(name = "NEGATIVE_PRESSURE", length = 100, nullable = true)
	public BigDecimal getNegativePressure() {
		return this.negativePressure;
	}

	@Column(name = "ANALYZE_METHOD", length = 100, nullable = true)
	public String getAnalyzeMethod() {
		return this.analyzeMethod;
	}

	@Column(name = "CHART_FILEID", length = 100, nullable = true)
	public String getChartFileId() {
		return this.chartFileId;
	}

	@Column(name = "CHART_FILENAME", length = 100, nullable = true)
	public String getChartFileName() {
		return this.chartFileName;
	}

	@Column(name = "ACTIVATION_ENERGY", length = 100, nullable = true)
	public BigDecimal getActivationEnergy() {
		return this.activationEnergy;
	}

	@Column(name = "PREEXPONENTIAL_FACTOR", length = 100, nullable = true)
	public BigDecimal getPreExponentialFactor() {
		return this.preExponentialFactor;
	}

	@Column(name = "REACTION_ORDER", length = 100, nullable = true)
	public BigDecimal getReactionOrder() {
		return this.reactionOrder;
	}

	@Column(name = "ORIGINALDATA_FILEIDS", length = 2000, nullable = true)
	public String getOriginalDataFileIds() {
		return this.originalDataFileIds;
	}

	@Column(name = "ORIGINALDATA_FILENAMES", length = 2000, nullable = true)
	public String getOriginalDataFileNames() {
		return this.originalDataFileNames;
	}

	@Column(name = "AUTHOR", length = 100, nullable = false)
	public String getAuthor() {
		return this.author;
	}

	@Column(name = "ORG", length = 100, nullable = true)
	public String getOrg() {
		return this.org;
	}

	@Column(name = "UPLOAD_TIME", length = 100, nullable = false)
	@Temporal(TemporalType.DATE)
	public Date getUploadTime() {
		return this.uploadTime;
	}

	@Column(name = "LINK_INFO", length = 100, nullable = true)
	public String getLinkInfo() {
		return this.linkInfo;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setLibType(String libType) {
		this.libType = libType;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setFatKind(String fatKind) {
		this.fatKind = fatKind;
	}

	public void setThinKind(String thinKind) {
		this.thinKind = thinKind;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public void setPhysicalParamFileId(String physicalParamFileId) {
		this.physicalParamFileId = physicalParamFileId;
	}

	public void setPhysicalParamFileName(String physicalParamFileName) {
		this.physicalParamFileName = physicalParamFileName;
	}

	public void setInstrumentName(String instrumentName) {
		this.instrumentName = instrumentName;
	}

	public void setInstrumentVendor(String instrumentVendor) {
		this.instrumentVendor = instrumentVendor;
	}

	public void setInstrumentType(String instrumentType) {
		this.instrumentType = instrumentType;
	}

	public void setTestMethod(String testMethod) {
		this.testMethod = testMethod;
	}

	public void setTestWay(String testWay) {
		this.testWay = testWay;
	}

	public void setSampleQuantity(BigDecimal sampleQuantity) {
		this.sampleQuantity = sampleQuantity;
	}

	public void setRiseProgram(String riseProgram) {
		this.riseProgram = riseProgram;
	}

	public void setAuraForm(String auraForm) {
		this.auraForm = auraForm;
	}

	public void setAuraRate(BigDecimal auraRate) {
		this.auraRate = auraRate;
	}

	public void setCatalystKind(String catalystKind) {
		this.catalystKind = catalystKind;
	}

	public void setReactiont(BigDecimal reactiont) {
		this.reactiont = reactiont;
	}

	public void setReactionTime(BigDecimal reactionTime) {
		this.reactionTime = reactionTime;
	}

	public void setForwardPressure(BigDecimal forwardPressure) {
		this.forwardPressure = forwardPressure;
	}

	public void setNegativePressure(BigDecimal negativePressure) {
		this.negativePressure = negativePressure;
	}

	public void setAnalyzeMethod(String analyzeMethod) {
		this.analyzeMethod = analyzeMethod;
	}

	public void setChartFileId(String chartFileId) {
		this.chartFileId = chartFileId;
	}

	public void setChartFileName(String chartFileName) {
		this.chartFileName = chartFileName;
	}

	public void setActivationEnergy(BigDecimal activationEnergy) {
		this.activationEnergy = activationEnergy;
	}

	public void setPreExponentialFactor(BigDecimal preExponentialFactor) {
		this.preExponentialFactor = preExponentialFactor;
	}

	public void setReactionOrder(BigDecimal reactionOrder) {
		this.reactionOrder = reactionOrder;
	}

	public void setOriginalDataFileIds(String originalDataFileIds) {
		this.originalDataFileIds = originalDataFileIds;
	}

	public void setOriginalDataFileNames(String originalDataFileNames) {
		this.originalDataFileNames = originalDataFileNames;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	public void setLinkInfo(String linkInfo) {
		this.linkInfo = linkInfo;
	}
}
