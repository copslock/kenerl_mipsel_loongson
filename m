Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 10:40:43 +0100 (CET)
Received: from mail-gx0-f214.google.com ([209.85.217.214]:59628 "EHLO
        mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491920Ab0BBJki (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 10:40:38 +0100
Received: by gxk6 with SMTP id 6so3348784gxk.4
        for <multiple recipients>; Tue, 02 Feb 2010 01:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=m9U3v3ioI75SJB5EanVHqg8X6cmZLtZ3ruaspZH3f9E=;
        b=GPgWtv8g15I312YwMrdaZflA1fuKdLQNhdBo4S5PqVW+Zjy0x3CSFHYNlr/kiLCwV+
         YANoPs1R0/kITNayI4++N9FNTRpwqMuKaNZaI7pnYS4+LfzVfcRYbpDjxdyihpwcWJkW
         rL1Sx9e3Uv6/UdsQkabUnhKsjMhEemd4XnPx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Tsp9tMixh/i+k/+/HepxGIpJIcC4j4bFCrObiqdiAW+Lc/+bduvEG1Yut8/R6Y4mPA
         OIa0pkLp4lXY5OiHX4g9n/A5DU2yaacoIJ/jwUcg9qnb53J2sBbOX632XFdq0N6NrBzp
         Ru9nRisnLkIj+/h0o0/NO2Kud5pYr0lIhBXGE=
Received: by 10.101.164.26 with SMTP id r26mr4897056ano.162.1265103631170;
        Tue, 02 Feb 2010 01:40:31 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm3911012gxk.9.2010.02.02.01.40.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 01:40:28 -0800 (PST)
Date:   Tue, 2 Feb 2010 18:40:04 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] MIPS: txx9: remove forced serial console setting
Message-Id: <20100202184004.efdff568.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

It is not always used, even if it is available.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/txx9/generic.h |    1 -
 arch/mips/txx9/generic/setup.c       |    5 -----
 arch/mips/txx9/jmr3927/setup.c       |    7 -------
 arch/mips/txx9/rbtx4927/setup.c      |    7 -------
 arch/mips/txx9/rbtx4938/setup.c      |    6 ------
 5 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/arch/mips/include/asm/txx9/generic.h b/arch/mips/include/asm/txx9/generic.h
index 827dc22..64887d3 100644
--- a/arch/mips/include/asm/txx9/generic.h
+++ b/arch/mips/include/asm/txx9/generic.h
@@ -42,7 +42,6 @@ struct txx9_board_vec {
 };
 extern struct txx9_board_vec *txx9_board_vec;
 extern int (*txx9_irq_dispatch)(int pending);
-char *prom_getcmdline(void);
 const char *prom_getenv(const char *name);
 void txx9_wdt_init(unsigned long base);
 void txx9_wdt_now(unsigned long base);
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index e27809b..7174d83 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -399,11 +399,6 @@ const char *get_system_type(void)
 	return txx9_system_type;
 }
 
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
 const char *__init prom_getenv(const char *name)
 {
 	const s32 *str;
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 25e50a7..3206f76 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -67,8 +67,6 @@ static void jmr3927_board_init(void);
 
 static void __init jmr3927_mem_setup(void)
 {
-	char *argptr;
-
 	set_io_port_base(JMR3927_PORT_BASE + JMR3927_PCIIO);
 
 	_machine_restart = jmr3927_machine_restart;
@@ -97,11 +95,6 @@ static void __init jmr3927_mem_setup(void)
 	jmr3927_board_init();
 
 	tx3927_sio_init(0, 1 << 1); /* ch1: noCTS */
-#ifdef CONFIG_SERIAL_TXX9_CONSOLE
-	argptr = prom_getcmdline();
-	if (!strstr(argptr, "console="))
-		strcat(argptr, " console=ttyS1,115200");
-#endif
 }
 
 static void __init jmr3927_pci_setup(void)
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index ee468ea..b15adfc 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -187,8 +187,6 @@ static void __init rbtx4937_clock_init(void);
 
 static void __init rbtx4927_mem_setup(void)
 {
-	char *argptr;
-
 	if (TX4927_REV_PCODE() == 0x4927) {
 		rbtx4927_clock_init();
 		tx4927_setup();
@@ -213,11 +211,6 @@ static void __init rbtx4927_mem_setup(void)
 	gpio_direction_output(15, 1);
 
 	tx4927_sio_init(0, 0);
-#ifdef CONFIG_SERIAL_TXX9_CONSOLE
-	argptr = prom_getcmdline();
-	if (!strstr(argptr, "console="))
-		strcat(argptr, " console=ttyS0,38400");
-#endif
 }
 
 static void __init rbtx4927_clock_init(void)
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index d66509b..d6e70da 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -153,7 +153,6 @@ static void __init rbtx4938_time_init(void)
 static void __init rbtx4938_mem_setup(void)
 {
 	unsigned long long pcfg;
-	char *argptr;
 
 	if (txx9_master_clock == 0)
 		txx9_master_clock = 25000000; /* 25MHz */
@@ -168,11 +167,6 @@ static void __init rbtx4938_mem_setup(void)
 #endif
 
 	tx4938_sio_init(7372800, 0);
-#ifdef CONFIG_SERIAL_TXX9_CONSOLE
-	argptr = prom_getcmdline();
-	if (!strstr(argptr, "console="))
-		strcat(argptr, " console=ttyS0,38400");
-#endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
 	pr_info("PIOSEL: disabling both ATA and NAND selection\n");
-- 
1.6.6.1
