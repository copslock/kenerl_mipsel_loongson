Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Oct 2009 16:04:17 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.145]:33897 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492670AbZJROEK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Oct 2009 16:04:10 +0200
Received: by ey-out-1920.google.com with SMTP id 13so661811eye.52
        for <multiple recipients>; Sun, 18 Oct 2009 07:04:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=wYUScjFvb8r5W/DoJvjAPiIgvZFf45h/j2ECx3VTfNA=;
        b=klf5PY7/0U6dRVqHm9YZahltrE9sjBCj/gtFmTsnaInWCxrp6J6fWMf0fPag506B08
         XND2cFn5PO0X+MN6EJiC1q1l/ZSQB20JWsDvIjsCzBsty2HdssO4gokZPIrVtOGYvqgz
         nB5MMcsEmKNhQN9b94WYYySZhh4aWkEXJqgBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=HAKSMEdwUOdNQOwH3AbNEbrTMg70OwJnedakrKQ2z0jKA99r4EdcPYA/YtQ5+lok2Z
         cnDsfBzNJrUhpi34Zmr0Y872JgMWq6a1dW0UEpBg13g4dXR3K6Rx00m/0JZ5e64x6A7y
         nmzfL+vXoaMNUe7j74m2W6gEEC8VZtRfwb+ks=
Received: by 10.211.128.15 with SMTP id f15mr4150735ebn.84.1255874649187;
        Sun, 18 Oct 2009 07:04:09 -0700 (PDT)
Received: from lenovo.localnet (147.59.76-86.rev.gaoland.net [86.76.59.147])
        by mx.google.com with ESMTPS id 10sm7006424eyz.35.2009.10.18.07.04.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Oct 2009 07:04:08 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 18 Oct 2009 16:04:09 +0200
Subject: [PATCH 1/2] alchemy: fix warnings in db1x00/pb1000/pb1550 board setup code
MIME-Version: 1.0
X-UID:	1451
X-Length: 3160
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200910181604.11732.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes warnings due to potentially unused
variables in board setup code or mixed variables
declaration and code (forbidden by ISO C90).

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 64eb26f..7aee14d 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -85,12 +85,14 @@ void board_reset(void)
 void __init board_setup(void)
 {
 	unsigned long bcsr1, bcsr2;
-	u32 pin_func = 0;
+	u32 pin_func;
 	char *argptr;
 
 	bcsr1 = DB1000_BCSR_PHYS_ADDR;
 	bcsr2 = DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS;
 
+	pin_func = 0;
+
 #ifdef CONFIG_MIPS_DB1000
 	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
 #endif
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index 287d661..50fff50 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -46,9 +46,13 @@ void __init board_setup(void)
 	u32 pin_func, static_cfg0;
 	u32 sys_freqctrl, sys_clksrc;
 	u32 prid = read_c0_prid();
+	char *argptr;
+
+	sys_freqctrl = 0;
+	sys_clksrc = 0;
+	argptr = prom_getcmdline();
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-	char *argptr = prom_getcmdline();
 	argptr = strstr(argptr, "console=");
 	if (argptr == NULL) {
 		argptr = prom_getcmdline();
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index bb41740..0d060c3 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -56,14 +56,13 @@ void board_reset(void)
 void __init board_setup(void)
 {
 	u32 pin_func;
+	char *argptr;
 
 	bcsr_init(PB1550_BCSR_PHYS_ADDR,
 		  PB1550_BCSR_PHYS_ADDR + PB1550_BCSR_HEXLED_OFS);
 
-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	char *argptr;
 	argptr = prom_getcmdline();
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 	argptr = strstr(argptr, "console=");
 	if (argptr == NULL) {
 		argptr = prom_getcmdline();
