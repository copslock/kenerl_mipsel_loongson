Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:39:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3605 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043858AbcFWQfHm55az (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 80A6ABE874834;
        Thu, 23 Jun 2016 17:34:57 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:35:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 14/14] MIPS: KVM: Save k0 straight into VCPU structure
Date:   Thu, 23 Jun 2016 17:34:47 +0100
Message-ID: <1466699687-24791-15-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54151
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

Currently on a guest exception the guest's k0 register is saved to the
scratch temp register and the guest k1 saved to the exception base
address + 0x3000 using k0 to extract the Exception Base field of the
EBase register and as the base operand to the store. Both are then
copied into the VCPU structure after the other general purpose registers
have been saved there.

This bouncing to exception base + 0x3000 is not actually necessary as
the VCPU pointer can be determined and written through just as easily
with only a single spare register. The VCPU pointer is already needed in
k1 for saving the other GP registers, so lets save the guest k0 register
straight into the VCPU structure through k1, first saving k1 into the
scratch temp register instead of k0.

This could potentially pave the way for having a single exception base
area for use by all guests.

The ehb after saving the k register to the scratch temp register is also
delayed until just before it needs to be read back.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index fb2cbf653474..de8b6ec5573f 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -347,17 +347,15 @@ void *kvm_mips_build_exception(void *addr, void *handler)
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
-	/* Save guest k0 */
-	uasm_i_mtc0(&p, K0, scratch_tmp[0], scratch_tmp[1]);
-	uasm_i_ehb(&p);
+	/* Save guest k1 into scratch register */
+	uasm_i_mtc0(&p, K1, scratch_tmp[0], scratch_tmp[1]);
 
-	/* Get EBASE */
-	uasm_i_mfc0(&p, K0, C0_EBASE);
-	/* Get rid of CPUNum */
-	uasm_i_srl(&p, K0, K0, 10);
-	uasm_i_sll(&p, K0, K0, 10);
-	/* Save k1 @ offset 0x3000 */
-	UASM_i_SW(&p, K1, 0x3000, K0);
+	/* Get the VCPU pointer from the VCPU scratch register */
+	uasm_i_mfc0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
+	uasm_i_addiu(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
+
+	/* Save guest k0 into VCPU structure */
+	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
 
 	/* Branch to the common handler */
 	uasm_il_b(&p, &r, label_exit_common);
@@ -395,12 +393,13 @@ void *kvm_mips_build_exit(void *addr)
 	/*
 	 * Generic Guest exception handler. We end up here when the guest
 	 * does something that causes a trap to kernel mode.
+	 *
+	 * Both k0/k1 registers will have already been saved (k0 into the vcpu
+	 * structure, and k1 into the scratch_tmp register).
+	 *
+	 * The k1 register will already contain the kvm_vcpu_arch pointer.
 	 */
 
-	/* Get the VCPU pointer from the scratch register */
-	uasm_i_mfc0(&p, K1, scratch_vcpu[0], scratch_vcpu[1]);
-	uasm_i_addiu(&p, K1, K1, offsetof(struct kvm_vcpu, arch));
-
 	/* Start saving Guest context to VCPU */
 	for (i = 0; i < 32; ++i) {
 		/* Guest k0/k1 saved later */
@@ -416,15 +415,9 @@ void *kvm_mips_build_exit(void *addr)
 	uasm_i_mflo(&p, T0);
 	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, lo), K1);
 
-	/* Finally save guest k0/k1 to VCPU */
+	/* Finally save guest k1 to VCPU */
+	uasm_i_ehb(&p);
 	uasm_i_mfc0(&p, T0, scratch_tmp[0], scratch_tmp[1]);
-	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, gprs[K0]), K1);
-
-	/* Get GUEST k1 and save it in VCPU */
-	uasm_i_addiu(&p, T1, ZERO, ~0x2ff);
-	uasm_i_mfc0(&p, T0, C0_EBASE);
-	uasm_i_and(&p, T0, T0, T1);
-	UASM_i_LW(&p, T0, 0x3000, T0);
 	UASM_i_SW(&p, T0, offsetof(struct kvm_vcpu_arch, gprs[K1]), K1);
 
 	/* Now that context has been saved, we can use other registers */
-- 
2.4.10
