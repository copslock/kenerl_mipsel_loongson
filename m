Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 12:32:52 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:57671 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990426AbdKVLbiP0PX8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 12:31:38 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 22 Nov 2017 11:31:32 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 22 Nov 2017 03:30:54 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/7] MIPS: VZ: Pass GC0 register names in $n format
Date:   Wed, 22 Nov 2017 11:30:29 +0000
Message-ID: <e7c8632d7bf6b5b881de429c5dadead71132ac6b.1511349998.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
References: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511350286-298552-755-64361-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 4.30
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187190
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        2.50 BSF_SC0_MV0735         META: custom rule MV0735 
        1.80 BSF_SC0_MV0735_3       META:  
X-BESS-Outbound-Spam-Status: SCORE=4.30 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MV0735, BSF_SC0_MV0735_3
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

Now that we are using assembler macros to implement VZ instructions on
toolchains which don't support them, pass VZ guest Cop0 register names
to the __{read,write}_{32bit,ulong,64bit}_gc0_register macros in $n
format rather than register numbers. This is to make them consistent
with the normal root Cop0 register access macros which they were
originally based on.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 376 ++++++++++++++++----------------
 1 file changed, 188 insertions(+), 188 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 361c35243366..000530b18f2e 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1947,10 +1947,10 @@ _ASM_MACRO_0(tlbginvf, _ASM_INSN_IF_MIPS(0x4200000c)
 		".set\tpush\n\t"					\
 		".set\tmips32r2\n\t"					\
 		_ASM_SET_VIRT						\
-		"mfgc0\t%0, $%1, %2\n\t"				\
+		"mfgc0\t%0, " #source ", %1\n\t"			\
 		".set\tpop"						\
 		: "=r" (__res)						\
-		: "i" (source), "i" (sel));				\
+		: "i" (sel));						\
 	__res;								\
 })
 
@@ -1960,10 +1960,10 @@ _ASM_MACRO_0(tlbginvf, _ASM_INSN_IF_MIPS(0x4200000c)
 		".set\tpush\n\t"					\
 		".set\tmips64r2\n\t"					\
 		_ASM_SET_VIRT						\
-		"dmfgc0\t%0, $%1, %2\n\t"				\
+		"dmfgc0\t%0, " #source ", %1\n\t"			\
 		".set\tpop"						\
 		: "=r" (__res)						\
-		: "i" (source), "i" (sel));				\
+		: "i" (sel));						\
 	__res;								\
 })
 
@@ -1973,10 +1973,10 @@ do {									\
 		".set\tpush\n\t"					\
 		".set\tmips32r2\n\t"					\
 		_ASM_SET_VIRT						\
-		"mtgc0\t%z0, $%1, %2\n\t"				\
+		"mtgc0\t%z0, " #register ", %1\n\t"			\
 		".set\tpop"						\
 		: : "Jr" ((unsigned int)(value)),			\
-		    "i" (register), "i" (sel));				\
+		    "i" (sel));						\
 } while (0)
 
 #define __write_64bit_gc0_register(register, sel, value)		\
@@ -1985,10 +1985,10 @@ do {									\
 		".set\tpush\n\t"					\
 		".set\tmips64r2\n\t"					\
 		_ASM_SET_VIRT						\
-		"dmtgc0\t%z0, $%1, %2\n\t"				\
+		"dmtgc0\t%z0, " #register ", %1\n\t"			\
 		".set\tpop"						\
 		: : "Jr" (value),					\
-		    "i" (register), "i" (sel));				\
+		    "i" (sel));						\
 } while (0)
 
 #define __read_ulong_gc0_register(reg, sel)				\
@@ -2004,207 +2004,207 @@ do {									\
 		__write_64bit_gc0_register(reg, sel, val);		\
 } while (0)
 
-#define read_gc0_index()		__read_32bit_gc0_register(0, 0)
-#define write_gc0_index(val)		__write_32bit_gc0_register(0, 0, val)
+#define read_gc0_index()		__read_32bit_gc0_register($0, 0)
+#define write_gc0_index(val)		__write_32bit_gc0_register($0, 0, val)
 
-#define read_gc0_entrylo0()		__read_ulong_gc0_register(2, 0)
-#define write_gc0_entrylo0(val)		__write_ulong_gc0_register(2, 0, val)
+#define read_gc0_entrylo0()		__read_ulong_gc0_register($2, 0)
+#define write_gc0_entrylo0(val)		__write_ulong_gc0_register($2, 0, val)
 
-#define read_gc0_entrylo1()		__read_ulong_gc0_register(3, 0)
-#define write_gc0_entrylo1(val)		__write_ulong_gc0_register(3, 0, val)
+#define read_gc0_entrylo1()		__read_ulong_gc0_register($3, 0)
+#define write_gc0_entrylo1(val)		__write_ulong_gc0_register($3, 0, val)
 
-#define read_gc0_context()		__read_ulong_gc0_register(4, 0)
-#define write_gc0_context(val)		__write_ulong_gc0_register(4, 0, val)
+#define read_gc0_context()		__read_ulong_gc0_register($4, 0)
+#define write_gc0_context(val)		__write_ulong_gc0_register($4, 0, val)
 
-#define read_gc0_contextconfig()	__read_32bit_gc0_register(4, 1)
-#define write_gc0_contextconfig(val)	__write_32bit_gc0_register(4, 1, val)
+#define read_gc0_contextconfig()	__read_32bit_gc0_register($4, 1)
+#define write_gc0_contextconfig(val)	__write_32bit_gc0_register($4, 1, val)
 
-#define read_gc0_userlocal()		__read_ulong_gc0_register(4, 2)
-#define write_gc0_userlocal(val)	__write_ulong_gc0_register(4, 2, val)
+#define read_gc0_userlocal()		__read_ulong_gc0_register($4, 2)
+#define write_gc0_userlocal(val)	__write_ulong_gc0_register($4, 2, val)
 
-#define read_gc0_xcontextconfig()	__read_ulong_gc0_register(4, 3)
-#define write_gc0_xcontextconfig(val)	__write_ulong_gc0_register(4, 3, val)
+#define read_gc0_xcontextconfig()	__read_ulong_gc0_register($4, 3)
+#define write_gc0_xcontextconfig(val)	__write_ulong_gc0_register($4, 3, val)
 
-#define read_gc0_pagemask()		__read_32bit_gc0_register(5, 0)
-#define write_gc0_pagemask(val)		__write_32bit_gc0_register(5, 0, val)
+#define read_gc0_pagemask()		__read_32bit_gc0_register($5, 0)
+#define write_gc0_pagemask(val)		__write_32bit_gc0_register($5, 0, val)
 
-#define read_gc0_pagegrain()		__read_32bit_gc0_register(5, 1)
-#define write_gc0_pagegrain(val)	__write_32bit_gc0_register(5, 1, val)
+#define read_gc0_pagegrain()		__read_32bit_gc0_register($5, 1)
+#define write_gc0_pagegrain(val)	__write_32bit_gc0_register($5, 1, val)
 
-#define read_gc0_segctl0()		__read_ulong_gc0_register(5, 2)
-#define write_gc0_segctl0(val)		__write_ulong_gc0_register(5, 2, val)
+#define read_gc0_segctl0()		__read_ulong_gc0_register($5, 2)
+#define write_gc0_segctl0(val)		__write_ulong_gc0_register($5, 2, val)
 
-#define read_gc0_segctl1()		__read_ulong_gc0_register(5, 3)
-#define write_gc0_segctl1(val)		__write_ulong_gc0_register(5, 3, val)
+#define read_gc0_segctl1()		__read_ulong_gc0_register($5, 3)
+#define write_gc0_segctl1(val)		__write_ulong_gc0_register($5, 3, val)
 
-#define read_gc0_segctl2()		__read_ulong_gc0_register(5, 4)
-#define write_gc0_segctl2(val)		__write_ulong_gc0_register(5, 4, val)
+#define read_gc0_segctl2()		__read_ulong_gc0_register($5, 4)
+#define write_gc0_segctl2(val)		__write_ulong_gc0_register($5, 4, val)
 
-#define read_gc0_pwbase()		__read_ulong_gc0_register(5, 5)
-#define write_gc0_pwbase(val)		__write_ulong_gc0_register(5, 5, val)
+#define read_gc0_pwbase()		__read_ulong_gc0_register($5, 5)
+#define write_gc0_pwbase(val)		__write_ulong_gc0_register($5, 5, val)
 
-#define read_gc0_pwfield()		__read_ulong_gc0_register(5, 6)
-#define write_gc0_pwfield(val)		__write_ulong_gc0_register(5, 6, val)
+#define read_gc0_pwfield()		__read_ulong_gc0_register($5, 6)
+#define write_gc0_pwfield(val)		__write_ulong_gc0_register($5, 6, val)
 
-#define read_gc0_pwsize()		__read_ulong_gc0_register(5, 7)
-#define write_gc0_pwsize(val)		__write_ulong_gc0_register(5, 7, val)
+#define read_gc0_pwsize()		__read_ulong_gc0_register($5, 7)
+#define write_gc0_pwsize(val)		__write_ulong_gc0_register($5, 7, val)
 
-#define read_gc0_wired()		__read_32bit_gc0_register(6, 0)
-#define write_gc0_wired(val)		__write_32bit_gc0_register(6, 0, val)
+#define read_gc0_wired()		__read_32bit_gc0_register($6, 0)
+#define write_gc0_wired(val)		__write_32bit_gc0_register($6, 0, val)
 
-#define read_gc0_pwctl()		__read_32bit_gc0_register(6, 6)
-#define write_gc0_pwctl(val)		__write_32bit_gc0_register(6, 6, val)
-
-#define read_gc0_hwrena()		__read_32bit_gc0_register(7, 0)
-#define write_gc0_hwrena(val)		__write_32bit_gc0_register(7, 0, val)
-
-#define read_gc0_badvaddr()		__read_ulong_gc0_register(8, 0)
-#define write_gc0_badvaddr(val)		__write_ulong_gc0_register(8, 0, val)
-
-#define read_gc0_badinstr()		__read_32bit_gc0_register(8, 1)
-#define write_gc0_badinstr(val)		__write_32bit_gc0_register(8, 1, val)
-
-#define read_gc0_badinstrp()		__read_32bit_gc0_register(8, 2)
-#define write_gc0_badinstrp(val)	__write_32bit_gc0_register(8, 2, val)
-
-#define read_gc0_count()		__read_32bit_gc0_register(9, 0)
-
-#define read_gc0_entryhi()		__read_ulong_gc0_register(10, 0)
-#define write_gc0_entryhi(val)		__write_ulong_gc0_register(10, 0, val)
-
-#define read_gc0_compare()		__read_32bit_gc0_register(11, 0)
-#define write_gc0_compare(val)		__write_32bit_gc0_register(11, 0, val)
-
-#define read_gc0_status()		__read_32bit_gc0_register(12, 0)
-#define write_gc0_status(val)		__write_32bit_gc0_register(12, 0, val)
-
-#define read_gc0_intctl()		__read_32bit_gc0_register(12, 1)
-#define write_gc0_intctl(val)		__write_32bit_gc0_register(12, 1, val)
-
-#define read_gc0_cause()		__read_32bit_gc0_register(13, 0)
-#define write_gc0_cause(val)		__write_32bit_gc0_register(13, 0, val)
-
-#define read_gc0_epc()			__read_ulong_gc0_register(14, 0)
-#define write_gc0_epc(val)		__write_ulong_gc0_register(14, 0, val)
-
-#define read_gc0_prid()			__read_32bit_gc0_register(15, 0)
-
-#define read_gc0_ebase()		__read_32bit_gc0_register(15, 1)
-#define write_gc0_ebase(val)		__write_32bit_gc0_register(15, 1, val)
-
-#define read_gc0_ebase_64()		__read_64bit_gc0_register(15, 1)
-#define write_gc0_ebase_64(val)		__write_64bit_gc0_register(15, 1, val)
-
-#define read_gc0_config()		__read_32bit_gc0_register(16, 0)
-#define read_gc0_config1()		__read_32bit_gc0_register(16, 1)
-#define read_gc0_config2()		__read_32bit_gc0_register(16, 2)
-#define read_gc0_config3()		__read_32bit_gc0_register(16, 3)
-#define read_gc0_config4()		__read_32bit_gc0_register(16, 4)
-#define read_gc0_config5()		__read_32bit_gc0_register(16, 5)
-#define read_gc0_config6()		__read_32bit_gc0_register(16, 6)
-#define read_gc0_config7()		__read_32bit_gc0_register(16, 7)
-#define write_gc0_config(val)		__write_32bit_gc0_register(16, 0, val)
-#define write_gc0_config1(val)		__write_32bit_gc0_register(16, 1, val)
-#define write_gc0_config2(val)		__write_32bit_gc0_register(16, 2, val)
-#define write_gc0_config3(val)		__write_32bit_gc0_register(16, 3, val)
-#define write_gc0_config4(val)		__write_32bit_gc0_register(16, 4, val)
-#define write_gc0_config5(val)		__write_32bit_gc0_register(16, 5, val)
-#define write_gc0_config6(val)		__write_32bit_gc0_register(16, 6, val)
-#define write_gc0_config7(val)		__write_32bit_gc0_register(16, 7, val)
-
-#define read_gc0_lladdr()		__read_ulong_gc0_register(17, 0)
-#define write_gc0_lladdr(val)		__write_ulong_gc0_register(17, 0, val)
-
-#define read_gc0_watchlo0()		__read_ulong_gc0_register(18, 0)
-#define read_gc0_watchlo1()		__read_ulong_gc0_register(18, 1)
-#define read_gc0_watchlo2()		__read_ulong_gc0_register(18, 2)
-#define read_gc0_watchlo3()		__read_ulong_gc0_register(18, 3)
-#define read_gc0_watchlo4()		__read_ulong_gc0_register(18, 4)
-#define read_gc0_watchlo5()		__read_ulong_gc0_register(18, 5)
-#define read_gc0_watchlo6()		__read_ulong_gc0_register(18, 6)
-#define read_gc0_watchlo7()		__read_ulong_gc0_register(18, 7)
-#define write_gc0_watchlo0(val)		__write_ulong_gc0_register(18, 0, val)
-#define write_gc0_watchlo1(val)		__write_ulong_gc0_register(18, 1, val)
-#define write_gc0_watchlo2(val)		__write_ulong_gc0_register(18, 2, val)
-#define write_gc0_watchlo3(val)		__write_ulong_gc0_register(18, 3, val)
-#define write_gc0_watchlo4(val)		__write_ulong_gc0_register(18, 4, val)
-#define write_gc0_watchlo5(val)		__write_ulong_gc0_register(18, 5, val)
-#define write_gc0_watchlo6(val)		__write_ulong_gc0_register(18, 6, val)
-#define write_gc0_watchlo7(val)		__write_ulong_gc0_register(18, 7, val)
-
-#define read_gc0_watchhi0()		__read_32bit_gc0_register(19, 0)
-#define read_gc0_watchhi1()		__read_32bit_gc0_register(19, 1)
-#define read_gc0_watchhi2()		__read_32bit_gc0_register(19, 2)
-#define read_gc0_watchhi3()		__read_32bit_gc0_register(19, 3)
-#define read_gc0_watchhi4()		__read_32bit_gc0_register(19, 4)
-#define read_gc0_watchhi5()		__read_32bit_gc0_register(19, 5)
-#define read_gc0_watchhi6()		__read_32bit_gc0_register(19, 6)
-#define read_gc0_watchhi7()		__read_32bit_gc0_register(19, 7)
-#define write_gc0_watchhi0(val)		__write_32bit_gc0_register(19, 0, val)
-#define write_gc0_watchhi1(val)		__write_32bit_gc0_register(19, 1, val)
-#define write_gc0_watchhi2(val)		__write_32bit_gc0_register(19, 2, val)
-#define write_gc0_watchhi3(val)		__write_32bit_gc0_register(19, 3, val)
-#define write_gc0_watchhi4(val)		__write_32bit_gc0_register(19, 4, val)
-#define write_gc0_watchhi5(val)		__write_32bit_gc0_register(19, 5, val)
-#define write_gc0_watchhi6(val)		__write_32bit_gc0_register(19, 6, val)
-#define write_gc0_watchhi7(val)		__write_32bit_gc0_register(19, 7, val)
-
-#define read_gc0_xcontext()		__read_ulong_gc0_register(20, 0)
-#define write_gc0_xcontext(val)		__write_ulong_gc0_register(20, 0, val)
-
-#define read_gc0_perfctrl0()		__read_32bit_gc0_register(25, 0)
-#define write_gc0_perfctrl0(val)	__write_32bit_gc0_register(25, 0, val)
-#define read_gc0_perfcntr0()		__read_32bit_gc0_register(25, 1)
-#define write_gc0_perfcntr0(val)	__write_32bit_gc0_register(25, 1, val)
-#define read_gc0_perfcntr0_64()		__read_64bit_gc0_register(25, 1)
-#define write_gc0_perfcntr0_64(val)	__write_64bit_gc0_register(25, 1, val)
-#define read_gc0_perfctrl1()		__read_32bit_gc0_register(25, 2)
-#define write_gc0_perfctrl1(val)	__write_32bit_gc0_register(25, 2, val)
-#define read_gc0_perfcntr1()		__read_32bit_gc0_register(25, 3)
-#define write_gc0_perfcntr1(val)	__write_32bit_gc0_register(25, 3, val)
-#define read_gc0_perfcntr1_64()		__read_64bit_gc0_register(25, 3)
-#define write_gc0_perfcntr1_64(val)	__write_64bit_gc0_register(25, 3, val)
-#define read_gc0_perfctrl2()		__read_32bit_gc0_register(25, 4)
-#define write_gc0_perfctrl2(val)	__write_32bit_gc0_register(25, 4, val)
-#define read_gc0_perfcntr2()		__read_32bit_gc0_register(25, 5)
-#define write_gc0_perfcntr2(val)	__write_32bit_gc0_register(25, 5, val)
-#define read_gc0_perfcntr2_64()		__read_64bit_gc0_register(25, 5)
-#define write_gc0_perfcntr2_64(val)	__write_64bit_gc0_register(25, 5, val)
-#define read_gc0_perfctrl3()		__read_32bit_gc0_register(25, 6)
-#define write_gc0_perfctrl3(val)	__write_32bit_gc0_register(25, 6, val)
-#define read_gc0_perfcntr3()		__read_32bit_gc0_register(25, 7)
-#define write_gc0_perfcntr3(val)	__write_32bit_gc0_register(25, 7, val)
-#define read_gc0_perfcntr3_64()		__read_64bit_gc0_register(25, 7)
-#define write_gc0_perfcntr3_64(val)	__write_64bit_gc0_register(25, 7, val)
-
-#define read_gc0_errorepc()		__read_ulong_gc0_register(30, 0)
-#define write_gc0_errorepc(val)		__write_ulong_gc0_register(30, 0, val)
-
-#define read_gc0_kscratch1()		__read_ulong_gc0_register(31, 2)
-#define read_gc0_kscratch2()		__read_ulong_gc0_register(31, 3)
-#define read_gc0_kscratch3()		__read_ulong_gc0_register(31, 4)
-#define read_gc0_kscratch4()		__read_ulong_gc0_register(31, 5)
-#define read_gc0_kscratch5()		__read_ulong_gc0_register(31, 6)
-#define read_gc0_kscratch6()		__read_ulong_gc0_register(31, 7)
-#define write_gc0_kscratch1(val)	__write_ulong_gc0_register(31, 2, val)
-#define write_gc0_kscratch2(val)	__write_ulong_gc0_register(31, 3, val)
-#define write_gc0_kscratch3(val)	__write_ulong_gc0_register(31, 4, val)
-#define write_gc0_kscratch4(val)	__write_ulong_gc0_register(31, 5, val)
-#define write_gc0_kscratch5(val)	__write_ulong_gc0_register(31, 6, val)
-#define write_gc0_kscratch6(val)	__write_ulong_gc0_register(31, 7, val)
+#define read_gc0_pwctl()		__read_32bit_gc0_register($6, 6)
+#define write_gc0_pwctl(val)		__write_32bit_gc0_register($6, 6, val)
+
+#define read_gc0_hwrena()		__read_32bit_gc0_register($7, 0)
+#define write_gc0_hwrena(val)		__write_32bit_gc0_register($7, 0, val)
+
+#define read_gc0_badvaddr()		__read_ulong_gc0_register($8, 0)
+#define write_gc0_badvaddr(val)		__write_ulong_gc0_register($8, 0, val)
+
+#define read_gc0_badinstr()		__read_32bit_gc0_register($8, 1)
+#define write_gc0_badinstr(val)		__write_32bit_gc0_register($8, 1, val)
+
+#define read_gc0_badinstrp()		__read_32bit_gc0_register($8, 2)
+#define write_gc0_badinstrp(val)	__write_32bit_gc0_register($8, 2, val)
+
+#define read_gc0_count()		__read_32bit_gc0_register($9, 0)
+
+#define read_gc0_entryhi()		__read_ulong_gc0_register($10, 0)
+#define write_gc0_entryhi(val)		__write_ulong_gc0_register($10, 0, val)
+
+#define read_gc0_compare()		__read_32bit_gc0_register($11, 0)
+#define write_gc0_compare(val)		__write_32bit_gc0_register($11, 0, val)
+
+#define read_gc0_status()		__read_32bit_gc0_register($12, 0)
+#define write_gc0_status(val)		__write_32bit_gc0_register($12, 0, val)
+
+#define read_gc0_intctl()		__read_32bit_gc0_register($12, 1)
+#define write_gc0_intctl(val)		__write_32bit_gc0_register($12, 1, val)
+
+#define read_gc0_cause()		__read_32bit_gc0_register($13, 0)
+#define write_gc0_cause(val)		__write_32bit_gc0_register($13, 0, val)
+
+#define read_gc0_epc()			__read_ulong_gc0_register($14, 0)
+#define write_gc0_epc(val)		__write_ulong_gc0_register($14, 0, val)
+
+#define read_gc0_prid()			__read_32bit_gc0_register($15, 0)
+
+#define read_gc0_ebase()		__read_32bit_gc0_register($15, 1)
+#define write_gc0_ebase(val)		__write_32bit_gc0_register($15, 1, val)
+
+#define read_gc0_ebase_64()		__read_64bit_gc0_register($15, 1)
+#define write_gc0_ebase_64(val)		__write_64bit_gc0_register($15, 1, val)
+
+#define read_gc0_config()		__read_32bit_gc0_register($16, 0)
+#define read_gc0_config1()		__read_32bit_gc0_register($16, 1)
+#define read_gc0_config2()		__read_32bit_gc0_register($16, 2)
+#define read_gc0_config3()		__read_32bit_gc0_register($16, 3)
+#define read_gc0_config4()		__read_32bit_gc0_register($16, 4)
+#define read_gc0_config5()		__read_32bit_gc0_register($16, 5)
+#define read_gc0_config6()		__read_32bit_gc0_register($16, 6)
+#define read_gc0_config7()		__read_32bit_gc0_register($16, 7)
+#define write_gc0_config(val)		__write_32bit_gc0_register($16, 0, val)
+#define write_gc0_config1(val)		__write_32bit_gc0_register($16, 1, val)
+#define write_gc0_config2(val)		__write_32bit_gc0_register($16, 2, val)
+#define write_gc0_config3(val)		__write_32bit_gc0_register($16, 3, val)
+#define write_gc0_config4(val)		__write_32bit_gc0_register($16, 4, val)
+#define write_gc0_config5(val)		__write_32bit_gc0_register($16, 5, val)
+#define write_gc0_config6(val)		__write_32bit_gc0_register($16, 6, val)
+#define write_gc0_config7(val)		__write_32bit_gc0_register($16, 7, val)
+
+#define read_gc0_lladdr()		__read_ulong_gc0_register($17, 0)
+#define write_gc0_lladdr(val)		__write_ulong_gc0_register($17, 0, val)
+
+#define read_gc0_watchlo0()		__read_ulong_gc0_register($18, 0)
+#define read_gc0_watchlo1()		__read_ulong_gc0_register($18, 1)
+#define read_gc0_watchlo2()		__read_ulong_gc0_register($18, 2)
+#define read_gc0_watchlo3()		__read_ulong_gc0_register($18, 3)
+#define read_gc0_watchlo4()		__read_ulong_gc0_register($18, 4)
+#define read_gc0_watchlo5()		__read_ulong_gc0_register($18, 5)
+#define read_gc0_watchlo6()		__read_ulong_gc0_register($18, 6)
+#define read_gc0_watchlo7()		__read_ulong_gc0_register($18, 7)
+#define write_gc0_watchlo0(val)		__write_ulong_gc0_register($18, 0, val)
+#define write_gc0_watchlo1(val)		__write_ulong_gc0_register($18, 1, val)
+#define write_gc0_watchlo2(val)		__write_ulong_gc0_register($18, 2, val)
+#define write_gc0_watchlo3(val)		__write_ulong_gc0_register($18, 3, val)
+#define write_gc0_watchlo4(val)		__write_ulong_gc0_register($18, 4, val)
+#define write_gc0_watchlo5(val)		__write_ulong_gc0_register($18, 5, val)
+#define write_gc0_watchlo6(val)		__write_ulong_gc0_register($18, 6, val)
+#define write_gc0_watchlo7(val)		__write_ulong_gc0_register($18, 7, val)
+
+#define read_gc0_watchhi0()		__read_32bit_gc0_register($19, 0)
+#define read_gc0_watchhi1()		__read_32bit_gc0_register($19, 1)
+#define read_gc0_watchhi2()		__read_32bit_gc0_register($19, 2)
+#define read_gc0_watchhi3()		__read_32bit_gc0_register($19, 3)
+#define read_gc0_watchhi4()		__read_32bit_gc0_register($19, 4)
+#define read_gc0_watchhi5()		__read_32bit_gc0_register($19, 5)
+#define read_gc0_watchhi6()		__read_32bit_gc0_register($19, 6)
+#define read_gc0_watchhi7()		__read_32bit_gc0_register($19, 7)
+#define write_gc0_watchhi0(val)		__write_32bit_gc0_register($19, 0, val)
+#define write_gc0_watchhi1(val)		__write_32bit_gc0_register($19, 1, val)
+#define write_gc0_watchhi2(val)		__write_32bit_gc0_register($19, 2, val)
+#define write_gc0_watchhi3(val)		__write_32bit_gc0_register($19, 3, val)
+#define write_gc0_watchhi4(val)		__write_32bit_gc0_register($19, 4, val)
+#define write_gc0_watchhi5(val)		__write_32bit_gc0_register($19, 5, val)
+#define write_gc0_watchhi6(val)		__write_32bit_gc0_register($19, 6, val)
+#define write_gc0_watchhi7(val)		__write_32bit_gc0_register($19, 7, val)
+
+#define read_gc0_xcontext()		__read_ulong_gc0_register($20, 0)
+#define write_gc0_xcontext(val)		__write_ulong_gc0_register($20, 0, val)
+
+#define read_gc0_perfctrl0()		__read_32bit_gc0_register($25, 0)
+#define write_gc0_perfctrl0(val)	__write_32bit_gc0_register($25, 0, val)
+#define read_gc0_perfcntr0()		__read_32bit_gc0_register($25, 1)
+#define write_gc0_perfcntr0(val)	__write_32bit_gc0_register($25, 1, val)
+#define read_gc0_perfcntr0_64()		__read_64bit_gc0_register($25, 1)
+#define write_gc0_perfcntr0_64(val)	__write_64bit_gc0_register($25, 1, val)
+#define read_gc0_perfctrl1()		__read_32bit_gc0_register($25, 2)
+#define write_gc0_perfctrl1(val)	__write_32bit_gc0_register($25, 2, val)
+#define read_gc0_perfcntr1()		__read_32bit_gc0_register($25, 3)
+#define write_gc0_perfcntr1(val)	__write_32bit_gc0_register($25, 3, val)
+#define read_gc0_perfcntr1_64()		__read_64bit_gc0_register($25, 3)
+#define write_gc0_perfcntr1_64(val)	__write_64bit_gc0_register($25, 3, val)
+#define read_gc0_perfctrl2()		__read_32bit_gc0_register($25, 4)
+#define write_gc0_perfctrl2(val)	__write_32bit_gc0_register($25, 4, val)
+#define read_gc0_perfcntr2()		__read_32bit_gc0_register($25, 5)
+#define write_gc0_perfcntr2(val)	__write_32bit_gc0_register($25, 5, val)
+#define read_gc0_perfcntr2_64()		__read_64bit_gc0_register($25, 5)
+#define write_gc0_perfcntr2_64(val)	__write_64bit_gc0_register($25, 5, val)
+#define read_gc0_perfctrl3()		__read_32bit_gc0_register($25, 6)
+#define write_gc0_perfctrl3(val)	__write_32bit_gc0_register($25, 6, val)
+#define read_gc0_perfcntr3()		__read_32bit_gc0_register($25, 7)
+#define write_gc0_perfcntr3(val)	__write_32bit_gc0_register($25, 7, val)
+#define read_gc0_perfcntr3_64()		__read_64bit_gc0_register($25, 7)
+#define write_gc0_perfcntr3_64(val)	__write_64bit_gc0_register($25, 7, val)
+
+#define read_gc0_errorepc()		__read_ulong_gc0_register($30, 0)
+#define write_gc0_errorepc(val)		__write_ulong_gc0_register($30, 0, val)
+
+#define read_gc0_kscratch1()		__read_ulong_gc0_register($31, 2)
+#define read_gc0_kscratch2()		__read_ulong_gc0_register($31, 3)
+#define read_gc0_kscratch3()		__read_ulong_gc0_register($31, 4)
+#define read_gc0_kscratch4()		__read_ulong_gc0_register($31, 5)
+#define read_gc0_kscratch5()		__read_ulong_gc0_register($31, 6)
+#define read_gc0_kscratch6()		__read_ulong_gc0_register($31, 7)
+#define write_gc0_kscratch1(val)	__write_ulong_gc0_register($31, 2, val)
+#define write_gc0_kscratch2(val)	__write_ulong_gc0_register($31, 3, val)
+#define write_gc0_kscratch3(val)	__write_ulong_gc0_register($31, 4, val)
+#define write_gc0_kscratch4(val)	__write_ulong_gc0_register($31, 5, val)
+#define write_gc0_kscratch5(val)	__write_ulong_gc0_register($31, 6, val)
+#define write_gc0_kscratch6(val)	__write_ulong_gc0_register($31, 7, val)
 
 /* Cavium OCTEON (cnMIPS) */
-#define read_gc0_cvmcount()		__read_ulong_gc0_register(9, 6)
-#define write_gc0_cvmcount(val)		__write_ulong_gc0_register(9, 6, val)
+#define read_gc0_cvmcount()		__read_ulong_gc0_register($9, 6)
+#define write_gc0_cvmcount(val)		__write_ulong_gc0_register($9, 6, val)
 
-#define read_gc0_cvmctl()		__read_64bit_gc0_register(9, 7)
-#define write_gc0_cvmctl(val)		__write_64bit_gc0_register(9, 7, val)
+#define read_gc0_cvmctl()		__read_64bit_gc0_register($9, 7)
+#define write_gc0_cvmctl(val)		__write_64bit_gc0_register($9, 7, val)
 
-#define read_gc0_cvmmemctl()		__read_64bit_gc0_register(11, 7)
-#define write_gc0_cvmmemctl(val)	__write_64bit_gc0_register(11, 7, val)
+#define read_gc0_cvmmemctl()		__read_64bit_gc0_register($11, 7)
+#define write_gc0_cvmmemctl(val)	__write_64bit_gc0_register($11, 7, val)
 
-#define read_gc0_cvmmemctl2()		__read_64bit_gc0_register(16, 6)
-#define write_gc0_cvmmemctl2(val)	__write_64bit_gc0_register(16, 6, val)
+#define read_gc0_cvmmemctl2()		__read_64bit_gc0_register($16, 6)
+#define write_gc0_cvmmemctl2(val)	__write_64bit_gc0_register($16, 6, val)
 
 /*
  * Macros to access the floating point coprocessor control registers
-- 
git-series 0.9.1
