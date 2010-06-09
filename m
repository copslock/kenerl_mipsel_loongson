Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 13:22:20 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37212 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2097170Ab0FILVy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 13:21:54 +0200
Received: from faui49h (faui49h.informatik.uni-erlangen.de [131.188.42.58])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id DFB7B5F26E;
        Wed,  9 Jun 2010 13:21:52 +0200 (MEST)
Received: by faui49h (sSMTP sendmail emulation); Wed, 09 Jun 2010 13:21:53 +0200
Date:   Wed, 9 Jun 2010 13:21:53 +0200
From:   Christoph Egger <siccegge@cs.fau.de>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     vamos@i4.informatik.uni-erlangen.de
Subject: [PATCH 5/9] Removing dead CONFIG_BLK_DEV_IDE
Message-ID: <73e9e4bd7615488c9567f02f8962825386956365.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: siccegge@cs.fau.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6340

CONFIG_BLK_DEV_IDE doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/mips/mti-malta/malta-setup.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index b7f37d4..d85143c 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -105,28 +105,6 @@ static void __init fd_activate(void)
 }
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-static void __init pci_clock_check(void)
-{
-	unsigned int __iomem *jmpr_p =
-		(unsigned int *) ioremap(MALTA_JMPRS_REG, sizeof(unsigned int));
-	int jmpr = (__raw_readl(jmpr_p) >> 2) & 0x07;
-	static const int pciclocks[] __initdata = {
-		33, 20, 25, 30, 12, 16, 37, 10
-	};
-	int pciclock = pciclocks[jmpr];
-	char *argptr = prom_getcmdline();
-
-	if (pciclock != 33 && !strstr(argptr, "idebus=")) {
-		printk(KERN_WARNING "WARNING: PCI clock is %dMHz, "
-				"setting idebus\n", pciclock);
-		argptr += strlen(argptr);
-		sprintf(argptr, " idebus=%d", pciclock);
-		if (pciclock < 20 || pciclock > 66)
-			printk(KERN_WARNING "WARNING: IDE timing "
-					"calculations will be incorrect\n");
-	}
-}
 #endif
 
 #if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
@@ -207,9 +185,6 @@ void __init plat_mem_setup(void)
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
 		bonito_quirks_setup();
 
-#ifdef CONFIG_BLK_DEV_IDE
-	pci_clock_check();
-#endif
 
 #ifdef CONFIG_BLK_DEV_FD
 	fd_activate();
-- 
1.6.3.3
