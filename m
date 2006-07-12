Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jul 2006 14:28:42 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:45535 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S3561335AbWGLN2d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Jul 2006 14:28:33 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1G0Yjl-000690-00; Wed, 12 Jul 2006 09:02:21 +0200
Date:	Wed, 12 Jul 2006 09:02:21 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Cc:	linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] au1100fb.c startup sequence
Message-ID: <20060712070221.GI5994@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WHz+neNWvhIGAO8A"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a patch to fix up the start up sequence.

This new sequence allow you to correctly enable the LCD controller
even if the bootloader has already did it.

The patch also fixes up a wrong indentation issue.

Ciao,

Rodolfo


Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-startup-fix

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 1b9ad17..f9fcc65 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -167,7 +167,7 @@ int au1100fb_setmode(struct au1100fb_dev
 
 			info->fix.visual = FB_VISUAL_TRUECOLOR;
 			info->fix.line_length = info->var.xres_virtual << 1; /* depth=16 */
-	}
+		}
 	} else {
 		/* mono */
 		info->fix.visual = FB_VISUAL_MONO10;
@@ -180,16 +180,11 @@ int au1100fb_setmode(struct au1100fb_dev
 
 	/* Determine BPP mode and format */
 	fbdev->regs->lcd_control = fbdev->panel->control_base;
-
-	fbdev->regs->lcd_intenable = 0;
-	fbdev->regs->lcd_intstatus = 0;
-
 	fbdev->regs->lcd_horztiming = fbdev->panel->horztiming;
-
 	fbdev->regs->lcd_verttiming = fbdev->panel->verttiming;
-
 	fbdev->regs->lcd_clkcontrol = fbdev->panel->clkcontrol_base;
-
+	fbdev->regs->lcd_intenable = 0;
+	fbdev->regs->lcd_intstatus = 0;
 	fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(fbdev->fb_phys);
 
 	if (panel_is_dual(fbdev->panel)) {
@@ -217,7 +212,8 @@ int au1100fb_setmode(struct au1100fb_dev
 	fbdev->regs->lcd_pwmhi = 0;
 
 	/* Resume controller */
-	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
+	mdelay(10);
+	au1100fb_fb_blank(VESA_NO_BLANKING, info);
 
 	return 0;
 }

--WHz+neNWvhIGAO8A--
