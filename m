Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 12:49:24 +0100 (BST)
Received: from [213.161.0.31] ([213.161.0.31]:55476 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133612AbVJ1LtF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 12:49:05 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 56B7EC015
	for <linux-mips@linux-mips.org>; Fri, 28 Oct 2005 13:48:19 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 2A51D1BC07E
	for <linux-mips@linux-mips.org>; Fri, 28 Oct 2005 13:48:22 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id B23D31A18B2
	for <linux-mips@linux-mips.org>; Fri, 28 Oct 2005 13:48:22 +0200 (CEST)
Subject: AU1200 fb patch
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Content-Type: multipart/mixed; boundary="=-xjP9W/KF3+PAG8uzmEPe"
Date:	Fri, 28 Oct 2005 13:48:04 +0200
Message-Id: <1130500084.4785.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips


--=-xjP9W/KF3+PAG8uzmEPe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

This patch fixes compilation error for au1200fb.c to replace
io_remap_page_range with the io_remap_pfn_range.
Also it adds new panel setting.

BR,
Matej

--=-xjP9W/KF3+PAG8uzmEPe
Content-Disposition: attachment; filename=linux-2.6.14-rc2-prime_view-PM070WX1.patch
Content-Type: text/x-patch; name=linux-2.6.14-rc2-prime_view-PM070WX1.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch:
- Adds new panel setting for Prime View PM070WX1
- Replaces io_remap_page_range with the io_remap_pfn_range

Signed-off-by: Matej Kupljen <matej.kupljen@ultra.si>

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -651,6 +651,39 @@ static struct panel_settings known_lcd_p
 		856, 856,
 		480, 480,
 	},
+	[9] = { /* Prime View PM070WX1 800x480 TFT */
+		.name = "PrimeView_PM070WX1",
+		.monspecs = {
+			.modedb = NULL,
+			.modedb_len = 0,
+			.hfmin = 30000,	
+			.hfmax = 70000, 
+			.vfmin = 60, 
+			.vfmax = 60, 
+			.dclkmin = 6000000, 
+			.dclkmax = 28000000, 
+			.input = FB_DISP_RGB,
+		},
+		.mode_screen		= LCD_SCREEN_SX_N(800) | 
+			LCD_SCREEN_SY_N(480),
+		.mode_horztiming	= LCD_HORZTIMING_HND2_N(43) | 
+			LCD_HORZTIMING_HND1_N(43) | LCD_HORZTIMING_HPW_N(114),
+		.mode_verttiming	= LCD_VERTTIMING_VND2_N(20) | 
+			LCD_VERTTIMING_VND1_N(21) | LCD_VERTTIMING_VPW_N(4),
+		.mode_clkcontrol	= 0x00020001, /* /4=24Mhz */
+		.mode_pwmdiv		= 0x8000063f,
+		.mode_pwmhi		= 0x03400000,
+		.mode_outmask	= 0x00fcfcfc,
+		.mode_fifoctrl	= 0x2f2f2f2f,
+		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
+		.mode_backlight	= 0x00000000,
+		.mode_auxpll		= 8, /* 96MHz AUXPLL */
+		.device_init		= board_au1200fb_panel_init,
+		.device_shutdown	= board_au1200fb_panel_shutdown,
+		800, 800,
+		480, 480,
+	},
+
 };
 
 #define NUM_PANELS (sizeof(known_lcd_panels) / sizeof(struct panel_settings))
@@ -1276,7 +1309,7 @@ int au1200fb_fb_mmap(struct fb_info *fbi
 
 	vma->vm_flags |= VM_IO;
     
-	if (io_remap_page_range(vma, vma->vm_start, off,
+	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) {
 		return -EAGAIN;

--=-xjP9W/KF3+PAG8uzmEPe--
