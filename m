Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:43:59 +0200 (CEST)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53339 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842557AbaGWOhder-Ra (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:33 +0200
Received: by mail-wg0-f44.google.com with SMTP id m15so1272700wgh.3
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Al6g1/jryciOqWGSFkvh7NtkVRV5f3IUyaBz+65X8es=;
        b=wRAvHTIWGmevWqM/BDTwbSREnVISWwdhrFRQP4fxwY2LpbeT3JYMwfmbtmjsXWOuDi
         U5dujNczExGxQMaTZnOYC/amxSt7oEKEStSZpXewiSmjqTE6QVSMcQ/iVrW87FxG6skC
         di/sinzDwqL8rcJ+D4wqD//nH8c61CMuF5wKh+Ul60zbff3111NhjZmUHAugqhyTVpxE
         n/gGakJBfidH6JXbTfUmZMM7Xa9XP4nn2wC3k9pbB+dbXVKdVLszA0qK5ZWHKmyjHE3D
         0vlNH1WmKDg5qGaQUrM0OGd2lX2CtWEcRPqtDWY8ZvESbK8ODEs8Po6sdwCSX0WltEUj
         ZElQ==
X-Received: by 10.194.92.148 with SMTP id cm20mr2397711wjb.57.1406126242774;
        Wed, 23 Jul 2014 07:37:22 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id ex4sm10196560wic.2.2014.07.23.07.37.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:37:22 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 08/10] MIPS: Alchemy: au1200fb: use clk framework
Date:   Wed, 23 Jul 2014 16:36:55 +0200
Message-Id: <1406126217-471265-9-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

minimal patch to replace direct clock register hackery with clock
framework calls.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/video/fbdev/au1200fb.c | 50 +++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 1c8e106..40494db 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -30,6 +30,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
@@ -330,9 +331,8 @@ struct panel_settings
 	uint32 mode_pwmhi;
 	uint32 mode_outmask;
 	uint32 mode_fifoctrl;
-	uint32 mode_toyclksrc;
 	uint32 mode_backlight;
-	uint32 mode_auxpll;
+	uint32 lcdclk;
 #define Xres min_xres
 #define Yres min_yres
 	u32	min_xres;		/* Minimum horizontal resolution */
@@ -379,9 +379,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x00000000,
 		.mode_outmask	= 0x00FFFFFF,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 8, /* 96MHz AUXPLL */
+		.lcdclk		= 96,
 		320, 320,
 		240, 240,
 	},
@@ -407,9 +406,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x00000000,
 		.mode_outmask	= 0x00FFFFFF,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 8, /* 96MHz AUXPLL */
+		.lcdclk		= 96,
 		640, 480,
 		640, 480,
 	},
@@ -435,9 +433,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x00000000,
 		.mode_outmask	= 0x00FFFFFF,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 8, /* 96MHz AUXPLL */
+		.lcdclk		= 96,
 		800, 800,
 		600, 600,
 	},
@@ -463,9 +460,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x00000000,
 		.mode_outmask	= 0x00FFFFFF,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 6, /* 72MHz AUXPLL */
+		.lcdclk		= 72,
 		1024, 1024,
 		768, 768,
 	},
@@ -491,9 +487,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x00000000,
 		.mode_outmask	= 0x00FFFFFF,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 10, /* 120MHz AUXPLL */
+		.lcdclk		= 120,
 		1280, 1280,
 		1024, 1024,
 	},
@@ -519,9 +514,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x03400000, /* SCB 0x0 */
 		.mode_outmask	= 0x00FFFFFF,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 8, /* 96MHz AUXPLL */
+		.lcdclk		= 96,
 		1024, 1024,
 		768, 768,
 	},
@@ -550,9 +544,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x03400000,
 		.mode_outmask	= 0x00fcfcfc,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 8, /* 96MHz AUXPLL */
+		.lcdclk		= 96,
 		640, 480,
 		640, 480,
 	},
@@ -581,9 +574,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x03400000,
 		.mode_outmask	= 0x00fcfcfc,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 8, /* 96MHz AUXPLL */
+		.lcdclk		= 96, /* 96MHz AUXPLL */
 		320, 320,
 		240, 240,
 	},
@@ -612,9 +604,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x03400000,
 		.mode_outmask	= 0x00fcfcfc,
 		.mode_fifoctrl	= 0x2f2f2f2f,
-		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
-		.mode_auxpll		= 8, /* 96MHz AUXPLL */
+		.lcdclk		= 96,
 		856, 856,
 		480, 480,
 	},
@@ -646,9 +637,8 @@ static struct panel_settings known_lcd_panels[] =
 		.mode_pwmhi		= 0x00000000,
 		.mode_outmask		= 0x00FFFFFF,
 		.mode_fifoctrl		= 0x2f2f2f2f,
-		.mode_toyclksrc		= 0x00000004, /* AUXPLL directly */
 		.mode_backlight		= 0x00000000,
-		.mode_auxpll		= (48/12) * 2,
+		.lcdclk			= 96,
 		800, 800,
 		480, 480,
 	},
@@ -828,11 +818,17 @@ static void au1200_setpanel(struct panel_settings *newpanel,
 	 */
 	if (!(panel->mode_clkcontrol & LCD_CLKCONTROL_EXT))
 	{
-		uint32 sys_clksrc;
-		alchemy_wrsys(panel->mode_auxpll, AU1000_SYS_AUXPLL);
-		sys_clksrc = alchemy_rdsys(AU1000_SYS_CLKSRC) & ~0x0000001f;
-		sys_clksrc |= panel->mode_toyclksrc;
-		alchemy_wrsys(sys_clksrc, AU1000_SYS_CLKSRC);
+		struct clk *c = clk_get(NULL, "lcd_intclk");
+		long r, pc = panel->lcdclk * 1000000;
+
+		if (!IS_ERR(c)) {
+			r = clk_round_rate(c, pc);
+			if ((pc - r) < (pc / 10)) {	/* 10% slack */
+				clk_set_rate(c, r);
+				clk_prepare_enable(c);
+			}
+			clk_put(c);
+		}
 	}
 
 	/*
-- 
2.0.1
