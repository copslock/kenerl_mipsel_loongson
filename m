Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Aug 2013 16:14:17 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:51595 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825738Ab3H2OOIAePbg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Aug 2013 16:14:08 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VF2z0-00041g-VL; Thu, 29 Aug 2013 09:13:59 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH v2] MIPS: Allow ASID size to be determined at boot time.
Date:   Thu, 29 Aug 2013 09:13:52 -0500
Message-Id: <1377785632-13113-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Original patch by Ralf Baechle and removed by Harold Koerfgen
with commit f67e4ffc79905482c3b9b8c8dd65197bac7eb508. Allows
for more generic kernels since ASID size is determinted during
boot. This patch is required for new Aptiv cores. Tested on
Malta, SEAD-3, microMIPS, Aptiv, and ERLite-3 (Cavium) platforms.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/kvm_host.h    |    2 +-
 arch/mips/include/asm/mmu_context.h |   99 ++++++++++++++++++++++++-----------
 arch/mips/kernel/genex.S            |    2 +-
 arch/mips/kernel/smtc.c             |    8 +--
 arch/mips/kernel/traps.c            |    4 +-
 arch/mips/kvm/kvm_mips_emul.c       |   44 +++++++---------
 arch/mips/kvm/kvm_tlb.c             |   34 +++++-------
 arch/mips/lib/dump_tlb.c            |    5 +-
 arch/mips/lib/r3k_dump_tlb.c        |    6 +--
 arch/mips/mm/tlb-r3k.c              |   20 +++----
 arch/mips/mm/tlb-r4k.c              |    2 +-
 arch/mips/mm/tlb-r8k.c              |    2 +-
 arch/mips/mm/tlbex.c                |   72 +++++++++++++++++++++++++
 13 files changed, 195 insertions(+), 105 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 4d6fa0b..3f870ad 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -336,7 +336,7 @@ enum emulation_result {
 #define VPN2_MASK           0xffffe000
 #define TLB_IS_GLOBAL(x)    (((x).tlb_lo0 & MIPS3_PG_G) && ((x).tlb_lo1 & MIPS3_PG_G))
 #define TLB_VPN2(x)         ((x).tlb_hi & VPN2_MASK)
-#define TLB_ASID(x)         ((x).tlb_hi & ASID_MASK)
+#define TLB_ASID(x)         ASID_MASK((x).tlb_hi)
 #define TLB_IS_VALID(x, va) (((va) & (1 << PAGE_SHIFT)) ? ((x).tlb_lo1 & MIPS3_PG_V) : ((x).tlb_lo0 & MIPS3_PG_V))
 
 struct kvm_mips_tlb {
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 3b29079..2d423ef 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -28,8 +28,10 @@
 
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)					\
 do {									\
-	extern void tlbmiss_handler_setup_pgd(unsigned long);		\
-	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
+	extern u32 tlbmiss_handler_setup_pgd[];				\
+	void (*handler)(unsigned long);					\
+	handler = (void *)tlbmiss_handler_setup_pgd;			\
+	handler((unsigned long)pgd);					\
 } while (0)
 
 #define TLBMISS_HANDLER_SETUP()						\
@@ -63,45 +65,78 @@ extern unsigned long pgd_current[];
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT*/
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
-#define ASID_INC	0x40
-#define ASID_MASK	0xfc0
-
-#elif defined(CONFIG_CPU_R8000)
-
-#define ASID_INC	0x10
-#define ASID_MASK	0xff0
+#ifdef CONFIG_64BIT
+#define WORD_ADDR ".dword"
+#else
+#define WORD_ADDR ".word"
+#endif
 
-#elif defined(CONFIG_MIPS_MT_SMTC)
+#define ASID_INC(asid)						\
+({								\
+	unsigned long __asid = asid;				\
+	__asm__("1:\taddiu\t%0,1\t\t\t\t# patched\n\t"		\
+	".section\t__asid_inc,\"a\"\n\t"			\
+	WORD_ADDR " 1b\n\t"					\
+	".previous"						\
+	:"=r" (__asid)						\
+	:"0" (__asid));						\
+	__asid;							\
+})
+
+#define ASID_MASK(asid)						\
+({								\
+	unsigned long __asid = asid;				\
+	__asm__("1:\tandi\t%0,%1,0xfc0\t\t\t# patched\n\t"	\
+	".section\t__asid_mask,\"a\"\n\t"			\
+	WORD_ADDR " 1b\n\t"					\
+	".previous"						\
+	:"=r" (__asid)						\
+	:"r" (__asid));						\
+	__asid;							\
+})
+
+#define ASID_VERSION_MASK					\
+({								\
+	unsigned long __asid;					\
+	__asm__("1:\tli\t%0,0xff00\t\t\t\t# patched\n\t"	\
+	".section\t__asid_version_mask,\"a\"\n\t"		\
+	WORD_ADDR " 1b\n\t"					\
+	".previous"						\
+	:"=r" (__asid));					\
+	__asid;							\
+})
+
+#define ASID_FIRST_VERSION					\
+({								\
+	unsigned long __asid;					\
+	__asm__("1:\tli\t%0,0x100\t\t\t\t# patched\n\t"		\
+	".section\t__asid_first_version,\"a\"\n\t"		\
+	WORD_ADDR " 1b\n\t"					\
+	".previous"						\
+	:"=r" (__asid));					\
+	__asid;							\
+})
 
-#define ASID_INC	0x1
+#ifdef CONFIG_MIPS_MT_SMTC
 extern unsigned long smtc_asid_mask;
-#define ASID_MASK	(smtc_asid_mask)
-#define HW_ASID_MASK	0xff
-/* End SMTC/34K debug hack */
-#else /* FIXME: not correct for R6000 */
-
-#define ASID_INC	0x1
-#define ASID_MASK	0xff
-
+#define HW_ASID_MASK			0xff
 #endif
 
+#define ASID_FIRST_VERSION_R3000	0x1000
+#define ASID_FIRST_VERSION_R4000	0x100
+#define ASID_FIRST_VERSION_R8000	0x1000
+#define ASID_FIRST_VERSION_RM9000	0x1000
+#define ASID_FIRST_VERSION_99K		0x1000
+
 #define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
-#define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
+#define cpu_asid(cpu, mm)	ASID_MASK(cpu_context((cpu), (mm)))
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
-/*
- *  All unused by hardware upper bits will be considered
- *  as a software asid extension.
- */
-#define ASID_VERSION_MASK  ((unsigned long)~(ASID_MASK|(ASID_MASK-1)))
-#define ASID_FIRST_VERSION ((unsigned long)(~ASID_VERSION_MASK) + 1)
-
 #ifndef CONFIG_MIPS_MT_SMTC
 /* Normal, classic MIPS get_new_mmu_context */
 static inline void
@@ -110,7 +145,7 @@ get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 	extern void kvm_local_flush_tlb_all(void);
 	unsigned long asid = asid_cache(cpu);
 
-	if (! ((asid += ASID_INC) & ASID_MASK) ) {
+	if (!ASID_MASK((asid = ASID_INC(asid)))) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
 #ifdef CONFIG_KVM
@@ -173,7 +208,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 * free up the ASID value for use and flush any old
 	 * instances of it from the TLB.
 	 */
-	oldasid = (read_c0_entryhi() & ASID_MASK);
+	oldasid = ASID_MASK(read_c0_entryhi());
 	if(smtc_live_asid[mytlb][oldasid]) {
 		smtc_live_asid[mytlb][oldasid] &= ~(0x1 << cpu);
 		if(smtc_live_asid[mytlb][oldasid] == 0)
@@ -237,7 +272,7 @@ activate_mm(struct mm_struct *prev, struct mm_struct *next)
 #ifdef CONFIG_MIPS_MT_SMTC
 	/* See comments for similar code above */
 	mtflags = dvpe();
-	oldasid = read_c0_entryhi() & ASID_MASK;
+	oldasid = ASID_MASK(read_c0_entryhi());
 	if(smtc_live_asid[mytlb][oldasid]) {
 		smtc_live_asid[mytlb][oldasid] &= ~(0x1 << cpu);
 		if(smtc_live_asid[mytlb][oldasid] == 0)
@@ -282,7 +317,7 @@ drop_mmu_context(struct mm_struct *mm, unsigned cpu)
 #ifdef CONFIG_MIPS_MT_SMTC
 		/* See comments for similar code above */
 		prevvpe = dvpe();
-		oldasid = (read_c0_entryhi() & ASID_MASK);
+		oldasid = ASID_MASK(read_c0_entryhi());
 		if (smtc_live_asid[mytlb][oldasid]) {
 			smtc_live_asid[mytlb][oldasid] &= ~(0x1 << cpu);
 			if(smtc_live_asid[mytlb][oldasid] == 0)
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 31fa856..66c6ef5 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -493,7 +493,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	noreorder
 	/* check if TLB contains a entry for EPC */
 	MFC0	k1, CP0_ENTRYHI
-	andi	k1, 0xff	/* ASID_MASK */
+	andi	k1, 0xff	/* ASID_MASK patched at run-time!! */
 	MFC0	k0, CP0_EPC
 	PTR_SRL k0, _PAGE_SHIFT + 1
 	PTR_SLL k0, _PAGE_SHIFT + 1
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index dfc1b91..b30cc97 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -1394,7 +1394,7 @@ void smtc_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 	asid = asid_cache(cpu);
 
 	do {
-		if (!((asid += ASID_INC) & ASID_MASK) ) {
+		if (!(ASID_MASK(asid = ASID_INC(asid)))) {
 			if (cpu_has_vtag_icache)
 				flush_icache_all();
 			/* Traverse all online CPUs (hack requires contiguous range) */
@@ -1413,7 +1413,7 @@ void smtc_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 						mips_ihb();
 					}
 					tcstat = read_tc_c0_tcstatus();
-					smtc_live_asid[tlb][(tcstat & ASID_MASK)] |= (asiduse)(0x1 << i);
+					smtc_live_asid[tlb][ASID_MASK(tcstat)] |= (asiduse)(0x1 << i);
 					if (!prevhalt)
 						write_tc_c0_tchalt(0);
 				}
@@ -1422,7 +1422,7 @@ void smtc_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 				asid = ASID_FIRST_VERSION;
 			local_flush_tlb_all();	/* start new asid cycle */
 		}
-	} while (smtc_live_asid[tlb][(asid & ASID_MASK)]);
+	} while (smtc_live_asid[tlb][ASID_MASK(asid)]);
 
 	/*
 	 * SMTC shares the TLB within VPEs and possibly across all VPEs.
@@ -1460,7 +1460,7 @@ void smtc_flush_tlb_asid(unsigned long asid)
 		tlb_read();
 		ehb();
 		ehi = read_c0_entryhi();
-		if ((ehi & ASID_MASK) == asid) {
+		if (ASID_MASK(ehi) == asid) {
 		    /*
 		     * Invalidate only entries with specified ASID,
 		     * makiing sure all entries differ.
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index aec3408..b25f1b5 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1780,9 +1780,7 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	}
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-	if (!cpu_data[cpu].asid_cache)
-		cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
-
+	asid_cache(cpu) = ASID_FIRST_VERSION;
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 	BUG_ON(current->mm);
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 4b6274b..461624e 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -525,18 +525,14 @@ kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc, uint32_t cause,
 				printk("MTCz, cop0->reg[EBASE]: %#lx\n",
 				       kvm_read_c0_guest_ebase(cop0));
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
-				uint32_t nasid =
-				    vcpu->arch.gprs[rt] & ASID_MASK;
-				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0)
-				    &&
-				    ((kvm_read_c0_guest_entryhi(cop0) &
-				      ASID_MASK) != nasid)) {
-
-					kvm_debug
-					    ("MTCz, change ASID from %#lx to %#lx\n",
-					     kvm_read_c0_guest_entryhi(cop0) &
-					     ASID_MASK,
-					     vcpu->arch.gprs[rt] & ASID_MASK);
+				uint32_t nasid = ASID_MASK(vcpu->arch.gprs[rt]);
+
+				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0) &&
+				    (ASID_MASK(kvm_read_c0_guest_entryhi(cop0))
+				     != nasid)) {
+					kvm_debug("MTCz, change ASID from %#lx to %#lx\n",
+						ASID_MASK(kvm_read_c0_guest_entryhi(cop0)),
+						ASID_MASK(vcpu->arch.gprs[rt]));
 
 					/* Blow away the shadow host TLBs */
 					kvm_mips_flush_host_tlb(1);
@@ -988,8 +984,7 @@ kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc, uint32_t cause,
 		 * resulting handler will do the right thing
 		 */
 		index = kvm_mips_guest_tlb_lookup(vcpu, (va & VPN2_MASK) |
-						  (kvm_read_c0_guest_entryhi
-						   (cop0) & ASID_MASK));
+				(ASID_MASK(kvm_read_c0_guest_entryhi(cop0))));
 
 		if (index < 0) {
 			vcpu->arch.host_cp0_entryhi = (va & VPN2_MASK);
@@ -1153,8 +1148,8 @@ kvm_mips_emulate_tlbmiss_ld(unsigned long cause, uint32_t *opc,
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi = (vcpu->arch.  host_cp0_badvaddr & VPN2_MASK) |
-				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+				 ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1199,9 +1194,8 @@ kvm_mips_emulate_tlbinv_ld(unsigned long cause, uint32_t *opc,
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
-	unsigned long entryhi =
-		(vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-		(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
+				 ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1246,7 +1240,7 @@ kvm_mips_emulate_tlbmiss_st(unsigned long cause, uint32_t *opc,
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+				 ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1290,7 +1284,7 @@ kvm_mips_emulate_tlbinv_st(unsigned long cause, uint32_t *opc,
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-		(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+				 ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1359,7 +1353,7 @@ kvm_mips_emulate_tlbmod(unsigned long cause, uint32_t *opc,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+				 ASID_MASK(kvm_read_c0_guest_entryhi(cop0));
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	enum emulation_result er = EMULATE_DONE;
 
@@ -1784,10 +1778,8 @@ kvm_mips_handle_tlbmiss(unsigned long cause, uint32_t *opc,
 	 * exception. The guest exc handler should then inject an entry into the
 	 * guest TLB
 	 */
-	index = kvm_mips_guest_tlb_lookup(vcpu,
-					  (va & VPN2_MASK) |
-					  (kvm_read_c0_guest_entryhi
-					   (vcpu->arch.cop0) & ASID_MASK));
+	index = kvm_mips_guest_tlb_lookup(vcpu, (va & VPN2_MASK) |
+			ASID_MASK(kvm_read_c0_guest_entryhi(vcpu->arch.cop0)));
 	if (index < 0) {
 		if (exccode == T_TLB_LD_MISS) {
 			er = kvm_mips_emulate_tlbmiss_ld(cause, opc, run, vcpu);
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index c777dd3..a248c3e 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -53,13 +53,12 @@ EXPORT_SYMBOL(kvm_mips_is_error_pfn);
 
 uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.guest_kernel_asid[smp_processor_id()] & ASID_MASK;
+	return (ASID_MASK(vcpu->arch.guest_kernel_asid[smp_processor_id()]));
 }
 
-
 uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.guest_user_asid[smp_processor_id()] & ASID_MASK;
+	return (ASID_MASK(vcpu->arch.guest_user_asid[smp_processor_id()]));
 }
 
 inline uint32_t kvm_mips_get_commpage_asid (struct kvm_vcpu *vcpu)
@@ -86,7 +85,7 @@ void kvm_mips_dump_host_tlbs(void)
 	old_pagemask = read_c0_pagemask();
 
 	printk("HOST TLBs:\n");
-	printk("ASID: %#lx\n", read_c0_entryhi() & ASID_MASK);
+	printk("ASID: %#lx\n", ASID_MASK(read_c0_entryhi()));
 
 	for (i = 0; i < current_cpu_data.tlbsize; i++) {
 		write_c0_index(i);
@@ -445,7 +444,7 @@ int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long entryhi)
 
 	for (i = 0; i < KVM_MIPS_GUEST_TLB_SIZE; i++) {
 		if (((TLB_VPN2(tlb[i]) & ~tlb[i].tlb_mask) == ((entryhi & VPN2_MASK) & ~tlb[i].tlb_mask)) &&
-			(TLB_IS_GLOBAL(tlb[i]) || (TLB_ASID(tlb[i]) == (entryhi & ASID_MASK)))) {
+			(TLB_IS_GLOBAL(tlb[i]) || (TLB_ASID(tlb[i]) == ASID_MASK(entryhi)))) {
 			index = i;
 			break;
 		}
@@ -538,7 +537,8 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 #ifdef DEBUG
 	if (idx > 0) {
 		kvm_debug("%s: Invalidated entryhi %#lx @ idx %d\n", __func__,
-			  (va & VPN2_MASK) | (vcpu->arch.asid_map[va & ASID_MASK] & ASID_MASK), idx);
+			  (va & VPN2_MASK) |
+			  ASID_MASK(vcpu->arch.asid_map[ASID_MASK(va)]), idx);
 	}
 #endif
 
@@ -643,7 +643,7 @@ kvm_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu,
 {
 	unsigned long asid = asid_cache(cpu);
 
-	if (!((asid += ASID_INC) & ASID_MASK)) {
+	if (!(ASID_MASK(asid = ASID_INC(asid)))) {
 		if (cpu_has_vtag_icache) {
 			flush_icache_all();
 		}
@@ -821,8 +821,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (!newasid) {
 		/* If we preempted while the guest was executing, then reload the pre-empted ASID */
 		if (current->flags & PF_VCPU) {
-			write_c0_entryhi(vcpu->arch.
-					 preempt_entryhi & ASID_MASK);
+			write_c0_entryhi(ASID_MASK(vcpu->arch.preempt_entryhi));
 			ehb();
 		}
 	} else {
@@ -834,13 +833,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		if (current->flags & PF_VCPU) {
 			if (KVM_GUEST_KERNEL_MODE(vcpu))
-				write_c0_entryhi(vcpu->arch.
-						 guest_kernel_asid[cpu] &
-						 ASID_MASK);
+				write_c0_entryhi(ASID_MASK(vcpu->arch.guest_kernel_asid[cpu]));
 			else
-				write_c0_entryhi(vcpu->arch.
-						 guest_user_asid[cpu] &
-						 ASID_MASK);
+				write_c0_entryhi(ASID_MASK(vcpu->arch.guest_user_asid[cpu]));
 			ehb();
 		}
 	}
@@ -895,12 +890,9 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 		if (index >= 0) {
 			inst = *(opc);
 		} else {
-			index =
-			    kvm_mips_guest_tlb_lookup(vcpu,
-						      ((unsigned long) opc & VPN2_MASK)
-						      |
-						      (kvm_read_c0_guest_entryhi
-						       (cop0) & ASID_MASK));
+			index = kvm_mips_guest_tlb_lookup(vcpu,
+				((unsigned long) opc & VPN2_MASK) |
+				ASID_MASK(kvm_read_c0_guest_entryhi(cop0)));
 			if (index < 0) {
 				kvm_err
 				    ("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 32b9f21..8a12d00 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -11,6 +11,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/tlbdebug.h>
+#include <asm/mmu_context.h>
 
 static inline const char *msk2str(unsigned int mask)
 {
@@ -55,7 +56,7 @@ static void dump_tlb(int first, int last)
 	s_pagemask = read_c0_pagemask();
 	s_entryhi = read_c0_entryhi();
 	s_index = read_c0_index();
-	asid = s_entryhi & 0xff;
+	asid = ASID_MASK(s_entryhi);
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i);
@@ -85,7 +86,7 @@ static void dump_tlb(int first, int last)
 
 			printk("va=%0*lx asid=%02lx\n",
 			       width, (entryhi & ~0x1fffUL),
-			       entryhi & 0xff);
+			       ASID_MASK(entryhi));
 			printk("\t[pa=%0*llx c=%d d=%d v=%d g=%d] ",
 			       width,
 			       (entrylo0 << 6) & PAGE_MASK, c0,
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 91615c2..ec19a84 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -21,7 +21,7 @@ static void dump_tlb(int first, int last)
 	unsigned int asid;
 	unsigned long entryhi, entrylo0;
 
-	asid = read_c0_entryhi() & 0xfc0;
+	asid = ASID_MASK(read_c0_entryhi());
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i<<8);
@@ -35,7 +35,7 @@ static void dump_tlb(int first, int last)
 
 		/* Unused entries have a virtual address of KSEG0.  */
 		if ((entryhi & 0xffffe000) != 0x80000000
-		    && (entryhi & 0xfc0) == asid) {
+		    && (ASID_MASK(entryhi) == asid)) {
 			/*
 			 * Only print entries in use
 			 */
@@ -44,7 +44,7 @@ static void dump_tlb(int first, int last)
 			printk("va=%08lx asid=%08lx"
 			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
 			       (entryhi & 0xffffe000),
-			       entryhi & 0xfc0,
+			       ASID_MASK(entryhi),
 			       entrylo0 & PAGE_MASK,
 			       (entrylo0 & (1 << 11)) ? 1 : 0,
 			       (entrylo0 & (1 << 10)) ? 1 : 0,
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 9aca109..8923da6 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -51,7 +51,7 @@ void local_flush_tlb_all(void)
 #endif
 
 	local_irq_save(flags);
-	old_ctx = read_c0_entryhi() & ASID_MASK;
+	old_ctx = ASID_MASK(read_c0_entryhi());
 	write_c0_entrylo0(0);
 	entry = r3k_have_wired_reg ? read_c0_wired() : 8;
 	for (; entry < current_cpu_data.tlbsize; entry++) {
@@ -87,13 +87,13 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 #ifdef DEBUG_TLB
 		printk("[tlbrange<%lu,0x%08lx,0x%08lx>]",
-			cpu_context(cpu, mm) & ASID_MASK, start, end);
+			ASID_MASK(cpu_context(cpu, mm)), start, end);
 #endif
 		local_irq_save(flags);
 		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
 		if (size <= current_cpu_data.tlbsize) {
-			int oldpid = read_c0_entryhi() & ASID_MASK;
-			int newpid = cpu_context(cpu, mm) & ASID_MASK;
+			int oldpid = ASID_MASK(read_c0_entryhi());
+			int newpid = ASID_MASK(cpu_context(cpu, mm));
 
 			start &= PAGE_MASK;
 			end += PAGE_SIZE - 1;
@@ -166,10 +166,10 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 #ifdef DEBUG_TLB
 		printk("[tlbpage<%lu,0x%08lx>]", cpu_context(cpu, vma->vm_mm), page);
 #endif
-		newpid = cpu_context(cpu, vma->vm_mm) & ASID_MASK;
+		newpid = ASID_MASK(cpu_context(cpu, vma->vm_mm));
 		page &= PAGE_MASK;
 		local_irq_save(flags);
-		oldpid = read_c0_entryhi() & ASID_MASK;
+		oldpid = ASID_MASK(read_c0_entryhi());
 		write_c0_entryhi(page | newpid);
 		BARRIER;
 		tlb_probe();
@@ -197,10 +197,10 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 	if (current->active_mm != vma->vm_mm)
 		return;
 
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = ASID_MASK(read_c0_entryhi());
 
 #ifdef DEBUG_TLB
-	if ((pid != (cpu_context(cpu, vma->vm_mm) & ASID_MASK)) || (cpu_context(cpu, vma->vm_mm) == 0)) {
+	if ((pid != ASID_MASK(cpu_context(cpu, vma->vm_mm))) || (cpu_context(cpu, vma->vm_mm) == 0)) {
 		printk("update_mmu_cache: Wheee, bogus tlbpid mmpid=%lu tlbpid=%d\n",
 		       (cpu_context(cpu, vma->vm_mm)), pid);
 	}
@@ -241,7 +241,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 		local_irq_save(flags);
 		/* Save old context and create impossible VPN2 value */
-		old_ctx = read_c0_entryhi() & ASID_MASK;
+		old_ctx = ASID_MASK(read_c0_entryhi());
 		old_pagemask = read_c0_pagemask();
 		w = read_c0_wired();
 		write_c0_wired(w + 1);
@@ -264,7 +264,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 #endif
 
 		local_irq_save(flags);
-		old_ctx = read_c0_entryhi() & ASID_MASK;
+		old_ctx = ASID_MASK(read_c0_entryhi());
 		write_c0_entrylo0(entrylo0);
 		write_c0_entryhi(entryhi);
 		write_c0_index(wired);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 00b26a6..ea5eb69 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -287,7 +287,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 
 	ENTER_CRITICAL(flags);
 
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = ASID_MASK(read_c0_entryhi());
 	address &= (PAGE_MASK << 1);
 	write_c0_entryhi(address | pid);
 	pgdp = pgd_offset(vma->vm_mm, address);
diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
index 6a99733..0d1d092 100644
--- a/arch/mips/mm/tlb-r8k.c
+++ b/arch/mips/mm/tlb-r8k.c
@@ -195,7 +195,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	if (current->active_mm != vma->vm_mm)
 		return;
 
-	pid = read_c0_entryhi() & ASID_MASK;
+	pid = ASID_MASK(read_c0_entryhi());
 
 	local_irq_save(flags);
 	address &= PAGE_MASK;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 821b451..ca6166a 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/cache.h>
 
+#include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 #include <asm/war.h>
@@ -2202,6 +2203,75 @@ static void flush_tlb_handlers(void)
 #endif
 }
 
+/* Fixup an immediate instruction. */
+static void insn_fixup(unsigned long **start, unsigned long **stop,
+		       unsigned long i_const)
+{
+	unsigned long **p;
+
+	for (p = start; p < stop; p++) {
+#ifndef CONFIG_CPU_MICROMIPS
+		u32 *ip = (u32 *)*p;
+
+		*ip = (*ip & 0xffff0000) | i_const;
+#else
+		u16 *ip = ((u16 *)((unsigned long)*p - 1));
+
+		if ((*ip & 0xf000) == 0x4000) {		/* ADDIUS5 */
+			*ip &= 0xfff1;
+			*ip |= (i_const << 1);
+		} else if ((*ip & 0xf000) == 0x6000) {	/* ADDIUR1SP */
+			*ip &= 0xfff1;
+			*ip |= ((i_const >> 2) << 1);
+		} else {
+			ip++;
+			*ip = i_const;
+		}
+#endif
+	}
+}
+
+#define asid_insn_fixup(section, const)					\
+do {									\
+	extern unsigned long *__start_ ## section;			\
+	extern unsigned long *__stop_ ## section;			\
+	insn_fixup(&__start_ ## section, &__stop_ ## section, const);	\
+} while(0)
+
+/* Caller is assumed to flush the caches before first context switch. */
+static void setup_asid(unsigned long inc, unsigned int mask,
+		       unsigned int version_mask,
+		       unsigned int first_version)
+{
+#ifndef CONFIG_MIPS_MT_SMTC
+	extern asmlinkage void handle_ri_rdhwr_vivt(void);
+	unsigned long *vivt_exc;
+
+	/* The microMIPS addiu instruction only has a 3-bit immediate value. */
+	BUG_ON(cpu_has_mmips && (inc > 7));
+
+	/* Patch up one instruction in 'genex.s' that uses ASID_MASK. */
+#ifdef CONFIG_CPU_MICROMIPS
+	vivt_exc = (unsigned long *)((unsigned long) &handle_ri_rdhwr_vivt - 1);
+#else
+	vivt_exc = (unsigned long *) &handle_ri_rdhwr_vivt;
+#endif
+	vivt_exc++;
+	*vivt_exc = (*vivt_exc & 0xffff0000) | mask;
+
+	current_cpu_data.asid_cache = first_version;
+
+	asid_insn_fixup(__asid_mask, mask);
+	asid_insn_fixup(__asid_version_mask, version_mask);
+#else
+	asid_insn_fixup(__asid_mask, smtc_asid_mask);
+	asid_insn_fixup(__asid_version_mask,
+		~(smtc_asid_mask | (smtc_asid_mask - 1)));
+#endif
+	asid_insn_fixup(__asid_inc, inc);
+	asid_insn_fixup(__asid_first_version, first_version);
+}
+
 void build_tlb_refill_handler(void)
 {
 	/*
@@ -2226,6 +2296,7 @@ void build_tlb_refill_handler(void)
 	case CPU_TX3922:
 	case CPU_TX3927:
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+		setup_asid(0x40, 0xfc0, 0xf000, ASID_FIRST_VERSION_R3000);
 		if (cpu_has_local_ebase)
 			build_r3000_tlb_refill_handler();
 		if (!run_once) {
@@ -2252,6 +2323,7 @@ void build_tlb_refill_handler(void)
 		break;
 
 	default:
+		setup_asid(0x1, 0xff, 0xff00, ASID_FIRST_VERSION_R4000);
 		if (!run_once) {
 			scratch_reg = allocate_kscratch();
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-- 
1.7.9.5
