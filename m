Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 08:14:23 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:39602 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133529AbWCXIOO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 08:14:14 +0000
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 19545C0F4;
	Fri, 24 Mar 2006 09:24:11 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id E80801BC090;
	Fri, 24 Mar 2006 09:24:12 +0100 (CET)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 446681A18DD;
	Fri, 24 Mar 2006 09:22:58 +0100 (CET)
Date:	Fri, 24 Mar 2006 09:23:00 +0100
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
Subject: [patch] au1200fb: fix ioctl, mmap and pm declarations
Message-ID: <20060324082300.GD5195@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Fix warnings and make ioctl and mmap work again.

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>


 drivers/video/au1200fb.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6.16.git/drivers/video/au1200fb.c
===================================================================
--- linux-2.6.16.git.orig/drivers/video/au1200fb.c
+++ linux-2.6.16.git/drivers/video/au1200fb.c
@@ -1246,7 +1246,7 @@ int au1200fb_fb_blank(int blank_mode, st
  * Map video memory in user space. We don't use the generic fb_mmap
  * method mainly to allow the use of the TLB streaming flag (CCA=6)
  */
-int au1200fb_fb_mmap(struct fb_info *fbi, struct file *file, struct vm_area_struct *vma)
+int au1200fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
 	unsigned int len;
 	unsigned long start=0, off;
@@ -1465,8 +1465,7 @@ void get_window(unsigned int plane, au12
 	au_sync();
 }
 
-static int au1200fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, struct fb_info *info)
+static int au1200fb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	int plane;
 	int val;
@@ -1763,13 +1763,13 @@ int au1200fb_drv_remove(struct device *d
 	return 0;
 }
 
-int au1200fb_drv_suspend(struct device *dev, u32 state, u32 level)
+int au1200fb_drv_suspend(struct device *dev, pm_message_t state)
 {
 	/* TODO */
 	return 0;
 }
 
-int au1200fb_drv_resume(struct device *dev, u32 level)
+int au1200fb_drv_resume(struct device *dev)
 {
 	/* TODO */
 	return 0;
