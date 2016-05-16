Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 13:51:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43625 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014177AbcEPLvFo0RjU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2016 13:51:05 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 4FF903FBA2237;
        Mon, 16 May 2016 12:50:55 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 16 May 2016 12:50:58 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 16 May 2016 12:50:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Guenter Roeck <private@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Fix VZ probe gas errors with binutils <2.24
Date:   Mon, 16 May 2016 12:50:04 +0100
Message-ID: <1463399404-10978-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <57374216.10307@roeck-us.net>
References: <57374216.10307@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53455
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

The VZ guest register & TLB access macros introduced in commit "MIPS:
Add guest CP0 accessors" use VZ ASE specific instructions that aren't
understood by versions of binutils prior to 2.24.

Add a check for whether the toolchain supports the -mvirt option,
similar to the MSA toolchain check, and implement the accessors using
.word if not.

Due to difficulty in converting compiler specified registers (e.g. "$3")
to usable numbers (e.g. "3") in inline asm, we need to copy to/from a
temporary register, namely the assembler temporary (at/$1), and specify
guest CP0 registers numerically in the gc0 macros.

Fixes: 7eb91118227d ("MIPS: Add guest CP0 accessors")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Ralf: If it isn't too late, can this to be squashed into the "MIPS: Add
guest CP0 accessors" commit?
---
 arch/mips/Makefile               |   2 +
 arch/mips/include/asm/mipsregs.h | 475 ++++++++++++++++++++++++---------------
 2 files changed, 296 insertions(+), 181 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c0b002a09bef..efd7a9dc93c4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -200,6 +200,8 @@ ifeq ($(CONFIG_CPU_HAS_MSA),y)
 toolchain-msa				:= $(call cc-option-yn,$(mips-cflags) -mhard-float -mfp64 -Wa$(comma)-mmsa)
 cflags-$(toolchain-msa)			+= -DTOOLCHAIN_SUPPORTS_MSA
 endif
+toolchain-virt				:= $(call cc-option-yn,$(mips-cflags) -mvirt)
+cflags-$(toolchain-virt)		+= -DTOOLCHAIN_SUPPORTS_VIRT
 
 cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_NEVER)	+= -mcompact-branches=never
 cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_OPTIMAL)	+= -mcompact-branches=optimal
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 1019de6bb2a8..25d01577d0b5 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1683,15 +1683,18 @@ do {									\
  * Macros to access the guest system control coprocessor
  */
 
+#ifdef TOOLCHAIN_SUPPORTS_VIRT
+
 #define __read_32bit_gc0_register(source, sel)				\
 ({ int __res;								\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
 		".set\tmips32r2\n\t"					\
 		".set\tvirt\n\t"					\
-		"mfgc0\t%0, " #source ", " #sel "\n\t"			\
+		"mfgc0\t%0, $%1, %2\n\t"				\
 		".set\tpop"						\
-		: "=r" (__res));					\
+		: "=r" (__res)						\
+		: "i" (source), "i" (sel));				\
 	__res;								\
 })
 
@@ -1701,9 +1704,10 @@ do {									\
 		".set\tpush\n\t"					\
 		".set\tmips64r2\n\t"					\
 		".set\tvirt\n\t"					\
-		"dmfgc0\t%0, " #source ", " #sel "\n\t"			\
+		"dmfgc0\t%0, $%1, %2\n\t"			\
 		".set\tpop"						\
-		: "=r" (__res));					\
+		: "=r" (__res)						\
+		: "i" (source), "i" (sel));				\
 	__res;								\
 })
 
@@ -1713,9 +1717,10 @@ do {									\
 		".set\tpush\n\t"					\
 		".set\tmips32r2\n\t"					\
 		".set\tvirt\n\t"					\
-		"mtgc0\t%z0, " #register ", " #sel "\n\t"		\
+		"mtgc0\t%z0, $%1, %2\n\t"				\
 		".set\tpop"						\
-		: : "Jr" ((unsigned int)(value)));			\
+		: : "Jr" ((unsigned int)(value)),			\
+		    "i" (register), "i" (sel));				\
 } while (0)
 
 #define __write_64bit_gc0_register(register, sel, value)		\
@@ -1724,11 +1729,70 @@ do {									\
 		".set\tpush\n\t"					\
 		".set\tmips64r2\n\t"					\
 		".set\tvirt\n\t"					\
-		"dmtgc0\t%z0, " #register ", " #sel "\n\t"		\
+		"dmtgc0\t%z0, $%1, %2\n\t"				\
 		".set\tpop"						\
-		: : "Jr" (value));					\
+		: : "Jr" (value),					\
+		    "i" (register), "i" (sel));				\
 } while (0)
 
+#else	/* TOOLCHAIN_SUPPORTS_VIRT */
+
+#define __read_32bit_gc0_register(source, sel)				\
+({ int __res;								\
+	__asm__ __volatile__(						\
+		".set\tpush\n\t"					\
+		".set\tnoat\n\t"					\
+		"# mfgc0\t$1, $%1, %2\n\t"				\
+		".word\t(0x40610000 | %1 << 11 | %2)\n\t"		\
+		"move\t%0, $1\n\t"					\
+		".set\tpop"						\
+		: "=r" (__res)						\
+		: "i" (source), "i" (sel));				\
+	__res;								\
+})
+
+#define __read_64bit_gc0_register(source, sel)				\
+({ unsigned long long __res;						\
+	__asm__ __volatile__(						\
+		".set\tpush\n\t"					\
+		".set\tnoat\n\t"					\
+		"# dmfgc0\t$1, $%1, %2\n\t"				\
+		".word\t(0x40610100 | %1 << 11 | %2)\n\t"		\
+		"move\t%0, $1\n\t"					\
+		".set\tpop"						\
+		: "=r" (__res)						\
+		: "i" (source), "i" (sel));				\
+	__res;								\
+})
+
+#define __write_32bit_gc0_register(register, sel, value)		\
+do {									\
+	__asm__ __volatile__(						\
+		".set\tpush\n\t"					\
+		".set\tnoat\n\t"					\
+		"move\t$1, %0\n\t"					\
+		"# mtgc0\t$1, $%1, %2\n\t"				\
+		".word\t(0x40610200 | %1 << 11 | %2)\n\t"		\
+		".set\tpop"						\
+		: : "Jr" ((unsigned int)(value)),			\
+		    "i" (register), "i" (sel));				\
+} while (0)
+
+#define __write_64bit_gc0_register(register, sel, value)		\
+do {									\
+	__asm__ __volatile__(						\
+		".set\tpush\n\t"					\
+		".set\tnoat\n\t"					\
+		"move\t$1, %0\n\t"					\
+		"# dmtgc0\t$1, $%1, %2\n\t"				\
+		".word\t(0x40610300 | %1 << 11 | %2)\n\t"		\
+		".set\tpop"						\
+		: : "Jr" (value),					\
+		    "i" (register), "i" (sel));				\
+} while (0)
+
+#endif	/* !TOOLCHAIN_SUPPORTS_VIRT */
+
 #define __read_ulong_gc0_register(reg, sel)				\
 	((sizeof(unsigned long) == 4) ?					\
 	(unsigned long) __read_32bit_gc0_register(reg, sel) :		\
@@ -1742,189 +1806,189 @@ do {									\
 		__write_64bit_gc0_register(reg, sel, val);		\
 } while (0)
 
-#define read_gc0_index()		__read_32bit_gc0_register($0, 0)
-#define write_gc0_index(val)		__write_32bit_gc0_register($0, 0, val)
+#define read_gc0_index()		__read_32bit_gc0_register(0, 0)
+#define write_gc0_index(val)		__write_32bit_gc0_register(0, 0, val)
 
-#define read_gc0_entrylo0()		__read_ulong_gc0_register($2, 0)
-#define write_gc0_entrylo0(val)		__write_ulong_gc0_register($2, 0, val)
+#define read_gc0_entrylo0()		__read_ulong_gc0_register(2, 0)
+#define write_gc0_entrylo0(val)		__write_ulong_gc0_register(2, 0, val)
 
-#define read_gc0_entrylo1()		__read_ulong_gc0_register($3, 0)
-#define write_gc0_entrylo1(val)		__write_ulong_gc0_register($3, 0, val)
+#define read_gc0_entrylo1()		__read_ulong_gc0_register(3, 0)
+#define write_gc0_entrylo1(val)		__write_ulong_gc0_register(3, 0, val)
 
-#define read_gc0_context()		__read_ulong_gc0_register($4, 0)
-#define write_gc0_context(val)		__write_ulong_gc0_register($4, 0, val)
+#define read_gc0_context()		__read_ulong_gc0_register(4, 0)
+#define write_gc0_context(val)		__write_ulong_gc0_register(4, 0, val)
 
-#define read_gc0_contextconfig()	__read_32bit_gc0_register($4, 1)
-#define write_gc0_contextconfig(val)	__write_32bit_gc0_register($4, 1, val)
+#define read_gc0_contextconfig()	__read_32bit_gc0_register(4, 1)
+#define write_gc0_contextconfig(val)	__write_32bit_gc0_register(4, 1, val)
 
-#define read_gc0_userlocal()		__read_ulong_gc0_register($4, 2)
-#define write_gc0_userlocal(val)	__write_ulong_gc0_register($4, 2, val)
+#define read_gc0_userlocal()		__read_ulong_gc0_register(4, 2)
+#define write_gc0_userlocal(val)	__write_ulong_gc0_register(4, 2, val)
 
-#define read_gc0_xcontextconfig()	__read_ulong_gc0_register($4, 3)
-#define write_gc0_xcontextconfig(val)	__write_ulong_gc0_register($4, 3, val)
+#define read_gc0_xcontextconfig()	__read_ulong_gc0_register(4, 3)
+#define write_gc0_xcontextconfig(val)	__write_ulong_gc0_register(4, 3, val)
 
-#define read_gc0_pagemask()		__read_32bit_gc0_register($5, 0)
-#define write_gc0_pagemask(val)		__write_32bit_gc0_register($5, 0, val)
+#define read_gc0_pagemask()		__read_32bit_gc0_register(5, 0)
+#define write_gc0_pagemask(val)		__write_32bit_gc0_register(5, 0, val)
 
-#define read_gc0_pagegrain()		__read_32bit_gc0_register($5, 1)
-#define write_gc0_pagegrain(val)	__write_32bit_gc0_register($5, 1, val)
+#define read_gc0_pagegrain()		__read_32bit_gc0_register(5, 1)
+#define write_gc0_pagegrain(val)	__write_32bit_gc0_register(5, 1, val)
 
-#define read_gc0_segctl0()		__read_ulong_gc0_register($5, 2)
-#define write_gc0_segctl0(val)		__write_ulong_gc0_register($5, 2, val)
+#define read_gc0_segctl0()		__read_ulong_gc0_register(5, 2)
+#define write_gc0_segctl0(val)		__write_ulong_gc0_register(5, 2, val)
 
-#define read_gc0_segctl1()		__read_ulong_gc0_register($5, 3)
-#define write_gc0_segctl1(val)		__write_ulong_gc0_register($5, 3, val)
-
-#define read_gc0_segctl2()		__read_ulong_gc0_register($5, 4)
-#define write_gc0_segctl2(val)		__write_ulong_gc0_register($5, 4, val)
-
-#define read_gc0_pwbase()		__read_ulong_gc0_register($5, 5)
-#define write_gc0_pwbase(val)		__write_ulong_gc0_register($5, 5, val)
-
-#define read_gc0_pwfield()		__read_ulong_gc0_register($5, 6)
-#define write_gc0_pwfield(val)		__write_ulong_gc0_register($5, 6, val)
-
-#define read_gc0_pwsize()		__read_ulong_gc0_register($5, 7)
-#define write_gc0_pwsize(val)		__write_ulong_gc0_register($5, 7, val)
-
-#define read_gc0_wired()		__read_32bit_gc0_register($6, 0)
-#define write_gc0_wired(val)		__write_32bit_gc0_register($6, 0, val)
-
-#define read_gc0_pwctl()		__read_32bit_gc0_register($6, 6)
-#define write_gc0_pwctl(val)		__write_32bit_gc0_register($6, 6, val)
-
-#define read_gc0_hwrena()		__read_32bit_gc0_register($7, 0)
-#define write_gc0_hwrena(val)		__write_32bit_gc0_register($7, 0, val)
-
-#define read_gc0_badvaddr()		__read_ulong_gc0_register($8, 0)
-#define write_gc0_badvaddr(val)		__write_ulong_gc0_register($8, 0, val)
-
-#define read_gc0_badinstr()		__read_32bit_gc0_register($8, 1)
-#define write_gc0_badinstr(val)		__write_32bit_gc0_register($8, 1, val)
-
-#define read_gc0_badinstrp()		__read_32bit_gc0_register($8, 2)
-#define write_gc0_badinstrp(val)	__write_32bit_gc0_register($8, 2, val)
-
-#define read_gc0_count()		__read_32bit_gc0_register($9, 0)
-
-#define read_gc0_entryhi()		__read_ulong_gc0_register($10, 0)
-#define write_gc0_entryhi(val)		__write_ulong_gc0_register($10, 0, val)
-
-#define read_gc0_compare()		__read_32bit_gc0_register($11, 0)
-#define write_gc0_compare(val)		__write_32bit_gc0_register($11, 0, val)
-
-#define read_gc0_status()		__read_32bit_gc0_register($12, 0)
-#define write_gc0_status(val)		__write_32bit_gc0_register($12, 0, val)
-
-#define read_gc0_intctl()		__read_32bit_gc0_register($12, 1)
-#define write_gc0_intctl(val)		__write_32bit_gc0_register($12, 1, val)
-
-#define read_gc0_cause()		__read_32bit_gc0_register($13, 0)
-#define write_gc0_cause(val)		__write_32bit_gc0_register($13, 0, val)
-
-#define read_gc0_epc()			__read_ulong_gc0_register($14, 0)
-#define write_gc0_epc(val)		__write_ulong_gc0_register($14, 0, val)
-
-#define read_gc0_ebase()		__read_32bit_gc0_register($15, 1)
-#define write_gc0_ebase(val)		__write_32bit_gc0_register($15, 1, val)
-
-#define read_gc0_ebase_64()		__read_64bit_gc0_register($15, 1)
-#define write_gc0_ebase_64(val)		__write_64bit_gc0_register($15, 1, val)
-
-#define read_gc0_config()		__read_32bit_gc0_register($16, 0)
-#define read_gc0_config1()		__read_32bit_gc0_register($16, 1)
-#define read_gc0_config2()		__read_32bit_gc0_register($16, 2)
-#define read_gc0_config3()		__read_32bit_gc0_register($16, 3)
-#define read_gc0_config4()		__read_32bit_gc0_register($16, 4)
-#define read_gc0_config5()		__read_32bit_gc0_register($16, 5)
-#define read_gc0_config6()		__read_32bit_gc0_register($16, 6)
-#define read_gc0_config7()		__read_32bit_gc0_register($16, 7)
-#define write_gc0_config(val)		__write_32bit_gc0_register($16, 0, val)
-#define write_gc0_config1(val)		__write_32bit_gc0_register($16, 1, val)
-#define write_gc0_config2(val)		__write_32bit_gc0_register($16, 2, val)
-#define write_gc0_config3(val)		__write_32bit_gc0_register($16, 3, val)
-#define write_gc0_config4(val)		__write_32bit_gc0_register($16, 4, val)
-#define write_gc0_config5(val)		__write_32bit_gc0_register($16, 5, val)
-#define write_gc0_config6(val)		__write_32bit_gc0_register($16, 6, val)
-#define write_gc0_config7(val)		__write_32bit_gc0_register($16, 7, val)
-
-#define read_gc0_watchlo0()		__read_ulong_gc0_register($18, 0)
-#define read_gc0_watchlo1()		__read_ulong_gc0_register($18, 1)
-#define read_gc0_watchlo2()		__read_ulong_gc0_register($18, 2)
-#define read_gc0_watchlo3()		__read_ulong_gc0_register($18, 3)
-#define read_gc0_watchlo4()		__read_ulong_gc0_register($18, 4)
-#define read_gc0_watchlo5()		__read_ulong_gc0_register($18, 5)
-#define read_gc0_watchlo6()		__read_ulong_gc0_register($18, 6)
-#define read_gc0_watchlo7()		__read_ulong_gc0_register($18, 7)
-#define write_gc0_watchlo0(val)		__write_ulong_gc0_register($18, 0, val)
-#define write_gc0_watchlo1(val)		__write_ulong_gc0_register($18, 1, val)
-#define write_gc0_watchlo2(val)		__write_ulong_gc0_register($18, 2, val)
-#define write_gc0_watchlo3(val)		__write_ulong_gc0_register($18, 3, val)
-#define write_gc0_watchlo4(val)		__write_ulong_gc0_register($18, 4, val)
-#define write_gc0_watchlo5(val)		__write_ulong_gc0_register($18, 5, val)
-#define write_gc0_watchlo6(val)		__write_ulong_gc0_register($18, 6, val)
-#define write_gc0_watchlo7(val)		__write_ulong_gc0_register($18, 7, val)
-
-#define read_gc0_watchhi0()		__read_32bit_gc0_register($19, 0)
-#define read_gc0_watchhi1()		__read_32bit_gc0_register($19, 1)
-#define read_gc0_watchhi2()		__read_32bit_gc0_register($19, 2)
-#define read_gc0_watchhi3()		__read_32bit_gc0_register($19, 3)
-#define read_gc0_watchhi4()		__read_32bit_gc0_register($19, 4)
-#define read_gc0_watchhi5()		__read_32bit_gc0_register($19, 5)
-#define read_gc0_watchhi6()		__read_32bit_gc0_register($19, 6)
-#define read_gc0_watchhi7()		__read_32bit_gc0_register($19, 7)
-#define write_gc0_watchhi0(val)		__write_32bit_gc0_register($19, 0, val)
-#define write_gc0_watchhi1(val)		__write_32bit_gc0_register($19, 1, val)
-#define write_gc0_watchhi2(val)		__write_32bit_gc0_register($19, 2, val)
-#define write_gc0_watchhi3(val)		__write_32bit_gc0_register($19, 3, val)
-#define write_gc0_watchhi4(val)		__write_32bit_gc0_register($19, 4, val)
-#define write_gc0_watchhi5(val)		__write_32bit_gc0_register($19, 5, val)
-#define write_gc0_watchhi6(val)		__write_32bit_gc0_register($19, 6, val)
-#define write_gc0_watchhi7(val)		__write_32bit_gc0_register($19, 7, val)
-
-#define read_gc0_xcontext()		__read_ulong_gc0_register($20, 0)
-#define write_gc0_xcontext(val)		__write_ulong_gc0_register($20, 0, val)
-
-#define read_gc0_perfctrl0()		__read_32bit_gc0_register($25, 0)
-#define write_gc0_perfctrl0(val)	__write_32bit_gc0_register($25, 0, val)
-#define read_gc0_perfcntr0()		__read_32bit_gc0_register($25, 1)
-#define write_gc0_perfcntr0(val)	__write_32bit_gc0_register($25, 1, val)
-#define read_gc0_perfcntr0_64()		__read_64bit_gc0_register($25, 1)
-#define write_gc0_perfcntr0_64(val)	__write_64bit_gc0_register($25, 1, val)
-#define read_gc0_perfctrl1()		__read_32bit_gc0_register($25, 2)
-#define write_gc0_perfctrl1(val)	__write_32bit_gc0_register($25, 2, val)
-#define read_gc0_perfcntr1()		__read_32bit_gc0_register($25, 3)
-#define write_gc0_perfcntr1(val)	__write_32bit_gc0_register($25, 3, val)
-#define read_gc0_perfcntr1_64()		__read_64bit_gc0_register($25, 3)
-#define write_gc0_perfcntr1_64(val)	__write_64bit_gc0_register($25, 3, val)
-#define read_gc0_perfctrl2()		__read_32bit_gc0_register($25, 4)
-#define write_gc0_perfctrl2(val)	__write_32bit_gc0_register($25, 4, val)
-#define read_gc0_perfcntr2()		__read_32bit_gc0_register($25, 5)
-#define write_gc0_perfcntr2(val)	__write_32bit_gc0_register($25, 5, val)
-#define read_gc0_perfcntr2_64()		__read_64bit_gc0_register($25, 5)
-#define write_gc0_perfcntr2_64(val)	__write_64bit_gc0_register($25, 5, val)
-#define read_gc0_perfctrl3()		__read_32bit_gc0_register($25, 6)
-#define write_gc0_perfctrl3(val)	__write_32bit_gc0_register($25, 6, val)
-#define read_gc0_perfcntr3()		__read_32bit_gc0_register($25, 7)
-#define write_gc0_perfcntr3(val)	__write_32bit_gc0_register($25, 7, val)
-#define read_gc0_perfcntr3_64()		__read_64bit_gc0_register($25, 7)
-#define write_gc0_perfcntr3_64(val)	__write_64bit_gc0_register($25, 7, val)
-
-#define read_gc0_errorepc()		__read_ulong_gc0_register($30, 0)
-#define write_gc0_errorepc(val)		__write_ulong_gc0_register($30, 0, val)
-
-#define read_gc0_kscratch1()		__read_ulong_gc0_register($31, 2)
-#define read_gc0_kscratch2()		__read_ulong_gc0_register($31, 3)
-#define read_gc0_kscratch3()		__read_ulong_gc0_register($31, 4)
-#define read_gc0_kscratch4()		__read_ulong_gc0_register($31, 5)
-#define read_gc0_kscratch5()		__read_ulong_gc0_register($31, 6)
-#define read_gc0_kscratch6()		__read_ulong_gc0_register($31, 7)
-#define write_gc0_kscratch1(val)	__write_ulong_gc0_register($31, 2, val)
-#define write_gc0_kscratch2(val)	__write_ulong_gc0_register($31, 3, val)
-#define write_gc0_kscratch3(val)	__write_ulong_gc0_register($31, 4, val)
-#define write_gc0_kscratch4(val)	__write_ulong_gc0_register($31, 5, val)
-#define write_gc0_kscratch5(val)	__write_ulong_gc0_register($31, 6, val)
-#define write_gc0_kscratch6(val)	__write_ulong_gc0_register($31, 7, val)
+#define read_gc0_segctl1()		__read_ulong_gc0_register(5, 3)
+#define write_gc0_segctl1(val)		__write_ulong_gc0_register(5, 3, val)
+
+#define read_gc0_segctl2()		__read_ulong_gc0_register(5, 4)
+#define write_gc0_segctl2(val)		__write_ulong_gc0_register(5, 4, val)
+
+#define read_gc0_pwbase()		__read_ulong_gc0_register(5, 5)
+#define write_gc0_pwbase(val)		__write_ulong_gc0_register(5, 5, val)
+
+#define read_gc0_pwfield()		__read_ulong_gc0_register(5, 6)
+#define write_gc0_pwfield(val)		__write_ulong_gc0_register(5, 6, val)
+
+#define read_gc0_pwsize()		__read_ulong_gc0_register(5, 7)
+#define write_gc0_pwsize(val)		__write_ulong_gc0_register(5, 7, val)
+
+#define read_gc0_wired()		__read_32bit_gc0_register(6, 0)
+#define write_gc0_wired(val)		__write_32bit_gc0_register(6, 0, val)
+
+#define read_gc0_pwctl()		__read_32bit_gc0_register(6, 6)
+#define write_gc0_pwctl(val)		__write_32bit_gc0_register(6, 6, val)
+
+#define read_gc0_hwrena()		__read_32bit_gc0_register(7, 0)
+#define write_gc0_hwrena(val)		__write_32bit_gc0_register(7, 0, val)
+
+#define read_gc0_badvaddr()		__read_ulong_gc0_register(8, 0)
+#define write_gc0_badvaddr(val)		__write_ulong_gc0_register(8, 0, val)
+
+#define read_gc0_badinstr()		__read_32bit_gc0_register(8, 1)
+#define write_gc0_badinstr(val)		__write_32bit_gc0_register(8, 1, val)
+
+#define read_gc0_badinstrp()		__read_32bit_gc0_register(8, 2)
+#define write_gc0_badinstrp(val)	__write_32bit_gc0_register(8, 2, val)
+
+#define read_gc0_count()		__read_32bit_gc0_register(9, 0)
+
+#define read_gc0_entryhi()		__read_ulong_gc0_register(10, 0)
+#define write_gc0_entryhi(val)		__write_ulong_gc0_register(10, 0, val)
+
+#define read_gc0_compare()		__read_32bit_gc0_register(11, 0)
+#define write_gc0_compare(val)		__write_32bit_gc0_register(11, 0, val)
+
+#define read_gc0_status()		__read_32bit_gc0_register(12, 0)
+#define write_gc0_status(val)		__write_32bit_gc0_register(12, 0, val)
+
+#define read_gc0_intctl()		__read_32bit_gc0_register(12, 1)
+#define write_gc0_intctl(val)		__write_32bit_gc0_register(12, 1, val)
+
+#define read_gc0_cause()		__read_32bit_gc0_register(13, 0)
+#define write_gc0_cause(val)		__write_32bit_gc0_register(13, 0, val)
+
+#define read_gc0_epc()			__read_ulong_gc0_register(14, 0)
+#define write_gc0_epc(val)		__write_ulong_gc0_register(14, 0, val)
+
+#define read_gc0_ebase()		__read_32bit_gc0_register(15, 1)
+#define write_gc0_ebase(val)		__write_32bit_gc0_register(15, 1, val)
+
+#define read_gc0_ebase_64()		__read_64bit_gc0_register(15, 1)
+#define write_gc0_ebase_64(val)		__write_64bit_gc0_register(15, 1, val)
+
+#define read_gc0_config()		__read_32bit_gc0_register(16, 0)
+#define read_gc0_config1()		__read_32bit_gc0_register(16, 1)
+#define read_gc0_config2()		__read_32bit_gc0_register(16, 2)
+#define read_gc0_config3()		__read_32bit_gc0_register(16, 3)
+#define read_gc0_config4()		__read_32bit_gc0_register(16, 4)
+#define read_gc0_config5()		__read_32bit_gc0_register(16, 5)
+#define read_gc0_config6()		__read_32bit_gc0_register(16, 6)
+#define read_gc0_config7()		__read_32bit_gc0_register(16, 7)
+#define write_gc0_config(val)		__write_32bit_gc0_register(16, 0, val)
+#define write_gc0_config1(val)		__write_32bit_gc0_register(16, 1, val)
+#define write_gc0_config2(val)		__write_32bit_gc0_register(16, 2, val)
+#define write_gc0_config3(val)		__write_32bit_gc0_register(16, 3, val)
+#define write_gc0_config4(val)		__write_32bit_gc0_register(16, 4, val)
+#define write_gc0_config5(val)		__write_32bit_gc0_register(16, 5, val)
+#define write_gc0_config6(val)		__write_32bit_gc0_register(16, 6, val)
+#define write_gc0_config7(val)		__write_32bit_gc0_register(16, 7, val)
+
+#define read_gc0_watchlo0()		__read_ulong_gc0_register(18, 0)
+#define read_gc0_watchlo1()		__read_ulong_gc0_register(18, 1)
+#define read_gc0_watchlo2()		__read_ulong_gc0_register(18, 2)
+#define read_gc0_watchlo3()		__read_ulong_gc0_register(18, 3)
+#define read_gc0_watchlo4()		__read_ulong_gc0_register(18, 4)
+#define read_gc0_watchlo5()		__read_ulong_gc0_register(18, 5)
+#define read_gc0_watchlo6()		__read_ulong_gc0_register(18, 6)
+#define read_gc0_watchlo7()		__read_ulong_gc0_register(18, 7)
+#define write_gc0_watchlo0(val)		__write_ulong_gc0_register(18, 0, val)
+#define write_gc0_watchlo1(val)		__write_ulong_gc0_register(18, 1, val)
+#define write_gc0_watchlo2(val)		__write_ulong_gc0_register(18, 2, val)
+#define write_gc0_watchlo3(val)		__write_ulong_gc0_register(18, 3, val)
+#define write_gc0_watchlo4(val)		__write_ulong_gc0_register(18, 4, val)
+#define write_gc0_watchlo5(val)		__write_ulong_gc0_register(18, 5, val)
+#define write_gc0_watchlo6(val)		__write_ulong_gc0_register(18, 6, val)
+#define write_gc0_watchlo7(val)		__write_ulong_gc0_register(18, 7, val)
+
+#define read_gc0_watchhi0()		__read_32bit_gc0_register(19, 0)
+#define read_gc0_watchhi1()		__read_32bit_gc0_register(19, 1)
+#define read_gc0_watchhi2()		__read_32bit_gc0_register(19, 2)
+#define read_gc0_watchhi3()		__read_32bit_gc0_register(19, 3)
+#define read_gc0_watchhi4()		__read_32bit_gc0_register(19, 4)
+#define read_gc0_watchhi5()		__read_32bit_gc0_register(19, 5)
+#define read_gc0_watchhi6()		__read_32bit_gc0_register(19, 6)
+#define read_gc0_watchhi7()		__read_32bit_gc0_register(19, 7)
+#define write_gc0_watchhi0(val)		__write_32bit_gc0_register(19, 0, val)
+#define write_gc0_watchhi1(val)		__write_32bit_gc0_register(19, 1, val)
+#define write_gc0_watchhi2(val)		__write_32bit_gc0_register(19, 2, val)
+#define write_gc0_watchhi3(val)		__write_32bit_gc0_register(19, 3, val)
+#define write_gc0_watchhi4(val)		__write_32bit_gc0_register(19, 4, val)
+#define write_gc0_watchhi5(val)		__write_32bit_gc0_register(19, 5, val)
+#define write_gc0_watchhi6(val)		__write_32bit_gc0_register(19, 6, val)
+#define write_gc0_watchhi7(val)		__write_32bit_gc0_register(19, 7, val)
+
+#define read_gc0_xcontext()		__read_ulong_gc0_register(20, 0)
+#define write_gc0_xcontext(val)		__write_ulong_gc0_register(20, 0, val)
+
+#define read_gc0_perfctrl0()		__read_32bit_gc0_register(25, 0)
+#define write_gc0_perfctrl0(val)	__write_32bit_gc0_register(25, 0, val)
+#define read_gc0_perfcntr0()		__read_32bit_gc0_register(25, 1)
+#define write_gc0_perfcntr0(val)	__write_32bit_gc0_register(25, 1, val)
+#define read_gc0_perfcntr0_64()		__read_64bit_gc0_register(25, 1)
+#define write_gc0_perfcntr0_64(val)	__write_64bit_gc0_register(25, 1, val)
+#define read_gc0_perfctrl1()		__read_32bit_gc0_register(25, 2)
+#define write_gc0_perfctrl1(val)	__write_32bit_gc0_register(25, 2, val)
+#define read_gc0_perfcntr1()		__read_32bit_gc0_register(25, 3)
+#define write_gc0_perfcntr1(val)	__write_32bit_gc0_register(25, 3, val)
+#define read_gc0_perfcntr1_64()		__read_64bit_gc0_register(25, 3)
+#define write_gc0_perfcntr1_64(val)	__write_64bit_gc0_register(25, 3, val)
+#define read_gc0_perfctrl2()		__read_32bit_gc0_register(25, 4)
+#define write_gc0_perfctrl2(val)	__write_32bit_gc0_register(25, 4, val)
+#define read_gc0_perfcntr2()		__read_32bit_gc0_register(25, 5)
+#define write_gc0_perfcntr2(val)	__write_32bit_gc0_register(25, 5, val)
+#define read_gc0_perfcntr2_64()		__read_64bit_gc0_register(25, 5)
+#define write_gc0_perfcntr2_64(val)	__write_64bit_gc0_register(25, 5, val)
+#define read_gc0_perfctrl3()		__read_32bit_gc0_register(25, 6)
+#define write_gc0_perfctrl3(val)	__write_32bit_gc0_register(25, 6, val)
+#define read_gc0_perfcntr3()		__read_32bit_gc0_register(25, 7)
+#define write_gc0_perfcntr3(val)	__write_32bit_gc0_register(25, 7, val)
+#define read_gc0_perfcntr3_64()		__read_64bit_gc0_register(25, 7)
+#define write_gc0_perfcntr3_64(val)	__write_64bit_gc0_register(25, 7, val)
+
+#define read_gc0_errorepc()		__read_ulong_gc0_register(30, 0)
+#define write_gc0_errorepc(val)		__write_ulong_gc0_register(30, 0, val)
+
+#define read_gc0_kscratch1()		__read_ulong_gc0_register(31, 2)
+#define read_gc0_kscratch2()		__read_ulong_gc0_register(31, 3)
+#define read_gc0_kscratch3()		__read_ulong_gc0_register(31, 4)
+#define read_gc0_kscratch4()		__read_ulong_gc0_register(31, 5)
+#define read_gc0_kscratch5()		__read_ulong_gc0_register(31, 6)
+#define read_gc0_kscratch6()		__read_ulong_gc0_register(31, 7)
+#define write_gc0_kscratch1(val)	__write_ulong_gc0_register(31, 2, val)
+#define write_gc0_kscratch2(val)	__write_ulong_gc0_register(31, 3, val)
+#define write_gc0_kscratch3(val)	__write_ulong_gc0_register(31, 4, val)
+#define write_gc0_kscratch4(val)	__write_ulong_gc0_register(31, 5, val)
+#define write_gc0_kscratch5(val)	__write_ulong_gc0_register(31, 6, val)
+#define write_gc0_kscratch6(val)	__write_ulong_gc0_register(31, 7, val)
 
 /*
  * Macros to access the floating point coprocessor control registers
@@ -2421,6 +2485,8 @@ static inline void tlb_write_random(void)
 		".set reorder");
 }
 
+#ifdef TOOLCHAIN_SUPPORTS_VIRT
+
 /*
  * Guest TLB operations.
  *
@@ -2479,6 +2545,53 @@ static inline void guest_tlbinvf(void)
 		".set pop");
 }
 
+#else	/* TOOLCHAIN_SUPPORTS_VIRT */
+
+/*
+ * Guest TLB operations.
+ *
+ * It is responsibility of the caller to take care of any TLB hazards.
+ */
+static inline void guest_tlb_probe(void)
+{
+	__asm__ __volatile__(
+		"# tlbgp\n\t"
+		".word 0x42000010");
+}
+
+static inline void guest_tlb_read(void)
+{
+	__asm__ __volatile__(
+		"# tlbgr\n\t"
+		".word 0x42000009");
+}
+
+static inline void guest_tlb_write_indexed(void)
+{
+	__asm__ __volatile__(
+		"# tlbgwi\n\t"
+		".word 0x4200000a");
+}
+
+static inline void guest_tlb_write_random(void)
+{
+	__asm__ __volatile__(
+		"# tlbgwr\n\t"
+		".word 0x4200000e");
+}
+
+/*
+ * Guest TLB Invalidate Flush
+ */
+static inline void guest_tlbinvf(void)
+{
+	__asm__ __volatile__(
+		"# tlbginvf\n\t"
+		".word 0x4200000c");
+}
+
+#endif	/* !TOOLCHAIN_SUPPORTS_VIRT */
+
 /*
  * Manipulate bits in a register.
  */
-- 
2.4.10
