Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:28:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42536 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009091AbbIVR2cTMudU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:28:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7E4396F0F8E44;
        Tue, 22 Sep 2015 18:28:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:28:26 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:28:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 5/5] MIPS: always read full 64 bit CM error GCRs for CM3
Date:   Tue, 22 Sep 2015 10:26:41 -0700
Message-ID: <1442942801-2883-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442942801-2883-1-git-send-email-paul.burton@imgtec.com>
References: <1442942801-2883-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49289
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

CM3 has 64 bit GCR_ERROR_* registers, but the code in
mips_cm_error_report was previously only reading 32 bits of it in MIPS32
kernels. Fix by splitting the reads for CM2 & CM3, and making use of the
read64_ variants of the accessor function for CM3.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mips-cm.h |  3 ++
 arch/mips/kernel/mips-cm.c      | 70 +++++++++++++++++++++--------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index b9df4b2..82e7e92 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -11,6 +11,7 @@
 #ifndef __MIPS_ASM_MIPS_CM_H__
 #define __MIPS_ASM_MIPS_CM_H__
 
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/types.h>
@@ -259,6 +260,8 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 /* GCR_ERROR_CAUSE register fields */
 #define CM_GCR_ERROR_CAUSE_ERRTYPE_SHF		27
 #define CM_GCR_ERROR_CAUSE_ERRTYPE_MSK		(_ULCAST_(0x1f) << 27)
+#define CM3_GCR_ERROR_CAUSE_ERRTYPE_SHF		58
+#define CM3_GCR_ERROR_CAUSE_ERRTYPE_MSK		GENMASK_ULL(63, 58)
 #define CM_GCR_ERROR_CAUSE_ERRINFO_SHF		0
 #define CM_GCR_ERROR_CAUSE_ERRINGO_MSK		(_ULCAST_(0x7ffffff) << 0)
 
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 88a8e21..02f7d7a 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -252,36 +252,26 @@ int mips_cm_probe(void)
 
 void mips_cm_error_report(void)
 {
-	/*
-	 * CM3 has a 64-bit Error cause register with 0:57 containing the error
-	 * info and 63:58 the error type. For old CMs, everything is contained
-	 * in a single 32-bit register (0:26 and 31:27 respectively). Even
-	 * though the cm_error is u64, we will simply ignore the upper word
-	 * for CM2.
-	 */
-	u64 cm_error;
-	unsigned long revision, cm_addr, cm_other;
-	int ocause, cause, cm_error_cause_sft;
+	u64 cm_error, cm_addr, cm_other;
+	unsigned long revision;
+	int ocause, cause;
 	char buf[256];
 
 	if (!mips_cm_present())
 		return;
 
 	revision = mips_cm_revision();
-	cm_error = read_gcr_error_cause();
-	cm_addr = read_gcr_error_addr();
-	cm_other = read_gcr_error_mult();
 
-	cm_error_cause_sft = CM_GCR_ERROR_CAUSE_ERRTYPE_SHF +
-				 ((revision >= CM_REV_CM3) ? 31 : 0);
-	cause = cm_error >> cm_error_cause_sft;
+	if (revision < CM_REV_CM3) { /* CM2 */
+		cm_error = read_gcr_error_cause();
+		cm_addr = read_gcr_error_addr();
+		cm_other = read_gcr_error_mult();
+		cause = cm_error >> CM_GCR_ERROR_CAUSE_ERRTYPE_SHF;
+		ocause = cm_other >> CM_GCR_ERROR_MULT_ERR2ND_SHF;
 
-	if (!cause)
-		/* All good */
-		return;
+		if (!cause)
+			return;
 
-	ocause = cm_other >> CM_GCR_ERROR_MULT_ERR2ND_SHF;
-	if (revision < CM_REV_CM3) { /* CM2 */
 		if (cause < 16) {
 			unsigned long cca_bits = (cm_error >> 15) & 7;
 			unsigned long tr_bits = (cm_error >> 12) & 7;
@@ -313,18 +303,30 @@ void mips_cm_error_report(void)
 		}
 			pr_err("CM_ERROR=%08llx %s <%s>\n", cm_error,
 			       cm2_causes[cause], buf);
-		pr_err("CM_ADDR =%08lx\n", cm_addr);
-		pr_err("CM_OTHER=%08lx %s\n", cm_other, cm2_causes[ocause]);
+		pr_err("CM_ADDR =%08llx\n", cm_addr);
+		pr_err("CM_OTHER=%08llx %s\n", cm_other, cm2_causes[ocause]);
 	} else { /* CM3 */
-	/* Used by cause == {1,2,3} */
-		unsigned long core_id_bits = (cm_error >> 22) & 0xf;
-		unsigned long vp_id_bits = (cm_error >> 18) & 0xf;
-		unsigned long cmd_bits = (cm_error >> 14) & 0xf;
-		unsigned long cmd_group_bits = (cm_error >> 11) & 0xf;
-		unsigned long cm3_cca_bits = (cm_error >> 8) & 7;
-		unsigned long mcp_bits = (cm_error >> 5) & 0xf;
-		unsigned long cm3_tr_bits = (cm_error >> 1) & 0xf;
-		unsigned long sched_bit = cm_error & 0x1;
+		ulong core_id_bits, vp_id_bits, cmd_bits, cmd_group_bits;
+		ulong cm3_cca_bits, mcp_bits, cm3_tr_bits, sched_bit;
+
+		cm_error = read64_gcr_error_cause();
+		cm_addr = read64_gcr_error_addr();
+		cm_other = read64_gcr_error_mult();
+		cause = cm_error >> CM3_GCR_ERROR_CAUSE_ERRTYPE_SHF;
+		ocause = cm_other >> CM_GCR_ERROR_MULT_ERR2ND_SHF;
+
+		if (!cause)
+			return;
+
+		/* Used by cause == {1,2,3} */
+		core_id_bits = (cm_error >> 22) & 0xf;
+		vp_id_bits = (cm_error >> 18) & 0xf;
+		cmd_bits = (cm_error >> 14) & 0xf;
+		cmd_group_bits = (cm_error >> 11) & 0xf;
+		cm3_cca_bits = (cm_error >> 8) & 7;
+		mcp_bits = (cm_error >> 5) & 0xf;
+		cm3_tr_bits = (cm_error >> 1) & 0xf;
+		sched_bit = cm_error & 0x1;
 
 		if (cause == 1 || cause == 3) { /* Tag ECC */
 			unsigned long tag_ecc = (cm_error >> 57) & 0x1;
@@ -372,8 +374,8 @@ void mips_cm_error_report(void)
 
 		pr_err("CM_ERROR=%llx %s <%s>\n", cm_error,
 		       cm3_causes[cause], buf);
-		pr_err("CM_ADDR =%lx\n", cm_addr);
-		pr_err("CM_OTHER=%lx %s\n", cm_other, cm3_causes[ocause]);
+		pr_err("CM_ADDR =%llx\n", cm_addr);
+		pr_err("CM_OTHER=%llx %s\n", cm_other, cm3_causes[ocause]);
 	}
 
 	/* reprime cause register */
-- 
2.5.3
