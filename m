Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 15:32:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19029 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011061AbcBDOcYFGvOK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 15:32:24 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id C25358DD9E755;
        Thu,  4 Feb 2016 14:32:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 14:32:17 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 14:32:16 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Stop using dla in 32 bit kernels
Date:   Thu, 4 Feb 2016 14:31:57 +0000
Message-ID: <1454596317-5042-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.26]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51775
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
that isn't sufficient to avoid warnings when built with -mabi=32, as
CONFIG_32BIT=y kernels are:

      CC      arch/mips/mm/c-r4k.o
    {standard input}: Assembler messages:
    {standard input}:4105: Warning: dla used to load 32-bit register;
        recommend using la instead
    {standard input}:4129: Warning: dla used to load 32-bit register;
        recommend using la instead

Avoid this by instead making use of the PTR_LA macro which defines the
appropriate variant of the "la" instruction to use.

Tested with Codescape GNU Tools 2015.06-05 for MIPS IMG Linux, which
includes binutils 2.24.90 & gcc 4.9.2.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/hazards.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 7b99efd..ffe2aaa 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -11,6 +11,7 @@
 #define _ASM_HAZARDS_H
 
 #include <linux/stringify.h>
+#include <asm/asm.h>
 #include <asm/compiler.h>
 
 #define ___ssnop							\
@@ -54,22 +55,16 @@
 
 /*
  * gcc has a tradition of misscompiling the previous construct using the
- * address of a label as argument to inline assembler.	Gas otoh has the
- * annoying difference between la and dla which are only usable for 32-bit
- * rsp. 64-bit code, so can't be used without conditional compilation.
- * The alterantive is switching the assembler to 64-bit code which happens
- * to work right even for 32-bit code ...
+ * address of a label as argument to inline assembler.
  */
 #define instruction_hazard()						\
 do {									\
 	unsigned long tmp;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set "MIPS_ISA_LEVEL"				\n"	\
-	"	dla	%0, 1f					\n"	\
-	"	jr.hb	%0					\n"	\
-	"	.set	mips0					\n"	\
-	"1:							\n"	\
+	__stringify(PTR_LA) "	%0, 1f\n\t"				\
+	"jr.hb	%0\n\t"							\
+	"1:"								\
 	: "=r" (tmp));							\
 } while (0)
 
-- 
2.7.0
