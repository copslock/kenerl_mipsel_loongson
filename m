Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 14:57:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16447 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008937AbaIPM5SdNdCj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 14:57:18 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A965164E45B34
        for <linux-mips@linux-mips.org>; Tue, 16 Sep 2014 13:57:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 16 Sep 2014 13:57:11 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 16 Sep 2014 13:57:10 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: idle: Remove leftover __pastwait symbol and its references
Date:   Tue, 16 Sep 2014 13:57:08 +0100
Message-ID: <1410872228-12116-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42652
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

The __pastwait symbol was only used by the address_is_in_r4k_wait_irqoff
function but this is no longer used since the SMTC removal in commit
b633648c5ad3 ('MIPS: MT: Remove SMTC support'). That symbol also led to
build failures under certain random configuration due to the way the
compiler compiled the r4k_wait_irqoff function. If that function was
called multiple times, the __pastwait symbol was redefined breaking the
build like this:

CHK     include/generated/compile.h
CC      arch/mips/kernel/idle.o
{standard input}: Assembler messages:
{standard input}:527: Error: symbol `__pastwait' is already defined

Link: http://www.linux-mips.org/archives/linux-mips/2009-06/msg00282.html
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/idle.h | 7 -------
 arch/mips/kernel/idle.c      | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/arch/mips/include/asm/idle.h b/arch/mips/include/asm/idle.h
index d9f932de80e9..1c967abd545c 100644
--- a/arch/mips/include/asm/idle.h
+++ b/arch/mips/include/asm/idle.h
@@ -8,19 +8,12 @@ extern void (*cpu_wait)(void);
 extern void r4k_wait(void);
 extern asmlinkage void __r4k_wait(void);
 extern void r4k_wait_irqoff(void);
-extern void __pastwait(void);
 
 static inline int using_rollback_handler(void)
 {
 	return cpu_wait == r4k_wait;
 }
 
-static inline int address_is_in_r4k_wait_irqoff(unsigned long addr)
-{
-	return addr >= (unsigned long)r4k_wait_irqoff &&
-	       addr < (unsigned long)__pastwait;
-}
-
 extern int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
 				   struct cpuidle_driver *drv, int index);
 
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 09ce45980758..0b9082b6b683 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -68,9 +68,6 @@ void r4k_wait_irqoff(void)
 		"	wait			\n"
 		"	.set	pop		\n");
 	local_irq_enable();
-	__asm__(
-	"	.globl __pastwait	\n"
-	"__pastwait:			\n");
 }
 
 /*
-- 
2.1.0
