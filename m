Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 16:57:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23477 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993941AbdGGO50sZnTb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 16:57:26 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 60B0A377A8507;
        Fri,  7 Jul 2017 15:57:17 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 7 Jul 2017 15:57:20 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        <linux-kernel@vger.kernel.org>, Aaron Tomlin <atomlin@redhat.com>,
        "Jason A. Donenfeld" <jason@zx2c4.com>
Subject: [PATCH] MIPS: Fix minimum alignment requirement of IRQ stack
Date:   Fri, 7 Jul 2017 15:57:12 +0100
Message-ID: <1499439432-29847-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Commit db8466c581cc ("MIPS: IRQ Stack: Unwind IRQ stack onto task
stack") erroneously set the initial stack pointer of the IRQ stack to a
value with a 4 byte alignment. The MIPS32 ABI requires that the minimum
stack alignment is 8 byte, and the MIPS64 ABIs(n32/n64) require 16 byte
minimum alignment. Use the ALMASK stack pointer mask to align the stack
as appropriate for the kernel build.

Fixes: db8466c581cc ("MIPS: IRQ Stack: Unwind IRQ stack onto task stack")
Reported-by: Darius Ivanauskas <dasilt@yahoo.com>
Suggested-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/include/asm/irq.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index ddd1c918103b..ac66a2de091a 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_IRQ_H
 #define _ASM_IRQ_H
 
+#include <asm/asm.h>
 #include <linux/linkage.h>
 #include <linux/smp.h>
 #include <linux/irqdomain.h>
@@ -17,8 +18,8 @@
 
 #include <irq.h>
 
-#define IRQ_STACK_SIZE			THREAD_SIZE
-#define IRQ_STACK_START			(IRQ_STACK_SIZE - sizeof(unsigned long))
+#define IRQ_STACK_SIZE	THREAD_SIZE
+#define IRQ_STACK_START	((IRQ_STACK_SIZE - sizeof(unsigned long)) & ALMASK)
 
 extern void *irq_stack[NR_CPUS];
 
-- 
2.7.4
