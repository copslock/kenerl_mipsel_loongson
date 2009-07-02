Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:51:15 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:39588 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492025AbZGBCsx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:48:53 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622hBWe016354
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:43:11 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:43:10 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622hAYg006014;
	Wed, 1 Jul 2009 19:43:10 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 12/15] Added coherentio command line option for
	DMA_NONCOHERENT kernel
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:42:45 -0700
Message-ID: <20090702024244.23268.41013.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:43:10.0693 (UTC) FILETIME=[D68AF150:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman (chris@mips.com)
---

 arch/mips/mti-malta/malta-setup.c |  100 +++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 69f5f9c..3f52c31 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -32,6 +32,7 @@
 #include <asm/mips-boards/maltaint.h>
 #include <asm/dma.h>
 #include <asm/traps.h>
+#include <asm/gcmpregs.h>
 #ifdef CONFIG_VT
 #include <linux/console.h>
 #endif
@@ -105,6 +106,103 @@ static void __init fd_activate(void)
 }
 #endif
 
+int coherentio = -1;
+static int __init setcoherentio(char *str)
+{
+	if (coherentio < 0)
+		pr_info("Command line checking done before"
+				" plat_setup_iocoherency!!\n");
+	if (coherentio == 0)
+		pr_info("Command line enabling coherentio"
+				" (this will break...)!!\n");
+
+	coherentio = 1;
+	pr_info("Hardware DMA cache coherency (command line)\n");
+	return 1;
+}
+__setup("coherentio", setcoherentio);
+
+static int __init setnocoherentio(char *str)
+{
+	if (coherentio < 0)
+		pr_info("Command line checking done before"
+				" plat_setup_iocoherency!!\n");
+	if (coherentio == 1)
+		pr_info("Command line disabling coherentio\n");
+
+	coherentio = 0;
+	pr_info("Software DMA cache coherency (command line)\n");
+	return 1;
+}
+__setup("nocoherentio", setnocoherentio);
+
+static int __init
+plat_enable_iocoherency(void)
+{
+	int supported = 0;
+	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
+		if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
+			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
+			pr_info("Enabled Bonito CPU coherency\n");
+			supported = 1;
+		}
+		if (strstr(prom_getcmdline(), "iobcuncached")) {
+			BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
+			BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
+				~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
+				  BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
+			pr_info("Disabled Bonito IOBC coherency\n");
+		} else {
+			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
+			BONITO_PCIMEMBASECFG |=
+				(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
+				 BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
+			pr_info("Enabled Bonito IOBC coherency\n");
+		}
+	} else if (gcmp_niocu() != 0) {
+		/* Nothing special needs to be done to enable coherency */
+		pr_info("CMP IOCU detected\n");
+		if ((*(unsigned int *)0xbf403000 & 0x81) != 0x81) {
+			pr_crit("IOCU OPERATION DISABLED BY SWITCH"
+				" - DEFAULTING TO SW IO COHERENCY\n");
+			return 0;
+		}
+		supported = 1;
+	}
+	return supported;
+}
+
+static void __init
+plat_setup_iocoherency(void)
+{
+#ifdef CONFIG_DMA_NONCOHERENT
+	/*
+	 * Kernel has been configured with software coherency
+	 * but we might choose to turn it off
+	 */
+	if (plat_enable_iocoherency()) {
+		if (coherentio == 0)
+			pr_info("Hardware DMA cache coherency supported"
+					" but disabled from command line\n");
+		else {
+			coherentio = 1;
+			printk(KERN_INFO "Hardware DMA cache coherency\n");
+		}
+	} else {
+		if (coherentio == 1)
+			pr_info("Hardware DMA cache coherency not supported"
+				" but enabled from command line\n");
+		else {
+			coherentio = 0;
+			pr_info("Software DMA cache coherency\n");
+		}
+	}
+#else
+	if (!plat_enable_iocoherency())
+		panic("Hardware DMA cache coherency not supported");
+#endif
+}
+
 #ifdef CONFIG_BLK_DEV_IDE
 static void __init pci_clock_check(void)
 {
@@ -207,6 +305,8 @@ void __init plat_mem_setup(void)
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
 		bonito_quirks_setup();
 
+	plat_setup_iocoherency();
+
 #ifdef CONFIG_BLK_DEV_IDE
 	pci_clock_check();
 #endif
