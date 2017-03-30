Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 23:49:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46198 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992881AbdC3VtBkD6UH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 23:49:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 230729717356F;
        Thu, 30 Mar 2017 22:48:51 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Mar 2017 22:48:54
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3] MIPS: Avoid warnings from use of dla in 32 bit kernels
Date:   Thu, 30 Mar 2017 14:48:38 -0700
Message-ID: <20170330214838.5828-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The instruction_hazard macro made use of the dla pseudo-instruction even
for 32 bit kernels. Although it surrounded that use with ".set mips64rX"
that isn't sufficient to avoid warnings for MIPSr6 CONFIG_32BIT=y
kernels. For example this can be reproduced using maltasmvp_defconfig &
changing only the CPU type to 64r6 (CONFIG_CPU_MIPS64_R6):

      CC      arch/mips/mm/c-r4k.o
    {standard input}: Assembler messages:
    {standard input}:4105: Warning: dla used to load 32-bit register;
        recommend using la instead
    {standard input}:4129: Warning: dla used to load 32-bit register;
        recommend using la instead

One seemingly straightforward fix would be to make use of the PTR_LA
macro to emit the appropriate pseudo-instruction, however this would
involve including asm.h which is intended solely for inclusion in
assembly code. When included by C code its definition of various generic
& non-namespaced macros such as LONG, PTR, CAT etc cause numerous build
failures.

Instead fix this by adding a ".set gp=64" directive to inform the
assembler that general purpose registers are 64 bit for the dla
instruction. This is a lie, but no more so than using the dla
instruction to begin with.

Tested with Codescape GNU Tools 2016.05-01 for MIPS IMG Linux, which
includes binutils 2.24.90 & gcc 4.9.2.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

Changes in v3:
- Stop including asm.h, use dla & .set gp=64 instead.

Changes in v2:
- Leave .set <isa> around jr.hb.
- Describe how to reproduce in the commit message.

 arch/mips/include/asm/hazards.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index e0fecf206f2c..a3418d064ce1 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -66,10 +66,12 @@ do {									\
 	unsigned long tmp;						\
 									\
 	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
 	"	.set "MIPS_ISA_LEVEL"				\n"	\
+	"	.set	gp=64					\n"	\
 	"	dla	%0, 1f					\n"	\
 	"	jr.hb	%0					\n"	\
-	"	.set	mips0					\n"	\
+	"	.set	pop					\n"	\
 	"1:							\n"	\
 	: "=r" (tmp));							\
 } while (0)
-- 
2.12.1
