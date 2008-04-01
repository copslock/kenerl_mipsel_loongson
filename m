Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 15:49:48 +0200 (CEST)
Received: from [157.159.40.25] ([157.159.40.25]:12692 "EHLO mx1.minet.net")
	by lappi.linux-mips.net with ESMTP id S1101510AbYDANtf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 15:49:35 +0200
Received: from localhost (spam.minet.net [192.168.1.97])
	by mx1.minet.net (Postfix) with ESMTP id 26B7260CFA;
	Tue,  1 Apr 2008 15:49:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using ClamAV at minet.net
Received: from smtp.minet.net (imap.minet.net [192.168.1.27])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.minet.net (Postfix) with ESMTP id E758A60CFB;
	Tue,  1 Apr 2008 15:49:14 +0200 (CEST)
Received: from ibook (mla78-1-82-240-17-188.fbx.proxad.net [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: florian)
	by smtp.minet.net (Postfix) with ESMTP id 866C215B59;
	Tue,  1 Apr 2008 15:48:33 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Tue, 1 Apr 2008 15:53:25 +0200
Subject: [PATCH] Fix xss1500 compilation
MIME-Version: 1.0
X-UID:	946
X-Length: 1931
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, Adrian Bunk <bunk@kernel.org>
Content-Disposition: inline
Message-Id: <200804011553.25850.florian.fainelli@telecomint.eu>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This patch fixes the compilation of the Au1000 XSS1500
board setup and irqmap code.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
diff --git a/arch/mips/au1000/xxs1500/board_setup.c 
b/arch/mips/au1000/xxs1500/board_setup.c
index a9237f4..b2e413e 100644
--- a/arch/mips/au1000/xxs1500/board_setup.c
+++ b/arch/mips/au1000/xxs1500/board_setup.c
@@ -33,11 +33,10 @@
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
-#include <asm/keyboard.h>
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
 #include <asm/pgtable.h>
-#include <asm/au1000.h>
+#include <asm/mach-au1x00/au1000.h>
 
 void board_reset(void)
 {
diff --git a/arch/mips/au1000/xxs1500/irqmap.c 
b/arch/mips/au1000/xxs1500/irqmap.c
index 3893492..a343da1 100644
--- a/arch/mips/au1000/xxs1500/irqmap.c
+++ b/arch/mips/au1000/xxs1500/irqmap.c
@@ -45,7 +45,7 @@
 #include <asm/io.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
-#include <asm/au1000.h>
+#include <asm/mach-au1x00/au1000.h>
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0},
