Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:20:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32522 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041082AbcFINTmwANgi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:42 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 53040D2930801;
        Thu,  9 Jun 2016 14:19:32 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 04/18] MIPS: KVM: Convert headers to kernel sized types
Date:   Thu, 9 Jun 2016 14:19:07 +0100
Message-ID: <1465478361-7431-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53918
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

Convert the MIPS kvm_host.h structs, function declaration prototypes and
associated definition prototypes to use standard kernel sized types
(e.g. u32) instead of inttypes.h style ones (e.g. uint32_t).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 97 +++++++++++++++++++---------------------
 arch/mips/kvm/dyntrans.c         |  8 ++--
 arch/mips/kvm/emulate.c          | 67 ++++++++++++++-------------
 arch/mips/kvm/interrupt.c        | 10 ++---
 arch/mips/kvm/interrupt.h        | 10 ++---
 arch/mips/kvm/tlb.c              |  8 ++--
 6 files changed, 98 insertions(+), 102 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index cbcedd7a684b..9250b59acd18 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -368,11 +368,11 @@ struct kvm_vcpu_arch {
 
 	struct hrtimer comparecount_timer;
 	/* Count timer control KVM register */
-	uint32_t count_ctl;
+	u32 count_ctl;
 	/* Count bias from the raw time */
-	uint32_t count_bias;
+	u32 count_bias;
 	/* Frequency of timer in Hz */
-	uint32_t count_hz;
+	u32 count_hz;
 	/* Dynamic nanosecond bias (multiple of count_period) to avoid overflow */
 	s64 count_dyn_bias;
 	/* Resume time */
@@ -395,8 +395,8 @@ struct kvm_vcpu_arch {
 	struct kvm_mips_tlb guest_tlb[KVM_MIPS_GUEST_TLB_SIZE];
 
 	/* Cached guest kernel/user ASIDs */
-	uint32_t guest_user_asid[NR_CPUS];
-	uint32_t guest_kernel_asid[NR_CPUS];
+	u32 guest_user_asid[NR_CPUS];
+	u32 guest_kernel_asid[NR_CPUS];
 	struct mm_struct guest_kernel_mm, guest_user_mm;
 
 	int last_sched_cpu;
@@ -587,9 +587,9 @@ struct kvm_mips_callbacks {
 	void (*dequeue_io_int)(struct kvm_vcpu *vcpu,
 			       struct kvm_mips_interrupt *irq);
 	int (*irq_deliver)(struct kvm_vcpu *vcpu, unsigned int priority,
-			   uint32_t cause);
+			   u32 cause);
 	int (*irq_clear)(struct kvm_vcpu *vcpu, unsigned int priority,
-			 uint32_t cause);
+			 u32 cause);
 	int (*get_one_reg)(struct kvm_vcpu *vcpu,
 			   const struct kvm_one_reg *reg, s64 *v);
 	int (*set_one_reg)(struct kvm_vcpu *vcpu,
@@ -620,11 +620,11 @@ void kvm_drop_fpu(struct kvm_vcpu *vcpu);
 void kvm_lose_fpu(struct kvm_vcpu *vcpu);
 
 /* TLB handling */
-uint32_t kvm_get_kernel_asid(struct kvm_vcpu *vcpu);
+u32 kvm_get_kernel_asid(struct kvm_vcpu *vcpu);
 
-uint32_t kvm_get_user_asid(struct kvm_vcpu *vcpu);
+u32 kvm_get_user_asid(struct kvm_vcpu *vcpu);
 
-uint32_t kvm_get_commpage_asid (struct kvm_vcpu *vcpu);
+u32 kvm_get_commpage_asid (struct kvm_vcpu *vcpu);
 
 extern int kvm_mips_handle_kseg0_tlb_fault(unsigned long badbaddr,
 					   struct kvm_vcpu *vcpu);
@@ -638,12 +638,12 @@ extern int kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
 						unsigned long *hpa1);
 
 extern enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
-						     uint32_t *opc,
+						     u32 *opc,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause,
-						    uint32_t *opc,
+						    u32 *opc,
 						    struct kvm_run *run,
 						    struct kvm_vcpu *vcpu);
 
@@ -665,90 +665,90 @@ extern void kvm_mips_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 extern void kvm_mips_vcpu_put(struct kvm_vcpu *vcpu);
 
 /* Emulation */
-uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu);
-enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause);
+u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu);
+enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause);
 
 extern enum emulation_result kvm_mips_emulate_inst(unsigned long cause,
-						   uint32_t *opc,
+						   u32 *opc,
 						   struct kvm_run *run,
 						   struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
-						      uint32_t *opc,
+						      u32 *opc,
 						      struct kvm_run *run,
 						      struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
-							 uint32_t *opc,
+							 u32 *opc,
 							 struct kvm_run *run,
 							 struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
-							uint32_t *opc,
+							u32 *opc,
 							struct kvm_run *run,
 							struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
-							 uint32_t *opc,
+							 u32 *opc,
 							 struct kvm_run *run,
 							 struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
-							uint32_t *opc,
+							u32 *opc,
 							struct kvm_run *run,
 							struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
-						     uint32_t *opc,
+						     u32 *opc,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
-						      uint32_t *opc,
+						      u32 *opc,
 						      struct kvm_run *run,
 						      struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_handle_ri(unsigned long cause,
-						uint32_t *opc,
+						u32 *opc,
 						struct kvm_run *run,
 						struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
-						     uint32_t *opc,
+						     u32 *opc,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
-						     uint32_t *opc,
+						     u32 *opc,
 						     struct kvm_run *run,
 						     struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
-						       uint32_t *opc,
+						       u32 *opc,
 						       struct kvm_run *run,
 						       struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
-							 uint32_t *opc,
+							 u32 *opc,
 							 struct kvm_run *run,
 							 struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
-						      uint32_t *opc,
+						      u32 *opc,
 						      struct kvm_run *run,
 						      struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
-							 uint32_t *opc,
+							 u32 *opc,
 							 struct kvm_run *run,
 							 struct kvm_vcpu *vcpu);
 
 extern enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
 							 struct kvm_run *run);
 
-uint32_t kvm_mips_read_count(struct kvm_vcpu *vcpu);
-void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count);
-void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare, bool ack);
+u32 kvm_mips_read_count(struct kvm_vcpu *vcpu);
+void kvm_mips_write_count(struct kvm_vcpu *vcpu, u32 count);
+void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack);
 void kvm_mips_init_count(struct kvm_vcpu *vcpu);
 int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl);
 int kvm_mips_set_count_resume(struct kvm_vcpu *vcpu, s64 count_resume);
@@ -758,26 +758,26 @@ void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_mips_count_timeout(struct kvm_vcpu *vcpu);
 
 enum emulation_result kvm_mips_check_privilege(unsigned long cause,
-					       uint32_t *opc,
+					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu);
 
-enum emulation_result kvm_mips_emulate_cache(uint32_t inst,
-					     uint32_t *opc,
-					     uint32_t cause,
+enum emulation_result kvm_mips_emulate_cache(u32 inst,
+					     u32 *opc,
+					     u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_CP0(uint32_t inst,
-					   uint32_t *opc,
-					   uint32_t cause,
+enum emulation_result kvm_mips_emulate_CP0(u32 inst,
+					   u32 *opc,
+					   u32 cause,
 					   struct kvm_run *run,
 					   struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_store(uint32_t inst,
-					     uint32_t cause,
+enum emulation_result kvm_mips_emulate_store(u32 inst,
+					     u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu);
-enum emulation_result kvm_mips_emulate_load(uint32_t inst,
-					    uint32_t cause,
+enum emulation_result kvm_mips_emulate_load(u32 inst,
+					    u32 cause,
 					    struct kvm_run *run,
 					    struct kvm_vcpu *vcpu);
 
@@ -787,14 +787,11 @@ unsigned int kvm_mips_config4_wrmask(struct kvm_vcpu *vcpu);
 unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu);
 
 /* Dynamic binary translation */
-extern int kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
+extern int kvm_mips_trans_cache_index(u32 inst, u32 *opc,
 				      struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
-				   struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc,
-			       struct kvm_vcpu *vcpu);
-extern int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc,
-			       struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_cache_va(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
+extern int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu);
 
 /* Misc */
 extern void kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index f1527a465c1b..e79502a88534 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -28,7 +28,7 @@
 #define CLEAR_TEMPLATE  0x00000020
 #define SW_TEMPLATE     0xac000000
 
-int kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
+int kvm_mips_trans_cache_index(u32 inst, u32 *opc,
 			       struct kvm_vcpu *vcpu)
 {
 	int result = 0;
@@ -49,7 +49,7 @@ int kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
  * Address based CACHE instructions are transformed into synci(s). A little
  * heavy for just D-cache invalidates, but avoids an expensive trap
  */
-int kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
+int kvm_mips_trans_cache_va(u32 inst, u32 *opc,
 			    struct kvm_vcpu *vcpu)
 {
 	int result = 0;
@@ -70,7 +70,7 @@ int kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
 	return result;
 }
 
-int kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
+int kvm_mips_trans_mfc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 {
 	int32_t rt, rd, sel;
 	uint32_t mfc0_inst;
@@ -110,7 +110,7 @@ int kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-int kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
+int kvm_mips_trans_mtc0(u32 inst, u32 *opc, struct kvm_vcpu *vcpu)
 {
 	int32_t rt, rd, sel;
 	uint32_t mtc0_inst = SW_TEMPLATE;
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 6c2adcfd7faf..c59c51908476 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -198,7 +198,7 @@ sigill:
 	return nextpc;
 }
 
-enum emulation_result update_pc(struct kvm_vcpu *vcpu, uint32_t cause)
+enum emulation_result update_pc(struct kvm_vcpu *vcpu, u32 cause)
 {
 	unsigned long branch_pc;
 	enum emulation_result er = EMULATE_DONE;
@@ -243,7 +243,7 @@ static inline int kvm_mips_count_disabled(struct kvm_vcpu *vcpu)
  *
  * Assumes !kvm_mips_count_disabled(@vcpu) (guest CP0_Count timer is running).
  */
-static uint32_t kvm_mips_ktime_to_count(struct kvm_vcpu *vcpu, ktime_t now)
+static u32 kvm_mips_ktime_to_count(struct kvm_vcpu *vcpu, ktime_t now)
 {
 	s64 now_ns, periods;
 	u64 delta;
@@ -300,7 +300,7 @@ static inline ktime_t kvm_mips_count_time(struct kvm_vcpu *vcpu)
  *
  * Returns:	The current value of the guest CP0_Count register.
  */
-static uint32_t kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
+static u32 kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	ktime_t expires, threshold;
@@ -360,7 +360,7 @@ static uint32_t kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
  *
  * Returns:	The current guest CP0_Count value.
  */
-uint32_t kvm_mips_read_count(struct kvm_vcpu *vcpu)
+u32 kvm_mips_read_count(struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 
@@ -387,8 +387,7 @@ uint32_t kvm_mips_read_count(struct kvm_vcpu *vcpu)
  *
  * Returns:	The ktime at the point of freeze.
  */
-static ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu,
-				       uint32_t *count)
+static ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu, u32 *count)
 {
 	ktime_t now;
 
@@ -419,7 +418,7 @@ static ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu,
  * Assumes !kvm_mips_count_disabled(@vcpu) (guest CP0_Count timer is running).
  */
 static void kvm_mips_resume_hrtimer(struct kvm_vcpu *vcpu,
-				    ktime_t now, uint32_t count)
+				    ktime_t now, u32 count)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	uint32_t compare;
@@ -444,7 +443,7 @@ static void kvm_mips_resume_hrtimer(struct kvm_vcpu *vcpu,
  *
  * Sets the CP0_Count value and updates the timer accordingly.
  */
-void kvm_mips_write_count(struct kvm_vcpu *vcpu, uint32_t count)
+void kvm_mips_write_count(struct kvm_vcpu *vcpu, u32 count)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	ktime_t now;
@@ -538,7 +537,7 @@ int kvm_mips_set_count_hz(struct kvm_vcpu *vcpu, s64 count_hz)
  * If @ack, atomically acknowledge any pending timer interrupt, otherwise ensure
  * any pending timer interrupt is preserved.
  */
-void kvm_mips_write_compare(struct kvm_vcpu *vcpu, uint32_t compare, bool ack)
+void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	int dc;
@@ -973,8 +972,8 @@ unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu)
 	return mask;
 }
 
-enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
-					   uint32_t cause, struct kvm_run *run,
+enum emulation_result kvm_mips_emulate_CP0(u32 inst, u32 *opc, u32 cause,
+					   struct kvm_run *run,
 					   struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
@@ -1312,7 +1311,7 @@ dont_update_pc:
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
+enum emulation_result kvm_mips_emulate_store(u32 inst, u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
@@ -1424,7 +1423,7 @@ enum emulation_result kvm_mips_emulate_store(uint32_t inst, uint32_t cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
+enum emulation_result kvm_mips_emulate_load(u32 inst, u32 cause,
 					    struct kvm_run *run,
 					    struct kvm_vcpu *vcpu)
 {
@@ -1529,8 +1528,8 @@ enum emulation_result kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
-					     uint32_t cause,
+enum emulation_result kvm_mips_emulate_cache(u32 inst, u32 *opc,
+					     u32 cause,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
@@ -1687,7 +1686,7 @@ dont_update_pc:
 	return er;
 }
 
-enum emulation_result kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
+enum emulation_result kvm_mips_emulate_inst(unsigned long cause, u32 *opc,
 					    struct kvm_run *run,
 					    struct kvm_vcpu *vcpu)
 {
@@ -1735,7 +1734,7 @@ enum emulation_result kvm_mips_emulate_inst(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
-					       uint32_t *opc,
+					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu)
 {
@@ -1770,7 +1769,7 @@ enum emulation_result kvm_mips_emulate_syscall(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
-						  uint32_t *opc,
+						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
 {
@@ -1816,7 +1815,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
-						 uint32_t *opc,
+						 u32 *opc,
 						 struct kvm_run *run,
 						 struct kvm_vcpu *vcpu)
 {
@@ -1862,7 +1861,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
-						  uint32_t *opc,
+						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
 {
@@ -1906,7 +1905,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
-						 uint32_t *opc,
+						 u32 *opc,
 						 struct kvm_run *run,
 						 struct kvm_vcpu *vcpu)
 {
@@ -1950,7 +1949,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
 }
 
 /* TLBMOD: store into address matching TLB with Dirty bit off */
-enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
+enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause, u32 *opc,
 					     struct kvm_run *run,
 					     struct kvm_vcpu *vcpu)
 {
@@ -1979,7 +1978,7 @@ enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
 }
 
 enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
-					      uint32_t *opc,
+					      u32 *opc,
 					      struct kvm_run *run,
 					      struct kvm_vcpu *vcpu)
 {
@@ -2022,7 +2021,7 @@ enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
-					       uint32_t *opc,
+					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu)
 {
@@ -2051,7 +2050,7 @@ enum emulation_result kvm_mips_emulate_fpu_exc(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
-					      uint32_t *opc,
+					      u32 *opc,
 					      struct kvm_run *run,
 					      struct kvm_vcpu *vcpu)
 {
@@ -2086,7 +2085,7 @@ enum emulation_result kvm_mips_emulate_ri_exc(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
-					      uint32_t *opc,
+					      u32 *opc,
 					      struct kvm_run *run,
 					      struct kvm_vcpu *vcpu)
 {
@@ -2121,7 +2120,7 @@ enum emulation_result kvm_mips_emulate_bp_exc(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
-						uint32_t *opc,
+						u32 *opc,
 						struct kvm_run *run,
 						struct kvm_vcpu *vcpu)
 {
@@ -2156,7 +2155,7 @@ enum emulation_result kvm_mips_emulate_trap_exc(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
-						  uint32_t *opc,
+						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
 {
@@ -2191,7 +2190,7 @@ enum emulation_result kvm_mips_emulate_msafpe_exc(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
-					       uint32_t *opc,
+					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu)
 {
@@ -2226,7 +2225,7 @@ enum emulation_result kvm_mips_emulate_fpe_exc(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
-						  uint32_t *opc,
+						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
 {
@@ -2275,7 +2274,7 @@ enum emulation_result kvm_mips_emulate_msadis_exc(unsigned long cause,
 #define SYNC   0x0000000f
 #define RDHWR  0x0000003b
 
-enum emulation_result kvm_mips_handle_ri(unsigned long cause, uint32_t *opc,
+enum emulation_result kvm_mips_handle_ri(unsigned long cause, u32 *opc,
 					 struct kvm_run *run,
 					 struct kvm_vcpu *vcpu)
 {
@@ -2406,7 +2405,7 @@ done:
 }
 
 static enum emulation_result kvm_mips_emulate_exc(unsigned long cause,
-						  uint32_t *opc,
+						  u32 *opc,
 						  struct kvm_run *run,
 						  struct kvm_vcpu *vcpu)
 {
@@ -2444,7 +2443,7 @@ static enum emulation_result kvm_mips_emulate_exc(unsigned long cause,
 }
 
 enum emulation_result kvm_mips_check_privilege(unsigned long cause,
-					       uint32_t *opc,
+					       u32 *opc,
 					       struct kvm_run *run,
 					       struct kvm_vcpu *vcpu)
 {
@@ -2540,7 +2539,7 @@ enum emulation_result kvm_mips_check_privilege(unsigned long cause,
  *     case we inject the TLB from the Guest TLB into the shadow host TLB
  */
 enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
-					      uint32_t *opc,
+					      u32 *opc,
 					      struct kvm_run *run,
 					      struct kvm_vcpu *vcpu)
 {
diff --git a/arch/mips/kvm/interrupt.c b/arch/mips/kvm/interrupt.c
index 95f790663b0c..49ce83237fc3 100644
--- a/arch/mips/kvm/interrupt.c
+++ b/arch/mips/kvm/interrupt.c
@@ -22,12 +22,12 @@
 
 #include "interrupt.h"
 
-void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
+void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, unsigned int priority)
 {
 	set_bit(priority, &vcpu->arch.pending_exceptions);
 }
 
-void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
+void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, unsigned int priority)
 {
 	clear_bit(priority, &vcpu->arch.pending_exceptions);
 }
@@ -114,7 +114,7 @@ void kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
 
 /* Deliver the interrupt of the corresponding priority, if possible. */
 int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
-			    uint32_t cause)
+			    u32 cause)
 {
 	int allowed = 0;
 	uint32_t exccode;
@@ -196,12 +196,12 @@ int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
 }
 
 int kvm_mips_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority,
-			  uint32_t cause)
+			  u32 cause)
 {
 	return 1;
 }
 
-void kvm_mips_deliver_interrupts(struct kvm_vcpu *vcpu, uint32_t cause)
+void kvm_mips_deliver_interrupts(struct kvm_vcpu *vcpu, u32 cause)
 {
 	unsigned long *pending = &vcpu->arch.pending_exceptions;
 	unsigned long *pending_clr = &vcpu->arch.pending_exceptions_clr;
diff --git a/arch/mips/kvm/interrupt.h b/arch/mips/kvm/interrupt.h
index 2143884709e4..d661c100b219 100644
--- a/arch/mips/kvm/interrupt.h
+++ b/arch/mips/kvm/interrupt.h
@@ -37,8 +37,8 @@ extern char mips32_GuestException[], mips32_GuestExceptionEnd[];
 #define KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE (0)
 #define KVM_MIPS_IRQ_CLEAR_ALL_AT_ONCE   (0)
 
-void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority);
-void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority);
+void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, unsigned int priority);
+void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, unsigned int priority);
 int kvm_mips_pending_timer(struct kvm_vcpu *vcpu);
 
 void kvm_mips_queue_timer_int_cb(struct kvm_vcpu *vcpu);
@@ -48,7 +48,7 @@ void kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu,
 void kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu,
 				struct kvm_mips_interrupt *irq);
 int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
-			    uint32_t cause);
+			    u32 cause);
 int kvm_mips_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority,
-			  uint32_t cause);
-void kvm_mips_deliver_interrupts(struct kvm_vcpu *vcpu, uint32_t cause);
+			  u32 cause);
+void kvm_mips_deliver_interrupts(struct kvm_vcpu *vcpu, u32 cause);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index ed021ae7867a..7ea346e150a8 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -47,7 +47,7 @@ EXPORT_SYMBOL_GPL(kvm_mips_release_pfn_clean);
 bool (*kvm_mips_is_error_pfn)(kvm_pfn_t pfn);
 EXPORT_SYMBOL_GPL(kvm_mips_is_error_pfn);
 
-uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
+u32 kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 {
 	int cpu = smp_processor_id();
 
@@ -55,7 +55,7 @@ uint32_t kvm_mips_get_kernel_asid(struct kvm_vcpu *vcpu)
 			cpu_asid_mask(&cpu_data[cpu]);
 }
 
-uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
+u32 kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 {
 	int cpu = smp_processor_id();
 
@@ -63,7 +63,7 @@ uint32_t kvm_mips_get_user_asid(struct kvm_vcpu *vcpu)
 			cpu_asid_mask(&cpu_data[cpu]);
 }
 
-inline uint32_t kvm_mips_get_commpage_asid(struct kvm_vcpu *vcpu)
+inline u32 kvm_mips_get_commpage_asid(struct kvm_vcpu *vcpu)
 {
 	return vcpu->kvm->arch.commpage_tlb;
 }
@@ -751,7 +751,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_arch_vcpu_put);
 
-uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
+u32 kvm_get_inst(u32 *opc, struct kvm_vcpu *vcpu)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long paddr, flags, vpn2, asid;
-- 
2.4.10
