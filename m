Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 10:43:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40799 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991172AbdGJInlDL0rM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2017 10:43:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B9375C50002F9;
        Mon, 10 Jul 2017 09:43:32 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 10 Jul 2017 09:43:34 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        "Jason A. Donenfeld" <jason@zx2c4.com>
Subject: [PATCH v2] MIPS: Fix minimum alignment requirement of IRQ stack
Date:   Mon, 10 Jul 2017 09:43:31 +0100
Message-ID: <1499676211-20141-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59078
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
minimum alignment. Fix IRQ_STACK_START such that it leaves space for the
dummy stack frame (containing interrupted task kernel stack pointer)
while also meeting minimum alignment requirements.

Fixes: db8466c581cc ("MIPS: IRQ Stack: Unwind IRQ stack onto task stack")
Reported-by: Darius Ivanauskas <dasilt@yahoo.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2:
Don't include asm/asm.h since the definitions in it lead to breakage
when it pollutes the C namespace (thanks kbuild test robot!)

 arch/mips/include/asm/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index ddd1c918103b..c5d351786416 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -18,7 +18,7 @@
 #include <irq.h>
 
 #define IRQ_STACK_SIZE			THREAD_SIZE
-#define IRQ_STACK_START			(IRQ_STACK_SIZE - sizeof(unsigned long))
+#define IRQ_STACK_START			(IRQ_STACK_SIZE - 16)
 
 extern void *irq_stack[NR_CPUS];
 
-- 
2.7.4
