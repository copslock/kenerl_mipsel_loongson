Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2016 15:53:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48985 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027788AbcD2NxYKDSyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Apr 2016 15:53:24 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id E5D8DF9C873F3;
        Fri, 29 Apr 2016 14:53:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 29 Apr 2016 14:53:17 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 29 Apr 2016 14:53:16 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 2/6] MIPS: Add register definitions for VZ ASE registers
Date:   Fri, 29 Apr 2016 14:53:04 +0100
Message-ID: <1461937988-13787-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1461937988-13787-1-git-send-email-james.hogan@imgtec.com>
References: <1461937988-13787-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53262
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

Add various register definitions to <asm/mipsregs.h> for the coprocessor
zero registers in the VZ ASE, namely CP0_GuestCtl0, CP0_GuestCtl0Ext,
CP0_GuestCtl1, CP0_GuestCtl2, CP0_GuestCtl3, and CP0_GTOffset.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 117 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index f46646a093f0..29f1c4124650 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -55,8 +55,14 @@
 #define CP0_BADINSTR $8, 1
 #define CP0_COUNT $9
 #define CP0_ENTRYHI $10
+#define CP0_GUESTCTL1 $10, 4
+#define CP0_GUESTCTL2 $10, 5
+#define CP0_GUESTCTL3 $10, 6
 #define CP0_COMPARE $11
+#define CP0_GUESTCTL0EXT $11, 4
 #define CP0_STATUS $12
+#define CP0_GUESTCTL0 $12, 6
+#define CP0_GTOFFSET $12, 7
 #define CP0_CAUSE $13
 #define CP0_EPC $14
 #define CP0_PRID $15
@@ -738,6 +744,94 @@
 #define MIPS_PWCTL_PSN_SHIFT	0
 #define MIPS_PWCTL_PSN_MASK	0x0000003f
 
+/* GuestCtl0 fields */
+#define MIPS_GCTL0_GM_SHIFT	31
+#define MIPS_GCTL0_GM		(_ULCAST_(1) << MIPS_GCTL0_GM_SHIFT)
+#define MIPS_GCTL0_RI_SHIFT	30
+#define MIPS_GCTL0_RI		(_ULCAST_(1) << MIPS_GCTL0_RI_SHIFT)
+#define MIPS_GCTL0_MC_SHIFT	29
+#define MIPS_GCTL0_MC		(_ULCAST_(1) << MIPS_GCTL0_MC_SHIFT)
+#define MIPS_GCTL0_CP0_SHIFT	28
+#define MIPS_GCTL0_CP0		(_ULCAST_(1) << MIPS_GCTL0_CP0_SHIFT)
+#define MIPS_GCTL0_AT_SHIFT	26
+#define MIPS_GCTL0_AT		(_ULCAST_(0x3) << MIPS_GCTL0_AT_SHIFT)
+#define MIPS_GCTL0_GT_SHIFT	25
+#define MIPS_GCTL0_GT		(_ULCAST_(1) << MIPS_GCTL0_GT_SHIFT)
+#define MIPS_GCTL0_CG_SHIFT	24
+#define MIPS_GCTL0_CG		(_ULCAST_(1) << MIPS_GCTL0_CG_SHIFT)
+#define MIPS_GCTL0_CF_SHIFT	23
+#define MIPS_GCTL0_CF		(_ULCAST_(1) << MIPS_GCTL0_CF_SHIFT)
+#define MIPS_GCTL0_G1_SHIFT	22
+#define MIPS_GCTL0_G1		(_ULCAST_(1) << MIPS_GCTL0_G1_SHIFT)
+#define MIPS_GCTL0_G0E_SHIFT	19
+#define MIPS_GCTL0_G0E		(_ULCAST_(1) << MIPS_GCTL0_G0E_SHIFT)
+#define MIPS_GCTL0_PT_SHIFT	18
+#define MIPS_GCTL0_PT		(_ULCAST_(1) << MIPS_GCTL0_PT_SHIFT)
+#define MIPS_GCTL0_RAD_SHIFT	9
+#define MIPS_GCTL0_RAD		(_ULCAST_(1) << MIPS_GCTL0_RAD_SHIFT)
+#define MIPS_GCTL0_DRG_SHIFT	8
+#define MIPS_GCTL0_DRG		(_ULCAST_(1) << MIPS_GCTL0_DRG_SHIFT)
+#define MIPS_GCTL0_G2_SHIFT	7
+#define MIPS_GCTL0_G2		(_ULCAST_(1) << MIPS_GCTL0_G2_SHIFT)
+#define MIPS_GCTL0_GEXC_SHIFT	2
+#define MIPS_GCTL0_GEXC		(_ULCAST_(0x1f) << MIPS_GCTL0_GEXC_SHIFT)
+#define MIPS_GCTL0_SFC2_SHIFT	1
+#define MIPS_GCTL0_SFC2		(_ULCAST_(1) << MIPS_GCTL0_SFC2_SHIFT)
+#define MIPS_GCTL0_SFC1_SHIFT	0
+#define MIPS_GCTL0_SFC1		(_ULCAST_(1) << MIPS_GCTL0_SFC1_SHIFT)
+
+/* GuestCtl0.AT Guest address translation control */
+#define MIPS_GCTL0_AT_ROOT	1  /* Guest MMU under Root control */
+#define MIPS_GCTL0_AT_GUEST	3  /* Guest MMU under Guest control */
+
+/* GuestCtl0.GExcCode Hypervisor exception cause codes */
+#define MIPS_GCTL0_GEXC_GPSI	0  /* Guest Privileged Sensitive Instruction */
+#define MIPS_GCTL0_GEXC_GSFC	1  /* Guest Software Field Change */
+#define MIPS_GCTL0_GEXC_HC	2  /* Hypercall */
+#define MIPS_GCTL0_GEXC_GRR	3  /* Guest Reserved Instruction Redirect */
+#define MIPS_GCTL0_GEXC_GVA	8  /* Guest Virtual Address available */
+#define MIPS_GCTL0_GEXC_GHFC	9  /* Guest Hardware Field Change */
+#define MIPS_GCTL0_GEXC_GPA	10 /* Guest Physical Address available */
+
+/* GuestCtl0Ext fields */
+#define MIPS_GCTL0EXT_RPW_SHIFT	8
+#define MIPS_GCTL0EXT_RPW	(_ULCAST_(0x3) << MIPS_GCTL0EXT_RPW_SHIFT)
+#define MIPS_GCTL0EXT_NCC_SHIFT	6
+#define MIPS_GCTL0EXT_NCC	(_ULCAST_(0x3) << MIPS_GCTL0EXT_NCC_SHIFT)
+#define MIPS_GCTL0EXT_CGI_SHIFT	4
+#define MIPS_GCTL0EXT_CGI	(_ULCAST_(1) << MIPS_GCTL0EXT_CGI_SHIFT)
+#define MIPS_GCTL0EXT_FCD_SHIFT	3
+#define MIPS_GCTL0EXT_FCD	(_ULCAST_(1) << MIPS_GCTL0EXT_FCD_SHIFT)
+#define MIPS_GCTL0EXT_OG_SHIFT	2
+#define MIPS_GCTL0EXT_OG	(_ULCAST_(1) << MIPS_GCTL0EXT_OG_SHIFT)
+#define MIPS_GCTL0EXT_BG_SHIFT	1
+#define MIPS_GCTL0EXT_BG	(_ULCAST_(1) << MIPS_GCTL0EXT_BG_SHIFT)
+#define MIPS_GCTL0EXT_MG_SHIFT	0
+#define MIPS_GCTL0EXT_MG	(_ULCAST_(1) << MIPS_GCTL0EXT_MG_SHIFT)
+
+/* GuestCtl0Ext.RPW Root page walk configuration */
+#define MIPS_GCTL0EXT_RPW_BOTH	0  /* Root PW for GPA->RPA and RVA->RPA */
+#define MIPS_GCTL0EXT_RPW_GPA	2  /* Root PW for GPA->RPA */
+#define MIPS_GCTL0EXT_RPW_RVA	3  /* Root PW for RVA->RPA */
+
+/* GuestCtl0Ext.NCC Nested cache coherency attributes */
+#define MIPS_GCTL0EXT_NCC_IND	0  /* Guest CCA independent of Root CCA */
+#define MIPS_GCTL0EXT_NCC_MOD	1  /* Guest CCA modified by Root CCA */
+
+/* GuestCtl1 fields */
+#define MIPS_GCTL1_ID_SHIFT	0
+#define MIPS_GCTL1_ID_WIDTH	8
+#define MIPS_GCTL1_ID		(_ULCAST_(0xff) << MIPS_GCTL1_ID_SHIFT)
+#define MIPS_GCTL1_RID_SHIFT	16
+#define MIPS_GCTL1_RID_WIDTH	8
+#define MIPS_GCTL1_RID		(_ULCAST_(0xff) << MIPS_GCTL1_RID_SHIFT)
+#define MIPS_GCTL1_EID_SHIFT	24
+#define MIPS_GCTL1_EID_WIDTH	8
+#define MIPS_GCTL1_EID		(_ULCAST_(0xff) << MIPS_GCTL1_EID_SHIFT)
+
+/* GuestID reserved for root context */
+#define MIPS_GCTL1_ROOT_GUESTID	0
+
 /* CDMMBase register bit definitions */
 #define MIPS_CDMMBASE_SIZE_SHIFT 0
 #define MIPS_CDMMBASE_SIZE	(_ULCAST_(511) << MIPS_CDMMBASE_SIZE_SHIFT)
@@ -1268,9 +1362,21 @@ do {									\
 #define read_c0_entryhi()	__read_ulong_c0_register($10, 0)
 #define write_c0_entryhi(val)	__write_ulong_c0_register($10, 0, val)
 
+#define read_c0_guestctl1()	__read_32bit_c0_register($10, 4)
+#define write_c0_guestctl1(val)	__write_32bit_c0_register($10, 4, val)
+
+#define read_c0_guestctl2()	__read_32bit_c0_register($10, 5)
+#define write_c0_guestctl2(val)	__write_32bit_c0_register($10, 5, val)
+
+#define read_c0_guestctl3()	__read_32bit_c0_register($10, 6)
+#define write_c0_guestctl3(val)	__write_32bit_c0_register($10, 6, val)
+
 #define read_c0_compare()	__read_32bit_c0_register($11, 0)
 #define write_c0_compare(val)	__write_32bit_c0_register($11, 0, val)
 
+#define read_c0_guestctl0ext()	__read_32bit_c0_register($11, 4)
+#define write_c0_guestctl0ext(val) __write_32bit_c0_register($11, 4, val)
+
 #define read_c0_compare2()	__read_32bit_c0_register($11, 6) /* pnx8550 */
 #define write_c0_compare2(val)	__write_32bit_c0_register($11, 6, val)
 
@@ -1281,6 +1387,12 @@ do {									\
 
 #define write_c0_status(val)	__write_32bit_c0_register($12, 0, val)
 
+#define read_c0_guestctl0()	__read_32bit_c0_register($12, 6)
+#define write_c0_guestctl0(val)	__write_32bit_c0_register($12, 6, val)
+
+#define read_c0_gtoffset()	__read_32bit_c0_register($12, 7)
+#define write_c0_gtoffset(val)	__write_32bit_c0_register($12, 7, val)
+
 #define read_c0_cause()		__read_32bit_c0_register($13, 0)
 #define write_c0_cause(val)	__write_32bit_c0_register($13, 0, val)
 
@@ -2109,6 +2221,11 @@ __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
 __BUILD_SET_C0(pagegrain)
+__BUILD_SET_C0(guestctl0)
+__BUILD_SET_C0(guestctl0ext)
+__BUILD_SET_C0(guestctl1)
+__BUILD_SET_C0(guestctl2)
+__BUILD_SET_C0(guestctl3)
 __BUILD_SET_C0(brcm_config_0)
 __BUILD_SET_C0(brcm_bus_pll)
 __BUILD_SET_C0(brcm_reset)
-- 
2.4.10
