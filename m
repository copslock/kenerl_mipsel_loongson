Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 14:47:41 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:15791 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133540AbWEaMrc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 14:47:32 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FlQ2q-000832-QB
	for linux-mips@linux-mips.org; Wed, 31 May 2006 14:43:29 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FlQ73-0002gG-OJ
	for linux-mips@linux-mips.org; Wed, 31 May 2006 14:47:49 +0200
Date:	Wed, 31 May 2006 14:47:49 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060531124749.GE27426@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] au1100fb fb_blank
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

since some boards need to manage GPIOs to turn on and off the LCD and
since on shutdwon the driver does:

   #if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
           au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
   #endif
           fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;

I suggest the attached patch to do the same during boot.

Note that this prevents boards support developers to add
specific code before the command:

   fbdev->regs->lcd_control |= LCD_CONTROL_GO;

but putting all these stuff into proper function au1100fb_fb_blank().

Please, let me know what do you think about it.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1100fb-fb_blank

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 7c5fd9c..a59654b 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -110,6 +114,8 @@ static struct fb_var_screeninfo au1100fb
 
 static struct au1100fb_drv_info drv_info;
 
+int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi);
+
 /*
  * Set hardware with var settings. This will enable the controller with a specific
  * mode, normally validated with the fb_check_var method
@@ -205,7 +211,7 @@ int au1100fb_setmode(struct au1100fb_dev
 	fbdev->regs->lcd_pwmhi = 0;
 
 	/* Resume controller */
-	fbdev->regs->lcd_control |= LCD_CONTROL_GO;
+	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
 
 	return 0;
 }

--xB0nW4MQa6jZONgY--
