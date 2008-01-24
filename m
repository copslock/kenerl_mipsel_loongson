Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:59:08 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:65018 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037144AbYAXQxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:12 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id E60D98FEAF7;
	Thu, 24 Jan 2008 19:53:02 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id C7B8D8FEA74;
	Thu, 24 Jan 2008 19:53:02 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] [MIPS] Malta: else should follow close brace in malta_int.c
Date:	Thu, 24 Jan 2008 19:52:51 +0300
Message-Id: <1201193577-4261-12-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch fixes two errors reported by checkpatch.pl.

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_int.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index a268912..2473a77 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -329,8 +329,7 @@ void __init arch_init_irq(void)
 		set_vi_handler(MSC01E_INT_COREHI, corehi_irqdispatch);
 		setup_irq(MSC01E_INT_BASE+MSC01E_INT_I8259A, &i8259irq);
 		setup_irq(MSC01E_INT_BASE+MSC01E_INT_COREHI, &corehi_irqaction);
-	}
-	else if (cpu_has_vint) {
+	} else if (cpu_has_vint) {
 		set_vi_handler(MIPSCPU_INT_I8259A, malta_hw0_irqdispatch);
 		set_vi_handler(MIPSCPU_INT_COREHI, corehi_irqdispatch);
 #ifdef CONFIG_MIPS_MT_SMTC
@@ -355,8 +354,7 @@ void __init arch_init_irq(void)
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
 						&corehi_irqaction);
 #endif /* CONFIG_MIPS_MT_SMTC */
-	}
-	else {
+	} else {
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_I8259A, &i8259irq);
 		setup_irq(MIPS_CPU_IRQ_BASE+MIPSCPU_INT_COREHI,
 						&corehi_irqaction);
-- 
1.5.3
