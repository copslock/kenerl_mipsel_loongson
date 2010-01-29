Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 09:50:30 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:44119 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491133Ab0A2IuX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2010 09:50:23 +0100
Received: by ywh41 with SMTP id 41so322094ywh.0
        for <multiple recipients>; Fri, 29 Jan 2010 00:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ih2TmTcBxNc8drpcP3YKXA5bGmx/hA7qPDUMqgvndX4=;
        b=FDymfi14x5XyCBka9+vL3Xstr+hEL2Z6FKTWe1T4D4ObX3FlFlqJ3m9sAzVsE6TUAI
         0ieo9R/CVnSjv37kh0rc7XSrNOQO2jM49tsw55E0UehlpPBT1nDR+6/PkDbyPg5gfP1a
         wmg8o7U2aOk9KwPkBcqDHNHHA3hgUYsNqQlbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=CHppIZte+IgIiXlbCidq6i2U+lu0XUy0Me6A6odQA69ce/2qOg0AKRnJZto7w4ij6R
         9jVjyMXQd2umyVBKMoi0hNJ/dIJAb4CUXKSmOo4bFpOA1YZ/BC3hceqsMy7e5sh8Gnf8
         JX7CZmoF9akxXX/lKJ3LIwgk1je2EYIiIu1kg=
Received: by 10.91.51.1 with SMTP id d1mr763764agk.41.1264755016498;
        Fri, 29 Jan 2010 00:50:16 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm1123724gxk.1.2010.01.29.00.50.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 00:50:16 -0800 (PST)
Date:   Fri, 29 Jan 2010 17:49:52 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue] MIPS: Alchemy: remove forced command line setting
Message-Id: <20100129174952.6656d6a9.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18682

It is not always used, even if it is available.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   25 ----------------------
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   10 --------
 arch/mips/alchemy/devboards/pb1100/board_setup.c |   25 ----------------------
 arch/mips/alchemy/devboards/pb1200/board_setup.c |   14 ------------
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   16 --------------
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   10 --------
 arch/mips/alchemy/mtx-1/board_setup.c            |   10 --------
 arch/mips/alchemy/xxs1500/board_setup.c          |   10 --------
 8 files changed, 0 insertions(+), 120 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 56c541d..559d9b2 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -125,7 +125,6 @@ void __init board_setup(void)
 {
 	unsigned long bcsr1, bcsr2;
 	u32 pin_func;
-	char *argptr;
 
 	bcsr1 = DB1000_BCSR_PHYS_ADDR;
 	bcsr2 = DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS;
@@ -159,30 +158,6 @@ void __init board_setup(void)
 	/* initialize board register space */
 	bcsr_init(bcsr1, bcsr2);
 
-	argptr = prom_getcmdline();
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-
-#ifdef CONFIG_FB_AU1100
-	argptr = strstr(argptr, "video=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		/* default panel */
-		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
-	}
-#endif
-
-#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
-	/* au1000 does not support vra, au1500 and au1100 do */
-	strcat(argptr, " au1000_audio=vra");
-	argptr = prom_getcmdline();
-#endif
-
 	/* Not valid for Au1550 */
 #if defined(CONFIG_IRDA) && \
    (defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100))
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index 28b8bd2..b5311d8 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -47,19 +47,9 @@ void __init board_setup(void)
 	u32 pin_func, static_cfg0;
 	u32 sys_freqctrl, sys_clksrc;
 	u32 prid = read_c0_prid();
-	char *argptr;
 
 	sys_freqctrl = 0;
 	sys_clksrc = 0;
-	argptr = prom_getcmdline();
-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
 
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index e0bd855..c7b4caa 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -47,35 +47,10 @@ void board_reset(void)
 void __init board_setup(void)
 {
 	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
-	char *argptr;
 
 	bcsr_init(DB1000_BCSR_PHYS_ADDR,
 		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
 
-	argptr = prom_getcmdline();
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-
-#ifdef CONFIG_FB_AU1100
-	argptr = strstr(argptr, "video=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		/* default panel */
-		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
-	}
-#endif
-
-#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
-	/* au1000 does not support vra, au1500 and au1100 do */
-	strcat(argptr, " au1000_audio=vra");
-	argptr = prom_getcmdline();
-#endif
-
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
 	alchemy_gpio1_input_enable();
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index 2cf59e7..3184063 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -56,24 +56,10 @@ void board_reset(void)
 
 void __init board_setup(void)
 {
-	char *argptr;
-
 	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
 	bcsr_init(PB1200_BCSR_PHYS_ADDR,
 		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
 
-	argptr = prom_getcmdline();
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-#ifdef CONFIG_FB_AU1200
-	strcat(argptr, " video=au1200fb:panel:bs");
-#endif
-
 #if 0
 	{
 		u32 pin_func;
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index 3f0c92c..fa9770a 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -54,26 +54,10 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 	u32 sys_freqctrl, sys_clksrc;
-	char *argptr;
 
 	bcsr_init(DB1000_BCSR_PHYS_ADDR,
 		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
 
-	argptr = prom_getcmdline();
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-
-#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
-	/* au1000 does not support vra, au1500 and au1100 do */
-	strcat(argptr, " au1000_audio=vra");
-	argptr = prom_getcmdline();
-#endif
-
 	sys_clksrc = sys_freqctrl = pin_func = 0;
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index 0d060c3..1e8fb3d 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -56,20 +56,10 @@ void board_reset(void)
 void __init board_setup(void)
 {
 	u32 pin_func;
-	char *argptr;
 
 	bcsr_init(PB1550_BCSR_PHYS_ADDR,
 		  PB1550_BCSR_PHYS_ADDR + PB1550_BCSR_HEXLED_OFS);
 
-	argptr = prom_getcmdline();
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-
 	alchemy_gpio2_enable();
 
 	/*
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index e2838c6..a9f0336 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -67,16 +67,6 @@ static void mtx1_power_off(void)
 
 void __init board_setup(void)
 {
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	char *argptr;
-	argptr = prom_getcmdline();
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-
 	alchemy_gpio2_enable();
 
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index 7956afa..47b4292 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -51,16 +51,6 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	char *argptr;
-	argptr = prom_getcmdline();
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-
 	pm_power_off = xxs1500_power_off;
 	_machine_halt = xxs1500_power_off;
 	_machine_restart = xxs1500_reset;
-- 
1.6.6.1
