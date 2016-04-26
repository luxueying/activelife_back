package com.activelife.back.utils;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUpload {
    private static final Log LOG = LogFactory.getLog(FileUpload.class);

    /**
     * 上传文件
     * 
     * @param request
     *            请求对象
     * @param fieldName
     *            文件域名称
     * @param folderName
     *            上传目标文件夹名称
     * @return 上传文件路径
     * @throws Exception
     * @author lxy
     */
    public static String uploadFile(HttpServletRequest request, String fieldName, String folderName) throws Exception {
        String filePath = null;
        // 使用MultipartHttpServletRequest包装文件数据
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        // 得到图片保存目录的真实路径
        String targetPath = request.getSession().getServletContext().getRealPath(folderName);
        // 根据真实路径创建目录
        File targetFile = new File(targetPath);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }

        MultipartFile multipartFile = multipartRequest.getFile(fieldName);
        // 获取文件名
        String fileName = multipartFile.getOriginalFilename();
        int index = fileName.lastIndexOf(".");
        if (index == -1) {
            LOG.info("文件名：" + fileName + "不正确！");
            throw new Exception("文件名不正确！");
        } else {
            fileName = UUID.randomUUID().toString() + fileName.substring(index);
            LOG.info("文件名：" + fileName);
        }
        filePath = folderName + "/" + fileName;
        fileName = targetPath + "/" + fileName;
        File file = new File(fileName);

        try {
            // 保存上传文件
            multipartFile.transferTo(file);
            LOG.info(fileName + "上传成功！！！");
        } catch (Exception e) {
            LOG.info(fileName + "上传失败！！！");
            e.printStackTrace();
            throw e;
        }

        return filePath;
    }

    /**
     * 裁剪图片
     * 
     * @param request
     *            请求对象
     * @param fileName
     *            文件名
     * @param folderName
     *            保存文件夹名称
     * @param x
     *            剪切横坐标
     * @param y
     *            剪切纵坐标
     * @param width
     *            剪切宽度
     * @param height
     *            剪切高度
     * @return 剪切成功返回true，剪切失败返回false
     * @throws Exception
     */

    public static boolean cutImage(HttpServletRequest request, String fileName, String folderName, int x, int y,
            int width, int height) throws Exception {
        String realPath = request.getSession().getServletContext().getRealPath(folderName);
        String filePath = realPath + "/" + fileName;
        File imageFile = new File(filePath);
        if (!imageFile.exists()) {
            LOG.info(filePath + "找不到要裁剪的文件！！！");
            throw new Exception("找不到要裁剪的文件:" + filePath);
        }
        // 取得文件后缀名
        String formatName = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
        BufferedImage image = null;
        boolean result = false;
        try {
            image = ImageIO.read(imageFile);
            image = image.getSubimage(x, y, width, height);
            // 覆盖掉原文件
            result = ImageIO.write(image, formatName, new File(filePath));
        } catch (Exception e) {
            LOG.info(filePath + "文件裁剪失败！！！");
            e.printStackTrace();
            throw e;
        }

        return result;
    }

    /**
     * 压缩图片
     * 
     * @param request
     *            请求对象
     * @param fileName
     *            文件名
     * @param folderName
     *            保存文件夹名称
     * @param width
     *            压缩宽度
     * @param height
     *            压缩高度
     * @return 压缩成功返回true，压缩失败返回false
     * @throws Exception
     */
    public static boolean zoomImage(HttpServletRequest request, String fileName, String folderName, int width,
            int height) throws Exception {
        String realPath = request.getSession().getServletContext().getRealPath(folderName);
        String filePath = realPath + "/" + fileName;
        File imageFile = new File(filePath);
        if (!imageFile.exists()) {
            LOG.info(filePath + "找不到要压缩的文件！！！");
            throw new Exception("找不到要压缩的文件:" + filePath);
        }
        // 取得文件后缀名
        String formatName = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
        BufferedImage image = null;
        boolean result = false;
        try {
            image = ImageIO.read(imageFile);
            image = zoom(image, width, height);
            ImageIO.write(image, formatName, new File(filePath));
            // 覆盖掉原文件
            result = ImageIO.write(image, formatName, new File(filePath));
        } catch (Exception e) {
            LOG.info(filePath + "文件压缩失败！！！");
            e.printStackTrace();
            throw e;
        }

        return result;
    }

    /**
     * 压缩图片
     * 
     * @param sourceImage
     *            待压缩图片
     * @param width
     *            压缩图片高度
     * @param heigt
     *            压缩图片宽度
     */
    private static BufferedImage zoom(BufferedImage sourceImage, int width, int height) {
        BufferedImage zoomImage = new BufferedImage(width, height, sourceImage.getType());
        Image image = sourceImage.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        Graphics gc = zoomImage.getGraphics();
        gc.setColor(Color.WHITE);
        gc.drawImage(image, 0, 0, null);

        return zoomImage;
    }

    /**
     * 删除文件
     * 
     * @param filePath
     *            文件路径
     * @return 删除成功返回true，删除失败返回false
     */
    public static boolean deleteFile(String filePath) {
        File file = new File(filePath);
        if (file.exists()) {
            return file.delete();
        } else {
            LOG.info(filePath + "文件不存在！！！");
            return false;
        }
    }

}
