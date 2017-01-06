Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:38:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46373 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992328AbdAFBdnspxXu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:43 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3208FA15EA7BF;
        Fri,  6 Jan 2017 01:33:40 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:40 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 16/30] KVM: MIPS: Support NetLogic KScratch registers
Date:   Fri, 6 Jan 2017 01:32:48 +0000
Message-ID: <610a667f2bb87443b20a9f9bc1b4bddfc3ae0b09.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56186
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

tlbex.c uses the implementation dependent $22 CP0 register group on
NetLogic cores, with the help of the c0_kscratch() helper. Allow these
registers to be allocated by the KVM entry code too instead of assuming
KScratch registers are all $31, which will also allow pgd_reg to be
handled since it is allocated that way.

We also drop the masking of kscratch_mask with 0xfc, as it is redundant
for the standard KScratch registers (Config4.KScrExist won't have the
low 2 bits set anyway), and apparently not necessary for NetLogic.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index f683d123172c..7424d3d566ff 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -91,6 +91,21 @@ static void *kvm_mips_build_ret_from_exit(void *addr);
 static void *kvm_mips_build_ret_to_guest(void *addr);
 static void *kvm_mips_build_ret_to_host(void *addr);
 
+/*
+ * The version of this function in tlbex.c uses current_cpu_type(), but for KVM
+ * we assume symmetry.
+ */
+static int c0_kscratch(void)
+{
+	switch (boot_cpu_type()) {
+	case CPU_XLP:
+	case CPU_XLR:
+		return 22;
+	default:
+		return 31;
+	}
+}
+
 /**
  * kvm_mips_entry_setup() - Perform global setup for entry code.
  *
@@ -105,18 +120,18 @@ int kvm_mips_entry_setup(void)
 	 * We prefer to use KScratchN registers if they are available over the
 	 * defaults above, which may not work on all cores.
 	 */
-	unsigned int kscratch_mask = cpu_data[0].kscratch_mask & 0xfc;
+	unsigned int kscratch_mask = cpu_data[0].kscratch_mask;
 
 	/* Pick a scratch register for storing VCPU */
 	if (kscratch_mask) {
-		scratch_vcpu[0] = 31;
+		scratch_vcpu[0] = c0_kscratch();
 		scratch_vcpu[1] = ffs(kscratch_mask) - 1;
 		kscratch_mask &= ~BIT(scratch_vcpu[1]);
 	}
 
 	/* Pick a scratch register to use as a temp for saving state */
 	if (kscratch_mask) {
-		scratch_tmp[0] = 31;
+		scratch_tmp[0] = c0_kscratch();
 		scratch_tmp[1] = ffs(kscratch_mask) - 1;
 		kscratch_mask &= ~BIT(scratch_tmp[1]);
 	}
@@ -132,7 +147,7 @@ static void kvm_mips_build_save_scratch(u32 **p, unsigned int tmp,
 	UASM_i_SW(p, tmp, offsetof(struct pt_regs, cp0_epc), frame);
 
 	/* Save the temp scratch register value in cp0_cause of stack frame */
-	if (scratch_tmp[0] == 31) {
+	if (scratch_tmp[0] == c0_kscratch()) {
 		UASM_i_MFC0(p, tmp, scratch_tmp[0], scratch_tmp[1]);
 		UASM_i_SW(p, tmp, offsetof(struct pt_regs, cp0_cause), frame);
 	}
@@ -148,7 +163,7 @@ static void kvm_mips_build_restore_scratch(u32 **p, unsigned int tmp,
 	UASM_i_LW(p, tmp, offsetof(struct pt_regs, cp0_epc), frame);
 	UASM_i_MTC0(p, tmp, scratch_vcpu[0], scratch_vcpu[1]);
 
-	if (scratch_tmp[0] == 31) {
+	if (scratch_tmp[0] == c0_kscratch()) {
 		UASM_i_LW(p, tmp, offsetof(struct pt_regs, cp0_cause), frame);
 		UASM_i_MTC0(p, tmp, scratch_tmp[0], scratch_tmp[1]);
 	}
-- 
git-series 0.8.10
