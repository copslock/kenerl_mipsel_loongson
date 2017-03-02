Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:45:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62560 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993891AbdCBJhi30sPt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:38 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9E2F4C1768105;
        Thu,  2 Mar 2017 09:37:29 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:31 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 18/32] KVM: MIPS/Entry: Update entry code to support VZ
Date:   Thu, 2 Mar 2017 09:36:45 +0000
Message-ID: <1629f985c20638c3a870035ffe3f4a96a80358a2.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56978
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

Update MIPS KVM entry code to support VZ:

 - We need to set GuestCtl0.GM while in guest mode.

 - For cores supporting GuestID, we need to set the root GuestID to
   match the main GuestID while in guest mode so that the root TLB
   refill handler writes the correct GuestID into the TLB.

 - For cores without GuestID where the root ASID dealiases RVA/GPA
   mappings, we need to load that ASID from the gpa_mm rather than the
   per-VCPU guest_kernel_mm or guest_user_mm, since the root TLB maps
   guest physical addresses. We also need to restore the normal process
   ASID on exit.

 - The normal linux process pgd needs restoring on exit, as we can't
   leave the GPA mappings active for kernel code.

 - GuestCtl0 needs saving on exit for the GExcCode field, as it may be
   clobbered if a preemption occurs.

We also need to move the TLB refill handler to the XTLB vector at offset
0x80 on 64-bit VZ kernels, as hardware will use Root.Status.KX to
determine whether a TLB refill or XTLB Refill exception is to be taken
on a root TLB miss from guest mode, and KX needs to be set for kernel
code to be able to access the 64-bit segments.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |   5 +-
 arch/mips/kvm/entry.c            | 132 +++++++++++++++++++++++++++++---
 arch/mips/kvm/mips.c             |   4 +-
 3 files changed, 131 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index cff18b2156f9..9938c665729e 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -287,13 +287,18 @@ struct kvm_mmu_memory_cache {
 struct kvm_vcpu_arch {
 	void *guest_ebase;
 	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
+
+	/* Host registers preserved across guest mode execution */
 	unsigned long host_stack;
 	unsigned long host_gp;
+	unsigned long host_pgd;
+	unsigned long host_entryhi;
 
 	/* Host CP0 registers used when handling exits from guest */
 	unsigned long host_cp0_badvaddr;
 	unsigned long host_cp0_epc;
 	u32 host_cp0_cause;
+	u32 host_cp0_guestctl0;
 	u32 host_cp0_badinstr;
 	u32 host_cp0_badinstrp;
 
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index c5b254c4d0da..16e1c93b484f 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -51,12 +51,15 @@
 #define RA		31
 
 /* Some CP0 registers */
+#define C0_PWBASE	5, 5
 #define C0_HWRENA	7, 0
 #define C0_BADVADDR	8, 0
 #define C0_BADINSTR	8, 1
 #define C0_BADINSTRP	8, 2
 #define C0_ENTRYHI	10, 0
+#define C0_GUESTCTL1	10, 4
 #define C0_STATUS	12, 0
+#define C0_GUESTCTL0	12, 6
 #define C0_CAUSE	13, 0
 #define C0_EPC		14, 0
 #define C0_EBASE	15, 1
@@ -292,8 +295,8 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	unsigned int i;
 	struct uasm_label labels[2];
 	struct uasm_reloc relocs[2];
-	struct uasm_label *l = labels;
-	struct uasm_reloc *r = relocs;
+	struct uasm_label __maybe_unused *l = labels;
+	struct uasm_reloc __maybe_unused *r = relocs;
 
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
@@ -302,7 +305,67 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, pc), K1);
 	UASM_i_MTC0(&p, T0, C0_EPC);
 
-	/* Set the ASID for the Guest Kernel */
+#ifdef CONFIG_KVM_MIPS_VZ
+	/* Save normal linux process pgd (VZ guarantees pgd_reg is set) */
+	UASM_i_MFC0(&p, K0, c0_kscratch(), pgd_reg);
+	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, host_pgd), K1);
+
+	/*
+	 * Set up KVM GPA pgd.
+	 * This does roughly the same as TLBMISS_HANDLER_SETUP_PGD():
+	 * - call tlbmiss_handler_setup_pgd(mm->pgd)
+	 * - write mm->pgd into CP0_PWBase
+	 *
+	 * We keep S0 pointing at struct kvm so we can load the ASID below.
+	 */
+	UASM_i_LW(&p, S0, (int)offsetof(struct kvm_vcpu, kvm) -
+			  (int)offsetof(struct kvm_vcpu, arch), K1);
+	UASM_i_LW(&p, A0, offsetof(struct kvm, arch.gpa_mm.pgd), S0);
+	UASM_i_LA(&p, T9, (unsigned long)tlbmiss_handler_setup_pgd);
+	uasm_i_jalr(&p, RA, T9);
+	/* delay slot */
+	if (cpu_has_htw)
+		UASM_i_MTC0(&p, A0, C0_PWBASE);
+	else
+		uasm_i_nop(&p);
+
+	/* Set GM bit to setup eret to VZ guest context */
+	uasm_i_addiu(&p, V1, ZERO, 1);
+	uasm_i_mfc0(&p, K0, C0_GUESTCTL0);
+	uasm_i_ins(&p, K0, V1, MIPS_GCTL0_GM_SHIFT, 1);
+	uasm_i_mtc0(&p, K0, C0_GUESTCTL0);
+
+	if (cpu_has_guestid) {
+		/*
+		 * Set root mode GuestID, so that root TLB refill handler can
+		 * use the correct GuestID in the root TLB.
+		 */
+
+		/* Get current GuestID */
+		uasm_i_mfc0(&p, T0, C0_GUESTCTL1);
+		/* Set GuestCtl1.RID = GuestCtl1.ID */
+		uasm_i_ext(&p, T1, T0, MIPS_GCTL1_ID_SHIFT,
+			   MIPS_GCTL1_ID_WIDTH);
+		uasm_i_ins(&p, T0, T1, MIPS_GCTL1_RID_SHIFT,
+			   MIPS_GCTL1_RID_WIDTH);
+		uasm_i_mtc0(&p, T0, C0_GUESTCTL1);
+
+		/* GuestID handles dealiasing so we don't need to touch ASID */
+		goto skip_asid_restore;
+	}
+
+	/* Root ASID Dealias (RAD) */
+
+	/* Save host ASID */
+	UASM_i_MFC0(&p, K0, C0_ENTRYHI);
+	UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, host_entryhi),
+		  K1);
+
+	/* Set the root ASID for the Guest */
+	UASM_i_ADDIU(&p, T1, S0,
+		     offsetof(struct kvm, arch.gpa_mm.context.asid));
+#else
+	/* Set the ASID for the Guest Kernel or User */
 	UASM_i_LW(&p, T0, offsetof(struct kvm_vcpu_arch, cop0), K1);
 	UASM_i_LW(&p, T0, offsetof(struct mips_coproc, reg[MIPS_CP0_STATUS][0]),
 		  T0);
@@ -315,6 +378,7 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	UASM_i_ADDIU(&p, T1, K1, offsetof(struct kvm_vcpu_arch,
 					  guest_user_mm.context.asid));
 	uasm_l_kernel_asid(&l, p);
+#endif
 
 	/* t1: contains the base of the ASID array, need to get the cpu id  */
 	/* smp_processor_id */
@@ -339,6 +403,7 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	uasm_i_andi(&p, K0, K0, MIPS_ENTRYHI_ASID);
 #endif
 
+#ifndef CONFIG_KVM_MIPS_VZ
 	/*
 	 * Set up KVM T&E GVA pgd.
 	 * This does roughly the same as TLBMISS_HANDLER_SETUP_PGD():
@@ -351,7 +416,11 @@ static void *kvm_mips_build_enter_guest(void *addr)
 	UASM_i_LA(&p, T9, (unsigned long)tlbmiss_handler_setup_pgd);
 	uasm_i_jalr(&p, RA, T9);
 	 uasm_i_mtc0(&p, K0, C0_ENTRYHI);
-
+#else
+	/* Set up KVM VZ root ASID (!guestid) */
+	uasm_i_mtc0(&p, K0, C0_ENTRYHI);
+skip_asid_restore:
+#endif
 	uasm_i_ehb(&p);
 
 	/* Disable RDHWR access */
@@ -559,13 +628,10 @@ void *kvm_mips_build_exit(void *addr)
 	/* Now that context has been saved, we can use other registers */
 
 	/* Restore vcpu */
-	UASM_i_MFC0(&p, A1, scratch_vcpu[0], scratch_vcpu[1]);
-	uasm_i_move(&p, S1, A1);
+	UASM_i_MFC0(&p, S1, scratch_vcpu[0], scratch_vcpu[1]);
 
 	/* Restore run (vcpu->run) */
-	UASM_i_LW(&p, A0, offsetof(struct kvm_vcpu, run), A1);
-	/* Save pointer to run in s0, will be saved by the compiler */
-	uasm_i_move(&p, S0, A0);
+	UASM_i_LW(&p, S0, offsetof(struct kvm_vcpu, run), S1);
 
 	/*
 	 * Save Host level EPC, BadVaddr and Cause to VCPU, useful to process
@@ -641,6 +707,52 @@ void *kvm_mips_build_exit(void *addr)
 		uasm_l_msa_1(&l, p);
 	}
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	/* Restore host ASID */
+	if (!cpu_has_guestid) {
+		UASM_i_LW(&p, K0, offsetof(struct kvm_vcpu_arch, host_entryhi),
+			  K1);
+		UASM_i_MTC0(&p, K0, C0_ENTRYHI);
+	}
+
+	/*
+	 * Set up normal Linux process pgd.
+	 * This does roughly the same as TLBMISS_HANDLER_SETUP_PGD():
+	 * - call tlbmiss_handler_setup_pgd(mm->pgd)
+	 * - write mm->pgd into CP0_PWBase
+	 */
+	UASM_i_LW(&p, A0,
+		  offsetof(struct kvm_vcpu_arch, host_pgd), K1);
+	UASM_i_LA(&p, T9, (unsigned long)tlbmiss_handler_setup_pgd);
+	uasm_i_jalr(&p, RA, T9);
+	/* delay slot */
+	if (cpu_has_htw)
+		UASM_i_MTC0(&p, A0, C0_PWBASE);
+	else
+		uasm_i_nop(&p);
+
+	/* Clear GM bit so we don't enter guest mode when EXL is cleared */
+	uasm_i_mfc0(&p, K0, C0_GUESTCTL0);
+	uasm_i_ins(&p, K0, ZERO, MIPS_GCTL0_GM_SHIFT, 1);
+	uasm_i_mtc0(&p, K0, C0_GUESTCTL0);
+
+	/* Save GuestCtl0 so we can access GExcCode after CPU migration */
+	uasm_i_sw(&p, K0,
+		  offsetof(struct kvm_vcpu_arch, host_cp0_guestctl0), K1);
+
+	if (cpu_has_guestid) {
+		/*
+		 * Clear root mode GuestID, so that root TLB operations use the
+		 * root GuestID in the root TLB.
+		 */
+		uasm_i_mfc0(&p, T0, C0_GUESTCTL1);
+		/* Set GuestCtl1.RID = MIPS_GCTL1_ROOT_GUESTID (i.e. 0) */
+		uasm_i_ins(&p, T0, ZERO, MIPS_GCTL1_RID_SHIFT,
+			   MIPS_GCTL1_RID_WIDTH);
+		uasm_i_mtc0(&p, T0, C0_GUESTCTL1);
+	}
+#endif
+
 	/* Now that the new EBASE has been loaded, unset BEV and KSU_USER */
 	uasm_i_addiu(&p, AT, ZERO, ~(ST0_EXL | KSU_USER | ST0_IE));
 	uasm_i_and(&p, V0, V0, AT);
@@ -680,6 +792,8 @@ void *kvm_mips_build_exit(void *addr)
 	 * Now jump to the kvm_mips_handle_exit() to see if we can deal
 	 * with this in the kernel
 	 */
+	uasm_i_move(&p, A0, S0);
+	uasm_i_move(&p, A1, S1);
 	UASM_i_LA(&p, T9, (unsigned long)kvm_mips_handle_exit);
 	uasm_i_jalr(&p, RA, T9);
 	 UASM_i_ADDIU(&p, SP, SP, -CALLFRAME_SIZ);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a500d2be2022..efb406455229 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -323,8 +323,10 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	/* Build guest exception vectors dynamically in unmapped memory */
 	handler = gebase + 0x2000;
 
-	/* TLB refill */
+	/* TLB refill (or XTLB refill on 64-bit VZ where KX=1) */
 	refill_start = gebase;
+	if (IS_ENABLED(CONFIG_KVM_MIPS_VZ) && IS_ENABLED(CONFIG_64BIT))
+		refill_start += 0x080;
 	refill_end = kvm_mips_build_tlb_refill_exception(refill_start, handler);
 
 	/* General Exception Entry point */
-- 
git-series 0.8.10
