Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 12:34:25 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:36976 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991033AbdKVLbmoyox8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 12:31:42 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 22 Nov 2017 11:31:35 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 22 Nov 2017 03:31:00 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 6/7] MIPS: XPA: Standardise readx/writex accessors
Date:   Wed, 22 Nov 2017 11:30:32 +0000
Message-ID: <ee83f3d40494dcad3b7cad073c9829ecf9cce2cd.1511349998.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
References: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511350289-637139-12581-475811-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 4.30
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187190
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        1.80 BSF_SC0_MV0735_3       META:  
        2.50 BSF_SC0_MV0735         META: custom rule MV0735 
X-BESS-Outbound-Spam-Status: SCORE=4.30 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MV0735_3, BSF_SC0_MV0735
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61055
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

Now that we are using assembler macros to implement XPA instructions on
toolchains which don't support them, pass Cop0 register names to the
__{readx,writex}_32bit_c0_register macros in $n format rather than
register numbers. Also pass a register select which may be useful in
future (for example for MemoryMapID field of WatchHi registers on
I6500).

This is to make them consistent with the normal Cop0 register access
macros which they were originally based on.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index f2b9af887e83..5b901deab52a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1499,7 +1499,7 @@ _ASM_MACRO_2R_1S(mthc0, rt, rd, sel,
 #define _ASM_SET_XPA ".set\txpa\n\t"
 #endif
 
-#define __readx_32bit_c0_register(source)				\
+#define __readx_32bit_c0_register(source, sel)				\
 ({									\
 	unsigned int __res;						\
 									\
@@ -1507,23 +1507,23 @@ _ASM_MACRO_2R_1S(mthc0, rt, rd, sel,
 	"	.set	push					\n"	\
 	"	.set	mips32r2				\n"	\
 	_ASM_SET_XPA							\
-	"	mfhc0	%0, $%1					\n"	\
+	"	mfhc0	%0, " #source ", %1			\n"	\
 	"	.set	pop					\n"	\
 	: "=r" (__res)							\
-	: "i" (source));						\
+	: "i" (sel));							\
 	__res;								\
 })
 
-#define __writex_32bit_c0_register(register, value)			\
+#define __writex_32bit_c0_register(register, sel, value)		\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	mips32r2				\n"	\
 	_ASM_SET_XPA							\
-	"	mthc0	%z0, $%1				\n"	\
+	"	mthc0	%z0, " #register ", %1			\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "Jr" (value), "i" (register));				\
+	: "Jr" (value), "i" (sel));					\
 } while (0)
 
 #define read_c0_index()		__read_32bit_c0_register($0, 0)
@@ -1535,14 +1535,14 @@ do {									\
 #define read_c0_entrylo0()	__read_ulong_c0_register($2, 0)
 #define write_c0_entrylo0(val)	__write_ulong_c0_register($2, 0, val)
 
-#define readx_c0_entrylo0()	__readx_32bit_c0_register(2)
-#define writex_c0_entrylo0(val)	__writex_32bit_c0_register(2, val)
+#define readx_c0_entrylo0()	__readx_32bit_c0_register($2, 0)
+#define writex_c0_entrylo0(val)	__writex_32bit_c0_register($2, 0, val)
 
 #define read_c0_entrylo1()	__read_ulong_c0_register($3, 0)
 #define write_c0_entrylo1(val)	__write_ulong_c0_register($3, 0, val)
 
-#define readx_c0_entrylo1()	__readx_32bit_c0_register(3)
-#define writex_c0_entrylo1(val)	__writex_32bit_c0_register(3, val)
+#define readx_c0_entrylo1()	__readx_32bit_c0_register($3, 0)
+#define writex_c0_entrylo1(val)	__writex_32bit_c0_register($3, 0, val)
 
 #define read_c0_conf()		__read_32bit_c0_register($3, 0)
 #define write_c0_conf(val)	__write_32bit_c0_register($3, 0, val)
-- 
git-series 0.9.1
