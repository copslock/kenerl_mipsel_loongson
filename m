Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 17:53:49 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:4015 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133760AbWEXPxi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 17:53:38 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FivcI-0005no-9c
	for linux-mips@linux-mips.org; Wed, 24 May 2006 17:49:47 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1Fivg0-0007FQ-2k
	for linux-mips@linux-mips.org; Wed, 24 May 2006 17:53:36 +0200
Date:	Wed, 24 May 2006 17:53:36 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060524155335.GA27426@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] Clean compiling for au1100fb.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Without the attached patch when compiling au1100fb.c I get:

     CC      drivers/video/au1100fb.o
   drivers/video/au1100fb.c: In function `au1100fb_fb_setcolreg':
   drivers/video/au1100fb.c:219: warning: ISO C90 forbids mixed declarations and code
   drivers/video/au1100fb.c: In function `au1100fb_fb_pan_display':
   drivers/video/au1100fb.c:321: warning: ISO C90 forbids mixed declarations and code
   drivers/video/au1100fb.c: In function `au1100fb_fb_mmap':
   drivers/video/au1100fb.c:387: warning: ISO C90 forbids mixed declarations and code
   drivers/video/au1100fb.c: In function `au1100fb_drv_probe':
   drivers/video/au1100fb.c:471: warning: unsigned int format, long unsigned int arg (arg 2)
   drivers/video/au1100fb.c: At top level:
   drivers/video/au1100fb.c:617: warning: initialization from incompatible pointer type
   drivers/video/au1100fb.c:618: warning: initialization from incompatible pointer type
     LD      drivers/video/built-in.o

my compiler is:

   giometti@zaigor:~$ mipsel-linux-gcc --version
   mipsel-linux-gcc (GCC) 3.4.3
   Copyright (C) 2004 Free Software Foundation, Inc.
   This is free software; see the source for copying conditions.  There is NO
   warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1100fb.c.patch"

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 7c5fd9c..1f401a9 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -215,10 +244,13 @@ int au1100fb_setmode(struct au1100fb_dev
  */
 int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
 {
-	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
-	u32 *palette = fbdev->regs->lcd_pallettebase;
+	struct au1100fb_device *fbdev;
+	u32 *palette;
 	u32 value;
 
+	fbdev = to_au1100fb_device(fbi);
+	palette = fbdev->regs->lcd_pallettebase;
+
 	if (regno > (AU1100_LCD_NBR_PALETTE_ENTRIES - 1))
 		return -EINVAL;
 
@@ -317,9 +363,11 @@ int au1100fb_fb_blank(int blank_mode, st
  */
 int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
-	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	struct au1100fb_device *fbdev;
 	int dy;
 
+	fbdev = to_au1100fb_device(fbi);
+
 	print_dbg("fb_pan_display %p %p", var, fbi);
 
 	if (!var || !fbdev) {
@@ -383,10 +431,12 @@ void au1100fb_fb_rotate(struct fb_info *
  */
 int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
-	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	struct au1100fb_device *fbdev;
 	unsigned int len;
 	unsigned long start=0, off;
 
+	fbdev = to_au1100fb_device(fbi);
+
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
 		return -EINVAL;
 	}
@@ -468,7 +518,7 @@ int au1100fb_drv_probe(struct device *de
 
 	if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len,
 				DRIVER_NAME)) {
-		print_err("fail to lock memory region at 0x%08x",
+		print_err("fail to lock memory region at 0x%08lx",
 				au1100fb_fix.mmio_start);
 		return -EBUSY;
 	}
@@ -596,13 +657,13 @@ int au1100fb_drv_remove(struct device *d
 	return 0;
 }
 
-int au1100fb_drv_suspend(struct device *dev, u32 state, u32 level)
+int au1100fb_drv_suspend(struct device *dev, pm_message_t state)
 {
 	/* TODO */
 	return 0;
 }
 
-int au1100fb_drv_resume(struct device *dev, u32 level)
+int au1100fb_drv_resume(struct device *dev)
 {
 	/* TODO */
 	return 0;

--EeQfGwPcQSOJBaQU--
