package com.cd.attachment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service("AttachmentService")
public class AttachmentService {

    @Autowired
    @Qualifier("AttachmentDao")
    private AttachmentDao attachmentDao;
    
    public Attachment createAttachmentIndex(String fileName, String filePath, String fileSize) {
        Attachment attachment = new Attachment();
        attachment.setFileName(fileName);
        attachment.setFilePath(filePath);
        attachment.setFileSize(fileSize);
        this.attachmentDao.save(attachment);
        return attachment;
    }
    
    public Attachment getAttachmentIndex(String fileId) {
        return this.attachmentDao.get(Attachment.class, fileId);
    }
    
}
