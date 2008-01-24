Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:56:10 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:63226 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037128AbYAXQxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:12 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 37F788FE21B;
	Thu, 24 Jan 2008 19:53:02 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id 1342B8FE0DC;
	Thu, 24 Jan 2008 19:53:02 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] [MIPS] Malta: fix oversized lines in malta_int.c
Date:	Thu, 24 Jan 2008 19:52:47 +0300
Message-Id: <1201193577-4261-8-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch fixes all "line over 80 characters" warnings found
in arch/mips/mips-boards/malta/malta_int.c by the checkpatch.pl
script.

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_int.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index 6d371f4..1b4b9c5 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -304,17 +304,25 @@ void __init arch_init_irq(void)
 	case MIPS_REVISION_SCON_SOCIT:
 	case MIPS_REVISION_SCON_ROCIT:
 		if (cpu_has_veic)
-			init_msc_irqs(MIPS_MSC01_IC_REG_BASE, MSC01E_INT_BASE, msc_eicirqmap, msc_nr_eicirqs);
+			init_msc_irqs(MIPS_MSC01_IC_REG_BASE,
+					MSC01E_INT_BASE, msc_eicirqmap,
+					msc_nr_eicirqs);
 		else
-			init_msc_irqs(MIPS_MSC01_IC_REG_BASE, MSC01C_INT_BASE, msc_irqmap, msc_nr_irqs);
+			init_msc_irqs(MIPS_MSC01_IC_REG_BASE,
+					MSC01C_INT_BASE, msc_irqmap,
+					msc_nr_irqs);
 		break;
 
 	case MIPS_REVISION_SCON_SOCITSC:
 	case MIPS_REVISION_SCON_SOCITSCP:
 		if (cpu_has_veic)
-			init_msc_irqs(MIPS_SOCITSC_IC_REG_BASE, MSC01E_INT_BASE, msc_eicirqmap, msc_nr_eicirqs);
+			init_msc_irqs(MIPS_SOCITSC_IC_REG_BASE,
+					MSC01E_INT_BASE, msc_eicirqmap,
+					msc_nr_eicirqs);
 		else
-			init_msc_irqs(MIPS_SOCITSC_IC_REG_BASE, MSC01C_INT_BASE, msc_irqmap, msc_nr_irqs);
+			init_msc_irqs(MIPS_SOCITSC_IC_REG_BASE,
+					MSC01C_INT_BASE, msc_irqmap,
+					msc_nr_irqs);
 	}
 
 	if (cpu_has_veic) {
@@ -345,11 +353,13 @@ void __init arch_init_irq(void)
 		}
 #else /* Not SMTC */
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_I8259A, &i8259irq);
-		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI, &corehi_irqaction);
+		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
+						&corehi_irqaction);
 #endif /* CONFIG_MIPS_MT_SMTC */
 	}
 	else {
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_I8259A, &i8259irq);
-		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI, &corehi_irqaction);
+		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
+						&corehi_irqaction);
 	}
 }
-- 
1.5.3
