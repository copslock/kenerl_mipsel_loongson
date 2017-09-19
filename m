Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2017 15:11:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55450 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdISNLm1sXaD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2017 15:11:42 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1BA4661CC987;
        Tue, 19 Sep 2017 14:11:33 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 19 Sep 2017 14:11:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Fix input modify in __write_64bit_c0_split()
Date:   Tue, 19 Sep 2017 14:11:22 +0100
Message-ID: <20170919131122.23926-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60074
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

The inline asm in __write_64bit_c0_split() modifies the 64-bit input
operand by shifting the high register left by 32, and constructing the
full 64-bit value in the low register (even on a 32-bit kernel), so if
that value is used again it could cause breakage as GCC would assume the
registers haven't changed when they have.

To quote the GCC extended asm documentation:
> Warning: Do not modify the contents of input-only operands (except for
> inputs tied to outputs). The compiler assumes that on exit from the
> asm statement these operands contain the same values as they had
> before executing the statement.

Avoid modifying the input by using a temporary variable as an output
which is modified instead of the input and not otherwise used. The asm
is always __volatile__ so GCC shouldn't optimise it out. The low
register of the temporary output is written before the high register of
the input is read, so we have two constraint alternatives, one where
both use the same registers (for when the input value isn't subsequently
used), and one with an early clobber on the output in case the low
output uses the same register as the high input. This allows the
resulting assembly to remain mostly unchanged.

A diff of a MIPS32r6 kernel reveals only three differences, two in
relation to write_c0_r10k_diag() in cpu_probe() (register allocation
rearranged slightly but otherwise identical), and one in relation to
write_c0_cvmmemctl2() in kvm_vz_local_flush_guesttlb_all(), but the
octeon CPU is only supported on 64-bit kernels where
__write_64bit_c0_split() isn't used so that shouldn't matter in
practice. So there currently doesn't appear to be anything broken by
this bug.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e4ed1bc9a734..a6810923b3f0 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1377,29 +1377,32 @@ do {									\
 
 #define __write_64bit_c0_split(source, sel, val)			\
 do {									\
+	unsigned long long __tmp;					\
 	unsigned long __flags;						\
 									\
 	local_irq_save(__flags);					\
 	if (sel == 0)							\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
-			"dsll\t%L0, %L0, 32\n\t"			\
+			"dsll\t%L0, %L1, 32\n\t"			\
 			"dsrl\t%L0, %L0, 32\n\t"			\
-			"dsll\t%M0, %M0, 32\n\t"			\
+			"dsll\t%M0, %M1, 32\n\t"			\
 			"or\t%L0, %L0, %M0\n\t"				\
 			"dmtc0\t%L0, " #source "\n\t"			\
 			".set\tmips0"					\
-			: : "r" (val));					\
+			: "=&r,r" (__tmp)				\
+			: "r,0" (val));					\
 	else								\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
-			"dsll\t%L0, %L0, 32\n\t"			\
+			"dsll\t%L0, %L1, 32\n\t"			\
 			"dsrl\t%L0, %L0, 32\n\t"			\
-			"dsll\t%M0, %M0, 32\n\t"			\
+			"dsll\t%M0, %M1, 32\n\t"			\
 			"or\t%L0, %L0, %M0\n\t"				\
 			"dmtc0\t%L0, " #source ", " #sel "\n\t"		\
 			".set\tmips0"					\
-			: : "r" (val));					\
+			: "=&r,r" (__tmp)				\
+			: "r,0" (val));					\
 	local_irq_restore(__flags);					\
 } while (0)
 
-- 
2.14.1
