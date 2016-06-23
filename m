Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:39:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62380 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043857AbcFWQfHLjLlz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EF16C3AD1BA8;
        Thu, 23 Jun 2016 17:34:56 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:35:00 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 13/14] MIPS: KVM: Relative branch to common exit handler
Date:   Thu, 23 Jun 2016 17:34:46 +0100
Message-ID: <1466699687-24791-14-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54150
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

Use a relative branch to get from the individual exception vectors to
the common guest exit handler, rather than loading the address of the
exit handler and jumping to it.

This is made easier due to the fact we are now generating the entry code
dynamically. This will also allow the exception code to be further
reduced in future patches.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  2 +-
 arch/mips/kvm/entry.c            | 23 +++++++++++++++++------
 arch/mips/kvm/mips.c             | 12 +++++++-----
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index a80c3208b234..b32785543787 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -538,7 +538,7 @@ extern int kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu);
 /* Building of entry/exception code */
 int kvm_mips_entry_setup(void);
 void *kvm_mips_build_vcpu_run(void *addr);
-void *kvm_mips_build_exception(void *addr);
+void *kvm_mips_build_exception(void *addr, void *handler);
 void *kvm_mips_build_exit(void *addr);
 
 /* FPU/MSA context management */
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index b6e7fd9f12f0..fb2cbf653474 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -69,12 +69,14 @@ enum label_id {
 	label_msa_1,
 	label_return_to_host,
 	label_kernel_asid,
+	label_exit_common,
 };
 
 UASM_L_LA(_fpu_1)
 UASM_L_LA(_msa_1)
 UASM_L_LA(_return_to_host)
 UASM_L_LA(_kernel_asid)
+UASM_L_LA(_exit_common)
 
 static void *kvm_mips_build_enter_guest(void *addr);
 static void *kvm_mips_build_ret_from_exit(void *addr);
@@ -327,15 +329,23 @@ static void *kvm_mips_build_enter_guest(void *addr)
 /**
  * kvm_mips_build_exception() - Assemble first level guest exception handler.
  * @addr:	Address to start writing code.
+ * @handler:	Address of common handler (within range of @addr).
  *
  * Assemble exception vector code for guest execution. The generated vector will
- * jump to the common exception handler generated by kvm_mips_build_exit().
+ * branch to the common exception handler generated by kvm_mips_build_exit().
  *
  * Returns:	Next address after end of written function.
  */
-void *kvm_mips_build_exception(void *addr)
+void *kvm_mips_build_exception(void *addr, void *handler)
 {
 	u32 *p = addr;
+	struct uasm_label labels[2];
+	struct uasm_reloc relocs[2];
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
 
 	/* Save guest k0 */
 	uasm_i_mtc0(&p, K0, scratch_tmp[0], scratch_tmp[1]);
@@ -349,12 +359,13 @@ void *kvm_mips_build_exception(void *addr)
 	/* Save k1 @ offset 0x3000 */
 	UASM_i_SW(&p, K1, 0x3000, K0);
 
-	/* Exception handler is installed @ offset 0x2000 */
-	uasm_i_addiu(&p, K0, K0, 0x2000);
-	/* Jump to the function */
-	uasm_i_jr(&p, K0);
+	/* Branch to the common handler */
+	uasm_il_b(&p, &r, label_exit_common);
 	 uasm_i_nop(&p);
 
+	uasm_l_exit_common(&l, handler);
+	uasm_resolve_relocs(relocs, labels);
+
 	return p;
 }
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index e45b505e2ad7..a62267f6fb07 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -265,7 +265,7 @@ static inline void dump_handler(const char *symbol, void *start, void *end)
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	int err, size;
-	void *gebase, *p;
+	void *gebase, *p, *handler;
 	int i;
 
 	struct kvm_vcpu *vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
@@ -304,22 +304,24 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	vcpu->arch.guest_ebase = gebase;
 
 	/* Build guest exception vectors dynamically in unmapped memory */
+	handler = gebase + 0x2000;
 
 	/* TLB Refill, EXL = 0 */
-	kvm_mips_build_exception(gebase);
+	kvm_mips_build_exception(gebase, handler);
 
 	/* General Exception Entry point */
-	kvm_mips_build_exception(gebase + 0x180);
+	kvm_mips_build_exception(gebase + 0x180, handler);
 
 	/* For vectored interrupts poke the exception code @ all offsets 0-7 */
 	for (i = 0; i < 8; i++) {
 		kvm_debug("L1 Vectored handler @ %p\n",
 			  gebase + 0x200 + (i * VECTORSPACING));
-		kvm_mips_build_exception(gebase + 0x200 + i * VECTORSPACING);
+		kvm_mips_build_exception(gebase + 0x200 + i * VECTORSPACING,
+					 handler);
 	}
 
 	/* General exit handler */
-	p = gebase + 0x2000;
+	p = handler;
 	p = kvm_mips_build_exit(p);
 
 	/* Guest entry routine */
-- 
2.4.10
