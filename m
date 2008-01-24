Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:54:39 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:49658 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037135AbYAXQxH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:07 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 6D4158FCB8B;
	Thu, 24 Jan 2008 19:53:01 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id 4A3D48FC859;
	Thu, 24 Jan 2008 19:53:01 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] [MIPS] Malta: check the PCI clock frequency in a separate function
Date:	Thu, 24 Jan 2008 19:52:43 +0300
Message-Id: <1201193577-4261-4-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds a separate short and sweet function to check the
PCI clock frequency. This is to improve readability of the Malta
setup code.

Along the way, a couple of coding style violations are fixed.

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_setup.c |   43 +++++++++++++++++------------
 1 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index d051405..79d74ea 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -108,6 +108,30 @@ void __init fd_activate(void)
 }
 #endif
 
+#ifdef CONFIG_BLK_DEV_IDE
+static void __init pci_clock_check(void)
+{
+	unsigned int __iomem *jmpr_p =
+		(unsigned int *) ioremap(MALTA_JMPRS_REG, sizeof(unsigned int));
+	int jmpr = (__raw_readl(jmpr_p) >> 2) & 0x07;
+	static const int pciclocks[] __initdata = {
+		33, 20, 25, 30, 12, 16, 37, 10
+	};
+	int pciclock = pciclocks[jmpr];
+	char *argptr = prom_getcmdline();
+
+	if (pciclock != 33 && !strstr(argptr, "idebus=")) {
+		printk(KERN_WARNING "WARNING: PCI clock is %dMHz, "
+				"setting idebus\n", pciclock);
+		argptr += strlen(argptr);
+		sprintf(argptr, " idebus=%d", pciclock);
+		if (pciclock < 20 || pciclock > 66)
+			printk(KERN_WARNING "WARNING: IDE timing "
+					"calculations will be incorrect\n");
+	}
+}
+#endif
+
 void __init plat_mem_setup(void)
 {
 	unsigned int i;
@@ -171,24 +195,7 @@ void __init plat_mem_setup(void)
 #endif
 
 #ifdef CONFIG_BLK_DEV_IDE
-	/* Check PCI clock */
-	{
-		unsigned int __iomem *jmpr_p = (unsigned int *) ioremap(MALTA_JMPRS_REG, sizeof(unsigned int));
-		int jmpr = (__raw_readl(jmpr_p) >> 2) & 0x07;
-		static const int pciclocks[] __initdata = {
-			33, 20, 25, 30, 12, 16, 37, 10
-		};
-		int pciclock = pciclocks[jmpr];
-		char *argptr = prom_getcmdline();
-
-		if (pciclock != 33 && !strstr (argptr, "idebus=")) {
-			printk("WARNING: PCI clock is %dMHz, setting idebus\n", pciclock);
-			argptr += strlen(argptr);
-			sprintf(argptr, " idebus=%d", pciclock);
-			if (pciclock < 20 || pciclock > 66)
-				printk("WARNING: IDE timing calculations will be incorrect\n");
-		}
-	}
+	pci_clock_check();
 #endif
 #ifdef CONFIG_BLK_DEV_FD
 	fd_activate();
-- 
1.5.3
