Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:54:09 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:48634 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037123AbYAXQxG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:06 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 411318FC199;
	Thu, 24 Jan 2008 19:53:01 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id 1BA1C8F0430;
	Thu, 24 Jan 2008 19:53:01 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] [MIPS] Malta: use the KERN_ facility level in printk()
Date:	Thu, 24 Jan 2008 19:52:42 +0300
Message-Id: <1201193577-4261-3-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds the KERN_ macros to printk() calls. Where applicable,
spaces are replaced by tabs.

These changes noticeably reduce the number of errors and warnings
reported by the checkpatch.pl script for the malta_int.c file.

Before the patch: total: 47 errors, 20 warnings, 354 lines checked

After the patch: total: 34 errors, 7 warnings, 355 lines checked

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_int.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index f010261..2483b40 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -83,7 +83,7 @@ static inline int mips_pcibios_iack(void)
 		BONITO_PCIMAP_CFG = 0;
 		break;
 	default:
-	        printk("Unknown system controller.\n");
+		printk(KERN_WARNING "Unknown system controller.\n");
 		return -1;
 	}
 	return irq;
@@ -127,8 +127,8 @@ static void corehi_irqdispatch(void)
 	unsigned int intrcause, datalo, datahi;
 	struct pt_regs *regs = get_irq_regs();
 
-        printk("CoreHI interrupt, shouldn't happen, so we die here!!!\n");
-        printk("epc   : %08lx\nStatus: %08lx\n"
+	printk(KERN_EMERG "CoreHI interrupt, shouldn't happen, we die here!\n");
+	printk(KERN_EMERG "epc   : %08lx\nStatus: %08lx\n"
 	       "Cause : %08lx\nbadVaddr : %08lx\n",
 	       regs->cp0_epc, regs->cp0_status,
 	       regs->cp0_cause, regs->cp0_badvaddr);
@@ -149,8 +149,9 @@ static void corehi_irqdispatch(void)
                 intrcause = GT_READ(GT_INTRCAUSE_OFS);
                 datalo = GT_READ(GT_CPUERR_ADDRLO_OFS);
                 datahi = GT_READ(GT_CPUERR_ADDRHI_OFS);
-                printk("GT_INTRCAUSE = %08x\n", intrcause);
-                printk("GT_CPUERR_ADDR = %02x%08x\n", datahi, datalo);
+		printk(KERN_EMERG "GT_INTRCAUSE = %08x\n", intrcause);
+		printk(KERN_EMERG "GT_CPUERR_ADDR = %02x%08x\n",
+				datahi, datalo);
                 break;
         case MIPS_REVISION_SCON_BONITO:
                 pcibadaddr = BONITO_PCIBADADDR;
@@ -161,14 +162,14 @@ static void corehi_irqdispatch(void)
                 intedge = BONITO_INTEDGE;
                 intsteer = BONITO_INTSTEER;
                 pcicmd = BONITO_PCICMD;
-                printk("BONITO_INTISR = %08x\n", intisr);
-                printk("BONITO_INTEN = %08x\n", inten);
-                printk("BONITO_INTPOL = %08x\n", intpol);
-                printk("BONITO_INTEDGE = %08x\n", intedge);
-                printk("BONITO_INTSTEER = %08x\n", intsteer);
-                printk("BONITO_PCICMD = %08x\n", pcicmd);
-                printk("BONITO_PCIBADADDR = %08x\n", pcibadaddr);
-                printk("BONITO_PCIMSTAT = %08x\n", pcimstat);
+		printk(KERN_EMERG "BONITO_INTISR = %08x\n", intisr);
+		printk(KERN_EMERG "BONITO_INTEN = %08x\n", inten);
+		printk(KERN_EMERG "BONITO_INTPOL = %08x\n", intpol);
+		printk(KERN_EMERG "BONITO_INTEDGE = %08x\n", intedge);
+		printk(KERN_EMERG "BONITO_INTSTEER = %08x\n", intsteer);
+		printk(KERN_EMERG "BONITO_PCICMD = %08x\n", pcicmd);
+		printk(KERN_EMERG "BONITO_PCIBADADDR = %08x\n", pcibadaddr);
+		printk(KERN_EMERG "BONITO_PCIMSTAT = %08x\n", pcimstat);
                 break;
         }
 
-- 
1.5.3
