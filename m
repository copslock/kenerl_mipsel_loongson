Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:50:58 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:55475 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6827534Ab3ESFsY2Ldr3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:48:24 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:48:15 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 2EF1E63005E; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 06/18] KVM/MIPS32-VZ: VZ-ASE related callbacks to handle guest exceptions that trap to the Root context.
Date:   Sat, 18 May 2013 22:47:28 -0700
Message-Id: <1368942460-15577-7-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

The VZ-ASE provices the Guest with its own COP0 context, so the types of exceptions
that will trap to the root a lot fewer than in the trap and emulate case.

- Root level TLB miss handlers that map GPAs to RPAs.
- Guest Exits

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_vz.c | 786 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 786 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_vz.c

diff --git a/arch/mips/kvm/kvm_vz.c b/arch/mips/kvm/kvm_vz.c
new file mode 100644
index 0000000..e85a497
--- /dev/null
+++ b/arch/mips/kvm/kvm_vz.c
@@ -0,0 +1,786 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: Support for hardware virtualization extensions
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Yann Le Du <ledu@kymasys.com>
+*/
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <asm/cacheflush.h>
+#include <asm/mipsvzregs.h>
+#include <asm/inst.h>
+
+#include <linux/kvm_host.h>
+
+#include "kvm_mips_opcode.h"
+#include "kvm_mips_int.h"
+
+#include "trace.h"
+
+static gpa_t kvm_vz_gva_to_gpa_cb(gva_t gva)
+{
+	/* VZ guest has already converted gva to gpa */
+	return gva;
+}
+
+void kvm_vz_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
+{
+	set_bit(priority, &vcpu->arch.pending_exceptions);
+	clear_bit(priority, &vcpu->arch.pending_exceptions_clr);
+}
+
+void kvm_vz_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
+{
+	clear_bit(priority, &vcpu->arch.pending_exceptions);
+	set_bit(priority, &vcpu->arch.pending_exceptions_clr);
+}
+
+void kvm_vz_queue_timer_int_cb(struct kvm_vcpu *vcpu)
+{
+	/* timer expiry is asynchronous to vcpu execution therefore defer guest
+	 * cp0 accesses */
+	kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_TIMER);
+}
+
+void kvm_vz_dequeue_timer_int_cb(struct kvm_vcpu *vcpu)
+{
+	/* timer expiry is asynchronous to vcpu execution therefore defer guest
+	 * cp0 accesses */
+	kvm_vz_dequeue_irq(vcpu, MIPS_EXC_INT_TIMER);
+}
+
+void
+kvm_vz_queue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
+{
+	int intr = (int)irq->irq;
+
+	/* interrupts are asynchronous to vcpu execution therefore defer guest
+	 * cp0 accesses */
+	switch (intr) {
+	case 2:
+		kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_IO);
+		break;
+
+	case 3:
+		kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_IPI_1);
+		break;
+
+	case 4:
+		kvm_vz_queue_irq(vcpu, MIPS_EXC_INT_IPI_2);
+		break;
+
+	default:
+		break;
+	}
+
+}
+
+void
+kvm_vz_dequeue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
+{
+	int intr = (int)irq->irq;
+
+	/* interrupts are asynchronous to vcpu execution therefore defer guest
+	 * cp0 accesses */
+	switch (intr) {
+	case -2:
+		kvm_vz_dequeue_irq(vcpu, MIPS_EXC_INT_IO);
+		break;
+
+	case -3:
+		kvm_vz_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_1);
+		break;
+
+	case -4:
+		kvm_vz_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_2);
+		break;
+
+	default:
+		break;
+	}
+
+}
+
+static uint32_t kvm_vz_priority_to_irq[MIPS_EXC_MAX] = {
+	[MIPS_EXC_INT_TIMER] = C_TI,
+	[MIPS_EXC_INT_IO]    = C_IRQ0,
+	[MIPS_EXC_INT_IPI_1] = C_IRQ1,
+	[MIPS_EXC_INT_IPI_2] = C_IRQ2,
+};
+
+static int
+kvm_vz_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
+		      uint32_t cause)
+{
+	uint32_t irq = (priority < MIPS_EXC_MAX) ? 
+		kvm_vz_priority_to_irq[priority] : 0;
+
+	switch (priority) {
+	case MIPS_EXC_INT_TIMER:
+		kvm_set_c0_guest_cause(vcpu->arch.cop0, irq);
+		break;
+
+	case MIPS_EXC_INT_IO:
+	case MIPS_EXC_INT_IPI_1:
+	case MIPS_EXC_INT_IPI_2:
+		if (cpu_has_vzvirtirq)
+			set_c0_guestctl2(irq);
+		else
+			kvm_set_c0_guest_cause(vcpu->arch.cop0, irq);
+		break;
+
+	default:
+		break;
+	}
+
+	clear_bit(priority, &vcpu->arch.pending_exceptions);
+	return 1;
+}
+
+static int
+kvm_vz_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority,
+		    uint32_t cause)
+{
+	uint32_t irq = (priority < MIPS_EXC_MAX) ?
+		kvm_vz_priority_to_irq[priority] : 0;
+
+	switch (priority) {
+	case MIPS_EXC_INT_TIMER:
+		/* Call to kvm_write_c0_guest_compare clears Cause.TI in
+		 * kvm_mips_emulate_CP0. Explicitly clear irq associated with
+		 * Cause.IP[IPTI] if GuestCtl2 virtual interrupt register not
+		 * supported.
+		 */
+		if (!cpu_has_vzvirtirq)
+			kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ5));
+
+		break;
+
+	case MIPS_EXC_INT_IO:
+	case MIPS_EXC_INT_IPI_1:
+	case MIPS_EXC_INT_IPI_2:
+		if (cpu_has_vzvirtirq)
+			clear_c0_guestctl2(irq);
+		else
+			kvm_clear_c0_guest_cause(vcpu->arch.cop0, irq);
+		break;
+
+	default:
+		break;
+	}
+
+	clear_bit(priority, &vcpu->arch.pending_exceptions_clr);
+	return 1;
+}
+
+/*
+ * Restore Guest.Count, Guest.Compare and Guest.Cause taking care to
+ * preserve the value of Guest.Cause[TI] while restoring Guest.Cause.
+ *
+ * Follows the algorithm in VZ ASE specification - Section: Guest Timer.
+ */
+void
+kvm_vz_restore_guest_timer_int(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	ulong current_guest_count;
+	ulong saved_guest_cause = regs->cp0reg[MIPS_CP0_CAUSE][0];
+	ulong saved_guest_count = regs->cp0reg[MIPS_CP0_COUNT][0];
+	ulong saved_guest_compare = regs->cp0reg[MIPS_CP0_COMPARE][0];
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	/* TODO VZ gtoffset not being set anywhere at the moment */
+	/* restore root gtoffset from unused Guest gtoffset register */
+	write_c0_gtoffset(regs->cp0reg[MIPS_CP0_STATUS][7]);
+	kvm_write_c0_guest_cause(cop0, saved_guest_cause);
+
+	/* after the following statement, the hardware might now set
+	 * Guest.Cause[TI] */
+	kvm_write_c0_guest_compare(cop0, saved_guest_compare);
+	current_guest_count = kvm_read_c0_guest_count(cop0);
+
+	/*
+	 * set Guest.Cause[TI] if it would have been set while the guest was
+	 * sleeping.  This code assumes that the counter has not completely
+	 * wrapped around while the guest was sleeping.
+	 */
+	if (current_guest_count > saved_guest_count) {
+		if ((saved_guest_compare > saved_guest_count)
+		    && (saved_guest_compare < current_guest_count)) {
+			kvm_write_c0_guest_cause(cop0,
+						 saved_guest_cause | C_TI);
+		}
+	} else {
+		/* The count has wrapped. Check to see if guest count has
+		 * passed the saved compare value */
+		if ((saved_guest_compare > saved_guest_count)
+		    || (saved_guest_compare < current_guest_count)) {
+			kvm_write_c0_guest_cause(cop0,
+						 saved_guest_cause | C_TI);
+		}
+	}
+}
+
+static int kvm_trap_vz_no_handler(struct kvm_vcpu *vcpu)
+{
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
+
+	kvm_err("Exception Code: %d not handled @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
+			exccode, opc, kvm_get_inst(opc, vcpu), badvaddr,
+			kvm_read_c0_guest_status(vcpu->arch.cop0));
+	kvm_arch_vcpu_dump_regs(vcpu);
+	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	return RESUME_HOST;
+}
+
+#define COP0MT 0xffe007f8
+#define MTC0   0x40800000
+#define COP0MF 0xffe007f8
+#define MFC0   0x40000000
+#define RT     0x001f0000
+#define RD     0x0000f800
+#define SEL    0x00000007
+
+enum emulation_result
+kvm_trap_vz_handle_gpsi(ulong cause, uint32_t *opc,
+			struct kvm_vcpu *vcpu)
+{
+	enum emulation_result er = EMULATE_DONE;
+	struct kvm_run *run = vcpu->run;
+	uint32_t inst;
+
+	/*
+	 *  Fetch the instruction.
+	 */
+	if (cause & CAUSEF_BD)
+		opc += 1;
+
+	inst = kvm_get_inst(opc, vcpu);
+
+	switch (((union mips_instruction)inst).r_format.opcode) {
+	case cop0_op:
+		++vcpu->stat.hypervisor_gpsi_cp0_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_GPSI_CP0_EXITS);
+		er = kvm_mips_emulate_CP0(inst, opc, cause, run, vcpu);
+		break;
+	case cache_op:
+		++vcpu->stat.hypervisor_gpsi_cache_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_GPSI_CACHE_EXITS);
+		er = kvm_mips_emulate_cache(inst, opc, cause, run, vcpu);
+		break;
+
+	default:
+		kvm_err("GPSI exception not supported (%p/%#x)\n",
+				opc, inst);
+		kvm_arch_vcpu_dump_regs(vcpu);
+		er = EMULATE_FAIL;
+		break;
+	}
+
+	return er;
+}
+
+enum emulation_result
+kvm_trap_vz_handle_gsfc(ulong cause, uint32_t *opc,
+			struct kvm_vcpu *vcpu)
+{
+	enum emulation_result er = EMULATE_DONE;
+	struct kvm_vcpu_arch *arch = &vcpu->arch;
+	uint32_t inst;
+
+	/*
+	 *  Fetch the instruction.
+	 */
+	if (cause & CAUSEF_BD)
+		opc += 1;
+
+	inst = kvm_get_inst(opc, vcpu);
+
+	/* complete MTC0 on behalf of guest and advance EPC */
+	if ((inst & COP0MT) == MTC0) {
+		int rt = (inst & RT) >> 16;
+		int val = arch->gprs[rt];
+		int rd = (inst & RD) >> 11;
+		int sel = (inst & SEL);
+
+		if ((rd == MIPS_CP0_STATUS) && (sel == 0)) {
+			++vcpu->stat.hypervisor_gsfc_cp0_status_exits;
+			trace_kvm_exit(vcpu, HYPERVISOR_GSFC_CP0_STATUS_EXITS);
+			write_c0_guest_status(val);
+		} else if ((rd == MIPS_CP0_CAUSE) && (sel == 0)) {
+			++vcpu->stat.hypervisor_gsfc_cp0_cause_exits;
+			trace_kvm_exit(vcpu, HYPERVISOR_GSFC_CP0_CAUSE_EXITS);
+			write_c0_guest_cause(val);
+#define	MIPS_CP0_INTCTL MIPS_CP0_STATUS
+		} else if ((rd == MIPS_CP0_INTCTL) && (sel == 1)) {
+			++vcpu->stat.hypervisor_gsfc_cp0_intctl_exits;
+			trace_kvm_exit(vcpu, HYPERVISOR_GSFC_CP0_INTCTL_EXITS);
+			write_c0_guest_intctl(val);
+		} else {
+			kvm_err("Handle GSFC, unsupported field change @ %p: %#x\n",
+			    opc, inst);
+			er = EMULATE_FAIL;
+		}
+
+		if (er != EMULATE_FAIL) {
+			er = update_pc(vcpu, cause);
+#ifdef DEBUG
+			kvm_debug(
+			    "[%#x] MTGC0[%d][%d], vcpu->arch.gprs[%d]: %#lx\n",
+			    vcpu->arch.pc, rd, sel, rt, vcpu->arch.gprs[rt]);
+#endif
+		}
+	} else {
+		kvm_err("Handle GSFC, unrecognized instruction @ %p: %#x\n",
+			opc, inst);
+		er = EMULATE_FAIL;
+	}
+
+	return er;
+}
+
+enum emulation_result
+kvm_trap_vz_no_handler_guest_exit(int32_t gexccode, ulong cause,
+				  uint32_t *opc, struct kvm_vcpu *vcpu)
+{
+	uint32_t inst;
+
+	/*
+	 *  Fetch the instruction.
+	 */
+	if (cause & CAUSEF_BD)
+		opc += 1;
+
+	inst = kvm_get_inst(opc, vcpu);
+
+	kvm_err(
+	    "Guest Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  Status: %#lx\n",
+	    gexccode, opc, inst, kvm_read_c0_guest_status(vcpu->arch.cop0));
+
+	return EMULATE_FAIL;
+}
+
+static int kvm_trap_vz_handle_guest_exit(struct kvm_vcpu *vcpu)
+{
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	enum emulation_result er = EMULATE_DONE;
+	int32_t gexccode =
+	    (read_c0_guestctl0() & GUESTCTL0_GEXC) >> GUESTCTL0_GEXC_SHIFT;
+	int ret = RESUME_GUEST;
+
+#ifdef DEBUG
+	kvm_debug("Hypervisor Guest Exit. GExcCode %s\n",
+	       (gexccode == GUESTCTL0_GEXC_GPSI ? "GPSI" :
+		(gexccode == GUESTCTL0_GEXC_GSFC ? "GSFC" :
+		 (gexccode == GUESTCTL0_GEXC_HC ? "HC" :
+		  (gexccode == GUESTCTL0_GEXC_GRR ? "GRR" :
+		   (gexccode == GUESTCTL0_GEXC_GVA ? "GVA" :
+		    (gexccode == GUESTCTL0_GEXC_GHFC ? "GHFC" :
+		     (gexccode == GUESTCTL0_GEXC_GPA ? "GPA" :
+		      "RESV"))))))));
+#endif
+
+	switch (gexccode) {
+	case GUESTCTL0_GEXC_GPSI:
+		++vcpu->stat.hypervisor_gpsi_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_GPSI_EXITS);
+		er = kvm_trap_vz_handle_gpsi(cause, opc, vcpu);
+		break;
+	case GUESTCTL0_GEXC_GSFC:
+		++vcpu->stat.hypervisor_gsfc_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_GSFC_EXITS);
+		er = kvm_trap_vz_handle_gsfc(cause, opc, vcpu);
+		break;
+	case GUESTCTL0_GEXC_HC:
+		++vcpu->stat.hypervisor_hc_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_HC_EXITS);
+		er = kvm_trap_vz_no_handler_guest_exit(gexccode, cause, opc,
+						       vcpu);
+		break;
+	case GUESTCTL0_GEXC_GRR:
+		++vcpu->stat.hypervisor_grr_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_GRR_EXITS);
+		er = kvm_trap_vz_no_handler_guest_exit(gexccode, cause, opc,
+						       vcpu);
+		break;
+	case GUESTCTL0_GEXC_GVA:
+		++vcpu->stat.hypervisor_gva_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_GVA_EXITS);
+		er = kvm_trap_vz_no_handler_guest_exit(gexccode, cause, opc,
+						       vcpu);
+		break;
+	case GUESTCTL0_GEXC_GHFC:
+		++vcpu->stat.hypervisor_ghfc_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_GHFC_EXITS);
+		er = kvm_trap_vz_no_handler_guest_exit(gexccode, cause, opc,
+						       vcpu);
+		break;
+	case GUESTCTL0_GEXC_GPA:
+		++vcpu->stat.hypervisor_gpa_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_GPA_EXITS);
+		er = kvm_trap_vz_no_handler_guest_exit(gexccode, cause, opc,
+						       vcpu);
+		break;
+	default:
+		++vcpu->stat.hypervisor_resv_exits;
+		trace_kvm_exit(vcpu, HYPERVISOR_RESV_EXITS);
+		er = kvm_trap_vz_no_handler_guest_exit(gexccode, cause, opc,
+						       vcpu);
+		break;
+
+	}
+
+	if (er == EMULATE_DONE)
+		ret = RESUME_GUEST;
+	else {
+		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+	}
+	return ret;
+}
+
+static int kvm_trap_vz_is_mmio_addrspace(struct kvm_vcpu *vcpu, ulong vaddr)
+{
+	gfn_t gfn = (vaddr >> PAGE_SHIFT);
+
+	/* KYMAXXX These MMIO flash address ranges are specific to the malta
+	 * board */
+	return (!kvm_is_visible_gfn(vcpu->kvm, gfn) ||
+		((vaddr >= 0x1e000000) && (vaddr <= 0x1e3fffff)) ||
+		((vaddr >= 0x1fc00000) && (vaddr <= 0x1fffffff)));
+}
+
+static int kvm_trap_vz_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
+	uint32_t inst;
+	ulong flags;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	if (kvm_trap_vz_is_mmio_addrspace(vcpu, badvaddr)) {
+#ifdef DEBUG
+		kvm_debug("Guest Emulate Load from MMIO space: PC: "
+			"%p, BadVaddr: %#lx\n", opc, badvaddr);
+#endif
+
+		/*
+		 *  Fetch the instruction.
+		 */
+		if (cause & CAUSEF_BD)
+			opc += 1;
+
+		inst = kvm_get_inst(opc, vcpu);
+
+		er = kvm_mips_emulate_load(inst, cause, run, vcpu);
+
+		if (er == EMULATE_FAIL) {
+			kvm_err(
+			    "Guest Emulate Load from MMIO space failed: PC: "
+			    "%p, BadVaddr: %#lx\n", opc, badvaddr);
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		} else {
+			run->exit_reason = KVM_EXIT_MMIO;
+			er = EMULATE_DO_MMIO;
+		}
+
+	} else {
+#ifdef DEBUG
+		kvm_debug("Guest ADDR TLB LD fault: PC: %p, BadVaddr: %#lx\n",
+			opc, badvaddr);
+#endif
+		local_irq_save(flags);
+		if (kvm_mips_handle_vz_root_tlb_fault(badvaddr, vcpu) < 0) {
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			er = EMULATE_FAIL;
+		}
+		local_irq_restore(flags);
+	}
+
+	if (er == EMULATE_DONE) {
+		ret = RESUME_GUEST;
+	} else if (er == EMULATE_DO_MMIO) {
+		ret = RESUME_HOST;
+	} else {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+	}
+	return ret;
+}
+
+static int kvm_trap_vz_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	uint32_t *opc = (uint32_t *) vcpu->arch.pc;
+	ulong cause = vcpu->arch.host_cp0_cause;
+	ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
+	uint32_t inst;
+	ulong flags;
+	enum emulation_result er = EMULATE_DONE;
+	int ret = RESUME_GUEST;
+
+	if (kvm_trap_vz_is_mmio_addrspace(vcpu, badvaddr)) {
+#ifdef DEBUG
+		kvm_debug("Guest Emulate Store to MMIO space: PC: "
+				"%p, BadVaddr: %#lx\n", opc, badvaddr);
+#endif
+		/*
+		 *  Fetch the instruction.
+		 */
+		if (cause & CAUSEF_BD)
+			opc += 1;
+
+		inst = kvm_get_inst(opc, vcpu);
+
+		er = kvm_mips_emulate_store(inst, cause, run, vcpu);
+
+		if (er == EMULATE_FAIL) {
+			kvm_err("Guest Emulate Store to MMIO space failed: PC: "
+				"%p, BadVaddr: %#lx\n", opc, badvaddr);
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		} else {
+			run->exit_reason = KVM_EXIT_MMIO;
+			er = EMULATE_DO_MMIO;
+		}
+
+	} else {
+#ifdef DEBUG
+		kvm_debug("Guest ADDR TLB ST fault: PC: %p, BadVaddr: %#lx\n",
+				opc, badvaddr);
+#endif
+		local_irq_save(flags);
+		if (kvm_mips_handle_vz_root_tlb_fault(badvaddr, vcpu) < 0) {
+			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			er = EMULATE_FAIL;
+		}
+		local_irq_restore(flags);
+	}
+
+	if (er == EMULATE_DONE) {
+		ret = RESUME_GUEST;
+	} else if (er == EMULATE_DO_MMIO) {
+		ret = RESUME_HOST;
+	} else {
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		ret = RESUME_HOST;
+	}
+	return ret;
+}
+
+static int kvm_vz_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	/* some registers are not restored
+	 * random, count        : read-only
+	 * userlocal            : not implemented in qemu
+	 * config6              : not implemented in processor variant
+	 * compare, cause       : defer to kvm_vz_restore_guest_timer_int
+	 */
+
+	kvm_write_c0_guest_index(cop0, regs->cp0reg[MIPS_CP0_TLB_INDEX][0]);
+	kvm_write_c0_guest_entrylo0(cop0, regs->cp0reg[MIPS_CP0_TLB_LO0][0]);
+	kvm_write_c0_guest_entrylo1(cop0, regs->cp0reg[MIPS_CP0_TLB_LO1][0]);
+	kvm_write_c0_guest_context(cop0, regs->cp0reg[MIPS_CP0_TLB_CONTEXT][0]);
+	kvm_write_c0_guest_pagemask(cop0,
+				    regs->cp0reg[MIPS_CP0_TLB_PG_MASK][0]);
+	kvm_write_c0_guest_pagegrain(cop0,
+				     regs->cp0reg[MIPS_CP0_TLB_PG_MASK][1]);
+	kvm_write_c0_guest_wired(cop0, regs->cp0reg[MIPS_CP0_TLB_WIRED][0]);
+	kvm_write_c0_guest_hwrena(cop0, regs->cp0reg[MIPS_CP0_HWRENA][0]);
+	kvm_write_c0_guest_badvaddr(cop0, regs->cp0reg[MIPS_CP0_BAD_VADDR][0]);
+	/* skip kvm_write_c0_guest_count */
+	kvm_write_c0_guest_entryhi(cop0, regs->cp0reg[MIPS_CP0_TLB_HI][0]);
+	/* defer kvm_write_c0_guest_compare */
+	kvm_write_c0_guest_status(cop0, regs->cp0reg[MIPS_CP0_STATUS][0]);
+	kvm_write_c0_guest_intctl(cop0, regs->cp0reg[MIPS_CP0_STATUS][1]);
+	/* defer kvm_write_c0_guest_cause */
+	kvm_write_c0_guest_epc(cop0, regs->cp0reg[MIPS_CP0_EXC_PC][0]);
+	kvm_write_c0_guest_prid(cop0, regs->cp0reg[MIPS_CP0_PRID][0]);
+	kvm_write_c0_guest_ebase(cop0, regs->cp0reg[MIPS_CP0_PRID][1]);
+
+	/* only restore implemented config registers */
+	kvm_write_c0_guest_config(cop0, regs->cp0reg[MIPS_CP0_CONFIG][0]);
+
+	if ((regs->cp0reg[MIPS_CP0_CONFIG][0] & MIPS_CONF_M) &
+			cpu_vz_has_config1)
+		kvm_write_c0_guest_config1(cop0,
+				regs->cp0reg[MIPS_CP0_CONFIG][1]);
+
+	if ((regs->cp0reg[MIPS_CP0_CONFIG][1] & MIPS_CONF_M) &
+			cpu_vz_has_config2)
+		kvm_write_c0_guest_config2(cop0,
+				regs->cp0reg[MIPS_CP0_CONFIG][2]);
+
+	if ((regs->cp0reg[MIPS_CP0_CONFIG][2] & MIPS_CONF_M) &
+			cpu_vz_has_config3)
+		kvm_write_c0_guest_config3(cop0,
+				regs->cp0reg[MIPS_CP0_CONFIG][3]);
+
+	if ((regs->cp0reg[MIPS_CP0_CONFIG][3] & MIPS_CONF_M) &
+			cpu_vz_has_config4)
+		kvm_write_c0_guest_config4(cop0,
+				regs->cp0reg[MIPS_CP0_CONFIG][4]);
+
+	if ((regs->cp0reg[MIPS_CP0_CONFIG][4] & MIPS_CONF_M) &
+			cpu_vz_has_config5)
+		kvm_write_c0_guest_config5(cop0,
+				regs->cp0reg[MIPS_CP0_CONFIG][5]);
+
+	if (cpu_vz_has_config6)
+		kvm_write_c0_guest_config6(cop0,
+				regs->cp0reg[MIPS_CP0_CONFIG][6]);
+	if (cpu_vz_has_config7)
+		kvm_write_c0_guest_config7(cop0,
+				regs->cp0reg[MIPS_CP0_CONFIG][7]);
+
+	kvm_write_c0_guest_errorepc(cop0, regs->cp0reg[MIPS_CP0_ERROR_PC][0]);
+
+	/* call after setting MIPS_CP0_CAUSE to avoid having it overwritten
+	 * this will set guest compare and cause.TI if necessary
+	 */
+	kvm_vz_restore_guest_timer_int(vcpu, regs);
+
+	return 0;
+}
+
+static int kvm_vz_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+
+	regs->cp0reg[MIPS_CP0_TLB_INDEX][0] = kvm_read_c0_guest_index(cop0);
+	regs->cp0reg[MIPS_CP0_TLB_LO0][0] = kvm_read_c0_guest_entrylo0(cop0);
+	regs->cp0reg[MIPS_CP0_TLB_LO1][0] = kvm_read_c0_guest_entrylo1(cop0);
+	regs->cp0reg[MIPS_CP0_TLB_CONTEXT][0] = kvm_read_c0_guest_context(cop0);
+	regs->cp0reg[MIPS_CP0_TLB_PG_MASK][0] =
+		kvm_read_c0_guest_pagemask(cop0);
+	regs->cp0reg[MIPS_CP0_TLB_PG_MASK][1] =
+		kvm_read_c0_guest_pagegrain(cop0);
+	regs->cp0reg[MIPS_CP0_TLB_WIRED][0] = kvm_read_c0_guest_wired(cop0);
+	regs->cp0reg[MIPS_CP0_HWRENA][0] = kvm_read_c0_guest_hwrena(cop0);
+	regs->cp0reg[MIPS_CP0_BAD_VADDR][0] = kvm_read_c0_guest_badvaddr(cop0);
+	regs->cp0reg[MIPS_CP0_COUNT][0] = kvm_read_c0_guest_count(cop0);
+	regs->cp0reg[MIPS_CP0_TLB_HI][0] = kvm_read_c0_guest_entryhi(cop0);
+	regs->cp0reg[MIPS_CP0_COMPARE][0] = kvm_read_c0_guest_compare(cop0);
+	regs->cp0reg[MIPS_CP0_STATUS][0] = kvm_read_c0_guest_status(cop0);
+	regs->cp0reg[MIPS_CP0_STATUS][1] = kvm_read_c0_guest_intctl(cop0);
+	regs->cp0reg[MIPS_CP0_CAUSE][0] = kvm_read_c0_guest_cause(cop0);
+	regs->cp0reg[MIPS_CP0_EXC_PC][0] = kvm_read_c0_guest_epc(cop0);
+	regs->cp0reg[MIPS_CP0_PRID][0] = kvm_read_c0_guest_prid(cop0);
+	regs->cp0reg[MIPS_CP0_PRID][1] = kvm_read_c0_guest_ebase(cop0);
+
+	/* only save implemented config registers */
+	regs->cp0reg[MIPS_CP0_CONFIG][0] = kvm_read_c0_guest_config(cop0);
+	regs->cp0reg[MIPS_CP0_CONFIG][1] =
+		(regs->cp0reg[MIPS_CP0_CONFIG][0] & MIPS_CONF_M) &
+		cpu_vz_has_config1 ?  kvm_read_c0_guest_config1(cop0) : 0;
+	regs->cp0reg[MIPS_CP0_CONFIG][2] =
+		(regs->cp0reg[MIPS_CP0_CONFIG][1] & MIPS_CONF_M) &
+		cpu_vz_has_config2 ?  kvm_read_c0_guest_config2(cop0) : 0;
+	regs->cp0reg[MIPS_CP0_CONFIG][3] =
+		(regs->cp0reg[MIPS_CP0_CONFIG][2] & MIPS_CONF_M) &
+		cpu_vz_has_config3 ?  kvm_read_c0_guest_config3(cop0) : 0;
+	regs->cp0reg[MIPS_CP0_CONFIG][4] =
+		(regs->cp0reg[MIPS_CP0_CONFIG][3] & MIPS_CONF_M) &
+		cpu_vz_has_config4 ?  kvm_read_c0_guest_config4(cop0) : 0;
+	regs->cp0reg[MIPS_CP0_CONFIG][5] =
+		(regs->cp0reg[MIPS_CP0_CONFIG][4] & MIPS_CONF_M) &
+		cpu_vz_has_config5 ?  kvm_read_c0_guest_config5(cop0) : 0;
+	regs->cp0reg[MIPS_CP0_CONFIG][6] =
+		cpu_vz_has_config6 ?  kvm_read_c0_guest_config6(cop0) : 0;
+	regs->cp0reg[MIPS_CP0_CONFIG][7] =
+		cpu_vz_has_config7 ?  kvm_read_c0_guest_config7(cop0) : 0;
+
+	regs->cp0reg[MIPS_CP0_ERROR_PC][0] = kvm_read_c0_guest_errorepc(cop0);
+
+	/* save root context gtoffset (in unused Guest gtoffset register) */
+	regs->cp0reg[MIPS_CP0_STATUS][7] = read_c0_gtoffset();
+
+	return 0;
+}
+
+static int kvm_vz_vm_init(struct kvm *kvm)
+{
+
+	/* Enable virtualization features granting guest control of privileged
+	 * features */
+	write_c0_guestctl0(GUESTCTL0_CP0 | GUESTCTL0_AT3 |
+			   /* GUESTCTL0_GT | *//* Guest timer is emulated */
+			   GUESTCTL0_CG | GUESTCTL0_CF);
+
+	return 0;
+}
+
+static int kvm_vz_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		vcpu->arch.vzguestid[i] = 0;
+
+	return 0;
+}
+
+static int kvm_vz_vcpu_setup(struct kvm_vcpu *vcpu)
+{
+	/* Initialize guest register structure; it will get overwritten with
+	 * the arch specific setup from QEMU but in the meantime
+	 * vcpu_load/vcpu_put should not write zeros.
+	 */
+	kvm_vz_ioctl_get_regs(vcpu, &vcpu->arch.guest_regs);
+
+	return 0;
+}
+
+static struct kvm_mips_callbacks kvm_vz_callbacks = {
+
+	.handle_cop_unusable = kvm_trap_vz_no_handler,
+	.handle_tlb_mod = kvm_trap_vz_no_handler,
+	.handle_tlb_ld_miss = kvm_trap_vz_handle_tlb_ld_miss,
+	.handle_tlb_st_miss = kvm_trap_vz_handle_tlb_st_miss,
+	.handle_addr_err_st = kvm_trap_vz_no_handler,
+	.handle_addr_err_ld = kvm_trap_vz_no_handler,
+	.handle_syscall = kvm_trap_vz_no_handler,
+	.handle_res_inst = kvm_trap_vz_no_handler,
+	.handle_break = kvm_trap_vz_no_handler,
+	.handle_guest_exit = kvm_trap_vz_handle_guest_exit,
+
+	.vm_init = kvm_vz_vm_init,
+	.vcpu_init = kvm_vz_vcpu_init,
+	.vcpu_setup = kvm_vz_vcpu_setup,
+	.gva_to_gpa = kvm_vz_gva_to_gpa_cb,
+	.queue_timer_int = kvm_vz_queue_timer_int_cb,
+	.dequeue_timer_int = kvm_vz_dequeue_timer_int_cb,
+	.queue_io_int = kvm_vz_queue_io_int_cb,
+	.dequeue_io_int = kvm_vz_dequeue_io_int_cb,
+	.irq_deliver = kvm_vz_irq_deliver_cb,
+	.irq_clear = kvm_vz_irq_clear_cb,
+	.vcpu_ioctl_get_regs = kvm_vz_ioctl_get_regs,
+	.vcpu_ioctl_set_regs = kvm_vz_ioctl_set_regs,
+};
+
+int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks)
+{
+	if (!cpu_has_vz) {
+		pr_info("Ignoring CONFIG_KVM_MIPS_VZ; no hardware support\n");
+		return -ENOSYS;
+	}
+
+	pr_info("Starting KVM with MIPS VZ extension\n");
+
+	*install_callbacks = &kvm_vz_callbacks;
+	return 0;
+}
-- 
1.7.11.3
