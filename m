Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 13:04:31 +0200 (CEST)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34223 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835247Ab3FGXECA-Fdl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:04:02 +0200
Received: by mail-ie0-f178.google.com with SMTP id at1so7878767iec.23
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FoagTgGzJwzTds64f54JvYbsdrBJO4XDU6Wm9AiVF9o=;
        b=T9k7Xq3ZduOf1bzXaQMAPc7mFNzWosaBONaSHsjlpJsyFW5MuUs2uC91LSfFwGsR3K
         uVVcgOQTETqjN4IGYWAUya3IGqnjCKA2CstbGABtbvsWa3Yj8AnmYMfi6ha2jqbcBrX5
         hb2MFlSk/O4LUfvGwOdNO726s2lu8iBIAf80xxEqGlM3DInDQac3HBEgZXvH1uSWHgDD
         Qd/MkFiDI915i7OmH6XgkqJd7Mtw9djZw8CBQKenJVjBBH8lb8PMC9ZH59W89RGZrO/A
         sTog0aZ1jlRSKH5ksyRoLAx3SztRivxvCafYFPZgo3lmvFNh+2Wt7d+AMjVliSYDXyxU
         9q7w==
X-Received: by 10.50.67.10 with SMTP id j10mr405793igt.70.1370646235535;
        Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id k10sm1232531ige.0.2013.06.07.16.03.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3qaE006727;
        Fri, 7 Jun 2013 16:03:52 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3qUa006726;
        Fri, 7 Jun 2013 16:03:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 29/31] mips/kvm: Add MIPSVZ support.
Date:   Fri,  7 Jun 2013 16:03:33 -0700
Message-Id: <1370646215-6543-30-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36795
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

This doen't share much from the trap-and-emulate implementation.

Included is a virtual interrupt controller and I/O emulation.
Currently these have hard coded addresses at:

  0x1e000000 - 64K of I/O space.
  0x1e010000 - virtual interrupt controller.

Future work will allow these windows to be positioned via ioctl.

The MIPSVZ specification has some optional and implementation defined
parts.  This implementation uses the OCTEON III behavior.  For use
with other implementations, we would have to split out the
implementation specific parts.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kvm/kvm_mips.c         |   31 +-
 arch/mips/kvm/kvm_mipsvz.c       | 1894 ++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_mipsvz_guest.S |  234 +++++
 3 files changed, 2156 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/kvm/kvm_mipsvz.c
 create mode 100644 arch/mips/kvm/kvm_mipsvz_guest.S

diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 18c8dc8..e908b3b 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -21,6 +21,7 @@
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/kvm_mips_te.h>
+#include <asm/kvm_mips_vz.h>
 
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 struct kvm_stats_debugfs_item debugfs_entries[] = {
@@ -62,7 +63,11 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 
 int kvm_arch_hardware_enable(void *garbage)
 {
+#if IS_ENABLED(CONFIG_KVM_MIPSVZ)
+	return mipsvz_arch_hardware_enable(garbage);
+#else
 	return 0;
+#endif
 }
 
 void kvm_arch_hardware_disable(void *garbage)
@@ -89,8 +94,15 @@ int kvm_mips_te_init_vm(struct kvm *kvm, unsigned long type);
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
+#if IS_ENABLED(CONFIG_KVM_MIPSTE)
 	if (type == 0)
 		return kvm_mips_te_init_vm(kvm, type);
+#endif
+#if IS_ENABLED(CONFIG_KVM_MIPSVZ)
+	if (type == 1)
+		return mipsvz_init_vm(kvm, type);
+#endif
+
 	return -EINVAL;
 }
 
@@ -411,27 +423,38 @@ out:
 
 long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
+	struct kvm *kvm = filp->private_data;
 	long r;
 
 	switch (ioctl) {
 	default:
-		r = -ENOIOCTLCMD;
+		r = kvm->arch.ops->vm_ioctl(kvm, ioctl, arg);
 	}
 
 	return r;
 }
 
-int kvm_mips_te_arch_init(void *opaque);
 void kvm_mips_te_arch_exit(void);
 
 int kvm_arch_init(void *opaque)
 {
-	return kvm_mips_te_arch_init(opaque);
+	int r = 0;
+#if IS_ENABLED(CONFIG_KVM_MIPSTE)
+	r = kvm_mips_te_arch_init(opaque);
+	if (r)
+		return r;
+#endif
+#if IS_ENABLED(CONFIG_KVM_MIPSVZ)
+	r = mipsvz_arch_init(opaque);
+#endif
+	return r;
 }
 
 void kvm_arch_exit(void)
 {
+#if IS_ENABLED(CONFIG_KVM_MIPSTE)
 	kvm_mips_te_arch_exit();
+#endif
 }
 
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
@@ -508,9 +531,11 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_ONE_REG:
 		r = 1;
 		break;
+#ifndef CONFIG_KVM_MIPSVZ
 	case KVM_CAP_COALESCED_MMIO:
 		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
 		break;
+#endif
 	default:
 		r = 0;
 		break;
diff --git a/arch/mips/kvm/kvm_mipsvz.c b/arch/mips/kvm/kvm_mipsvz.c
new file mode 100644
index 0000000..2f408e0
--- /dev/null
+++ b/arch/mips/kvm/kvm_mipsvz.c
@@ -0,0 +1,1894 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012-2013 Cavium, Inc.
+ */
+/* #define DEBUG 1 */
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+#include <linux/perf_event.h>
+
+#include <asm/mipsregs.h>
+#include <asm/setup.h>
+#include <asm/mmu_context.h>
+#include <asm/kvm_mips_vz.h>
+#include <asm/pgalloc.h>
+#include <asm/branch.h>
+#include <asm/inst.h>
+#include <asm/time.h>
+#include <asm/fpu.h>
+
+asmlinkage void handle_hypervisor(void);
+void mipsvz_start_guest(struct kvm_vcpu *vcpu);
+void mipsvz_exit_guest(void) __noreturn;
+
+void mipsvz_install_fpu(struct kvm_vcpu *vcpu);
+void mipsvz_readout_fpu(struct kvm_vcpu *vcpu);
+
+unsigned long mips_kvm_rootsp[NR_CPUS];
+static u32 mipsvz_cp0_count_offset[NR_CPUS];
+
+static unsigned long mipsvz_entryhi_mask;
+
+struct vcpu_mips {
+	void *foo;
+};
+
+struct mipsvz_kvm_tlb_entry {
+	u64 entryhi;
+	u64 entrylo0;
+	u64 entrylo1;
+	u32 pagemask;
+};
+
+struct kvm_mips_vcpu_vz {
+	struct kvm_vcpu *vcpu;
+	u64 c0_entrylo0;
+	u64 c0_entrylo1;
+	u64 c0_context;
+	u64 c0_userlocal;
+	u64 c0_badvaddr;
+	u64 c0_entryhi;
+	u64 c0_ebase;
+	u64 c0_xcontext;
+	u64 c0_kscratch[6];
+	u32 c0_pagemask;
+	u32 c0_pagegrain;
+	u32 c0_wired;
+	u32 c0_hwrena;
+	u32 c0_compare;
+	u32 c0_status;
+	u32 c0_cause;
+	u32 c0_index;
+
+	u32 c0_count; /* Not settable, value at last exit. */
+	u32 c0_count_offset;
+
+	int tlb_size;
+	struct mipsvz_kvm_tlb_entry *tlb_state;
+
+	u32 last_exit_insn;
+	/* Saved  mips_kvm_rootsp[] value when we are off the CPU. */
+	unsigned long rootsp;
+
+	/* Protected by kvm_arch.irq_chip_lock, the value of Guestctl2[VIP] */
+	u8 injected_ipx;
+
+	struct hrtimer compare_timer;
+	ktime_t compare_timer_read;
+
+	bool have_counter_state;
+};
+
+static bool mipsvz_count_expired(u32 old_count, u32 new_count, u32 compare)
+{
+	if (new_count > old_count)
+		return compare >= old_count && compare <= new_count;
+	else
+		return compare >= old_count || compare <= new_count;
+}
+
+static void mipsvz_install_guest_cp0(struct kvm_mips_vcpu_vz *vcpu_vz)
+{
+	u32 gconfig4 = read_gc0_config4();
+	u32 count;
+
+	write_gc0_index(vcpu_vz->c0_index);
+	write_gc0_entrylo0(vcpu_vz->c0_entrylo0);
+	write_gc0_entrylo1(vcpu_vz->c0_entrylo1);
+	write_gc0_context(vcpu_vz->c0_context);
+	write_gc0_userlocal(vcpu_vz->c0_userlocal);
+	write_gc0_pagemask(vcpu_vz->c0_pagemask);
+	write_gc0_pagegrain(vcpu_vz->c0_pagegrain);
+	write_gc0_wired(vcpu_vz->c0_wired);
+	write_gc0_hwrena(vcpu_vz->c0_hwrena);
+	write_gc0_badvaddr(vcpu_vz->c0_badvaddr);
+	write_gc0_entryhi(vcpu_vz->c0_entryhi);
+	write_gc0_compare(vcpu_vz->c0_compare);
+	write_gc0_cause(vcpu_vz->c0_cause);
+	write_gc0_status(vcpu_vz->c0_status);
+	write_gc0_ebase(vcpu_vz->c0_ebase);
+	write_gc0_xcontext(vcpu_vz->c0_xcontext);
+
+	count = read_gc0_count();
+
+	if (mipsvz_count_expired(vcpu_vz->c0_count, count, vcpu_vz->c0_compare) &&
+	    (vcpu_vz->c0_cause & CAUSEF_TI) == 0) {
+		vcpu_vz->c0_cause |= CAUSEF_TI;
+		write_gc0_cause(vcpu_vz->c0_cause);
+	}
+	vcpu_vz->have_counter_state = false;
+
+#define MIPSVZ_GUEST_INSTALL_SCRATCH(_i)				\
+	if (gconfig4 & (1 << (18 + (_i))))				\
+		write_gc0_kscratch(2 + (_i), vcpu_vz->c0_kscratch[_i])
+
+	MIPSVZ_GUEST_INSTALL_SCRATCH(0);
+	MIPSVZ_GUEST_INSTALL_SCRATCH(1);
+	MIPSVZ_GUEST_INSTALL_SCRATCH(2);
+	MIPSVZ_GUEST_INSTALL_SCRATCH(3);
+	MIPSVZ_GUEST_INSTALL_SCRATCH(4);
+	MIPSVZ_GUEST_INSTALL_SCRATCH(5);
+}
+
+static void mipsvz_readout_cp0_counter_state(struct kvm_mips_vcpu_vz *vcpu_vz)
+{
+	/* Must read count before cause so we can emulate TI getting set. */
+	vcpu_vz->compare_timer_read = ktime_get();
+	vcpu_vz->c0_count = read_gc0_count();
+	vcpu_vz->c0_cause = read_gc0_cause();
+	vcpu_vz->c0_compare = read_gc0_compare();
+	vcpu_vz->have_counter_state = true;
+}
+
+static void mipsvz_readout_guest_cp0(struct kvm_mips_vcpu_vz *vcpu_vz)
+{
+	u32 gconfig4 = read_gc0_config4();
+
+	vcpu_vz->c0_index = read_gc0_index();
+	vcpu_vz->c0_entrylo0 = read_gc0_entrylo0();
+	vcpu_vz->c0_entrylo1 = read_gc0_entrylo1();
+	vcpu_vz->c0_context = read_gc0_context();
+	vcpu_vz->c0_userlocal = read_gc0_userlocal();
+	vcpu_vz->c0_pagemask = read_gc0_pagemask();
+	vcpu_vz->c0_pagegrain = read_gc0_pagegrain();
+	vcpu_vz->c0_wired = read_gc0_wired();
+	vcpu_vz->c0_hwrena = read_gc0_hwrena();
+	vcpu_vz->c0_badvaddr = read_gc0_badvaddr();
+	vcpu_vz->c0_entryhi = read_gc0_entryhi();
+	vcpu_vz->c0_compare = read_gc0_compare();
+	vcpu_vz->c0_status = read_gc0_status();
+
+	/* Must read count before cause so we can emulate TI getting set. */
+	vcpu_vz->c0_count = read_gc0_count();
+
+	vcpu_vz->c0_cause = read_gc0_cause();
+	vcpu_vz->c0_ebase = read_gc0_ebase();
+	vcpu_vz->c0_xcontext = read_gc0_xcontext();
+	if (!vcpu_vz->have_counter_state)
+		mipsvz_readout_cp0_counter_state(vcpu_vz);
+
+
+#define MIPSVZ_GUEST_READOUT_SCRATCH(_i)				\
+	if (gconfig4 & (1 << (18 + (_i))))				\
+		vcpu_vz->c0_kscratch[_i] = read_gc0_kscratch(2 + (_i))
+
+	MIPSVZ_GUEST_READOUT_SCRATCH(0);
+	MIPSVZ_GUEST_READOUT_SCRATCH(1);
+	MIPSVZ_GUEST_READOUT_SCRATCH(2);
+	MIPSVZ_GUEST_READOUT_SCRATCH(3);
+	MIPSVZ_GUEST_READOUT_SCRATCH(4);
+	MIPSVZ_GUEST_READOUT_SCRATCH(5);
+}
+
+static void mipsvz_exit_vm(struct pt_regs *regs, u32 exit_reason)
+{
+	int i;
+	struct kvm_vcpu *vcpu = current->thread.vcpu;
+	struct kvm_run *kvm_run = vcpu->run;
+
+	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
+		vcpu->arch.gprs[i] = regs->regs[i];
+	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
+	vcpu->arch.hi = regs->hi;
+	vcpu->arch.lo = regs->lo;
+	vcpu->arch.epc = regs->cp0_epc;
+
+	kvm_run->exit_reason = exit_reason;
+
+	local_irq_disable();
+
+	clear_tsk_thread_flag(current, TIF_GUESTMODE);
+	mipsvz_exit_guest();
+	/* Never returns here */
+}
+
+static unsigned int  mipsvz_get_fcr31(void)
+{
+	kvm_err("Help!  missing mipsvz_get_fcr31\n");
+	return 0;
+}
+
+static unsigned long mipsvz_compute_return_epc(struct pt_regs *regs)
+{
+	if (delay_slot(regs)) {
+		union mips_instruction insn;
+		insn.word = regs->cp0_badinstrp;
+		return __compute_return_epc_for_insn0(regs, insn, mipsvz_get_fcr31);
+	} else {
+		regs->cp0_epc += 4;
+		return 0;
+	}
+}
+
+struct mipsvz_szreg {
+	u8 size;
+	s8 reg; /* negative value indicates error */
+	bool sign_extend;
+};
+
+static struct mipsvz_szreg mipsvz_get_load_params(u32 insn)
+{
+	struct mipsvz_szreg r;
+	r.size = 0;
+	r.reg = -1;
+	r.sign_extend = false;
+
+	if ((insn & 0x80000000) == 0)
+		goto out;
+
+	switch ((insn >> 26) & 0x1f) {
+	case 0x00: /* LB */
+		r.size = 1;
+		r.sign_extend = true;
+		break;
+	case 0x04: /* LBU */
+		r.size = 1;
+		break;
+	case 0x01: /* LH */
+		r.size = 2;
+		r.sign_extend = true;
+		break;
+	case 0x05: /* LHU */
+		r.size = 2;
+		break;
+	case 0x03: /* LW */
+		r.size = 4;
+		r.sign_extend = true;
+		break;
+	case 0x07: /* LWU */
+		r.size = 4;
+		break;
+	case 0x17: /* LD */
+		r.size = 8;
+		break;
+	default:
+		goto out;
+	}
+	r.reg = (insn >> 16) & 0x1f;
+
+out:
+	return r;
+}
+
+static struct mipsvz_szreg mipsvz_get_store_params(u32 insn)
+{
+	struct mipsvz_szreg r;
+	r.size = 0;
+	r.reg = -1;
+	r.sign_extend = false;
+
+	if ((insn & 0x80000000) == 0)
+		goto out;
+
+	switch ((insn >> 26) & 0x1f) {
+	case 0x08: /* SB */
+		r.size = 1;
+		break;
+	case 0x09: /* SH */
+		r.size = 2;
+		break;
+	case 0x0b: /* SW */
+		r.size = 4;
+		break;
+	case 0x1f: /* SD */
+		r.size = 8;
+		break;
+	default:
+		goto out;
+	}
+	r.reg = (insn >> 16) & 0x1f;
+
+out:
+	return r;
+}
+
+static int mipsvz_handle_io_in(struct kvm_vcpu *vcpu)
+{
+	unsigned long val = 0;
+	struct kvm_mips_vcpu_vz *vcpu_vz = vcpu->arch.impl;
+	void *dest = sizeof(struct kvm_run) + (char *)((void *)vcpu->run);
+	struct mipsvz_szreg r = mipsvz_get_load_params(vcpu_vz->last_exit_insn);
+
+	if (r.reg < 0)
+		return -EINVAL;
+	if (r.sign_extend)
+		switch (r.size) {
+		case 1:
+			val = *(s8 *)dest;
+			break;
+		case 2:
+			val = *(s16 *)dest;
+			break;
+		case 4:
+			val = *(s32 *)dest;
+			break;
+		case 8:
+			val = *(u64 *)dest;
+			break;
+		}
+	else
+		switch (r.size) {
+		case 1:
+			val = *(u8 *)dest;
+			break;
+		case 2:
+			val = *(u16 *)dest;
+			break;
+		case 4:
+			val = *(u32 *)dest;
+			break;
+		case 8:
+			val = *(u64 *)dest;
+			break;
+		}
+
+	vcpu->arch.gprs[r.reg] = val;
+	kvm_debug("   ... %016lx  size %d\n", val, r.size);
+	return 0;
+}
+
+int mipsvz_arch_init(void *opaque)
+{
+	unsigned long saved_entryhi;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	saved_entryhi = read_c0_entryhi();
+
+	write_c0_entryhi(~0x1ffful);
+	mipsvz_entryhi_mask = read_c0_entryhi();
+
+	write_c0_entryhi(saved_entryhi);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+int mipsvz_arch_hardware_enable(void *garbage)
+{
+	unsigned long flags;
+	int cpu = raw_smp_processor_id();
+	u32 count;
+	u64 cmv_count;
+
+	local_irq_save(flags);
+	count = read_c0_count();
+	cmv_count = read_c0_cvmcount();
+	local_irq_restore(flags);
+
+	mipsvz_cp0_count_offset[cpu] = ((u32)cmv_count) - count;
+
+	return 0;
+}
+
+#ifndef __PAGETABLE_PMD_FOLDED
+static void mipsvz_release_pud(pud_t pud)
+{
+	pmd_t *pmd = (pmd_t *)pud_val(pud);
+	int i;
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (pmd_present(pmd[i]))
+			pte_free_kernel(NULL, (pte_t *)pmd_val(pmd[i]));
+	}
+	pmd_free(NULL, pmd);
+}
+#endif
+
+static void mipsvz_destroy_vm(struct kvm *kvm)
+{
+	struct kvm_mips_vz *kvm_mips_vz = kvm->arch.impl;
+	pgd_t *pgd;
+	pud_t *pud;
+	int i;
+
+	pgd = kvm_mips_vz->pgd;
+	pud = pud_offset(pgd, 0);
+#ifndef __PAGETABLE_PMD_FOLDED
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		if (pud_present(pud[i]))
+			mipsvz_release_pud((pud[i]));
+	}
+#else
+	{
+		pmd_t *pmd = pmd_offset(pud, 0);
+		for (i = 0; i < PTRS_PER_PGD; i++) {
+			if (pmd_present(pmd[i]))
+				pte_free_kernel(NULL, (pte_t *)pmd_val(pmd[i]));
+		}
+	}
+#endif
+
+	free_pages((unsigned long)kvm_mips_vz->pgd, PGD_ORDER);
+	if (kvm_mips_vz->irq_chip)
+		__free_page(kvm_mips_vz->irq_chip);
+}
+
+/* Must be called with guest_mm_lock held. */
+static pte_t *mipsvz_pte_for_gpa(struct kvm *kvm, unsigned long addr)
+{
+	struct kvm_mips_vz *kvm_mips_vz = kvm->arch.impl;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = kvm_mips_vz->pgd + pgd_index(addr);
+	if (pgd_none(*pgd)) {
+		set_pgd(pgd, __pgd(0));
+		BUG();  /* Not used on MIPS. */
+	}
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud)) {
+		pmd_t *new_pmd = pmd_alloc_one(NULL, addr);
+		WARN(!new_pmd, "We're hosed, no memory");
+		pud_populate(NULL, pud, new_pmd);
+	}
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd)) {
+		pte_t *new_pte = pte_alloc_one_kernel(NULL, addr);
+		WARN(!new_pte, "We're hosed, no memory");
+		pmd_populate_kernel(NULL, pmd, new_pte);
+	}
+	return pte_offset(pmd, addr);
+}
+
+struct mipsvz_irqchip {
+	u32 num_irqs;
+	u32 num_cpus;
+};
+
+static int mipsvz_create_irqchip(struct kvm *kvm)
+{
+	struct kvm_mips_vz *kvm_mips_vz = kvm->arch.impl;
+	int ret = 0;
+	pfn_t pfn;
+	pte_t *ptep, entry;
+	struct page *irq_chip;
+	struct mipsvz_irqchip *chip;
+
+	mutex_lock(&kvm->lock);
+
+	if (kvm_mips_vz->irq_chip) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	irq_chip = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!irq_chip) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	chip = page_address(irq_chip);
+	chip->num_irqs = 64;
+	chip->num_cpus = max(8, KVM_MAX_VCPUS);
+
+	ptep = mipsvz_pte_for_gpa(kvm, 0x1e010000);
+
+	pfn = page_to_pfn(irq_chip);
+	entry = pfn_pte(pfn, __pgprot(_PAGE_VALID));
+	set_pte(ptep, entry);
+
+	kvm_mips_vz->irq_chip = irq_chip;
+out:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
+static void mipsvz_write_irqchip_w1x(u32 *irqchip_regs, int words_per_reg,
+				     unsigned int base, unsigned int offset,
+				     u32 val, u32 mask)
+{
+	int type = (offset - base) / words_per_reg;
+	int idx = (offset - base) % words_per_reg;
+
+	if (type == 0)  /* Set */
+		irqchip_regs[base + idx] = (irqchip_regs[base + idx] & ~mask) | (val & mask);
+	else if (type == 1) /* W1S*/
+		irqchip_regs[base + idx] |= (val & mask);
+	else if (type == 2) /* W1C*/
+		irqchip_regs[base + idx] &= ~(val & mask);
+
+	/* Make the W1S and W1C reg have the same value as the base reg. */
+	irqchip_regs[base + idx + 1 * words_per_reg] = irqchip_regs[base + idx];
+	irqchip_regs[base + idx + 2 * words_per_reg] = irqchip_regs[base + idx];
+}
+
+static void mipsvz_write_irqchip_reg(u32 *irqchip_regs, unsigned int offset, u32 val, u32 mask)
+{
+	int numbits = irqchip_regs[0];
+	int words_per_reg = numbits / 32;
+	int reg, reg_offset;
+	int rw_reg_base = 2;
+
+	if (offset <= 1 || offset >= (irqchip_regs[1] * (words_per_reg + 1) * 4))
+		return; /* ignore the write */
+
+	reg = (offset - rw_reg_base) / words_per_reg;
+	reg_offset = (offset - rw_reg_base) % words_per_reg;
+
+	if (reg_offset == 0)
+		mask &= ~0x1ffu; /* bits 8..0 are ignored */
+
+	if (reg <= 2) { /* Raw */
+		mipsvz_write_irqchip_w1x(irqchip_regs, words_per_reg, rw_reg_base, offset, val, mask);
+	} else {
+		/* Per CPU enables */
+		int cpu_first_reg = rw_reg_base + 3 * words_per_reg;
+		int cpu = (reg - 3) / 4;
+		int cpu_reg = (reg - 3) % 4;
+
+		if (cpu_reg != 0)
+			mipsvz_write_irqchip_w1x(irqchip_regs, words_per_reg,
+						 cpu_first_reg + words_per_reg + cpu * 4 * words_per_reg,
+						 offset, val, mask);
+	}
+}
+
+/* Returns a bit mask of vcpus where the */
+static u32 mipsvz_write_irqchip_new_irqs(struct kvm *kvm, u32 *irqchip_regs)
+{
+	u32 r = 0;
+	int rw_reg_base = 2;
+	int numbits = irqchip_regs[0];
+	int numcpus = irqchip_regs[1];
+	int words_per_reg = numbits / 32;
+	int cpu;
+
+	for (cpu = 0; cpu < numcpus; cpu++) {
+		int cpu_base = rw_reg_base + (3 * words_per_reg) + (cpu * 4 * words_per_reg);
+		int word;
+		u32 combined = 0;
+		for (word = 0; word < words_per_reg; word++) {
+			/* SRC = EN & RAW */
+			irqchip_regs[cpu_base + word] = irqchip_regs[cpu_base + words_per_reg + word] & irqchip_regs[rw_reg_base + word];
+			combined |= irqchip_regs[cpu_base + word];
+		}
+
+		if (kvm->vcpus[cpu]) {
+			u8 injected_ipx;
+			struct kvm_mips_vcpu_vz *vcpu_vz = kvm->vcpus[cpu]->arch.impl;
+			u8 old_injected_ipx = vcpu_vz->injected_ipx;
+
+			if (combined)
+				injected_ipx = 4;
+			else
+				injected_ipx = 0;
+
+			if (injected_ipx != old_injected_ipx) {
+				r |= 1 << cpu;
+				vcpu_vz->injected_ipx = injected_ipx;
+			}
+		}
+	}
+	return r;
+}
+
+static void mipsvz_assert_irqs(struct kvm *kvm, u32 effected_cpus)
+{
+	int i, me;
+	struct kvm_vcpu *vcpu;
+
+	if (!effected_cpus)
+		return;
+
+	me = get_cpu();
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!((1 << vcpu->vcpu_id) & effected_cpus))
+			continue;
+
+		if (me == vcpu->cpu) {
+			u32 gc2 = read_c0_guestctl2();
+			struct kvm_mips_vcpu_vz *vcpu_vz = vcpu->arch.impl;
+			gc2 = (gc2 & ~0xff00) | (((u32)vcpu_vz->injected_ipx) << 8);
+			write_c0_guestctl2(gc2);
+		} else {
+			kvm_make_request(KVM_REQ_EVENT, vcpu);
+			kvm_vcpu_kick(vcpu);
+		}
+	}
+
+	put_cpu();
+}
+
+static bool mipsvz_write_irqchip(struct pt_regs *regs,
+				 unsigned long write,
+				 unsigned long address,
+				 struct kvm *kvm,
+				 struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vz *kvm_mips_vz = kvm->arch.impl;
+	unsigned long flags;
+	struct mipsvz_szreg szreg;
+	u64 val;
+	u64 mask;
+	u32 *irqchip_regs;
+	u32 insn = regs->cp0_badinstr;
+	int offset = address - 0x1e010000;
+	u32 effected_cpus;
+
+	if (!write || !kvm_mips_vz->irq_chip) {
+		kvm_err("Error: Read fault in irqchip\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+	if (mipsvz_compute_return_epc(regs)) {
+		kvm_err("Error: Bad EPC on store emulation: %08x\n", insn);
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+	szreg = mipsvz_get_store_params(insn);
+	val = regs->regs[szreg.reg];
+	mask = ~0ul >> (64 - (szreg.size * 8));
+	val &= mask;
+	val <<= 8 * (offset & 7);
+	mask <<= 8 * (offset & 7);
+
+	irqchip_regs = page_address(kvm_mips_vz->irq_chip);
+
+	mutex_lock(&kvm->lock);
+
+	spin_lock_irqsave(&kvm_mips_vz->irq_chip_lock, flags);
+
+	if (szreg.size == 8) {
+		offset &= ~7;
+		mipsvz_write_irqchip_reg(irqchip_regs, offset / 4 + 1,
+					 (u32)(val >> 32), (u32)(mask >> 32));
+		mipsvz_write_irqchip_reg(irqchip_regs, offset / 4 ,
+					 (u32)val, (u32)mask);
+	} else {
+		if (offset & 4) {
+			val >>= 32;
+			mask >>= 32;
+		}
+		offset &= ~3;
+		mipsvz_write_irqchip_reg(irqchip_regs, offset / 4 ,
+					 (u32)val, (u32)mask);
+	}
+
+	effected_cpus = mipsvz_write_irqchip_new_irqs(kvm, irqchip_regs);
+
+	spin_unlock_irqrestore(&kvm_mips_vz->irq_chip_lock, flags);
+
+	mipsvz_assert_irqs(kvm, effected_cpus);
+
+	mutex_unlock(&kvm->lock);
+
+	return true;
+}
+
+static int mipsvz_irq_line(struct kvm *kvm, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct kvm_mips_vz *kvm_mips_vz = kvm->arch.impl;
+	unsigned long flags;
+	struct kvm_irq_level irq_level;
+	u32 *irqchip_regs;
+	u32 mask, val;
+	int numbits;
+	int i;
+	u32 effected_cpus;
+	int ret = 0;
+
+	if (!kvm_mips_vz->irq_chip)
+		return -ENODEV;
+
+	if (copy_from_user(&irq_level, argp, sizeof(irq_level))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	irqchip_regs = page_address(kvm_mips_vz->irq_chip);
+	numbits = irqchip_regs[0];
+
+	if (irq_level.irq < 9)
+		goto out; /* Ignore */
+	if (irq_level.irq >= numbits) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&kvm->lock);
+
+	mask = 1ull << (irq_level.irq % 32);
+	i = irq_level.irq / 32;
+	if (irq_level.level)
+		val = mask;
+	else
+		val = 0;
+
+	spin_lock_irqsave(&kvm_mips_vz->irq_chip_lock, flags);
+
+	mipsvz_write_irqchip_reg(irqchip_regs, 2 + i, val, mask);
+	effected_cpus = mipsvz_write_irqchip_new_irqs(kvm, irqchip_regs);
+
+	spin_unlock_irqrestore(&kvm_mips_vz->irq_chip_lock, flags);
+
+	mipsvz_assert_irqs(kvm, effected_cpus);
+
+	mutex_unlock(&kvm->lock);
+
+out:
+	return ret;
+}
+
+static enum hrtimer_restart mipsvz_compare_timer_expire(struct hrtimer *t)
+{
+	struct kvm_mips_vcpu_vz *vcpu_vz;
+	vcpu_vz = container_of(t, struct kvm_mips_vcpu_vz, compare_timer);
+	kvm_vcpu_kick(vcpu_vz->vcpu);
+
+	return HRTIMER_NORESTART;
+}
+
+static long mipsvz_vm_ioctl(struct kvm *kvm, unsigned int ioctl,
+			    unsigned long arg)
+{
+	int r = -ENOIOCTLCMD;
+
+	switch (ioctl) {
+	case KVM_CREATE_IRQCHIP:
+		r = mipsvz_create_irqchip(kvm);
+		break;
+	case KVM_IRQ_LINE:
+		r = mipsvz_irq_line(kvm, arg);
+		break;
+	default:
+		break;
+	}
+	return r;
+}
+
+static struct kvm_vcpu *mipsvz_vcpu_create(struct kvm *kvm,
+					   unsigned int id)
+{
+	int r;
+	struct kvm_vcpu *vcpu = NULL;
+	struct kvm_mips_vcpu_vz *vcpu_vz = NULL;
+	struct mipsvz_kvm_tlb_entry *tlb_state = NULL;
+
+	/* MIPS CPU numbers have a maximum of 10 significant bits. */
+	if (id >= (1u << 10) || id >= KVM_MAX_VCPUS)
+		return ERR_PTR(-EINVAL);
+
+	vcpu_vz = kzalloc(sizeof(struct kvm_mips_vcpu_vz), GFP_KERNEL);
+	if (!vcpu_vz) {
+		r = -ENOMEM;
+		goto err;
+	}
+
+	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
+	if (!vcpu) {
+		r = -ENOMEM;
+		goto err;
+	}
+	vcpu->arch.impl = vcpu_vz;
+	vcpu_vz->vcpu = vcpu;
+
+	vcpu_vz->tlb_size = 128;
+	tlb_state = kzalloc(sizeof(struct mipsvz_kvm_tlb_entry) * vcpu_vz->tlb_size,
+			    GFP_KERNEL);
+	if (!tlb_state) {
+		r = -ENOMEM;
+		goto err;
+	}
+
+	vcpu_vz->tlb_state = tlb_state;
+
+	hrtimer_init(&vcpu_vz->compare_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	vcpu_vz->compare_timer.function = mipsvz_compare_timer_expire;
+
+	r = kvm_vcpu_init(vcpu, kvm, id);
+	if (r)
+		goto err;
+
+	return vcpu;
+err:
+	kfree(vcpu);
+	kfree(tlb_state);
+	return ERR_PTR(r);
+}
+
+static int mipsvz_vcpu_setup(struct kvm_vcpu *vcpu)
+{
+	int i;
+	unsigned long entryhi_base;
+	struct kvm_mips_vcpu_vz *vcpu_vz = vcpu->arch.impl;
+
+	entryhi_base = 0xffffffff90000000ul & mipsvz_entryhi_mask;
+
+	vcpu_vz->c0_ebase = 0xffffffff80000000ull | vcpu->vcpu_id;
+	vcpu_vz->c0_status = ST0_BEV | ST0_ERL;
+
+	for (i = 0; i < vcpu_vz->tlb_size; i++) {
+		vcpu_vz->tlb_state[i].entryhi = entryhi_base + 8192 * i;
+		vcpu_vz->tlb_state[i].entrylo0 = 0;
+		vcpu_vz->tlb_state[i].entrylo1 = 0;
+		vcpu_vz->tlb_state[i].pagemask = 0;
+	}
+	return 0;
+}
+
+static void mipsvz_vcpu_free(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_vz *vcpu_vz = vcpu->arch.impl;
+	hrtimer_cancel(&vcpu_vz->compare_timer);
+	kfree(vcpu_vz->tlb_state);
+	kfree(vcpu_vz);
+	/* ?? kfree(vcpu); */
+}
+
+static void mipsvz_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_vz *vcpu_vz = vcpu->arch.impl;
+	unsigned long flags;
+	int i;
+	u64 memctl2, vmconfig;
+	unsigned long old_ctx;
+	int mmu_sizem1;
+
+	mipsvz_readout_guest_cp0(vcpu_vz);
+
+	local_irq_save(flags);
+
+	for (i = 0; i < vcpu_vz->tlb_size; i++) {
+		write_gc0_index(i);
+		guest_tlb_read();
+		vcpu_vz->tlb_state[i].entryhi = read_gc0_entryhi();
+		vcpu_vz->tlb_state[i].entrylo0 = read_gc0_entrylo0();
+		vcpu_vz->tlb_state[i].entrylo1 = read_gc0_entrylo1();
+		vcpu_vz->tlb_state[i].pagemask = read_gc0_pagemask();
+	}
+
+	memctl2 = __read_64bit_c0_register($16, 6); /* 16,6: CvmMemCtl2 */
+	memctl2 |= (1ull << 17); /* INHIBITTS */
+	__write_64bit_c0_register($16, 6, memctl2);
+
+	vmconfig = __read_64bit_c0_register($16, 7); /* 16,7: CvmVMConfig */
+	vmconfig &= ~0xffull;
+
+	mmu_sizem1 = (vmconfig >> 12) & 0xff;
+	vmconfig |= mmu_sizem1;		/* Root size TLBM1 */
+	__write_64bit_c0_register($16, 7, vmconfig);
+
+/* Copied from tlb-r4k.c */
+#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+	old_ctx = read_c0_entryhi();
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+	for (i = 0; i < vcpu_vz->tlb_size; i++) {
+		write_c0_index(mmu_sizem1 - i);
+		write_c0_entryhi(UNIQUE_ENTRYHI(mmu_sizem1 - i));
+		mtc0_tlbw_hazard();
+		tlb_write_indexed();
+	}
+	tlbw_use_hazard();
+	write_c0_entryhi(old_ctx);
+
+	memctl2 &= ~(1ull << 17); /* INHIBITTS */
+	__write_64bit_c0_register($16, 6, memctl2);
+
+	local_irq_restore(flags);
+
+	vcpu_vz->rootsp = mips_kvm_rootsp[vcpu->cpu];
+	mips_kvm_rootsp[vcpu->cpu] = 0;
+	vcpu->cpu = -1;
+}
+
+static void mipsvz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct kvm_mips_vcpu_vz *vcpu_vz = vcpu->arch.impl;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_mips_vz *kvm_mips_vz = kvm->arch.impl;
+	unsigned long flags;
+	int i;
+	u32 t32;
+	u64 cp_val, t64;
+	int mmu_size;
+
+	vcpu->cpu = cpu;
+	if (test_tsk_thread_flag(current, TIF_GUESTMODE))
+		mips_kvm_rootsp[vcpu->cpu] = vcpu_vz->rootsp;
+
+	write_c0_gtoffset(mipsvz_cp0_count_offset[cpu] + vcpu_vz->c0_count_offset);
+
+	local_irq_save(flags);
+
+	t32 = read_c0_guestctl0();
+	/* GM = RI = MC = SFC2 = PIP = 0; CP0 = GT = CG = CF = SFC1 = 1*/
+	t32 |= 0xf380fc03;
+	t32 ^= 0xe000fc02;
+
+	write_c0_guestctl0(t32);
+
+	t32 = read_gc0_config1();
+	t32 &= ~(1u << 3); /* Guest.Config1[WR] = 0 */
+	write_gc0_config1(t32);
+
+	t64 = __read_64bit_gc0_register($9, 7); /* 9, 7: Guest.CvmCtl */
+	t64 &= ~(7ull << 4); /* IPTI */
+	t64 |= (7ull << 4);
+	t64 &= ~(7ull << 7); /* IPPCI */
+	t64 |= (6ull << 7);
+	__write_64bit_gc0_register($9, 7, t64);
+
+	cp_val = __read_64bit_c0_register($16, 7); /* 16, 7: CvmVMConfig */
+	cp_val |= (1ull << 60); /* No I/O hole translation. */
+	cp_val &= ~0xffull;
+
+	mmu_size = ((cp_val >> 12) & 0xff) + 1;
+	cp_val |= mmu_size - vcpu_vz->tlb_size - 1;	/* Root size TLBM1 */
+	__write_64bit_c0_register($16, 7, cp_val);
+
+	cp_val = __read_64bit_c0_register($16, 6); /* 16, 6: CvmMemCtl2 */
+	cp_val |= (1ull << 17); /* INHIBITTS */
+	__write_64bit_c0_register($16, 6, cp_val);
+
+	for (i = 0; i < vcpu_vz->tlb_size; i++) {
+		write_gc0_index(i);
+		write_gc0_entryhi(vcpu_vz->tlb_state[i].entryhi);
+		write_gc0_entrylo0(vcpu_vz->tlb_state[i].entrylo0);
+		write_gc0_entrylo1(vcpu_vz->tlb_state[i].entrylo1);
+		write_gc0_pagemask(vcpu_vz->tlb_state[i].pagemask);
+		guest_tlb_write_indexed();
+	}
+
+	cp_val &= ~(1ull << 17); /* INHIBITTS */
+	__write_64bit_c0_register($16, 6, cp_val);
+
+
+	spin_lock(&kvm_mips_vz->irq_chip_lock);
+	if (kvm_mips_vz->irq_chip) {
+		u32 gc2 = read_c0_guestctl2();
+		gc2 = (gc2 & ~0xff00) | (((u32)vcpu_vz->injected_ipx) << 8);
+		write_c0_guestctl2(gc2);
+	}
+	spin_unlock(&kvm_mips_vz->irq_chip_lock);
+
+	local_irq_restore(flags);
+
+	mipsvz_install_guest_cp0(vcpu_vz);
+	vcpu_vz->have_counter_state = false;
+	/* OCTEON need a local iCache flush on switching guests. */
+	local_flush_icache_range(0, 0);
+}
+
+static bool mipsvz_emulate_io(struct pt_regs *regs,
+			      unsigned long write,
+			      unsigned long address,
+			      struct kvm *kvm,
+			      struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_vz *vcpu_vz = vcpu->arch.impl;
+	u32 insn = regs->cp0_badinstr;
+
+	if (mipsvz_compute_return_epc(regs)) {
+		kvm_err("Error: Bad EPC on store emulation: %08x\n", insn);
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+	vcpu->run->io.port = address - 0x1e000000;
+	vcpu->run->io.count = 1;
+	/* Store the data after the end of the kvm_run */
+	vcpu->run->io.data_offset = sizeof(struct kvm_run);
+	if (write) {
+		u64 val;
+		void *dest = sizeof(struct kvm_run) + (char *)((void *)vcpu->run);
+		struct mipsvz_szreg r = mipsvz_get_store_params(insn);
+		if (r.reg < 0) {
+			kvm_err("Error: Bad insn on store emulation: %08x\n", insn);
+			mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+		}
+		vcpu->run->io.size = r.size;
+		vcpu->run->io.direction = KVM_EXIT_IO_OUT;
+		val = regs->regs[r.reg];
+		switch (r.size) {
+		case 1:
+			*(u8 *)dest = (u8)val;
+			kvm_debug("I/O out %02x -> %04x\n", (unsigned)(u8)val,
+				  vcpu->run->io.port);
+			break;
+		case 2:
+			*(u16 *)dest = (u16)val;
+			kvm_debug("I/O out %04x -> %04x\n", (unsigned)(u16)val,
+				  vcpu->run->io.port);
+			break;
+		case 4:
+			*(u32 *)dest = (u32)val;
+			kvm_debug("I/O out %08x -> %04x\n", (unsigned)(u32)val,
+				  vcpu->run->io.port);
+			break;
+		default:
+			*(u64 *)dest = val;
+			kvm_debug("I/O out %016lx -> %04x\n", (unsigned long)val,
+				  vcpu->run->io.port);
+			break;
+		}
+	} else {
+		struct mipsvz_szreg r = mipsvz_get_load_params(insn);
+		if (r.reg < 0) {
+			kvm_err("Error: Bad insn on load emulation: %08x\n", insn);
+			mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+		}
+		vcpu_vz->last_exit_insn = insn;
+		vcpu->run->io.size = r.size;
+		vcpu->run->io.direction = KVM_EXIT_IO_IN;
+		kvm_debug("I/O in %04x ...\n", vcpu->run->io.port);
+	}
+	mipsvz_exit_vm(regs, KVM_EXIT_IO);
+	/* Never Gets Here. */
+	return true;
+}
+
+/* Return true if its a mipsvz guest fault. */
+bool mipsvz_page_fault(struct pt_regs *regs, unsigned long write,
+		       unsigned long address)
+{
+	unsigned long flags;
+	pte_t *ptep, entry;
+	u64 saved_entryhi;
+	pfn_t pfn;
+	s32 idx;
+	int srcu_idx;
+	unsigned long prot_bits;
+	struct kvm_vcpu *vcpu;
+	struct kvm *kvm;
+	struct kvm_mips_vz *kvm_mips_vz;
+	bool writable;
+
+	/*
+	 * Guest Physical Addresses can only be in the XKUSEG range
+	 * (which ends at XKSSEG).  Other addresses belong to the kernel.
+	 */
+	if (address >= XKSSEG)
+		return false;
+
+	vcpu = current->thread.vcpu;
+	kvm = vcpu->kvm;
+	kvm_mips_vz = kvm->arch.impl;
+
+	if (address >= 0x10000000) {
+		if (address < 0x1e000000) {
+			/* mmio */
+			mipsvz_exit_vm(regs, KVM_EXIT_EXCEPTION);
+			/* Never Gets Here. */
+		} else if (address < 0x1e010000) {
+			return mipsvz_emulate_io(regs, write, address,
+						 kvm, vcpu);
+		} else if (address < 0x1e020000) {
+			return mipsvz_write_irqchip(regs, write, address,
+						    kvm, vcpu);
+		} else {
+			mipsvz_exit_vm(regs, KVM_EXIT_EXCEPTION);
+			/* Never Gets Here. */
+		}
+	}
+
+	writable = false;
+
+	mutex_lock(&kvm_mips_vz->guest_mm_lock);
+
+	srcu_idx = srcu_read_lock(&kvm->srcu);
+
+	pfn = gfn_to_pfn_prot(kvm, address >> PAGE_SHIFT, write, &writable);
+
+#if 0
+	kvm_err("mipsvz_page_fault[%d] for %s: %lx -> page %x %s\n",
+		vcpu->vcpu_id, write ? "write" : "read",
+		address, (unsigned)pfn, writable ? "writable" : "read-only");
+#endif
+
+	if (!pfn) {
+		kvm_err("mipsvz_page_fault -- no mapping, must exit\n");
+		goto bad;
+	}
+
+	ptep = mipsvz_pte_for_gpa(kvm, address);
+
+	prot_bits = __READABLE | _PAGE_PRESENT;
+
+	/* If it is the same page, don't downgrade  _PAGE_DIRTY */
+	if (pte_pfn(*ptep) == pfn  && (pte_val(*ptep) &  _PAGE_DIRTY))
+		prot_bits |= __WRITEABLE;
+	if (write) {
+		if (!writable) {
+			kvm_err("mipsvz_page_fault writing to RO memory.");
+			goto bad;
+		} else {
+			prot_bits |= __WRITEABLE;
+			kvm_set_pfn_dirty(pfn);
+		}
+
+	} else {
+		kvm_set_pfn_accessed(pfn);
+	}
+	entry = pfn_pte(pfn, __pgprot(prot_bits));
+
+	set_pte(ptep, entry);
+
+	/* Directly set a valid TLB entry.  No more faults. */
+
+	local_irq_save(flags);
+	saved_entryhi = read_c0_entryhi();
+	address &= (PAGE_MASK << 1);
+	write_c0_entryhi(address | current->thread.guest_asid);
+	mtc0_tlbw_hazard();
+	tlb_probe();
+	tlb_probe_hazard();
+	idx = read_c0_index();
+
+	/* Goto a PTE pair boundry. */
+	ptep = (pte_t *)(((unsigned long)ptep) & ~(2 * sizeof(pte_t) - 1));
+	write_c0_entrylo0(pte_to_entrylo(pte_val(*ptep++)));
+	write_c0_entrylo1(pte_to_entrylo(pte_val(*ptep)));
+	mtc0_tlbw_hazard();
+	if (idx < 0)
+		tlb_write_random();
+	else
+		tlb_write_indexed();
+	tlbw_use_hazard();
+	write_c0_entryhi(saved_entryhi);
+	local_irq_restore(flags);
+
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	mutex_unlock(&kvm_mips_vz->guest_mm_lock);
+	return true;
+
+bad:
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	mutex_unlock(&kvm_mips_vz->guest_mm_lock);
+	mipsvz_exit_vm(regs, KVM_EXIT_EXCEPTION);
+	/* Never Gets Here. */
+	return true;
+}
+
+int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
+{
+	kvm_debug("kvm_unmap_hva for %lx\n", hva);
+	return 1;
+}
+
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+{
+	kvm_err("kvm_set_spte_hva %lx\n", hva);
+}
+
+int kvm_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	kvm_err("kvm_age_hva %lx\n", hva);
+	return 0;
+}
+
+int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	kvm_err("kvm_test_age_hva %lx\n", hva);
+	return 0;
+}
+
+bool  mipsvz_cp_unusable(struct pt_regs *regs)
+{
+	bool r = false;
+	unsigned int cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
+
+	preempt_disable();
+
+	if (cpid != 1 || !cpu_has_fpu)
+		goto out;
+
+	regs->cp0_status |= (ST0_CU1 | ST0_FR); /* Enable FPU in guest ... */
+	set_c0_status(ST0_CU1 | ST0_FR);  /* ... and now so we can install its contents. */
+	enable_fpu_hazard();
+	mipsvz_install_fpu(current->thread.vcpu);
+
+	r = true;
+out:
+	preempt_enable();
+	return r;
+}
+
+static void mipsvz_commit_memory_region(struct kvm *kvm,
+					struct kvm_userspace_memory_region *mem,
+					const struct kvm_memory_slot *old,
+					enum kvm_mr_change change)
+{
+}
+
+static int mipsvz_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+#define KVM_REG_MIPS_CP0_INDEX (0x10000 + 8 * 0 + 0)
+#define KVM_REG_MIPS_CP0_ENTRYLO0 (0x10000 + 8 * 2 + 0)
+#define KVM_REG_MIPS_CP0_ENTRYLO1 (0x10000 + 8 * 3 + 0)
+#define KVM_REG_MIPS_CP0_CONTEXT (0x10000 + 8 * 4 + 0)
+#define KVM_REG_MIPS_CP0_USERLOCAL (0x10000 + 8 * 4 + 2)
+#define KVM_REG_MIPS_CP0_PAGEMASK (0x10000 + 8 * 5 + 0)
+#define KVM_REG_MIPS_CP0_PAGEGRAIN (0x10000 + 8 * 5 + 1)
+#define KVM_REG_MIPS_CP0_WIRED (0x10000 + 8 * 6 + 0)
+#define KVM_REG_MIPS_CP0_HWRENA (0x10000 + 8 * 7 + 0)
+#define KVM_REG_MIPS_CP0_BADVADDR (0x10000 + 8 * 8 + 0)
+#define KVM_REG_MIPS_CP0_COUNT (0x10000 + 8 * 9 + 0)
+#define KVM_REG_MIPS_CP0_ENTRYHI (0x10000 + 8 * 10 + 0)
+#define KVM_REG_MIPS_CP0_COMPARE (0x10000 + 8 * 11 + 0)
+#define KVM_REG_MIPS_CP0_STATUS (0x10000 + 8 * 12 + 0)
+#define KVM_REG_MIPS_CP0_CAUSE (0x10000 + 8 * 13 + 0)
+#define KVM_REG_MIPS_CP0_EBASE (0x10000 + 8 * 15 + 1)
+#define KVM_REG_MIPS_CP0_CONFIG (0x10000 + 8 * 16 + 0)
+#define KVM_REG_MIPS_CP0_CONFIG1 (0x10000 + 8 * 16 + 1)
+#define KVM_REG_MIPS_CP0_CONFIG2 (0x10000 + 8 * 16 + 2)
+#define KVM_REG_MIPS_CP0_CONFIG3 (0x10000 + 8 * 16 + 3)
+#define KVM_REG_MIPS_CP0_CONFIG7 (0x10000 + 8 * 16 + 7)
+#define KVM_REG_MIPS_CP0_XCONTEXT (0x10000 + 8 * 20 + 0)
+#define KVM_REG_MIPS_CP0_ERROREPC (0x10000 + 8 * 30 + 0)
+
+static int mipsvz_get_reg(struct kvm_vcpu *vcpu,
+			  const struct kvm_one_reg *reg)
+{
+	u64 __user *uaddr = (u64 __user *)(long)reg->addr;
+	s64 v;
+
+	switch (reg->id) {
+	case KVM_REG_MIPS_CP0_INDEX:
+		v = read_gc0_index();
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYLO0:
+		v = read_gc0_entrylo0();
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYLO1:
+		v = read_gc0_entrylo1();
+		break;
+	case KVM_REG_MIPS_CP0_CONTEXT:
+		v = read_gc0_context();
+		break;
+	case KVM_REG_MIPS_CP0_USERLOCAL:
+		v = read_gc0_userlocal();
+		break;
+	case KVM_REG_MIPS_CP0_PAGEMASK:
+		v = read_gc0_pagemask();
+		break;
+	case KVM_REG_MIPS_CP0_PAGEGRAIN:
+		v = read_gc0_pagegrain();
+		break;
+	case KVM_REG_MIPS_CP0_WIRED:
+		v = read_gc0_wired();
+		break;
+	case KVM_REG_MIPS_CP0_HWRENA:
+		v = read_gc0_hwrena();
+		break;
+	case KVM_REG_MIPS_CP0_BADVADDR:
+		v = read_gc0_badvaddr();
+		break;
+	case KVM_REG_MIPS_CP0_COUNT:
+		v = read_gc0_count();
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYHI:
+		v = read_gc0_entryhi();
+		break;
+	case KVM_REG_MIPS_CP0_COMPARE:
+		v = read_gc0_compare();
+		break;
+	case KVM_REG_MIPS_CP0_STATUS:
+		v = read_gc0_status();
+		break;
+	case KVM_REG_MIPS_CP0_CAUSE:
+		v = read_gc0_cause();
+		break;
+	case KVM_REG_MIPS_CP0_EBASE:
+		v = read_gc0_ebase();
+		break;
+	case KVM_REG_MIPS_CP0_XCONTEXT:
+		v = read_gc0_xcontext();
+		break;
+	default:
+		return -EINVAL;
+	}
+	return put_user(v, uaddr);
+}
+
+static int mipsvz_set_reg(struct kvm_vcpu *vcpu,
+			  const struct kvm_one_reg *reg,
+			  u64 v)
+{
+	switch (reg->id) {
+	case KVM_REG_MIPS_CP0_INDEX:
+		write_gc0_index(v);
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYLO0:
+		write_gc0_entrylo0(v);
+		break;
+	case KVM_REG_MIPS_CP0_ENTRYLO1:
+		write_gc0_entrylo1(v);
+		break;
+	case KVM_REG_MIPS_CP0_CONTEXT:
+		write_gc0_context(v);
+		break;
+	case KVM_REG_MIPS_CP0_USERLOCAL:
+		write_gc0_userlocal(v);
+		break;
+	case KVM_REG_MIPS_CP0_PAGEMASK:
+		write_gc0_pagemask(v);
+		break;
+	case KVM_REG_MIPS_CP0_PAGEGRAIN:
+		write_gc0_pagegrain(v);
+		break;
+	case KVM_REG_MIPS_CP0_WIRED:
+		write_gc0_wired(v);
+		break;
+	case KVM_REG_MIPS_CP0_HWRENA:
+		write_gc0_hwrena(v);
+		break;
+	case KVM_REG_MIPS_CP0_BADVADDR:
+		write_gc0_badvaddr(v);
+		break;
+/*
+	case MSR_MIPS_CP0_COUNT:
+		????;
+		break;
+*/
+	case KVM_REG_MIPS_CP0_ENTRYHI:
+		write_gc0_entryhi(v);
+		break;
+	case KVM_REG_MIPS_CP0_COMPARE:
+		write_gc0_compare(v);
+		break;
+	case KVM_REG_MIPS_CP0_STATUS:
+		write_gc0_status(v);
+		break;
+	case KVM_REG_MIPS_CP0_CAUSE:
+		write_gc0_cause(v);
+		break;
+	case KVM_REG_MIPS_CP0_EBASE:
+		write_gc0_ebase(v);
+		break;
+	case KVM_REG_MIPS_CP0_XCONTEXT:
+		write_gc0_xcontext(v);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mipsvz_vcpu_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	int ret = 0;
+	int cpu;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_mips_vz *kvm_mips_vz = kvm->arch.impl;
+
+	if (kvm_run->exit_reason == KVM_EXIT_IO && kvm_run->io.direction == KVM_EXIT_IO_IN) {
+		ret = mipsvz_handle_io_in(vcpu);
+		if (unlikely(ret)) {
+			pr_warn("Error: Return from KVM_EXIT_IO with bad exit_insn state.\n");
+			return ret;
+		}
+	}
+
+	lose_fpu(1);
+
+	WARN(irqs_disabled(), "IRQs should be on here.");
+	local_irq_disable();
+	kvm_run->exit_reason = KVM_EXIT_UNKNOWN;
+	cpu = raw_smp_processor_id();
+
+	/*
+	 * Make sure the Root guest and host contexts are in the same
+	 * ASID generation
+	 */
+	if ((kvm_mips_vz->asid[cpu] ^ asid_cache(cpu)) & ASID_VERSION_MASK)
+		kvm_mips_vz->asid[cpu] = get_new_asid(cpu);
+	if ((cpu_context(cpu, current->mm) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
+		drop_mmu_context(current->mm, cpu);
+	if ((kvm_mips_vz->asid[cpu] ^ asid_cache(cpu)) & ASID_VERSION_MASK)
+		kvm_mips_vz->asid[cpu] = get_new_asid(cpu);
+
+	current->thread.mm_asid = read_c0_entryhi() & ASID_MASK;
+	current->thread.guest_asid = kvm_mips_vz->asid[cpu] & ASID_MASK;
+	current->thread.vcpu = vcpu;
+
+	write_c0_entryhi(current->thread.guest_asid);
+	TLBMISS_HANDLER_SETUP_PGD(kvm_mips_vz->pgd);
+
+	set_tsk_thread_flag(current, TIF_GUESTMODE);
+
+	mipsvz_start_guest(vcpu);
+
+	/* Save FPU if needed. */
+	if (read_c0_status() & ST0_CU1) {
+		set_c0_status(ST0_FR);
+		mipsvz_readout_fpu(vcpu);
+		disable_fpu();
+	}
+
+	local_irq_enable();
+
+	if (signal_pending(current) && kvm_run->exit_reason == KVM_EXIT_INTR)
+		ret = -EINTR;
+
+	return ret;
+}
+#if 0
+int kvm_dev_ioctl_check_extension(long ext)
+{
+	int r = 0;
+
+	switch (ext) {
+	case KVM_CAP_IRQCHIP:
+		r = 1;
+		break;
+	}
+
+	return r;
+}
+#endif
+static int mipsvz_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
+{
+	int me;
+	int ret = 0;
+
+	me = get_cpu();
+
+	if (vcpu->cpu == me) {
+		u32 cause = read_gc0_cause();
+		ret = (cause & CAUSEF_TI) != 0;
+	} else {
+		kvm_err("kvm_cpu_has_pending_timer:  Argh!!\n");
+	}
+
+	put_cpu();
+
+	kvm_debug("kvm_cpu_has_pending_timer: %d\n", ret);
+	return ret;
+}
+
+static int mipsvz_vcpu_runnable(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_vcpu_vz *vcpu_vz = vcpu->arch.impl;
+	unsigned long flags;
+	u64 *irqchip_regs;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_mips_vz *kvm_mips_vz = kvm->arch.impl;
+	u8 injected_ipx;
+
+	kvm_debug("kvm_arch_vcpu_runnable\n");
+
+	if (!kvm_mips_vz->irq_chip)
+		return 0;
+
+	irqchip_regs = page_address(kvm_mips_vz->irq_chip);
+
+	spin_lock_irqsave(&kvm_mips_vz->irq_chip_lock, flags);
+	injected_ipx = vcpu_vz->injected_ipx;
+	spin_unlock_irqrestore(&kvm_mips_vz->irq_chip_lock, flags);
+
+	return injected_ipx != 0;
+}
+
+static void mipsvz_hypercall_exit_vm(struct pt_regs *regs)
+{
+	mipsvz_exit_vm(regs, KVM_EXIT_SHUTDOWN);
+}
+
+static void mipsvz_hypercall_get_hpt_frequency(struct pt_regs *regs)
+{
+	regs->regs[2] = mips_hpt_frequency;
+}
+
+typedef void (*mipsvz_hypercall_handler_t)(struct pt_regs *);
+typedef void (*mipsvz_hypervisor_handler_t)(struct pt_regs *);
+
+static const  mipsvz_hypercall_handler_t mipsvz_hypercall_handlers[] = {
+	NULL,				/* Write to console. */
+	mipsvz_hypercall_exit_vm,	/* Exit VM */
+	mipsvz_hypercall_get_hpt_frequency, /* get the mips_hpt_frequency */
+};
+
+static void mipsvz_hypercall(struct pt_regs *regs)
+{
+	unsigned long call_number = regs->regs[2];
+
+	kvm_debug("kvm_mipsvz_hypercall: %lx\n", call_number);
+
+	if (mipsvz_compute_return_epc(regs)) {
+		kvm_err("Error: Bad EPC on hypercall\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+
+	if (call_number >= ARRAY_SIZE(mipsvz_hypercall_handlers) ||
+	    !mipsvz_hypercall_handlers[call_number]) {
+		struct kvm_vcpu *vcpu = current->thread.vcpu;
+		struct kvm_run *kvm_run = vcpu->run;
+		int i;
+
+		kvm_run->hypercall.nr = call_number;
+		for (i = 0; i < ARRAY_SIZE(kvm_run->hypercall.args); i++)
+			kvm_run->hypercall.args[i] = regs->regs[4 + i];
+		mipsvz_exit_vm(regs, KVM_EXIT_HYPERCALL);
+	} else {
+		mipsvz_hypercall_handlers[call_number](regs);
+	}
+}
+
+static void mipsvz_sfce(struct pt_regs *regs)
+{
+	bool is_64bit;
+	int rt, rd, sel;
+	u64 rt_val;
+	u32 t, m;
+	u32 insn = regs->cp0_badinstr;
+
+	if ((insn & 0xffc007f8) != 0x40800000) {
+		kvm_err("Error: SFCE not on DMTC0/MTC0.\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+	/* Move past the DMTC0/MTC0 insn */
+	if (mipsvz_compute_return_epc(regs)) {
+		kvm_err("Error: Bad EPC on SFCE\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+
+	is_64bit = insn & (1 << 21);
+	rt = (insn >> 16) & 0x1f;
+	rd = (insn >> 11) & 0x1f;
+	sel = insn & 7;
+
+	rt_val = rt ? regs->regs[rt] : 0;
+
+	switch ((rd << 3) | sel) {
+	case 0x60: /* Status */
+		write_gc0_status((u32)rt_val);
+		break;
+	case 0x61: /* IntCtl */
+		/* Ignore */
+		break;
+	case 0x68: /* Cause */
+		m = (1 << 27) | (1 << 23); /* DC and IV bits only */
+		t = read_gc0_cause();
+		t &= ~m;
+		t |= (m & (u32)rt_val);
+		write_gc0_cause(t);
+		break;
+	default:
+		kvm_err("Error: SFCE unknown target reg.\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+		break;
+	}
+}
+
+static void mipsvz_handle_cache(struct pt_regs *regs,
+				union mips_instruction insn)
+{
+	s64 ea;
+	s16 offset;
+
+	/* Move past the CACHE insn */
+	if (mipsvz_compute_return_epc(regs)) {
+		kvm_err("Error: Bad EPC on CACHE GPSI\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+
+	offset = insn.c_format.simmediate;
+
+	switch (insn.c_format.cache) {
+	case 0: /* Primary Instruction */
+		switch (insn.c_format.c_op) {
+		case 0: /* Index Invalidate */
+			ea = regs->regs[insn.c_format.rs] + offset;
+			asm volatile("cache	0x00,0(%0)" : : "d" (ea));
+			break;
+		case 4: /* ICache invalidate EA */
+			ea = regs->regs[insn.c_format.rs] + offset;
+			asm volatile("synci	0($0)");
+			break;
+		default:
+			goto cannot_handle;
+		}
+		break;
+	case 1: /* Primary Data */
+		switch (insn.c_format.c_op) {
+		case 0: /* writebadk/invalidate tag */
+#if 0
+			ea = regs->regs[insn.c_format.rs] + offset;
+			asm volatile("cache	0x01,0(%0)" : : "d" (ea));
+			break;
+#endif
+		case 5: /*  writebadk/invalidate EA */
+			/* OCTEON has coherent caches, but clear the write buffers. */
+			asm volatile("sync");
+			break;
+		default:
+			goto cannot_handle;
+		}
+		break;
+	case 2: /* Tertiary */
+	case 3: /* Secondary */
+	default:
+		goto cannot_handle;
+	}
+
+	return;
+cannot_handle:
+		kvm_err("Error: GPSI Illegal cache op %08x\n", insn.word);
+		mipsvz_exit_vm(regs, KVM_EXIT_EXCEPTION);
+}
+
+static void mipsvz_handle_wait(struct pt_regs *regs)
+{
+	struct kvm_mips_vcpu_vz *vcpu_vz;
+	struct kvm_vcpu *vcpu;
+
+	/* Move past the WAIT insn */
+	if (mipsvz_compute_return_epc(regs)) {
+		kvm_err("Error: Bad EPC on WAIT GPSI\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+
+	preempt_disable();
+	vcpu = current->thread.vcpu;
+	vcpu_vz = vcpu->arch.impl;
+	mipsvz_readout_cp0_counter_state(vcpu_vz);
+	if ((vcpu_vz->c0_cause & CAUSEF_TI) == 0) {
+		ktime_t exp;
+		u32 clk_to_exp = vcpu_vz->c0_compare - vcpu_vz->c0_count;
+		u64 ns_to_exp = (clk_to_exp * 1000000000ull) / mips_hpt_frequency;
+		/* Arm the timer */
+		exp = ktime_add_ns(vcpu_vz->compare_timer_read, ns_to_exp);
+		hrtimer_start(&vcpu_vz->compare_timer, exp, HRTIMER_MODE_ABS);
+	}
+	preempt_enable();
+
+	kvm_vcpu_block(current->thread.vcpu);
+
+	if (signal_pending(current))
+			mipsvz_exit_vm(regs, KVM_EXIT_INTR);
+}
+
+static void mipsvz_handle_gpsi_mtc0(struct pt_regs *regs,
+				    union mips_instruction insn)
+{
+	struct kvm_mips_vcpu_vz *vcpu_vz;
+	struct kvm_vcpu *vcpu;
+	u32 val;
+	u32 offset;
+
+	/* Move past the MTC0 insn */
+	if (mipsvz_compute_return_epc(regs)) {
+		kvm_err("Error: Bad EPC on MTC0 GPSI\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+
+	preempt_disable();
+	vcpu = current->thread.vcpu;
+	vcpu_vz = vcpu->arch.impl;
+	switch (insn.c0m_format.rd) {
+	case 9:
+		if (insn.c0m_format.sel != 0)
+			goto bad_reg;
+		/* Count */
+		val = regs->regs[insn.c0m_format.rt];
+		offset = val - read_gc0_count();
+		vcpu_vz->c0_count_offset += offset;
+		write_c0_gtoffset(mipsvz_cp0_count_offset[vcpu->cpu] + vcpu_vz->c0_count_offset);
+		break;
+	default:
+		goto bad_reg;
+	}
+
+	preempt_enable();
+	return;
+
+bad_reg:
+	kvm_err("Error: Bad Reg($%d,%d) on MTC0 GPSI\n",
+		insn.c0m_format.rd, insn.c0m_format.sel);
+	mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+
+}
+
+static void mipsvz_handle_gpsi_mfc0(struct pt_regs *regs,
+				    union mips_instruction insn)
+{
+	/* Move past the MFC0 insn */
+	if (mipsvz_compute_return_epc(regs)) {
+		kvm_err("Error: Bad EPC on MFC0 GPSI\n");
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+
+	switch (insn.c0m_format.rd) {
+	case 12:
+		if (insn.c0m_format.sel != 2)
+			goto bad_reg;
+		/* SRSCtl */
+		regs->regs[insn.c0m_format.rt] = 0;
+		break;
+	case 15:
+		if (insn.c0m_format.sel != 0)
+			goto bad_reg;
+		/* PRId */
+		regs->regs[insn.c0m_format.rt] = (s64)read_c0_prid();
+		break;
+	default:
+		goto bad_reg;
+	}
+	return;
+
+bad_reg:
+	kvm_err("Error: Bad Reg($%d,%d) on MTC0 GPSI\n",
+		insn.c0m_format.rd, insn.c0m_format.sel);
+	mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+
+}
+
+static void mipsvz_gpsi(struct pt_regs *regs)
+{
+	union mips_instruction insn;
+
+	insn.word = regs->cp0_badinstr;
+
+	if (insn.c_format.opcode == cache_op)
+		mipsvz_handle_cache(regs, insn);
+	else if (insn.c0_format.opcode == cop0_op &&
+		 insn.c0_format.co == 1 &&
+		 insn.c0_format.func == wait_op)
+		mipsvz_handle_wait(regs);
+	else if (insn.c0m_format.opcode == cop0_op &&
+		 insn.c0m_format.func == mtc_op &&
+		 insn.c0m_format.code == 0)
+		mipsvz_handle_gpsi_mtc0(regs, insn);
+	else if (insn.c0m_format.opcode == cop0_op &&
+		 insn.c0m_format.func == mfc_op &&
+		 insn.c0m_format.code == 0)
+		mipsvz_handle_gpsi_mfc0(regs, insn);
+	else {
+		kvm_err("Error: GPSI not on CACHE, WAIT, MFC0 or MTC0: %08x\n",
+			insn.word);
+		mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+	}
+}
+
+static void mipsvz_default_ex(struct pt_regs *regs)
+{
+	u32 guestctl0 = read_c0_guestctl0();
+	int gexc_code = (guestctl0 >> 2) & 0x1f;
+
+	kvm_err("Hypervisor Exception (%d): Not handled yet\n", gexc_code);
+	mipsvz_exit_vm(regs, KVM_EXIT_INTERNAL_ERROR);
+}
+
+#define mipsvz_gva mipsvz_default_ex
+#define mipsvz_gpa mipsvz_default_ex
+#define mipsvz_ghfc mipsvz_default_ex
+
+static const mipsvz_hypervisor_handler_t mipsvz_hypervisor_handlers[] = {
+	mipsvz_gpsi,		/* 0  - Guest Privileged Sensitive Instruction */
+	mipsvz_sfce,		/* 1  - Guest Software Field Change */
+	mipsvz_hypercall,	/* 2  - Hypercall */
+	mipsvz_default_ex,	/* 3  - Guest Reserved Instruction Redirect. */
+	mipsvz_default_ex,	/* 4  - Implementation defined */
+	mipsvz_default_ex,	/* 5  - Implementation defined */
+	mipsvz_default_ex,	/* 6  - Implementation defined */
+	mipsvz_default_ex,	/* 7  - Implementation defined */
+	mipsvz_gva,		/* 8  - Guest Mode Initiated Root TLB Execption: GVA */
+	mipsvz_ghfc,		/* 9  - Guest Hardware Field Change */
+	mipsvz_gpa,		/* 10 - Guest Mode Initiated Root TLB Execption: GPA */
+	mipsvz_default_ex,	/* 11 - Reserved */
+	mipsvz_default_ex,	/* 12 - Reserved */
+	mipsvz_default_ex,	/* 13 - Reserved */
+	mipsvz_default_ex,	/* 14 - Reserved */
+	mipsvz_default_ex,	/* 15 - Reserved */
+	mipsvz_default_ex,	/* 16 - Reserved */
+	mipsvz_default_ex,	/* 17 - Reserved */
+	mipsvz_default_ex,	/* 18 - Reserved */
+	mipsvz_default_ex,	/* 19 - Reserved */
+	mipsvz_default_ex,	/* 20 - Reserved */
+	mipsvz_default_ex,	/* 21 - Reserved */
+	mipsvz_default_ex,	/* 22 - Reserved */
+	mipsvz_default_ex,	/* 23 - Reserved */
+	mipsvz_default_ex,	/* 24 - Reserved */
+	mipsvz_default_ex,	/* 25 - Reserved */
+	mipsvz_default_ex,	/* 26 - Reserved */
+	mipsvz_default_ex,	/* 27 - Reserved */
+	mipsvz_default_ex,	/* 28 - Reserved */
+	mipsvz_default_ex,	/* 29 - Reserved */
+	mipsvz_default_ex,	/* 30 - Reserved */
+	mipsvz_default_ex,	/* 31 - Reserved */
+};
+/*
+ * Hypervisor Exception handler, called with interrupts disabled.
+ */
+asmlinkage void do_hypervisor(struct pt_regs *regs)
+{
+	int gexc_code;
+	u32 guestctl0 = read_c0_guestctl0();
+
+	/* Must read before any exceptions can happen. */
+	regs->cp0_badinstr = read_c0_badinstr();
+	regs->cp0_badinstrp = read_c0_badinstrp();
+
+	/* This could take a while, turn interrupts back on. */
+	local_irq_enable();
+
+	gexc_code = (guestctl0 >> 2) & 0x1f;
+
+	mipsvz_hypervisor_handlers[gexc_code](regs);
+}
+
+static long mipsvz_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned int ioctl,
+			      unsigned long arg)
+{
+	return -ENOIOCTLCMD;
+}
+
+static const struct kvm_mips_ops kvm_mips_vz_ops = {
+	.vcpu_runnable = mipsvz_vcpu_runnable,
+	.destroy_vm = mipsvz_destroy_vm,
+	.commit_memory_region = mipsvz_commit_memory_region,
+	.vcpu_create = mipsvz_vcpu_create,
+	.vcpu_free = mipsvz_vcpu_free,
+	.vcpu_run = mipsvz_vcpu_run,
+	.vm_ioctl = mipsvz_vm_ioctl,
+	.vcpu_ioctl = mipsvz_vcpu_ioctl,
+	.get_reg = mipsvz_get_reg,
+	.set_reg = mipsvz_set_reg,
+	.cpu_has_pending_timer = mipsvz_cpu_has_pending_timer,
+	.vcpu_init = mipsvz_vcpu_init,
+	.vcpu_setup = mipsvz_vcpu_setup,
+	.vcpu_load = mipsvz_vcpu_load,
+	.vcpu_put = mipsvz_vcpu_put,
+};
+
+int mipsvz_init_vm(struct kvm *kvm, unsigned long type)
+{
+	struct kvm_mips_vz *kvm_mips_vz;
+
+	if (!cpu_has_vz)
+		return -ENODEV;
+	if (type != 1)
+		return -EINVAL;
+
+	kvm->arch.ops = &kvm_mips_vz_ops;
+
+	kvm_mips_vz = kzalloc(sizeof(struct kvm_mips_vz), GFP_KERNEL);
+	if (!kvm_mips_vz)
+		goto err;
+
+	kvm->arch.impl = kvm_mips_vz;
+
+	mutex_init(&kvm_mips_vz->guest_mm_lock);
+
+	kvm_mips_vz->pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD_ORDER);
+	if (!kvm_mips_vz->pgd)
+		goto err;
+
+	pgd_init((unsigned long)kvm_mips_vz->pgd);
+
+	spin_lock_init(&kvm_mips_vz->irq_chip_lock);
+
+	set_except_vector(27, handle_hypervisor);
+
+	return 0;
+err:
+	kfree(kvm_mips_vz);
+	return -ENOMEM;
+}
diff --git a/arch/mips/kvm/kvm_mipsvz_guest.S b/arch/mips/kvm/kvm_mipsvz_guest.S
new file mode 100644
index 0000000..8e20dbc
--- /dev/null
+++ b/arch/mips/kvm/kvm_mipsvz_guest.S
@@ -0,0 +1,234 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+
+#include <asm/stackframe.h>
+
+#define START_GUEST_STACK_ADJUST (8 * 11)
+	.set noreorder
+	.p2align 5
+LEAF(mipsvz_start_guest)
+	daddiu	sp, sp, -START_GUEST_STACK_ADJUST
+	sd	$16, (0 * 8)(sp)
+	sd	$17, (1 * 8)(sp)
+	sd	$18, (2 * 8)(sp)
+	sd	$19, (3 * 8)(sp)
+	sd	$20, (4 * 8)(sp)
+	sd	$21, (5 * 8)(sp)
+	sd	$22, (6 * 8)(sp)
+	sd	$23, (7 * 8)(sp)
+	/*	$24, t8 */
+	/*	$25, t9 */
+	/*	$26, K0 */
+	/*	$27, K1 */
+	sd	$28, (8 * 8)(sp) /* gp/current */
+	/*	$29, sp */
+	sd	$30, (9 * 8)(sp)
+	sd	$31, (10 * 8)(sp)
+
+	/* Save sp in the CPU specific slot */
+	set_mips_kvm_rootsp sp, v0
+
+	/*
+	 * Move to EXL with interrupts enabled.  When we ERET to Guest
+	 * mode, we can again process interrupts.
+	 */
+	mfc0	v0, CP0_STATUS
+	ori	v0, ST0_EXL | ST0_IE
+	mtc0	v0, CP0_STATUS
+
+	dli	v0,1
+	/* Set GuestMode (GM) bit */
+	mfc0	v1, CP0_GUESTCTL0
+	ins	v1, v0, MIPS_GUESTCTL0B_GM, 1
+	mtc0	v1, CP0_GUESTCTL0
+
+	/* Set the high order bit of CPU_ID_REG to indicate guest mode. */
+	dmfc0	v1, CPU_ID_REG
+	dins	v1, v0, 63, 1
+	dmtc0	v1, CPU_ID_REG
+
+	/* Load Guest register state */
+	ld	v0, KVM_VCPU_ARCH_EPC(a0)
+	ld	v1, KVM_VCPU_ARCH_HI(a0)
+	ld	ta0, KVM_VCPU_ARCH_LO(a0)
+	dmtc0	v0, CP0_EPC
+	mthi	v1
+	mtlo	ta0
+
+	.set	push
+	.set	noat
+	ld	$1, KVM_VCPU_ARCH_R1(a0)
+	ld	$2, KVM_VCPU_ARCH_R2(a0)
+	ld	$3, KVM_VCPU_ARCH_R3(a0)
+	ld	$5, KVM_VCPU_ARCH_R5(a0)
+	ld	$6, KVM_VCPU_ARCH_R6(a0)
+	ld	$7, KVM_VCPU_ARCH_R7(a0)
+	ld	$8, KVM_VCPU_ARCH_R8(a0)
+	ld	$9, KVM_VCPU_ARCH_R9(a0)
+	ld	$10, KVM_VCPU_ARCH_R10(a0)
+	ld	$11, KVM_VCPU_ARCH_R11(a0)
+	ld	$12, KVM_VCPU_ARCH_R12(a0)
+	ld	$13, KVM_VCPU_ARCH_R13(a0)
+	ld	$14, KVM_VCPU_ARCH_R14(a0)
+	ld	$15, KVM_VCPU_ARCH_R15(a0)
+	ld	$16, KVM_VCPU_ARCH_R16(a0)
+	ld	$17, KVM_VCPU_ARCH_R17(a0)
+	ld	$18, KVM_VCPU_ARCH_R18(a0)
+	ld	$19, KVM_VCPU_ARCH_R19(a0)
+	ld	$20, KVM_VCPU_ARCH_R20(a0)
+	ld	$21, KVM_VCPU_ARCH_R21(a0)
+	ld	$22, KVM_VCPU_ARCH_R22(a0)
+	ld	$23, KVM_VCPU_ARCH_R23(a0)
+	ld	$24, KVM_VCPU_ARCH_R24(a0)
+	ld	$25, KVM_VCPU_ARCH_R25(a0)
+	ld	$26, KVM_VCPU_ARCH_R26(a0)
+	ld	$27, KVM_VCPU_ARCH_R27(a0)
+	ld	$28, KVM_VCPU_ARCH_R28(a0)
+	ld	$29, KVM_VCPU_ARCH_R29(a0)
+	ld	$30, KVM_VCPU_ARCH_R30(a0)
+	ld	$31, KVM_VCPU_ARCH_R31(a0)
+	ld	$4, KVM_VCPU_ARCH_R4(a0) /* $4 == a0, do it last. */
+	eret
+	.set	pop
+
+	.p2align 7
+.Lmipsvz_exit_guest:
+FEXPORT(mipsvz_exit_guest)
+
+	/* Clear sp in the CPU specific slot */
+	CPU_ID_MFC0	k0, CPU_ID_REG
+	get_mips_kvm_rootsp
+	move	sp, k1
+	set_mips_kvm_rootsp zero, v0
+
+	ld	$16, (0 * 8)(sp)
+	ld	$17, (1 * 8)(sp)
+	ld	$18, (2 * 8)(sp)
+	ld	$19, (3 * 8)(sp)
+	ld	$20, (4 * 8)(sp)
+	ld	$21, (5 * 8)(sp)
+	ld	$22, (6 * 8)(sp)
+	ld	$23, (7 * 8)(sp)
+	/*	$24, t8 */
+	/*	$25, t9 */
+	/*	$26, K0 */
+	/*	$27, K1 */
+	ld	$28, (8 * 8)(sp) /* gp/current */
+	/*	$29, sp */
+	ld	$30, (9 * 8)(sp)
+	ld	$31, (10 * 8)(sp)
+
+	jr	ra
+	 daddiu	sp, sp, START_GUEST_STACK_ADJUST
+	END(mipsvz_start_guest)
+
+	.p2align 5
+	.set mips64r2
+
+LEAF(mipsvz_install_fpu)
+	ldc1	$f0, (KVM_VCPU_ARCH_FPR + (0 * 8))(a0)
+	ldc1	$f1, (KVM_VCPU_ARCH_FPR + (1 * 8))(a0)
+	ldc1	$f2, (KVM_VCPU_ARCH_FPR + (2 * 8))(a0)
+	ldc1	$f3, (KVM_VCPU_ARCH_FPR + (3 * 8))(a0)
+	ldc1	$f4, (KVM_VCPU_ARCH_FPR + (4 * 8))(a0)
+	ldc1	$f5, (KVM_VCPU_ARCH_FPR + (5 * 8))(a0)
+	ldc1	$f6, (KVM_VCPU_ARCH_FPR + (6 * 8))(a0)
+	ldc1	$f7, (KVM_VCPU_ARCH_FPR + (7 * 8))(a0)
+	ldc1	$f8, (KVM_VCPU_ARCH_FPR + (8 * 8))(a0)
+	ldc1	$f9, (KVM_VCPU_ARCH_FPR + (9 * 8))(a0)
+	ldc1	$f10, (KVM_VCPU_ARCH_FPR + (10 * 8))(a0)
+	ldc1	$f11, (KVM_VCPU_ARCH_FPR + (11 * 8))(a0)
+	ldc1	$f12, (KVM_VCPU_ARCH_FPR + (12 * 8))(a0)
+	ldc1	$f13, (KVM_VCPU_ARCH_FPR + (13 * 8))(a0)
+	ldc1	$f14, (KVM_VCPU_ARCH_FPR + (14 * 8))(a0)
+	ldc1	$f15, (KVM_VCPU_ARCH_FPR + (15 * 8))(a0)
+	ldc1	$f16, (KVM_VCPU_ARCH_FPR + (16 * 8))(a0)
+	ldc1	$f17, (KVM_VCPU_ARCH_FPR + (17 * 8))(a0)
+	ldc1	$f18, (KVM_VCPU_ARCH_FPR + (18 * 8))(a0)
+	ldc1	$f19, (KVM_VCPU_ARCH_FPR + (19 * 8))(a0)
+	ldc1	$f20, (KVM_VCPU_ARCH_FPR + (20 * 8))(a0)
+	ldc1	$f21, (KVM_VCPU_ARCH_FPR + (21 * 8))(a0)
+	ldc1	$f22, (KVM_VCPU_ARCH_FPR + (22 * 8))(a0)
+	ldc1	$f23, (KVM_VCPU_ARCH_FPR + (23 * 8))(a0)
+	ldc1	$f24, (KVM_VCPU_ARCH_FPR + (24 * 8))(a0)
+	ldc1	$f25, (KVM_VCPU_ARCH_FPR + (25 * 8))(a0)
+	ldc1	$f26, (KVM_VCPU_ARCH_FPR + (26 * 8))(a0)
+	ldc1	$f27, (KVM_VCPU_ARCH_FPR + (27 * 8))(a0)
+	ldc1	$f28, (KVM_VCPU_ARCH_FPR + (28 * 8))(a0)
+	ldc1	$f29, (KVM_VCPU_ARCH_FPR + (29 * 8))(a0)
+	ldc1	$f30, (KVM_VCPU_ARCH_FPR + (30 * 8))(a0)
+	ldc1	$f31, (KVM_VCPU_ARCH_FPR + (31 * 8))(a0)
+
+	lw	t0, KVM_VCPU_ARCH_FCSR(a0)
+	ctc1	t0, $31
+
+	lw	t0, KVM_VCPU_ARCH_FENR(a0)
+	ctc1	t0, $28
+
+	lw	t0, KVM_VCPU_ARCH_FEXR(a0)
+	ctc1	t0, $26
+
+	lw	t0, KVM_VCPU_ARCH_FCCR(a0)
+
+	jr	ra
+	 ctc1	t0, $25
+
+	END(mipsvz_install_fpu)
+
+LEAF(mipsvz_readout_fpu)
+	sdc1	$f0, (KVM_VCPU_ARCH_FPR + (0 * 8))(a0)
+	sdc1	$f1, (KVM_VCPU_ARCH_FPR + (1 * 8))(a0)
+	sdc1	$f2, (KVM_VCPU_ARCH_FPR + (2 * 8))(a0)
+	sdc1	$f3, (KVM_VCPU_ARCH_FPR + (3 * 8))(a0)
+	sdc1	$f4, (KVM_VCPU_ARCH_FPR + (4 * 8))(a0)
+	sdc1	$f5, (KVM_VCPU_ARCH_FPR + (5 * 8))(a0)
+	sdc1	$f6, (KVM_VCPU_ARCH_FPR + (6 * 8))(a0)
+	sdc1	$f7, (KVM_VCPU_ARCH_FPR + (7 * 8))(a0)
+	sdc1	$f8, (KVM_VCPU_ARCH_FPR + (8 * 8))(a0)
+	sdc1	$f9, (KVM_VCPU_ARCH_FPR + (9 * 8))(a0)
+	sdc1	$f10, (KVM_VCPU_ARCH_FPR + (10 * 8))(a0)
+	sdc1	$f11, (KVM_VCPU_ARCH_FPR + (11 * 8))(a0)
+	sdc1	$f12, (KVM_VCPU_ARCH_FPR + (12 * 8))(a0)
+	sdc1	$f13, (KVM_VCPU_ARCH_FPR + (13 * 8))(a0)
+	sdc1	$f14, (KVM_VCPU_ARCH_FPR + (14 * 8))(a0)
+	sdc1	$f15, (KVM_VCPU_ARCH_FPR + (15 * 8))(a0)
+	sdc1	$f16, (KVM_VCPU_ARCH_FPR + (16 * 8))(a0)
+	sdc1	$f17, (KVM_VCPU_ARCH_FPR + (17 * 8))(a0)
+	sdc1	$f18, (KVM_VCPU_ARCH_FPR + (18 * 8))(a0)
+	sdc1	$f19, (KVM_VCPU_ARCH_FPR + (19 * 8))(a0)
+	sdc1	$f20, (KVM_VCPU_ARCH_FPR + (20 * 8))(a0)
+	sdc1	$f21, (KVM_VCPU_ARCH_FPR + (21 * 8))(a0)
+	sdc1	$f22, (KVM_VCPU_ARCH_FPR + (22 * 8))(a0)
+	sdc1	$f23, (KVM_VCPU_ARCH_FPR + (23 * 8))(a0)
+	sdc1	$f24, (KVM_VCPU_ARCH_FPR + (24 * 8))(a0)
+	sdc1	$f25, (KVM_VCPU_ARCH_FPR + (25 * 8))(a0)
+	sdc1	$f26, (KVM_VCPU_ARCH_FPR + (26 * 8))(a0)
+	sdc1	$f27, (KVM_VCPU_ARCH_FPR + (27 * 8))(a0)
+	sdc1	$f28, (KVM_VCPU_ARCH_FPR + (28 * 8))(a0)
+	sdc1	$f29, (KVM_VCPU_ARCH_FPR + (29 * 8))(a0)
+	sdc1	$f30, (KVM_VCPU_ARCH_FPR + (30 * 8))(a0)
+	sdc1	$f31, (KVM_VCPU_ARCH_FPR + (31 * 8))(a0)
+
+	cfc1	t0, $31
+	sw	t0, KVM_VCPU_ARCH_FCSR(a0)
+
+	cfc1	t0, $28
+	sw	t0, KVM_VCPU_ARCH_FENR(a0)
+
+	cfc1	t0, $26
+	sw	t0, KVM_VCPU_ARCH_FEXR(a0)
+
+	cfc1	t0, $25
+	sw	t0, KVM_VCPU_ARCH_FCCR(a0)
+
+	cfc1	t0, $0
+
+	jr	ra
+	 sw	t0, KVM_VCPU_ARCH_FIR(a0)
+
+	END(mipsvz_readout_fpu)
-- 
1.7.11.7
