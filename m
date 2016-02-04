Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 17:41:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29580 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012696AbcBDQlDzHfmh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 17:41:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C68F891751F4E;
        Thu,  4 Feb 2016 16:40:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 16:40:58 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 16:40:57 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2] MIPS: Stop using dla in 32 bit kernels
Date:   Thu, 4 Feb 2016 16:40:37 +0000
Message-ID: <1454604037-17054-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.26]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51788
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

Avoid this by instead making use of the PTR_LA macro which defines the
appropriate variant of the "la" instruction to use. The .set <isa>
directive is then no longer needed for the la pseudo-instruction, but
needs to remain around the jr.hb for pre-MIPSr2 kernels.

Tested with Codescape GNU Tools 2015.06-05 for MIPS IMG Linux, which
includes binutils 2.24.90 & gcc 4.9.2.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- Leave .set <isa> around jr.hb.
- Describe how to reproduce in the commit message.

 arch/mips/include/asm/hazards.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 7b99efd..835c770 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -11,6 +11,7 @@
 #define _ASM_HAZARDS_H
 
 #include <linux/stringify.h>
+#include <asm/asm.h>
 #include <asm/compiler.h>
 
 #define ___ssnop							\
@@ -65,8 +66,8 @@ do {									\
 	unsigned long tmp;						\
 									\
 	__asm__ __volatile__(						\
+	"	" __stringify(PTR_LA) "	%0, 1f			\n"	\
 	"	.set "MIPS_ISA_LEVEL"				\n"	\
-	"	dla	%0, 1f					\n"	\
 	"	jr.hb	%0					\n"	\
 	"	.set	mips0					\n"	\
 	"1:							\n"	\
-- 
2.7.0
