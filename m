Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jul 2006 13:34:23 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:28899 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S3561325AbWGLMeO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Jul 2006 13:34:14 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1G0Xxf-0004di-00; Wed, 12 Jul 2006 08:12:39 +0200
Date:	Wed, 12 Jul 2006 08:12:39 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Cc:	linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] au1100fb.c info->var.rotate fix
Message-ID: <20060712061239.GF5994@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a little patch to fix "info->var.rotate" data settings.

This info should be deduced directly from "fbdev->panel->control_base"
defined into au1100fb.h.

Ciao,

Rodolfo


Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-rotate

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index f492fe8..dc5a673 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -177,10 +177,11 @@ int au1100fb_setmode(struct au1100fb_dev
 	}
 
 	info->screen_size = info->fix.line_length * info->var.yres_virtual;
+	info->var.rotate = ((fbdev->panel->control_base&LCD_CONTROL_SM_MASK) \
+				>> LCD_CONTROL_SM_BIT) * 90;
 
 	/* Determine BPP mode and format */
-	fbdev->regs->lcd_control = fbdev->panel->control_base |
-			    ((info->var.rotate/90) << LCD_CONTROL_SM_BIT);
+	fbdev->regs->lcd_control = fbdev->panel->control_base;
 
 	fbdev->regs->lcd_intenable = 0;
 	fbdev->regs->lcd_intstatus = 0;

--KJY2Ze80yH5MUxol--
