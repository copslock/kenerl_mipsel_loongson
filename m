Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:51:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64903 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdHMCvEqGwa6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:51:04 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id D41DD1C045B27;
        Sun, 13 Aug 2017 03:50:55 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:50:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/19] MIPS: CM: Use BIT/GENMASK for register fields, order & drop shifts
Date:   Sat, 12 Aug 2017 19:49:27 -0700
Message-ID: <20170813024943.14989-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59499
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

There's no reason for us not to use BIT() & GENMASK() in asm/mips-cm.h
when declaring macros corresponding to register fields. This patch
modifies our definitions to do so.

The *_SHF definitions are removed entirely - they duplicate information
found in the masks, are infrequently used & can be replaced with use of
__ffs() where needed.

The *_MSK definitions then lose their _MSK suffix which is now somewhat
redundant, and users are modified to match.

The field definitions are moved to follow the appropriate register's
accessor functions, which helps to keep the field definitions in order &
to find the appropriate fields for a given register. Whilst here a
comment is added describing each register & including its name, which is
helpful both for linking the register back to hardware documentation &
for grepping purposes.

This also cleans up a couple of issues that became obvious as a result
of making the changes described above:

  - We previously had definitions for GCR_Cx_RESET_EXT_BASE & a phony
    copy of that named GCR_RESET_EXT_BASE - a register which does not
    exist. The bad definitions were added by commit 497e803ebf98 ("MIPS:
    smp-cps: Ensure secondary cores start with EVA disabled") and made
    use of from boot_core(), which is now modified to use the
    GCR_Cx_RESET_EXT_BASE definitions.

  - We had a typo in CM_GCR_ERROR_CAUSE_ERRINGO_MSK - we now correctly
    define this as inFo rather than inGo.

Now that we don't duplicate field information between _SHF & _MSK
definitions, and keep the fields next to the register accessors, it will
be much easier to spot & prevent any similar oddities being introduced
in the future.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cm.h    | 311 ++++++++++++++++---------------------
 arch/mips/kernel/mips-cm.c         |  48 +++---
 arch/mips/kernel/mips-cpc.c        |   8 +-
 arch/mips/kernel/pm-cps.c          |   4 +-
 arch/mips/kernel/smp-cps.c         |  10 +-
 arch/mips/kernel/traps.c           |   8 +-
 arch/mips/mm/sc-mips.c             |  36 ++---
 arch/mips/mti-malta/malta-dtshim.c |   2 +-
 drivers/irqchip/irq-mips-gic.c     |   4 +-
 9 files changed, 190 insertions(+), 241 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index b01fcf4647d2..4857d4ae97b7 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -127,212 +127,161 @@ static inline bool mips_cm_has_l2sync(void)
 	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_CLCB_OFS + off, cl_##name)	\
 	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_COCB_OFS + off, co_##name)
 
-/* GCB register accessor functions */
+/* GCR_CONFIG - Information about the system */
 GCR_ACCESSOR_RO(64, 0x000, config)
+#define CM_GCR_CONFIG_NUMIOCU			GENMASK(15, 8)
+#define CM_GCR_CONFIG_PCORES			GENMASK(7, 0)
+
+/* GCR_BASE - Base address of the Global Configuration Registers (GCRs) */
 GCR_ACCESSOR_RW(64, 0x008, base)
+#define CM_GCR_BASE_GCRBASE			GENMASK_ULL(47, 15)
+#define CM_GCR_BASE_CMDEFTGT			GENMASK(1, 0)
+#define  CM_GCR_BASE_CMDEFTGT_DISABLED		0
+#define  CM_GCR_BASE_CMDEFTGT_MEM		1
+#define  CM_GCR_BASE_CMDEFTGT_IOCU0		2
+#define  CM_GCR_BASE_CMDEFTGT_IOCU1		3
+
+/* GCR_ACCESS - Controls core/IOCU access to GCRs */
 GCR_ACCESSOR_RW(32, 0x020, access)
+#define CM_GCR_ACCESS_ACCESSEN			GENMASK(7, 0)
+
+/* GCR_REV - Indicates the Coherence Manager revision */
 GCR_ACCESSOR_RO(32, 0x030, rev)
+#define CM_GCR_REV_MAJOR			GENMASK(15, 8)
+#define CM_GCR_REV_MINOR			GENMASK(7, 0)
+
+#define CM_ENCODE_REV(major, minor) \
+		(((major) << __ffs(CM_GCR_REV_MAJOR)) | \
+		 ((minor) << __ffs(CM_GCR_REV_MINOR)))
+
+#define CM_REV_CM2				CM_ENCODE_REV(6, 0)
+#define CM_REV_CM2_5				CM_ENCODE_REV(7, 0)
+#define CM_REV_CM3				CM_ENCODE_REV(8, 0)
+
+/* GCR_ERR_CONTROL - Control error checking logic */
 GCR_ACCESSOR_RW(32, 0x038, err_control)
+#define CM_GCR_ERR_CONTROL_L2_ECC_EN		BIT(1)
+#define CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT	BIT(0)
+
+/* GCR_ERR_MASK - Control which errors are reported as interrupts */
 GCR_ACCESSOR_RW(64, 0x040, error_mask)
+
+/* GCR_ERR_CAUSE - Indicates the type of error that occurred */
 GCR_ACCESSOR_RW(64, 0x048, error_cause)
+#define CM_GCR_ERROR_CAUSE_ERRTYPE		GENMASK(31, 27)
+#define CM3_GCR_ERROR_CAUSE_ERRTYPE		GENMASK_ULL(63, 58)
+#define CM_GCR_ERROR_CAUSE_ERRINFO		GENMASK(26, 0)
+
+/* GCR_ERR_ADDR - Indicates the address associated with an error */
 GCR_ACCESSOR_RW(64, 0x050, error_addr)
+
+/* GCR_ERR_MULT - Indicates when multiple errors have occurred */
 GCR_ACCESSOR_RW(64, 0x058, error_mult)
+#define CM_GCR_ERROR_MULT_ERR2ND		GENMASK(4, 0)
+
+/* GCR_L2_ONLY_SYNC_BASE - Base address of the L2 cache-only sync region */
 GCR_ACCESSOR_RW(64, 0x070, l2_only_sync_base)
+#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE	GENMASK(31, 12)
+#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN		BIT(0)
+
+/* GCR_GIC_BASE - Base address of the Global Interrupt Controller (GIC) */
 GCR_ACCESSOR_RW(64, 0x080, gic_base)
+#define CM_GCR_GIC_BASE_GICBASE			GENMASK(31, 17)
+#define CM_GCR_GIC_BASE_GICEN			BIT(0)
+
+/* GCR_CPC_BASE - Base address of the Cluster Power Controller (CPC) */
 GCR_ACCESSOR_RW(64, 0x088, cpc_base)
+#define CM_GCR_CPC_BASE_CPCBASE			GENMASK(31, 15)
+#define CM_GCR_CPC_BASE_CPCEN			BIT(0)
+
+/* GCR_REGn_BASE - Base addresses of CM address regions */
 GCR_ACCESSOR_RW(64, 0x090, reg0_base)
-GCR_ACCESSOR_RW(64, 0x098, reg0_mask)
 GCR_ACCESSOR_RW(64, 0x0a0, reg1_base)
-GCR_ACCESSOR_RW(64, 0x0a8, reg1_mask)
 GCR_ACCESSOR_RW(64, 0x0b0, reg2_base)
-GCR_ACCESSOR_RW(64, 0x0b8, reg2_mask)
 GCR_ACCESSOR_RW(64, 0x0c0, reg3_base)
+#define CM_GCR_REGn_BASE_BASEADDR		GENMASK(31, 16)
+
+/* GCR_REGn_MASK - Size & destination of CM address regions */
+GCR_ACCESSOR_RW(64, 0x098, reg0_mask)
+GCR_ACCESSOR_RW(64, 0x0a8, reg1_mask)
+GCR_ACCESSOR_RW(64, 0x0b8, reg2_mask)
 GCR_ACCESSOR_RW(64, 0x0c8, reg3_mask)
+#define CM_GCR_REGn_MASK_ADDRMASK		GENMASK(31, 16)
+#define CM_GCR_REGn_MASK_CCAOVR			GENMASK(7, 5)
+#define CM_GCR_REGn_MASK_CCAOVREN		BIT(4)
+#define CM_GCR_REGn_MASK_DROPL2			BIT(2)
+#define CM_GCR_REGn_MASK_CMTGT			GENMASK(1, 0)
+#define  CM_GCR_REGn_MASK_CMTGT_DISABLED	0x0
+#define  CM_GCR_REGn_MASK_CMTGT_MEM		0x1
+#define  CM_GCR_REGn_MASK_CMTGT_IOCU0		0x2
+#define  CM_GCR_REGn_MASK_CMTGT_IOCU1		0x3
+
+/* GCR_GIC_STATUS - Indicates presence of a Global Interrupt Controller (GIC) */
 GCR_ACCESSOR_RO(32, 0x0d0, gic_status)
+#define CM_GCR_GIC_STATUS_EX			BIT(0)
+
+/* GCR_CPC_STATUS - Indicates presence of a Cluster Power Controller (CPC) */
 GCR_ACCESSOR_RO(32, 0x0f0, cpc_status)
+#define CM_GCR_CPC_STATUS_EX			BIT(0)
+
+/* GCR_L2_CONFIG - Indicates L2 cache configuration when Config5.L2C=1 */
 GCR_ACCESSOR_RW(32, 0x130, l2_config)
+#define CM_GCR_L2_CONFIG_BYPASS			BIT(20)
+#define CM_GCR_L2_CONFIG_SET_SIZE		GENMASK(15, 12)
+#define CM_GCR_L2_CONFIG_LINE_SIZE		GENMASK(11, 8)
+#define CM_GCR_L2_CONFIG_ASSOC			GENMASK(7, 0)
+
+/* GCR_SYS_CONFIG2 - Further information about the system */
 GCR_ACCESSOR_RO(32, 0x150, sys_config2)
+#define CM_GCR_SYS_CONFIG2_MAXVPW		GENMASK(3, 0)
+
+/* GCR_L2_PFT_CONTROL - Controls hardware L2 prefetching */
 GCR_ACCESSOR_RW(32, 0x300, l2_pft_control)
+#define CM_GCR_L2_PFT_CONTROL_PAGEMASK		GENMASK(31, 12)
+#define CM_GCR_L2_PFT_CONTROL_PFTEN		BIT(8)
+#define CM_GCR_L2_PFT_CONTROL_NPFT		GENMASK(7, 0)
+
+/* GCR_L2_PFT_CONTROL_B - Controls hardware L2 prefetching */
 GCR_ACCESSOR_RW(32, 0x308, l2_pft_control_b)
+#define CM_GCR_L2_PFT_CONTROL_B_CEN		BIT(8)
+#define CM_GCR_L2_PFT_CONTROL_B_PORTID		GENMASK(7, 0)
+
+/* GCR_BEV_BASE - Controls the location of the BEV for powered up cores */
 GCR_ACCESSOR_RW(64, 0x680, bev_base)
 
-/* Core Local & Core Other register accessor functions */
+/* GCR_Cx_RESET_RELEASE - Controls core reset for CM 1.x */
 GCR_CX_ACCESSOR_RW(32, 0x000, reset_release)
-GCR_CX_ACCESSOR_RW(32, 0x008, coherence)
-GCR_CX_ACCESSOR_RO(32, 0x010, config)
-GCR_CX_ACCESSOR_RW(32, 0x018, other)
-GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
-GCR_CX_ACCESSOR_RO(32, 0x028, id)
-GCR_CX_ACCESSOR_RW(32, 0x030, reset_ext_base)
-
-/* GCR_CONFIG register fields */
-#define CM_GCR_CONFIG_NUMIOCU_SHF		8
-#define CM_GCR_CONFIG_NUMIOCU_MSK		(_ULCAST_(0xf) << 8)
-#define CM_GCR_CONFIG_PCORES_SHF		0
-#define CM_GCR_CONFIG_PCORES_MSK		(_ULCAST_(0xff) << 0)
-
-/* GCR_BASE register fields */
-#define CM_GCR_BASE_GCRBASE_SHF			15
-#define CM_GCR_BASE_GCRBASE_MSK			(_ULCAST_(0x1ffff) << 15)
-#define CM_GCR_BASE_CMDEFTGT_SHF		0
-#define CM_GCR_BASE_CMDEFTGT_MSK		(_ULCAST_(0x3) << 0)
-#define  CM_GCR_BASE_CMDEFTGT_DISABLED		0
-#define  CM_GCR_BASE_CMDEFTGT_MEM		1
-#define  CM_GCR_BASE_CMDEFTGT_IOCU0		2
-#define  CM_GCR_BASE_CMDEFTGT_IOCU1		3
 
-/* GCR_RESET_EXT_BASE register fields */
-#define CM_GCR_RESET_EXT_BASE_EVARESET		BIT(31)
-#define CM_GCR_RESET_EXT_BASE_UEB		BIT(30)
+/* GCR_Cx_COHERENCE - Controls core coherence */
+GCR_CX_ACCESSOR_RW(32, 0x008, coherence)
+#define CM_GCR_Cx_COHERENCE_COHDOMAINEN		GENMASK(7, 0)
+#define CM3_GCR_Cx_COHERENCE_COHEN		BIT(0)
 
-/* GCR_ACCESS register fields */
-#define CM_GCR_ACCESS_ACCESSEN_SHF		0
-#define CM_GCR_ACCESS_ACCESSEN_MSK		(_ULCAST_(0xff) << 0)
+/* GCR_Cx_CONFIG - Information about a core's configuration */
+GCR_CX_ACCESSOR_RO(32, 0x010, config)
+#define CM_GCR_Cx_CONFIG_IOCUTYPE		GENMASK(11, 10)
+#define CM_GCR_Cx_CONFIG_PVPE			GENMASK(9, 0)
 
-/* GCR_REV register fields */
-#define CM_GCR_REV_MAJOR_SHF			8
-#define CM_GCR_REV_MAJOR_MSK			(_ULCAST_(0xff) << 8)
-#define CM_GCR_REV_MINOR_SHF			0
-#define CM_GCR_REV_MINOR_MSK			(_ULCAST_(0xff) << 0)
+/* GCR_Cx_OTHER - Configure the core-other/redirect GCR block */
+GCR_CX_ACCESSOR_RW(32, 0x018, other)
+#define CM_GCR_Cx_OTHER_CORENUM			GENMASK(31, 16)
+#define CM3_GCR_Cx_OTHER_CORE			GENMASK(13, 8)
+#define CM3_GCR_Cx_OTHER_VP			GENMASK(2, 0)
 
-#define CM_ENCODE_REV(major, minor) \
-		(((major) << CM_GCR_REV_MAJOR_SHF) | \
-		 ((minor) << CM_GCR_REV_MINOR_SHF))
+/* GCR_Cx_RESET_BASE - Configure where powered up cores will fetch from */
+GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
+#define CM_GCR_Cx_RESET_BASE_BEVEXCBASE		GENMASK(31, 12)
 
-#define CM_REV_CM2				CM_ENCODE_REV(6, 0)
-#define CM_REV_CM2_5				CM_ENCODE_REV(7, 0)
-#define CM_REV_CM3				CM_ENCODE_REV(8, 0)
+/* GCR_Cx_ID - Identify the current core */
+GCR_CX_ACCESSOR_RO(32, 0x028, id)
 
-/* GCR_ERR_CONTROL register fields */
-#define CM_GCR_ERR_CONTROL_L2_ECC_EN_SHF	1
-#define CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK	(_ULCAST_(0x1) << 1)
-#define CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_SHF	0
-#define CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_MSK	(_ULCAST_(0x1) << 0)
-
-/* GCR_ERROR_CAUSE register fields */
-#define CM_GCR_ERROR_CAUSE_ERRTYPE_SHF		27
-#define CM_GCR_ERROR_CAUSE_ERRTYPE_MSK		(_ULCAST_(0x1f) << 27)
-#define CM3_GCR_ERROR_CAUSE_ERRTYPE_SHF		58
-#define CM3_GCR_ERROR_CAUSE_ERRTYPE_MSK		GENMASK_ULL(63, 58)
-#define CM_GCR_ERROR_CAUSE_ERRINFO_SHF		0
-#define CM_GCR_ERROR_CAUSE_ERRINGO_MSK		(_ULCAST_(0x7ffffff) << 0)
-
-/* GCR_ERROR_MULT register fields */
-#define CM_GCR_ERROR_MULT_ERR2ND_SHF		0
-#define CM_GCR_ERROR_MULT_ERR2ND_MSK		(_ULCAST_(0x1f) << 0)
-
-/* GCR_L2_ONLY_SYNC_BASE register fields */
-#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE_SHF	12
-#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE_MSK	(_ULCAST_(0xfffff) << 12)
-#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN_SHF	0
-#define CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN_MSK	(_ULCAST_(0x1) << 0)
-
-/* GCR_GIC_BASE register fields */
-#define CM_GCR_GIC_BASE_GICBASE_SHF		17
-#define CM_GCR_GIC_BASE_GICBASE_MSK		(_ULCAST_(0x7fff) << 17)
-#define CM_GCR_GIC_BASE_GICEN_SHF		0
-#define CM_GCR_GIC_BASE_GICEN_MSK		(_ULCAST_(0x1) << 0)
-
-/* GCR_CPC_BASE register fields */
-#define CM_GCR_CPC_BASE_CPCBASE_SHF		15
-#define CM_GCR_CPC_BASE_CPCBASE_MSK		(_ULCAST_(0x1ffff) << 15)
-#define CM_GCR_CPC_BASE_CPCEN_SHF		0
-#define CM_GCR_CPC_BASE_CPCEN_MSK		(_ULCAST_(0x1) << 0)
-
-/* GCR_GIC_STATUS register fields */
-#define CM_GCR_GIC_STATUS_GICEX_SHF		0
-#define CM_GCR_GIC_STATUS_GICEX_MSK		(_ULCAST_(0x1) << 0)
-
-/* GCR_REGn_BASE register fields */
-#define CM_GCR_REGn_BASE_BASEADDR_SHF		16
-#define CM_GCR_REGn_BASE_BASEADDR_MSK		(_ULCAST_(0xffff) << 16)
-
-/* GCR_REGn_MASK register fields */
-#define CM_GCR_REGn_MASK_ADDRMASK_SHF		16
-#define CM_GCR_REGn_MASK_ADDRMASK_MSK		(_ULCAST_(0xffff) << 16)
-#define CM_GCR_REGn_MASK_CCAOVR_SHF		5
-#define CM_GCR_REGn_MASK_CCAOVR_MSK		(_ULCAST_(0x3) << 5)
-#define CM_GCR_REGn_MASK_CCAOVREN_SHF		4
-#define CM_GCR_REGn_MASK_CCAOVREN_MSK		(_ULCAST_(0x1) << 4)
-#define CM_GCR_REGn_MASK_DROPL2_SHF		2
-#define CM_GCR_REGn_MASK_DROPL2_MSK		(_ULCAST_(0x1) << 2)
-#define CM_GCR_REGn_MASK_CMTGT_SHF		0
-#define CM_GCR_REGn_MASK_CMTGT_MSK		(_ULCAST_(0x3) << 0)
-#define  CM_GCR_REGn_MASK_CMTGT_DISABLED	(_ULCAST_(0x0) << 0)
-#define  CM_GCR_REGn_MASK_CMTGT_MEM		(_ULCAST_(0x1) << 0)
-#define  CM_GCR_REGn_MASK_CMTGT_IOCU0		(_ULCAST_(0x2) << 0)
-#define  CM_GCR_REGn_MASK_CMTGT_IOCU1		(_ULCAST_(0x3) << 0)
-
-/* GCR_GIC_STATUS register fields */
-#define CM_GCR_GIC_STATUS_EX_SHF		0
-#define CM_GCR_GIC_STATUS_EX_MSK		(_ULCAST_(0x1) << 0)
-
-/* GCR_CPC_STATUS register fields */
-#define CM_GCR_CPC_STATUS_EX_SHF		0
-#define CM_GCR_CPC_STATUS_EX_MSK		(_ULCAST_(0x1) << 0)
-
-/* GCR_L2_CONFIG register fields */
-#define CM_GCR_L2_CONFIG_BYPASS_SHF		20
-#define CM_GCR_L2_CONFIG_BYPASS_MSK		(_ULCAST_(0x1) << 20)
-#define CM_GCR_L2_CONFIG_SET_SIZE_SHF		12
-#define CM_GCR_L2_CONFIG_SET_SIZE_MSK		(_ULCAST_(0xf) << 12)
-#define CM_GCR_L2_CONFIG_LINE_SIZE_SHF		8
-#define CM_GCR_L2_CONFIG_LINE_SIZE_MSK		(_ULCAST_(0xf) << 8)
-#define CM_GCR_L2_CONFIG_ASSOC_SHF		0
-#define CM_GCR_L2_CONFIG_ASSOC_MSK		(_ULCAST_(0xff) << 0)
-
-/* GCR_SYS_CONFIG2 register fields */
-#define CM_GCR_SYS_CONFIG2_MAXVPW_SHF		0
-#define CM_GCR_SYS_CONFIG2_MAXVPW_MSK		(_ULCAST_(0xf) << 0)
-
-/* GCR_L2_PFT_CONTROL register fields */
-#define CM_GCR_L2_PFT_CONTROL_PAGEMASK_SHF	12
-#define CM_GCR_L2_PFT_CONTROL_PAGEMASK_MSK	(_ULCAST_(0xfffff) << 12)
-#define CM_GCR_L2_PFT_CONTROL_PFTEN_SHF		8
-#define CM_GCR_L2_PFT_CONTROL_PFTEN_MSK		(_ULCAST_(0x1) << 8)
-#define CM_GCR_L2_PFT_CONTROL_NPFT_SHF		0
-#define CM_GCR_L2_PFT_CONTROL_NPFT_MSK		(_ULCAST_(0xff) << 0)
-
-/* GCR_L2_PFT_CONTROL_B register fields */
-#define CM_GCR_L2_PFT_CONTROL_B_CEN_SHF		8
-#define CM_GCR_L2_PFT_CONTROL_B_CEN_MSK		(_ULCAST_(0x1) << 8)
-#define CM_GCR_L2_PFT_CONTROL_B_PORTID_SHF	0
-#define CM_GCR_L2_PFT_CONTROL_B_PORTID_MSK	(_ULCAST_(0xff) << 0)
-
-/* GCR_Cx_COHERENCE register fields */
-#define CM_GCR_Cx_COHERENCE_COHDOMAINEN_SHF	0
-#define CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK	(_ULCAST_(0xff) << 0)
-#define CM3_GCR_Cx_COHERENCE_COHEN_MSK		(_ULCAST_(0x1) << 0)
-
-/* GCR_Cx_CONFIG register fields */
-#define CM_GCR_Cx_CONFIG_IOCUTYPE_SHF		10
-#define CM_GCR_Cx_CONFIG_IOCUTYPE_MSK		(_ULCAST_(0x3) << 10)
-#define CM_GCR_Cx_CONFIG_PVPE_SHF		0
-#define CM_GCR_Cx_CONFIG_PVPE_MSK		(_ULCAST_(0x3ff) << 0)
-
-/* GCR_Cx_OTHER register fields */
-#define CM_GCR_Cx_OTHER_CORENUM_SHF		16
-#define CM_GCR_Cx_OTHER_CORENUM_MSK		(_ULCAST_(0xffff) << 16)
-#define CM3_GCR_Cx_OTHER_CORE_SHF		8
-#define CM3_GCR_Cx_OTHER_CORE_MSK		(_ULCAST_(0x3f) << 8)
-#define CM3_GCR_Cx_OTHER_VP_SHF			0
-#define CM3_GCR_Cx_OTHER_VP_MSK			(_ULCAST_(0x7) << 0)
-
-/* GCR_Cx_RESET_BASE register fields */
-#define CM_GCR_Cx_RESET_BASE_BEVEXCBASE_SHF	12
-#define CM_GCR_Cx_RESET_BASE_BEVEXCBASE_MSK	(_ULCAST_(0xfffff) << 12)
-
-/* GCR_Cx_RESET_EXT_BASE register fields */
-#define CM_GCR_Cx_RESET_EXT_BASE_EVARESET_SHF	31
-#define CM_GCR_Cx_RESET_EXT_BASE_EVARESET_MSK	(_ULCAST_(0x1) << 31)
-#define CM_GCR_Cx_RESET_EXT_BASE_UEB_SHF	30
-#define CM_GCR_Cx_RESET_EXT_BASE_UEB_MSK	(_ULCAST_(0x1) << 30)
-#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCMASK_SHF	20
-#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCMASK_MSK	(_ULCAST_(0xff) << 20)
-#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCPA_SHF	1
-#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCPA_MSK	(_ULCAST_(0x7f) << 1)
-#define CM_GCR_Cx_RESET_EXT_BASE_PRESENT_SHF	0
-#define CM_GCR_Cx_RESET_EXT_BASE_PRESENT_MSK	(_ULCAST_(0x1) << 0)
+/* GCR_Cx_RESET_EXT_BASE - Configure behaviour when cores reset or power up */
+GCR_CX_ACCESSOR_RW(32, 0x030, reset_ext_base)
+#define CM_GCR_Cx_RESET_EXT_BASE_EVARESET	BIT(31)
+#define CM_GCR_Cx_RESET_EXT_BASE_UEB		BIT(30)
+#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCMASK	GENMASK(27, 20)
+#define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCPA	GENMASK(7, 1)
+#define CM_GCR_Cx_RESET_EXT_BASE_PRESENT	BIT(0)
 
 /**
  * mips_cm_numcores - return the number of cores present in the system
@@ -345,8 +294,8 @@ static inline unsigned mips_cm_numcores(void)
 	if (!mips_cm_present())
 		return 0;
 
-	return ((read_gcr_config() & CM_GCR_CONFIG_PCORES_MSK)
-		>> CM_GCR_CONFIG_PCORES_SHF) + 1;
+	return ((read_gcr_config() & CM_GCR_CONFIG_PCORES)
+		>> __ffs(CM_GCR_CONFIG_PCORES)) + 1;
 }
 
 /**
@@ -360,8 +309,8 @@ static inline unsigned mips_cm_numiocu(void)
 	if (!mips_cm_present())
 		return 0;
 
-	return (read_gcr_config() & CM_GCR_CONFIG_NUMIOCU_MSK)
-		>> CM_GCR_CONFIG_NUMIOCU_SHF;
+	return (read_gcr_config() & CM_GCR_CONFIG_NUMIOCU)
+		>> __ffs(CM_GCR_CONFIG_NUMIOCU);
 }
 
 /**
@@ -405,7 +354,7 @@ static inline unsigned int mips_cm_max_vp_width(void)
 	uint32_t cfg;
 
 	if (mips_cm_revision() >= CM_REV_CM3)
-		return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW_MSK;
+		return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW;
 
 	if (mips_cm_present()) {
 		/*
@@ -413,8 +362,8 @@ static inline unsigned int mips_cm_max_vp_width(void)
 		 * number of VP(E)s, and if that ever changes then this will
 		 * need revisiting.
 		 */
-		cfg = read_gcr_cl_config() & CM_GCR_Cx_CONFIG_PVPE_MSK;
-		return (cfg >> CM_GCR_Cx_CONFIG_PVPE_SHF) + 1;
+		cfg = read_gcr_cl_config() & CM_GCR_Cx_CONFIG_PVPE;
+		return (cfg >> __ffs(CM_GCR_Cx_CONFIG_PVPE)) + 1;
 	}
 
 	if (IS_ENABLED(CONFIG_SMP))
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 8b6b4976fb2f..7bbe0308617f 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -167,8 +167,8 @@ phys_addr_t __mips_cm_l2sync_phys_base(void)
 	 * current location.
 	 */
 	base_reg = read_gcr_l2_only_sync_base();
-	if (base_reg & CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN_MSK)
-		return base_reg & CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE_MSK;
+	if (base_reg & CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN)
+		return base_reg & CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE;
 
 	/* Default to following the CM */
 	return mips_cm_phys_base() + MIPS_CM_GCR_SIZE;
@@ -183,19 +183,19 @@ static void mips_cm_probe_l2sync(void)
 	phys_addr_t addr;
 
 	/* L2-only sync was introduced with CM major revision 6 */
-	major_rev = (read_gcr_rev() & CM_GCR_REV_MAJOR_MSK) >>
-		CM_GCR_REV_MAJOR_SHF;
+	major_rev = (read_gcr_rev() & CM_GCR_REV_MAJOR) >>
+		__ffs(CM_GCR_REV_MAJOR);
 	if (major_rev < 6)
 		return;
 
 	/* Find a location for the L2 sync region */
 	addr = mips_cm_l2sync_phys_base();
-	BUG_ON((addr & CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE_MSK) != addr);
+	BUG_ON((addr & CM_GCR_L2_ONLY_SYNC_BASE_SYNCBASE) != addr);
 	if (!addr)
 		return;
 
 	/* Set the region base address & enable it */
-	write_gcr_l2_only_sync_base(addr | CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN_MSK);
+	write_gcr_l2_only_sync_base(addr | CM_GCR_L2_ONLY_SYNC_BASE_SYNCEN);
 
 	/* Map the region */
 	mips_cm_l2sync_base = ioremap_nocache(addr, MIPS_CM_L2SYNC_SIZE);
@@ -215,7 +215,7 @@ int mips_cm_probe(void)
 		return 0;
 
 	addr = mips_cm_phys_base();
-	BUG_ON((addr & CM_GCR_BASE_GCRBASE_MSK) != addr);
+	BUG_ON((addr & CM_GCR_BASE_GCRBASE) != addr);
 	if (!addr)
 		return -ENODEV;
 
@@ -225,7 +225,7 @@ int mips_cm_probe(void)
 
 	/* sanity check that we're looking at a CM */
 	base_reg = read_gcr_base();
-	if ((base_reg & CM_GCR_BASE_GCRBASE_MSK) != addr) {
+	if ((base_reg & CM_GCR_BASE_GCRBASE) != addr) {
 		pr_err("GCRs appear to have been moved (expected them at 0x%08lx)!\n",
 		       (unsigned long)addr);
 		mips_gcr_base = NULL;
@@ -233,19 +233,19 @@ int mips_cm_probe(void)
 	}
 
 	/* set default target to memory */
-	base_reg &= ~CM_GCR_BASE_CMDEFTGT_MSK;
+	base_reg &= ~CM_GCR_BASE_CMDEFTGT;
 	base_reg |= CM_GCR_BASE_CMDEFTGT_MEM;
 	write_gcr_base(base_reg);
 
 	/* disable CM regions */
-	write_gcr_reg0_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
-	write_gcr_reg0_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
-	write_gcr_reg1_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
-	write_gcr_reg1_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
-	write_gcr_reg2_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
-	write_gcr_reg2_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
-	write_gcr_reg3_base(CM_GCR_REGn_BASE_BASEADDR_MSK);
-	write_gcr_reg3_mask(CM_GCR_REGn_MASK_ADDRMASK_MSK);
+	write_gcr_reg0_base(CM_GCR_REGn_BASE_BASEADDR);
+	write_gcr_reg0_mask(CM_GCR_REGn_MASK_ADDRMASK);
+	write_gcr_reg1_base(CM_GCR_REGn_BASE_BASEADDR);
+	write_gcr_reg1_mask(CM_GCR_REGn_MASK_ADDRMASK);
+	write_gcr_reg2_base(CM_GCR_REGn_BASE_BASEADDR);
+	write_gcr_reg2_mask(CM_GCR_REGn_MASK_ADDRMASK);
+	write_gcr_reg3_base(CM_GCR_REGn_BASE_BASEADDR);
+	write_gcr_reg3_mask(CM_GCR_REGn_MASK_ADDRMASK);
 
 	/* probe for an L2-only sync region */
 	mips_cm_probe_l2sync();
@@ -267,8 +267,8 @@ void mips_cm_lock_other(unsigned int core, unsigned int vp)
 	preempt_disable();
 
 	if (mips_cm_revision() >= CM_REV_CM3) {
-		val = core << CM3_GCR_Cx_OTHER_CORE_SHF;
-		val |= vp << CM3_GCR_Cx_OTHER_VP_SHF;
+		val = core << __ffs(CM3_GCR_Cx_OTHER_CORE);
+		val |= vp << __ffs(CM3_GCR_Cx_OTHER_VP);
 
 		/*
 		 * We need to disable interrupts in SMP systems in order to
@@ -293,7 +293,7 @@ void mips_cm_lock_other(unsigned int core, unsigned int vp)
 		spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
 				  per_cpu(cm_core_lock_flags, curr_core));
 
-		val = core << CM_GCR_Cx_OTHER_CORENUM_SHF;
+		val = core << __ffs(CM_GCR_Cx_OTHER_CORENUM);
 	}
 
 	write_gcr_cl_other(val);
@@ -337,8 +337,8 @@ void mips_cm_error_report(void)
 	cm_other = read_gcr_error_mult();
 
 	if (revision < CM_REV_CM3) { /* CM2 */
-		cause = cm_error >> CM_GCR_ERROR_CAUSE_ERRTYPE_SHF;
-		ocause = cm_other >> CM_GCR_ERROR_MULT_ERR2ND_SHF;
+		cause = cm_error >> __ffs(CM_GCR_ERROR_CAUSE_ERRTYPE);
+		ocause = cm_other >> __ffs(CM_GCR_ERROR_MULT_ERR2ND);
 
 		if (!cause)
 			return;
@@ -380,8 +380,8 @@ void mips_cm_error_report(void)
 		ulong core_id_bits, vp_id_bits, cmd_bits, cmd_group_bits;
 		ulong cm3_cca_bits, mcp_bits, cm3_tr_bits, sched_bit;
 
-		cause = cm_error >> CM3_GCR_ERROR_CAUSE_ERRTYPE_SHF;
-		ocause = cm_other >> CM_GCR_ERROR_MULT_ERR2ND_SHF;
+		cause = cm_error >> __ffs(CM3_GCR_ERROR_CAUSE_ERRTYPE);
+		ocause = cm_other >> __ffs(CM_GCR_ERROR_MULT_ERR2ND);
 
 		if (!cause)
 			return;
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index a4964c334cab..690eefd0fb54 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -40,13 +40,13 @@ static phys_addr_t mips_cpc_phys_base(void)
 	if (!mips_cm_present())
 		return 0;
 
-	if (!(read_gcr_cpc_status() & CM_GCR_CPC_STATUS_EX_MSK))
+	if (!(read_gcr_cpc_status() & CM_GCR_CPC_STATUS_EX))
 		return 0;
 
 	/* If the CPC is already enabled, leave it so */
 	cpc_base = read_gcr_cpc_base();
-	if (cpc_base & CM_GCR_CPC_BASE_CPCEN_MSK)
-		return cpc_base & CM_GCR_CPC_BASE_CPCBASE_MSK;
+	if (cpc_base & CM_GCR_CPC_BASE_CPCEN)
+		return cpc_base & CM_GCR_CPC_BASE_CPCBASE;
 
 	/* Otherwise, use the default address */
 	cpc_base = mips_cpc_default_phys_base();
@@ -54,7 +54,7 @@ static phys_addr_t mips_cpc_phys_base(void)
 		return cpc_base;
 
 	/* Enable the CPC, mapped at the default address */
-	write_gcr_cpc_base(cpc_base | CM_GCR_CPC_BASE_CPCEN_MSK);
+	write_gcr_cpc_base(cpc_base | CM_GCR_CPC_BASE_CPCEN);
 	return cpc_base;
 }
 
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index d99416094ba9..357b451c43a7 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -569,8 +569,8 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	 * rest will just be performing a rather unusual nop.
 	 */
 	uasm_i_addiu(&p, t0, zero, mips_cm_revision() < CM_REV_CM3
-				? CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK
-				: CM3_GCR_Cx_COHERENCE_COHEN_MSK);
+				? CM_GCR_Cx_COHERENCE_COHDOMAINEN
+				: CM3_GCR_Cx_COHERENCE_COHEN);
 
 	uasm_i_sw(&p, t0, 0, r_pcohctl);
 	uasm_i_lw(&p, t0, 0, r_pcohctl);
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index a6b8700563c7..b544d3df3b73 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -53,9 +53,9 @@ static unsigned core_vpe_count(unsigned core)
 		return 1;
 
 	mips_cm_lock_other(core, 0);
-	cfg = read_gcr_co_config() & CM_GCR_Cx_CONFIG_PVPE_MSK;
+	cfg = read_gcr_co_config() & CM_GCR_Cx_CONFIG_PVPE;
 	mips_cm_unlock_other();
-	return (cfg >> CM_GCR_Cx_CONFIG_PVPE_SHF) + 1;
+	return cfg + 1;
 }
 
 static void __init cps_smp_setup(void)
@@ -225,11 +225,11 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	write_gcr_co_coherence(0);
 
 	/* Start it with the legacy memory map and exception base */
-	write_gcr_co_reset_ext_base(CM_GCR_RESET_EXT_BASE_UEB);
+	write_gcr_co_reset_ext_base(CM_GCR_Cx_RESET_EXT_BASE_UEB);
 
 	/* Ensure the core can access the GCRs */
 	access = read_gcr_access();
-	access |= 1 << (CM_GCR_ACCESS_ACCESSEN_SHF + core);
+	access |= 1 << core;
 	write_gcr_access(access);
 
 	if (mips_cpc_present()) {
@@ -599,7 +599,7 @@ int register_cps_smp_ops(void)
 	}
 
 	/* check we have a GIC - we need one for IPIs */
-	if (!(read_gcr_gic_status() & CM_GCR_GIC_STATUS_EX_MSK)) {
+	if (!(read_gcr_gic_status() & CM_GCR_GIC_STATUS_EX)) {
 		pr_warn("MIPS CPS SMP unable to proceed without a GIC\n");
 		return -ENODEV;
 	}
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f3a69de9dc6b..4cba2e778284 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1672,7 +1672,7 @@ static inline void parity_protection_init(void)
 		/* Probe L2 ECC support */
 		gcr_ectl = read_gcr_err_control();
 
-		if (!(gcr_ectl & CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_MSK) ||
+		if (!(gcr_ectl & CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT) ||
 		    !(cp0_ectl & ERRCTL_PE)) {
 			/*
 			 * One of L1 or L2 ECC checking isn't supported,
@@ -1692,12 +1692,12 @@ static inline void parity_protection_init(void)
 
 		/* Configure L2 ECC checking */
 		if (l2parity)
-			gcr_ectl |= CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+			gcr_ectl |= CM_GCR_ERR_CONTROL_L2_ECC_EN;
 		else
-			gcr_ectl &= ~CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+			gcr_ectl &= ~CM_GCR_ERR_CONTROL_L2_ECC_EN;
 		write_gcr_err_control(gcr_ectl);
 		gcr_ectl = read_gcr_err_control();
-		gcr_ectl &= CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+		gcr_ectl &= CM_GCR_ERR_CONTROL_L2_ECC_EN;
 		WARN_ON(!!gcr_ectl != l2parity);
 
 		pr_info("Cache parity protection %sabled\n",
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index c909c3342729..7f30397cb10d 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -63,15 +63,15 @@ static void mips_sc_prefetch_enable(void)
 	 * prefetching for both code & data, for all ports.
 	 */
 	pftctl = read_gcr_l2_pft_control();
-	if (pftctl & CM_GCR_L2_PFT_CONTROL_NPFT_MSK) {
-		pftctl &= ~CM_GCR_L2_PFT_CONTROL_PAGEMASK_MSK;
-		pftctl |= PAGE_MASK & CM_GCR_L2_PFT_CONTROL_PAGEMASK_MSK;
-		pftctl |= CM_GCR_L2_PFT_CONTROL_PFTEN_MSK;
+	if (pftctl & CM_GCR_L2_PFT_CONTROL_NPFT) {
+		pftctl &= ~CM_GCR_L2_PFT_CONTROL_PAGEMASK;
+		pftctl |= PAGE_MASK & CM_GCR_L2_PFT_CONTROL_PAGEMASK;
+		pftctl |= CM_GCR_L2_PFT_CONTROL_PFTEN;
 		write_gcr_l2_pft_control(pftctl);
 
 		pftctl = read_gcr_l2_pft_control_b();
-		pftctl |= CM_GCR_L2_PFT_CONTROL_B_PORTID_MSK;
-		pftctl |= CM_GCR_L2_PFT_CONTROL_B_CEN_MSK;
+		pftctl |= CM_GCR_L2_PFT_CONTROL_B_PORTID;
+		pftctl |= CM_GCR_L2_PFT_CONTROL_B_CEN;
 		write_gcr_l2_pft_control_b(pftctl);
 	}
 }
@@ -84,12 +84,12 @@ static void mips_sc_prefetch_disable(void)
 		return;
 
 	pftctl = read_gcr_l2_pft_control();
-	pftctl &= ~CM_GCR_L2_PFT_CONTROL_PFTEN_MSK;
+	pftctl &= ~CM_GCR_L2_PFT_CONTROL_PFTEN;
 	write_gcr_l2_pft_control(pftctl);
 
 	pftctl = read_gcr_l2_pft_control_b();
-	pftctl &= ~CM_GCR_L2_PFT_CONTROL_B_PORTID_MSK;
-	pftctl &= ~CM_GCR_L2_PFT_CONTROL_B_CEN_MSK;
+	pftctl &= ~CM_GCR_L2_PFT_CONTROL_B_PORTID;
+	pftctl &= ~CM_GCR_L2_PFT_CONTROL_B_CEN;
 	write_gcr_l2_pft_control_b(pftctl);
 }
 
@@ -101,9 +101,9 @@ static bool mips_sc_prefetch_is_enabled(void)
 		return false;
 
 	pftctl = read_gcr_l2_pft_control();
-	if (!(pftctl & CM_GCR_L2_PFT_CONTROL_NPFT_MSK))
+	if (!(pftctl & CM_GCR_L2_PFT_CONTROL_NPFT))
 		return false;
-	return !!(pftctl & CM_GCR_L2_PFT_CONTROL_PFTEN_MSK);
+	return !!(pftctl & CM_GCR_L2_PFT_CONTROL_PFTEN);
 }
 
 static struct bcache_ops mips_sc_ops = {
@@ -160,21 +160,21 @@ static int __init mips_sc_probe_cm3(void)
 	unsigned long cfg = read_gcr_l2_config();
 	unsigned long sets, line_sz, assoc;
 
-	if (cfg & CM_GCR_L2_CONFIG_BYPASS_MSK)
+	if (cfg & CM_GCR_L2_CONFIG_BYPASS)
 		return 0;
 
-	sets = cfg & CM_GCR_L2_CONFIG_SET_SIZE_MSK;
-	sets >>= CM_GCR_L2_CONFIG_SET_SIZE_SHF;
+	sets = cfg & CM_GCR_L2_CONFIG_SET_SIZE;
+	sets >>= __ffs(CM_GCR_L2_CONFIG_SET_SIZE);
 	if (sets)
 		c->scache.sets = 64 << sets;
 
-	line_sz = cfg & CM_GCR_L2_CONFIG_LINE_SIZE_MSK;
-	line_sz >>= CM_GCR_L2_CONFIG_LINE_SIZE_SHF;
+	line_sz = cfg & CM_GCR_L2_CONFIG_LINE_SIZE;
+	line_sz >>= __ffs(CM_GCR_L2_CONFIG_LINE_SIZE);
 	if (line_sz)
 		c->scache.linesz = 2 << line_sz;
 
-	assoc = cfg & CM_GCR_L2_CONFIG_ASSOC_MSK;
-	assoc >>= CM_GCR_L2_CONFIG_ASSOC_SHF;
+	assoc = cfg & CM_GCR_L2_CONFIG_ASSOC;
+	assoc >>= __ffs(CM_GCR_L2_CONFIG_ASSOC);
 	c->scache.ways = assoc + 1;
 	c->scache.waysize = c->scache.sets * c->scache.linesz;
 	c->scache.waybit = __ffs(c->scache.waysize);
diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index c398582c316f..67602d57710c 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -236,7 +236,7 @@ static void __init remove_gic(void *fdt)
 
 	/* if we have a CM which reports a GIC is present, leave the DT alone */
 	err = mips_cm_probe();
-	if (!err && (read_gcr_gic_status() & CM_GCR_GIC_STATUS_GICEX_MSK))
+	if (!err && (read_gcr_gic_status() & CM_GCR_GIC_STATUS_GICEX))
 		return;
 
 	if (malta_scon() == MIPS_REVISION_SCON_ROCIT) {
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6ab1d3afec02..ae9f8e581d06 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -1009,7 +1009,7 @@ static int __init gic_of_init(struct device_node *node,
 		 */
 		if (mips_cm_present()) {
 			gic_base = read_gcr_gic_base() &
-				~CM_GCR_GIC_BASE_GICEN_MSK;
+				~CM_GCR_GIC_BASE_GICEN;
 			gic_len = 0x20000;
 		} else {
 			pr_err("Failed to get GIC memory range\n");
@@ -1021,7 +1021,7 @@ static int __init gic_of_init(struct device_node *node,
 	}
 
 	if (mips_cm_present())
-		write_gcr_gic_base(gic_base | CM_GCR_GIC_BASE_GICEN_MSK);
+		write_gcr_gic_base(gic_base | CM_GCR_GIC_BASE_GICEN);
 	gic_present = true;
 
 	__gic_init(gic_base, gic_len, cpu_vec, 0, node);
-- 
2.14.0
