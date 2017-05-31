Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 17:21:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24777 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993457AbdEaPUKBChQT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 17:20:10 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id EA5E168B1E096;
        Wed, 31 May 2017 16:19:58 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 May 2017 16:20:02 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 3/4] MIPS: Fix mips_atomic_set() with EVA
Date:   Wed, 31 May 2017 16:19:49 +0100
Message-ID: <59e14bb75b1fb34271dc3214edfbd9d01221f511.1496240182.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

EVA linked loads (LLE) and conditional stores (SCE) should be used on
EVA kernels for the MIPS_ATOMIC_SET operation of the sysmips system
call, or else the atomic set will apply to the kernel view of the
virtual address space (potentially unmapped on EVA kernels) rather than
the user view (TLB mapped).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15.x-
---
 arch/mips/kernel/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 3971220ea925..ca54ac40252b 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -29,6 +29,7 @@
 #include <linux/sched/task_stack.h>
 
 #include <asm/asm.h>
+#include <asm/asm-eva.h>
 #include <asm/branch.h>
 #include <asm/cachectl.h>
 #include <asm/cacheflush.h>
@@ -131,9 +132,11 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		__asm__ __volatile__ (
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"	li	%[err], 0				\n"
-		"1:	ll	%[old], (%[addr])			\n"
+		"1:							\n"
+		user_ll("%[old]", "(%[addr])")
 		"	move	%[tmp], %[new]				\n"
-		"2:	sc	%[tmp], (%[addr])			\n"
+		"2:							\n"
+		user_sc("%[tmp]", "(%[addr])")
 		"	beqz	%[tmp], 4f				\n"
 		"3:							\n"
 		"	.insn						\n"
-- 
git-series 0.8.10
