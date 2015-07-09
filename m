Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:45:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35086 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009961AbbGIJlwp0Mph (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 11:41:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2CFB5DDDCBFB2
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 10:41:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 10:41:45 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 9 Jul 2015 10:41:45 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 13/19] MIPS: kernel: mips-cm: Add support for reporting CM cache errors
Date:   Thu, 9 Jul 2015 10:40:47 +0100
Message-ID: <1436434853-30001-14-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48150
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

The CM cache error reporting code is not Malta specific and as such it
should live in the mips-cm.c file. Moreover, CM2 and CM3 differ in the
way cache errors are being recorded to the registers so extend the
previous code to add support for the CM3 as well.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mips-cm.h |   9 ++
 arch/mips/kernel/mips-cm.c      | 244 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/mti-malta/malta-int.c | 112 +-----------------
 3 files changed, 254 insertions(+), 111 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 273b89a685d5..4810379349d3 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -48,6 +48,15 @@ extern phys_addr_t __mips_cm_phys_base(void);
 extern int mips_cm_is64;
 
 /**
+ * mips_cm_error_report - Report CM cache errors
+ */
+#ifdef CONFIG_MIPS_CM
+extern void mips_cm_error_report(void);
+#else
+static inline void mips_cm_error_report(void) {}
+#endif
+
+/**
  * mips_cm_probe - probe for a Coherence Manager
  *
  * Attempt to detect the presence of a Coherence Manager. Returns 0 if a CM
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 37a9885ef0da..20f36cc9161e 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -17,6 +17,125 @@ void __iomem *mips_cm_base;
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
 
+static char *cm2_tr[8] = {
+	"mem",	"gcr",	"gic",	"mmio",
+	"0x04", "cpc", "0x06", "0x07"
+};
+
+/* CM3 Tag ECC transation type */
+static char *cm3_tr[16] = {
+	[0x0] = "ReqNoData",
+	[0x1] = "0x1",
+	[0x2] = "ReqWData",
+	[0x3] = "0x3",
+	[0x4] = "IReqNoResp",
+	[0x5] = "IReqWResp",
+	[0x6] = "IReqNoRespDat",
+	[0x7] = "IReqWRespDat",
+	[0x8] = "RespNoData",
+	[0x9] = "RespDataFol",
+	[0xa] = "RespWData",
+	[0xb] = "RespDataOnly",
+	[0xc] = "IRespNoData",
+	[0xd] = "IRespDataFol",
+	[0xe] = "IRespWData",
+	[0xf] = "IRespDataOnly"
+};
+
+static char *cm2_cmd[32] = {
+	[0x00] = "0x00",
+	[0x01] = "Legacy Write",
+	[0x02] = "Legacy Read",
+	[0x03] = "0x03",
+	[0x04] = "0x04",
+	[0x05] = "0x05",
+	[0x06] = "0x06",
+	[0x07] = "0x07",
+	[0x08] = "Coherent Read Own",
+	[0x09] = "Coherent Read Share",
+	[0x0a] = "Coherent Read Discard",
+	[0x0b] = "Coherent Ready Share Always",
+	[0x0c] = "Coherent Upgrade",
+	[0x0d] = "Coherent Writeback",
+	[0x0e] = "0x0e",
+	[0x0f] = "0x0f",
+	[0x10] = "Coherent Copyback",
+	[0x11] = "Coherent Copyback Invalidate",
+	[0x12] = "Coherent Invalidate",
+	[0x13] = "Coherent Write Invalidate",
+	[0x14] = "Coherent Completion Sync",
+	[0x15] = "0x15",
+	[0x16] = "0x16",
+	[0x17] = "0x17",
+	[0x18] = "0x18",
+	[0x19] = "0x19",
+	[0x1a] = "0x1a",
+	[0x1b] = "0x1b",
+	[0x1c] = "0x1c",
+	[0x1d] = "0x1d",
+	[0x1e] = "0x1e",
+	[0x1f] = "0x1f"
+};
+
+/* CM3 Tag ECC command type */
+static char *cm3_cmd[16] = {
+	[0x0] = "Legacy Read",
+	[0x1] = "Legacy Write",
+	[0x2] = "Coherent Read Own",
+	[0x3] = "Coherent Read Share",
+	[0x4] = "Coherent Read Discard",
+	[0x5] = "Coherent Evicted",
+	[0x6] = "Coherent Upgrade",
+	[0x7] = "Coherent Upgrade for Store Conditional",
+	[0x8] = "Coherent Writeback",
+	[0x9] = "Coherent Write Invalidate",
+	[0xa] = "0xa",
+	[0xb] = "0xb",
+	[0xc] = "0xc",
+	[0xd] = "0xd",
+	[0xe] = "0xe",
+	[0xf] = "0xf"
+};
+
+/* CM3 Tag ECC command group */
+static char *cm3_cmd_group[8] = {
+	[0x0] = "Normal",
+	[0x1] = "Registers",
+	[0x2] = "TLB",
+	[0x3] = "0x3",
+	[0x4] = "L1I",
+	[0x5] = "L1D",
+	[0x6] = "L3",
+	[0x7] = "L2"
+};
+
+static char *cm2_core[8] = {
+	"Invalid/OK",	"Invalid/Data",
+	"Shared/OK",	"Shared/Data",
+	"Modified/OK",	"Modified/Data",
+	"Exclusive/OK", "Exclusive/Data"
+};
+
+static char *cm2_causes[32] = {
+	"None", "GC_WR_ERR", "GC_RD_ERR", "COH_WR_ERR",
+	"COH_RD_ERR", "MMIO_WR_ERR", "MMIO_RD_ERR", "0x07",
+	"0x08", "0x09", "0x0a", "0x0b",
+	"0x0c", "0x0d", "0x0e", "0x0f",
+	"0x10", "0x11", "0x12", "0x13",
+	"0x14", "0x15", "0x16", "INTVN_WR_ERR",
+	"INTVN_RD_ERR", "0x19", "0x1a", "0x1b",
+	"0x1c", "0x1d", "0x1e", "0x1f"
+};
+
+static char *cm3_causes[32] = {
+	"0x0", "MP_CORRECTABLE_ECC_ERR", "MP_REQUEST_DECODE_ERR",
+	"MP_UNCORRECTABLE_ECC_ERR", "MP_PARITY_ERR", "MP_COHERENCE_ERR",
+	"CMBIU_REQUEST_DECODE_ERR", "CMBIU_PARITY_ERR", "CMBIU_AXI_RESP_ERR",
+	"0x9", "RBI_BUS_ERR", "0xb", "0xc", "0xd", "0xe", "0xf", "0x10",
+	"0x11", "0x12", "0x13", "0x14", "0x15", "0x16", "0x17", "0x18",
+	"0x19", "0x1a", "0x1b", "0x1c", "0x1d", "0x1e", "0x1f"
+};
+
 phys_addr_t __mips_cm_phys_base(void)
 {
 	u32 config3 = read_c0_config3();
@@ -130,3 +249,128 @@ int mips_cm_probe(void)
 
 	return 0;
 }
+
+void mips_cm_error_report(void)
+{
+	unsigned long revision = mips_cm_revision();
+	/*
+	 * CM3 has a 64-bit Error cause register with 0:57 containing the error
+	 * info and 63:58 the error type. For old CMs, everything is contained
+	 * in a single 32-bit register (0:26 and 31:27 respectively). Even
+	 * though the cm_error is u64, we will simply ignore the upper word
+	 * for CM2.
+	 */
+	u64 cm_error = read_gcr_error_cause();
+	int cm_error_cause_sft = CM_GCR_ERROR_CAUSE_ERRTYPE_SHF +
+				 ((revision >= CM_REV_CM3) ? 31 : 0);
+	unsigned long cm_addr = read_gcr_error_addr();
+	unsigned long cm_other = read_gcr_error_mult();
+	int ocause, cause;
+	char buf[256];
+
+	if (!mips_cm_present())
+		return;
+
+	cause = cm_error >> cm_error_cause_sft;
+
+	if (!cause)
+		/* All good */
+		return;
+
+	ocause = cm_other >> CM_GCR_ERROR_MULT_ERR2ND_SHF;
+	if (revision < CM_REV_CM3) { /* CM2 */
+		if (cause < 16) {
+			unsigned long cca_bits = (cm_error >> 15) & 7;
+			unsigned long tr_bits = (cm_error >> 12) & 7;
+			unsigned long cmd_bits = (cm_error >> 7) & 0x1f;
+			unsigned long stag_bits = (cm_error >> 3) & 15;
+			unsigned long sport_bits = (cm_error >> 0) & 7;
+
+			snprintf(buf, sizeof(buf),
+				 "CCA=%lu TR=%s MCmd=%s STag=%lu "
+				 "SPort=%lu\n", cca_bits, cm2_tr[tr_bits],
+				 cm2_cmd[cmd_bits], stag_bits, sport_bits);
+		} else {
+			/* glob state & sresp together */
+			unsigned long c3_bits = (cm_error >> 18) & 7;
+			unsigned long c2_bits = (cm_error >> 15) & 7;
+			unsigned long c1_bits = (cm_error >> 12) & 7;
+			unsigned long c0_bits = (cm_error >> 9) & 7;
+			unsigned long sc_bit = (cm_error >> 8) & 1;
+			unsigned long cmd_bits = (cm_error >> 3) & 0x1f;
+			unsigned long sport_bits = (cm_error >> 0) & 7;
+
+			snprintf(buf, sizeof(buf),
+				 "C3=%s C2=%s C1=%s C0=%s SC=%s "
+				 "MCmd=%s SPort=%lu\n",
+				 cm2_core[c3_bits], cm2_core[c2_bits],
+				 cm2_core[c1_bits], cm2_core[c0_bits],
+				 sc_bit ? "True" : "False",
+				 cm2_cmd[cmd_bits], sport_bits);
+		}
+			pr_err("CM_ERROR=%08llx %s <%s>\n", cm_error,
+			       cm2_causes[cause], buf);
+		pr_err("CM_ADDR =%08lx\n", cm_addr);
+		pr_err("CM_OTHER=%08lx %s\n", cm_other, cm2_causes[ocause]);
+	} else { /* CM3 */
+	/* Used by cause == {1,2,3} */
+		unsigned long core_id_bits = (cm_error >> 22) & 0xf;
+		unsigned long vp_id_bits = (cm_error >> 18) & 0xf;
+		unsigned long cmd_bits = (cm_error >> 14) & 0xf;
+		unsigned long cmd_group_bits = (cm_error >> 11) & 0xf;
+		unsigned long cm3_cca_bits = (cm_error >> 8) & 7;
+		unsigned long mcp_bits = (cm_error >> 5) & 0xf;
+		unsigned long cm3_tr_bits = (cm_error >> 1) & 0xf;
+		unsigned long sched_bit = cm_error & 0x1;
+
+		if (cause == 1 || cause == 3) { /* Tag ECC */
+			unsigned long tag_ecc = (cm_error >> 57) & 0x1;
+			unsigned long tag_way_bits = (cm_error >> 29) & 0xffff;
+			unsigned long dword_bits = (cm_error >> 49) & 0xff;
+			unsigned long data_way_bits = (cm_error >> 45) & 0xf;
+			unsigned long data_sets_bits = (cm_error >> 29) & 0xfff;
+			unsigned long bank_bit = (cm_error >> 28) & 0x1;
+			snprintf(buf, sizeof(buf),
+				 "%s ECC Error: Way=%lu (DWORD=%lu, Sets=%lu)"
+				 "Bank=%lu CoreID=%lu VPID=%lu Command=%s"
+				 "Command Group=%s CCA=%lu MCP=%d"
+				 "Transaction type=%s Scheduler=%lu\n",
+				 tag_ecc ? "TAG" : "DATA",
+				 tag_ecc ? (unsigned long)ffs(tag_way_bits) - 1 :
+				 data_way_bits, bank_bit, dword_bits,
+				 data_sets_bits,
+				 core_id_bits, vp_id_bits,
+				 cm3_cmd[cmd_bits],
+				 cm3_cmd_group[cmd_group_bits],
+				 cm3_cca_bits, 1 << mcp_bits,
+				 cm3_tr[cm3_tr_bits], sched_bit);
+		} else if (cause == 2) {
+			unsigned long data_error_type = (cm_error >> 41) & 0xfff;
+			unsigned long data_decode_cmd = (cm_error >> 37) & 0xf;
+			unsigned long data_decode_group = (cm_error >> 34) & 0x7;
+			unsigned long data_decode_destination_id = (cm_error >> 28) & 0x3f;
+
+			snprintf(buf, sizeof(buf),
+				 "Decode Request Error: Type=%lu, Command=%lu"
+				 "Command Group=%lu Destination ID=%lu"
+				 "CoreID=%lu VPID=%lu Command=%s"
+				 "Command Group=%s CCA=%lu MCP=%d"
+				 "Transaction type=%s Scheduler=%lu\n",
+				 data_error_type, data_decode_cmd,
+				 data_decode_group, data_decode_destination_id,
+				 core_id_bits, vp_id_bits,
+				 cm3_cmd[cmd_bits],
+				 cm3_cmd_group[cmd_group_bits],
+				 cm3_cca_bits, 1 << mcp_bits,
+				 cm3_tr[cm3_tr_bits], sched_bit);
+		}
+
+		pr_err("CM_ERROR=%llx %s <%s>\n", cm_error,
+		       cm3_causes[cause], buf);
+		pr_err("CM_ADDR =%lx\n", cm_addr);
+		pr_err("CM_OTHER=%lx %s\n", cm_other, cm3_causes[ocause]);
+	}
+
+	/* reprime cause register */
+	write_gcr_error_cause(0);
+}
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index d1392f8f5811..f05aa841f8fb 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -382,122 +382,12 @@ void malta_be_init(void)
 	/* Could change CM error mask register. */
 }
 
-
-static char *tr[8] = {
-	"mem",	"gcr",	"gic",	"mmio",
-	"0x04", "0x05", "0x06", "0x07"
-};
-
-static char *mcmd[32] = {
-	[0x00] = "0x00",
-	[0x01] = "Legacy Write",
-	[0x02] = "Legacy Read",
-	[0x03] = "0x03",
-	[0x04] = "0x04",
-	[0x05] = "0x05",
-	[0x06] = "0x06",
-	[0x07] = "0x07",
-	[0x08] = "Coherent Read Own",
-	[0x09] = "Coherent Read Share",
-	[0x0a] = "Coherent Read Discard",
-	[0x0b] = "Coherent Ready Share Always",
-	[0x0c] = "Coherent Upgrade",
-	[0x0d] = "Coherent Writeback",
-	[0x0e] = "0x0e",
-	[0x0f] = "0x0f",
-	[0x10] = "Coherent Copyback",
-	[0x11] = "Coherent Copyback Invalidate",
-	[0x12] = "Coherent Invalidate",
-	[0x13] = "Coherent Write Invalidate",
-	[0x14] = "Coherent Completion Sync",
-	[0x15] = "0x15",
-	[0x16] = "0x16",
-	[0x17] = "0x17",
-	[0x18] = "0x18",
-	[0x19] = "0x19",
-	[0x1a] = "0x1a",
-	[0x1b] = "0x1b",
-	[0x1c] = "0x1c",
-	[0x1d] = "0x1d",
-	[0x1e] = "0x1e",
-	[0x1f] = "0x1f"
-};
-
-static char *core[8] = {
-	"Invalid/OK",	"Invalid/Data",
-	"Shared/OK",	"Shared/Data",
-	"Modified/OK",	"Modified/Data",
-	"Exclusive/OK", "Exclusive/Data"
-};
-
-static char *causes[32] = {
-	"None", "GC_WR_ERR", "GC_RD_ERR", "COH_WR_ERR",
-	"COH_RD_ERR", "MMIO_WR_ERR", "MMIO_RD_ERR", "0x07",
-	"0x08", "0x09", "0x0a", "0x0b",
-	"0x0c", "0x0d", "0x0e", "0x0f",
-	"0x10", "0x11", "0x12", "0x13",
-	"0x14", "0x15", "0x16", "INTVN_WR_ERR",
-	"INTVN_RD_ERR", "0x19", "0x1a", "0x1b",
-	"0x1c", "0x1d", "0x1e", "0x1f"
-};
-
 int malta_be_handler(struct pt_regs *regs, int is_fixup)
 {
 	/* This duplicates the handling in do_be which seems wrong */
 	int retval = is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
 
-	if (mips_cm_present()) {
-		unsigned long cm_error = read_gcr_error_cause();
-		unsigned long cm_addr = read_gcr_error_addr();
-		unsigned long cm_other = read_gcr_error_mult();
-		unsigned long cause, ocause;
-		char buf[256];
-
-		cause = cm_error & CM_GCR_ERROR_CAUSE_ERRTYPE_MSK;
-		if (cause != 0) {
-			cause >>= CM_GCR_ERROR_CAUSE_ERRTYPE_SHF;
-			if (cause < 16) {
-				unsigned long cca_bits = (cm_error >> 15) & 7;
-				unsigned long tr_bits = (cm_error >> 12) & 7;
-				unsigned long cmd_bits = (cm_error >> 7) & 0x1f;
-				unsigned long stag_bits = (cm_error >> 3) & 15;
-				unsigned long sport_bits = (cm_error >> 0) & 7;
-
-				snprintf(buf, sizeof(buf),
-					 "CCA=%lu TR=%s MCmd=%s STag=%lu "
-					 "SPort=%lu\n",
-					 cca_bits, tr[tr_bits], mcmd[cmd_bits],
-					 stag_bits, sport_bits);
-			} else {
-				/* glob state & sresp together */
-				unsigned long c3_bits = (cm_error >> 18) & 7;
-				unsigned long c2_bits = (cm_error >> 15) & 7;
-				unsigned long c1_bits = (cm_error >> 12) & 7;
-				unsigned long c0_bits = (cm_error >> 9) & 7;
-				unsigned long sc_bit = (cm_error >> 8) & 1;
-				unsigned long cmd_bits = (cm_error >> 3) & 0x1f;
-				unsigned long sport_bits = (cm_error >> 0) & 7;
-				snprintf(buf, sizeof(buf),
-					 "C3=%s C2=%s C1=%s C0=%s SC=%s "
-					 "MCmd=%s SPort=%lu\n",
-					 core[c3_bits], core[c2_bits],
-					 core[c1_bits], core[c0_bits],
-					 sc_bit ? "True" : "False",
-					 mcmd[cmd_bits], sport_bits);
-			}
-
-			ocause = (cm_other & CM_GCR_ERROR_MULT_ERR2ND_MSK) >>
-				 CM_GCR_ERROR_MULT_ERR2ND_SHF;
-
-			pr_err("CM_ERROR=%08lx %s <%s>\n", cm_error,
-			       causes[cause], buf);
-			pr_err("CM_ADDR =%08lx\n", cm_addr);
-			pr_err("CM_OTHER=%08lx %s\n", cm_other, causes[ocause]);
-
-			/* reprime cause register */
-			write_gcr_error_cause(0);
-		}
-	}
+	mips_cm_error_report();
 
 	return retval;
 }
-- 
2.4.5
