Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2013 17:13:08 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:1074 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6852086Ab3KNQMwZZWfz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Nov 2013 17:12:52 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 01/12] MIPS: Add missing bits for Config registers
Date:   Thu, 14 Nov 2013 16:12:21 +0000
Message-ID: <1384445552-30573-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
References: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_14_16_12_52
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mipsregs.h | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e033141..412fe99 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -573,7 +573,9 @@
 #define MIPS_CONF1_IA		(_ULCAST_(7) << 16)
 #define MIPS_CONF1_IL		(_ULCAST_(7) << 19)
 #define MIPS_CONF1_IS		(_ULCAST_(7) << 22)
-#define MIPS_CONF1_TLBS		(_ULCAST_(63)<< 25)
+#define MIPS_CONF1_TLBS_SHIFT   (25)
+#define MIPS_CONF1_TLBS_SIZE    (6)
+#define MIPS_CONF1_TLBS         (_ULCAST_(63) << MIPS_CONF1_TLBS_SHIFT)
 
 #define MIPS_CONF2_SA		(_ULCAST_(15)<<	 0)
 #define MIPS_CONF2_SL		(_ULCAST_(15)<<	 4)
@@ -587,21 +589,53 @@
 #define MIPS_CONF3_TL		(_ULCAST_(1) <<	 0)
 #define MIPS_CONF3_SM		(_ULCAST_(1) <<	 1)
 #define MIPS_CONF3_MT		(_ULCAST_(1) <<	 2)
+#define MIPS_CONF3_CDMM		(_ULCAST_(1) <<	 3)
 #define MIPS_CONF3_SP		(_ULCAST_(1) <<	 4)
 #define MIPS_CONF3_VINT		(_ULCAST_(1) <<	 5)
 #define MIPS_CONF3_VEIC		(_ULCAST_(1) <<	 6)
 #define MIPS_CONF3_LPA		(_ULCAST_(1) <<	 7)
+#define MIPS_CONF3_ITL		(_ULCAST_(1) <<	 8)
+#define MIPS_CONF3_CTXTC	(_ULCAST_(1) <<	 9)
 #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
 #define MIPS_CONF3_DSP2P	(_ULCAST_(1) << 11)
 #define MIPS_CONF3_RXI		(_ULCAST_(1) << 12)
 #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
 #define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
 #define MIPS_CONF3_ISA_OE	(_ULCAST_(1) << 16)
+#define MIPS_CONF3_MCU		(_ULCAST_(1) << 17)
+#define MIPS_CONF3_MMAR		(_ULCAST_(7) << 18)
+#define MIPS_CONF3_IPLW		(_ULCAST_(3) << 21)
 #define MIPS_CONF3_VZ		(_ULCAST_(1) << 23)
-
+#define MIPS_CONF3_PW		(_ULCAST_(1) << 24)
+#define MIPS_CONF3_SC		(_ULCAST_(1) << 25)
+#define MIPS_CONF3_BI		(_ULCAST_(1) << 26)
+#define MIPS_CONF3_BP		(_ULCAST_(1) << 27)
+#define MIPS_CONF3_MSA		(_ULCAST_(1) << 28)
+#define MIPS_CONF3_CMGCR	(_ULCAST_(1) << 29)
+#define MIPS_CONF3_BPG		(_ULCAST_(1) << 30)
+
+#define MIPS_CONF4_MMUSIZEEXT_SHIFT	(0)
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
+#define MIPS_CONF4_FTLBSETS_SHIFT	(0)
+#define MIPS_CONF4_FTLBSETS_SHIFT	(0)
+#define MIPS_CONF4_FTLBSETS	(_ULCAST_(15) << MIPS_CONF4_FTLBSETS_SHIFT)
+#define MIPS_CONF4_FTLBWAYS_SHIFT	(4)
+#define MIPS_CONF4_FTLBWAYS	(_ULCAST_(15) << MIPS_CONF4_FTLBWAYS_SHIFT)
+#define MIPS_CONF4_FTLBPAGESIZE_SHIFT	(8)
+/* bits 10:8 in FTLB-only configurations */
+#define MIPS_CONF4_FTLBPAGESIZE (_ULCAST_(7) << MIPS_CONF4_FTLBPAGESIZE_SHIFT)
+/* bits 12:8 in VTLB-FTLB only configurations */
+#define MIPS_CONF4_VFTLBPAGESIZE (_ULCAST_(31) << MIPS_CONF4_FTLBPAGESIZE_SHIFT)
 #define MIPS_CONF4_MMUEXTDEF	(_ULCAST_(3) << 14)
 #define MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT (_ULCAST_(1) << 14)
+#define MIPS_CONF4_MMUEXTDEF_FTLBSIZEEXT	(_ULCAST_(2) << 14)
+#define MIPS_CONF4_MMUEXTDEF_VTLBSIZEEXT	(_ULCAST_(3) << 14)
+#define MIPS_CONF4_KSCREXIST	(_ULCAST_(255) << 16)
+#define MIPS_CONF4_VTLBSIZEEXT_SHIFT	(24)
+#define MIPS_CONF4_VTLBSIZEEXT	(_ULCAST_(15) << MIPS_CONF4_VTLBSIZEEXT_SHIFT)
+#define MIPS_CONF4_AE		(_ULCAST_(1) << 28)
+#define MIPS_CONF4_IE		(_ULCAST_(3) << 29)
+#define MIPS_CONF4_TLBINV	(_ULCAST_(2) << 29)
 
 #define MIPS_CONF5_NF		(_ULCAST_(1) << 0)
 #define MIPS_CONF5_UFR		(_ULCAST_(1) << 2)
@@ -616,6 +650,8 @@
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
 
+/*  EntryHI bit definition */
+#define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
 
 /*
  * Bits in the MIPS32/64 coprocessor 1 (FPU) revision register.
-- 
1.8.4.3
