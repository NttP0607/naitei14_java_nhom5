package vn.sun.public_service_manager.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import vn.sun.public_service_manager.dto.response.FileResDTO;
import vn.sun.public_service_manager.dto.response.MailResDTO;
import vn.sun.public_service_manager.entity.Application;
import vn.sun.public_service_manager.entity.Citizen;
import vn.sun.public_service_manager.exception.FileException;
import vn.sun.public_service_manager.repository.CitizenRepository;
import vn.sun.public_service_manager.service.ApplicationService;
import vn.sun.public_service_manager.service.EmailService;
import vn.sun.public_service_manager.utils.FileUtil;
import vn.sun.public_service_manager.utils.SecurityUtil;
import vn.sun.public_service_manager.utils.annotation.ApiMessage;

@RestController
@RequestMapping("/api/v1/applications")
public class ApplicationController {

    private final FileUtil fileUtil;
    private final ApplicationService applicationService;
    private final EmailService emailService;
    private final CitizenRepository citizenRepository;

    public ApplicationController(FileUtil fileUtil, ApplicationService applicationService, EmailService emailService,
            CitizenRepository citizenRepository) {
        this.fileUtil = fileUtil;
        this.applicationService = applicationService;
        this.emailService = emailService;
        this.citizenRepository = citizenRepository;
    }

    @PostMapping("/upload")
    @ApiMessage("Upload application with files successfully")
    public ResponseEntity<FileResDTO> createApplication(
            @RequestParam("serviceId") Long serviceId,
            @RequestParam("note") String note,
            @RequestParam(value = "files", required = false) MultipartFile[] files) throws FileException {

        if (files == null || files.length == 0) {
            throw new FileException("No files uploaded.");
        }

        List<String> allowedExtensions = List.of("pdf", "doc", "docx", "jpg", "png");
        fileUtil.validateFileExtensions(files, allowedExtensions);

        // create user folder if not exists
        String username = SecurityUtil.getCurrentUserName();
        Citizen citizen = citizenRepository.findByNationalId(username)
                .orElseThrow(() -> new FileException("Citizen with national ID " + username + " not found."));
        fileUtil.createDirectoryIfNotExists(username);

        // save files to user folder
        fileUtil.saveFiles(files, username);

        // save application data
        Application application = applicationService.createApplication(serviceId, note, files);

        MailResDTO mailResDTO = new MailResDTO();
        mailResDTO.setApplicationCode(application.getApplicationCode());
        mailResDTO.setServiceName(application.getService().getName());
        mailResDTO.setSubmittedAt(application.getSubmittedAt());
        // send mail
        emailService.sendApplicationConfirmationEmail(
                citizen.getEmail(),
                citizen.getFullName(), "Hồ sơ đã đăng ký...",
                mailResDTO,
                "email_template");

        FileResDTO response = new FileResDTO();
        response.setApplicationId(application.getApplicationCode());
        response.setUploadedAt(application.getSubmittedAt());
        return ResponseEntity.ok(response);
    }
}
