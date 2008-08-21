Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 23:15:47 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:43972 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28586967AbYHUWPC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 23:15:02 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 2FF2BFE2E23;
	Fri, 22 Aug 2008 00:14:59 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 4CB263F00B0;
	Fri, 22 Aug 2008 00:14:40 +0200 (CEST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 2408F90004;
	Fri, 22 Aug 2008 00:14:40 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 22 Aug 2008 00:14:38 +0200
Subject: [PATCH 3/6] rb532: do not KSEG1ADDR an already virtual address
MIME-Version: 1.0
X-UID:	1119
X-Length: 1611
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808220014.39030.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 4CB263F00B0.A2A49
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch removes the superfluous double KSEG1ADDR
against the base register in the setup code.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/setup.c b/arch/mips/rb532/setup.c
index 7aafa95..6d3286e 100644
--- a/arch/mips/rb532/setup.c
+++ b/arch/mips/rb532/setup.c
@@ -10,6 +10,7 @@
 #include <linux/ioport.h>
 
 #include <asm/mach-rc32434/rc32434.h>
+#include <asm/mach-rc32434/rb.h>
 #include <asm/mach-rc32434/pci.h>
 
 struct pci_reg __iomem *pci_reg;
@@ -27,7 +28,7 @@ static struct resource pci0_res[] = {
 static void rb_machine_restart(char *command)
 {
 	/* just jump to the reset vector */
-	writel(0x80000001, (void *)KSEG1ADDR(RC32434_REG_BASE + RC32434_RST));
+	writel(0x80000001, (void *)KSEG1ADDR(REG_BASE + RC32434_RST));
 	((void (*)(void)) KSEG1ADDR(0x1FC00000u))();
 }
