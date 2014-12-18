Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:15:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51792 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009159AbaLRPLsaX7Vf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9C780665E7971
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:39 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:42 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:42 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 16/67] MIPS: asm: irqflags: Add MIPS R6 related definitions
Date:   Thu, 18 Dec 2014 15:09:25 +0000
Message-ID: <1418915416-3196-17-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add the MIPS R6 related definitions to the IRQ related macros

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/irqflags.h | 6 +++---
 arch/mips/lib/mips-atomic.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 0fa5fdcd1f01..204b4de56f2a 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -17,7 +17,7 @@
 #include <linux/stringify.h>
 #include <asm/hazards.h>
 
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined (CONFIG_CPU_MIPSR6)
 
 static inline void arch_local_irq_disable(void)
 {
@@ -118,7 +118,7 @@ void arch_local_irq_disable(void);
 unsigned long arch_local_irq_save(void);
 void arch_local_irq_restore(unsigned long flags);
 void __arch_local_irq_restore(unsigned long flags);
-#endif /* CONFIG_CPU_MIPSR2 */
+#endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 
 static inline void arch_local_irq_enable(void)
 {
@@ -126,7 +126,7 @@ static inline void arch_local_irq_enable(void)
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
-#if   defined(CONFIG_CPU_MIPSR2)
+#if   defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	"	ei							\n"
 #else
 	"	mfc0	$1,$12						\n"
diff --git a/arch/mips/lib/mips-atomic.c b/arch/mips/lib/mips-atomic.c
index 57bcdaf1f1c8..8071422f2831 100644
--- a/arch/mips/lib/mips-atomic.c
+++ b/arch/mips/lib/mips-atomic.c
@@ -15,7 +15,7 @@
 #include <linux/export.h>
 #include <linux/stringify.h>
 
-#ifndef CONFIG_CPU_MIPSR2
+#if !defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_CPU_MIPSR6)
 
 /*
  * For cli() we have to insert nops to make sure that the new value
-- 
2.2.0
