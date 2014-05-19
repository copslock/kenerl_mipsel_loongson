Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 18:56:37 +0200 (CEST)
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:32149
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854802AbaESQzB66TrT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 May 2014 18:55:01 +0200
Received: from alberich.caveonetworks.com (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Mon, 19 May 2014 16:54:59 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 06/12] kvm tools, mips: Add MIPS support
Date:   Mon, 19 May 2014 18:53:25 +0200
Message-ID: <1400518411-9759-7-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM2PR06CA006.eurprd06.prod.outlook.com (10.255.61.23) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 021670B4D2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(81542001)(33646001)(92566001)(46102001)(21056001)(81156002)(87976001)(87286001)(4396001)(53416003)(62966002)(99396002)(50986999)(36756003)(77156001)(76482001)(93916002)(92726001)(88136002)(86362001)(81342001)(42186004)(79102001)(50466002)(20776003)(69596002)(47776003)(102836001)(31966008)(80022001)(74502001)(83322001)(77982001)(19580405001)(76176999)(19580395003)(50226001)(85852003)(83072002)(66066001)(64706001)(48376002)(89996001)(101416001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

So far this was tested with host running KVM using MIPS-VZ (on Cavium
Octeon3). A paravirtualized mips kernel was used for the guest.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/mips/include/kvm/barrier.h         |   20 +++
 tools/kvm/mips/include/kvm/kvm-arch.h        |   33 ++++
 tools/kvm/mips/include/kvm/kvm-config-arch.h |    7 +
 tools/kvm/mips/include/kvm/kvm-cpu-arch.h    |   42 +++++
 tools/kvm/mips/irq.c                         |   10 ++
 tools/kvm/mips/kvm-cpu.c                     |  218 ++++++++++++++++++++++++++
 tools/kvm/mips/kvm.c                         |  128 +++++++++++++++
 7 files changed, 458 insertions(+)
 create mode 100644 tools/kvm/mips/include/kvm/barrier.h
 create mode 100644 tools/kvm/mips/include/kvm/kvm-arch.h
 create mode 100644 tools/kvm/mips/include/kvm/kvm-config-arch.h
 create mode 100644 tools/kvm/mips/include/kvm/kvm-cpu-arch.h
 create mode 100644 tools/kvm/mips/irq.c
 create mode 100644 tools/kvm/mips/kvm-cpu.c
 create mode 100644 tools/kvm/mips/kvm.c

[andreas.herrmann:
   * Renamed kvm__arch_periodic_poll to kvm__arch_read_term
     because of commit fa817d892508b6d3a90f478dbeedbe5583b14da7
     (kvm tools: remove periodic tick in favour of a polling thread)
   * Added ioport__map_irq skeleton to fix build problem.
   * Rely on TERM_MAX_DEVS instead of using other macros
   * Adaptions for MMIO support
   * Set coalesc offset
   * Fixed compile warnings
   * Fixed debug output format for register dump
   * Added check for upper bound of len in hypercall_write_cons]

diff --git a/tools/kvm/mips/include/kvm/barrier.h b/tools/kvm/mips/include/kvm/barrier.h
new file mode 100644
index 0000000..45bfa72
--- /dev/null
+++ b/tools/kvm/mips/include/kvm/barrier.h
@@ -0,0 +1,20 @@
+#ifndef _KVM_BARRIER_H_
+#define _KVM_BARRIER_H_
+
+#define barrier() asm volatile("": : :"memory")
+
+#define mb()	asm volatile (".set push\n\t.set mips2\n\tsync\n\t.set pop": : :"memory")
+#define rmb() mb()
+#define wmb() mb()
+
+#ifdef CONFIG_SMP
+#define smp_mb()	mb()
+#define smp_rmb()	rmb()
+#define smp_wmb()	wmb()
+#else
+#define smp_mb()	barrier()
+#define smp_rmb()	barrier()
+#define smp_wmb()	barrier()
+#endif
+
+#endif /* _KVM_BARRIER_H_ */
diff --git a/tools/kvm/mips/include/kvm/kvm-arch.h b/tools/kvm/mips/include/kvm/kvm-arch.h
new file mode 100644
index 0000000..4a8407b
--- /dev/null
+++ b/tools/kvm/mips/include/kvm/kvm-arch.h
@@ -0,0 +1,33 @@
+#ifndef KVM__KVM_ARCH_H
+#define KVM__KVM_ARCH_H
+
+#define KVM_MMIO_START		0x10000000
+#define KVM_PCI_CFG_AREA	KVM_MMIO_START
+#define KVM_PCI_MMIO_AREA	(KVM_MMIO_START + 0x1000000)
+#define KVM_VIRTIO_MMIO_AREA	(KVM_MMIO_START + 0x2000000)
+
+/*
+ * Just for reference. This and the above corresponds to what's used
+ * in mipsvz_page_fault() in kvm_mipsvz.c of the host kernel.
+ */
+#define KVM_MIPS_IOPORT_AREA	0x1e000000
+#define KVM_MIPS_IOPORT_SIZE	0x00010000
+#define KVM_MIPS_IRQCHIP_AREA	0x1e010000
+#define KVM_MIPS_IRQCHIP_SIZE	0x00010000
+
+#define KVM_IRQ_OFFSET		1
+
+#define VIRTIO_DEFAULT_TRANS(kvm)	VIRTIO_PCI
+
+#include <stdbool.h>
+
+#include "linux/types.h"
+
+struct kvm_arch {
+	u64 entry_point;
+	u64 argc;
+	u64 argv;
+	bool is64bit;
+};
+
+#endif /* KVM__KVM_ARCH_H */
diff --git a/tools/kvm/mips/include/kvm/kvm-config-arch.h b/tools/kvm/mips/include/kvm/kvm-config-arch.h
new file mode 100644
index 0000000..8a28f9d
--- /dev/null
+++ b/tools/kvm/mips/include/kvm/kvm-config-arch.h
@@ -0,0 +1,7 @@
+#ifndef KVM__KVM_CONFIG_ARCH_H
+#define KVM__KVM_CONFIG_ARCH_H
+
+struct kvm_config_arch {
+};
+
+#endif /* KVM__MIPS_KVM_CONFIG_ARCH_H */
diff --git a/tools/kvm/mips/include/kvm/kvm-cpu-arch.h b/tools/kvm/mips/include/kvm/kvm-cpu-arch.h
new file mode 100644
index 0000000..d160837
--- /dev/null
+++ b/tools/kvm/mips/include/kvm/kvm-cpu-arch.h
@@ -0,0 +1,42 @@
+#ifndef KVM__KVM_CPU_ARCH_H
+#define KVM__KVM_CPU_ARCH_H
+
+#include <linux/kvm.h>	/* for struct kvm_regs */
+#include "kvm/kvm.h"	/* for kvm__emulate_{mm}io() */
+#include <pthread.h>
+
+struct kvm;
+
+struct kvm_cpu {
+	pthread_t	thread;		/* VCPU thread */
+
+	unsigned long	cpu_id;
+
+	struct kvm	*kvm;		/* parent KVM */
+	int		vcpu_fd;	/* For VCPU ioctls() */
+	struct kvm_run	*kvm_run;
+
+	struct kvm_regs	regs;
+
+	u8		is_running;
+	u8		paused;
+	u8		needs_nmi;
+
+	struct kvm_coalesced_mmio_ring *ring;
+};
+
+/*
+ * As these are such simple wrappers, let's have them in the header so they'll
+ * be cheaper to call:
+ */
+static inline bool kvm_cpu__emulate_io(struct kvm *kvm, u16 port, void *data, int direction, int size, u32 count)
+{
+	return kvm__emulate_io(kvm, port, data, direction, size, count);
+}
+
+static inline bool kvm_cpu__emulate_mmio(struct kvm *kvm, u64 phys_addr, u8 *data, u32 len, u8 is_write)
+{
+	return kvm__emulate_mmio(kvm, phys_addr, data, len, is_write);
+}
+
+#endif /* KVM__KVM_CPU_ARCH_H */
diff --git a/tools/kvm/mips/irq.c b/tools/kvm/mips/irq.c
new file mode 100644
index 0000000..c1ff6bb
--- /dev/null
+++ b/tools/kvm/mips/irq.c
@@ -0,0 +1,10 @@
+#include "kvm/irq.h"
+#include "kvm/kvm.h"
+
+#include <stdlib.h>
+
+int irq__add_msix_route(struct kvm *kvm, struct msi_msg *msg)
+{
+	pr_warning("irq__add_msix_route");
+	return 1;
+}
diff --git a/tools/kvm/mips/kvm-cpu.c b/tools/kvm/mips/kvm-cpu.c
new file mode 100644
index 0000000..1ab157a
--- /dev/null
+++ b/tools/kvm/mips/kvm-cpu.c
@@ -0,0 +1,218 @@
+#include "kvm/kvm-cpu.h"
+#include "kvm/term.h"
+
+#include <stdlib.h>
+
+static int debug_fd;
+
+void kvm_cpu__set_debug_fd(int fd)
+{
+	debug_fd = fd;
+}
+
+int kvm_cpu__get_debug_fd(void)
+{
+	return debug_fd;
+}
+
+void kvm_cpu__delete(struct kvm_cpu *vcpu)
+{
+	free(vcpu);
+}
+
+static struct kvm_cpu *kvm_cpu__new(struct kvm *kvm)
+{
+	struct kvm_cpu *vcpu;
+
+	vcpu = calloc(1, sizeof(*vcpu));
+	if (!vcpu)
+		return NULL;
+
+	vcpu->kvm = kvm;
+
+	return vcpu;
+}
+
+struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
+{
+	struct kvm_cpu *vcpu;
+	int mmap_size;
+	int coalesced_offset;
+
+	vcpu = kvm_cpu__new(kvm);
+	if (!vcpu)
+		return NULL;
+
+	vcpu->cpu_id = cpu_id;
+
+	vcpu->vcpu_fd = ioctl(vcpu->kvm->vm_fd, KVM_CREATE_VCPU, cpu_id);
+	if (vcpu->vcpu_fd < 0)
+		die_perror("KVM_CREATE_VCPU ioctl");
+
+	mmap_size = ioctl(vcpu->kvm->sys_fd, KVM_GET_VCPU_MMAP_SIZE, 0);
+	if (mmap_size < 0)
+		die_perror("KVM_GET_VCPU_MMAP_SIZE ioctl");
+
+	vcpu->kvm_run = mmap(NULL, mmap_size, PROT_RW, MAP_SHARED, vcpu->vcpu_fd, 0);
+	if (vcpu->kvm_run == MAP_FAILED)
+		die("unable to mmap vcpu fd");
+
+	vcpu->is_running = true;
+
+	coalesced_offset = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION, KVM_CAP_COALESCED_MMIO);
+	if (coalesced_offset)
+		vcpu->ring = (void *)vcpu->kvm_run + (coalesced_offset * PAGE_SIZE);
+
+	return vcpu;
+}
+
+static void kvm_cpu__setup_regs(struct kvm_cpu *vcpu)
+{
+	uint32_t v;
+	struct kvm_one_reg one_reg;
+
+	memset(&vcpu->regs, 0, sizeof(vcpu->regs));
+	vcpu->regs.pc = vcpu->kvm->arch.entry_point;
+	vcpu->regs.gpr[4] = vcpu->kvm->arch.argc;
+	vcpu->regs.gpr[5] = vcpu->kvm->arch.argv;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_REGS, &vcpu->regs) < 0)
+		die_perror("KVM_SET_REGS failed");
+
+
+	one_reg.id = KVM_REG_MIPS | KVM_REG_SIZE_U32 | (0x10000 + 8 * 12 + 0); /* Status */
+	one_reg.addr = (unsigned long)(uint32_t *)&v;
+	v = 6;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_SET_ONE_REG, &one_reg) < 0)
+		die_perror("KVM_SET_ONE_REG failed");
+}
+
+/**
+ * kvm_cpu__reset_vcpu - reset virtual CPU to a known state
+ */
+void kvm_cpu__reset_vcpu(struct kvm_cpu *vcpu)
+{
+	kvm_cpu__setup_regs(vcpu);
+}
+
+static bool kvm_cpu__hypercall_write_cons(struct kvm_cpu *vcpu)
+{
+	int term = (int)vcpu->kvm_run->hypercall.args[0];
+	u64 addr = vcpu->kvm_run->hypercall.args[1];
+	int len = (int)vcpu->kvm_run->hypercall.args[2];
+	char *host_addr;
+
+	if (term < 0 || term >= TERM_MAX_DEVS) {
+		pr_warning("hypercall_write_cons term out of range <%d>", term);
+		return false;
+	}
+
+	if ((addr & 0xffffffffc0000000ull) == 0xffffffff80000000ull)
+		addr &= 0x1ffffffful; /* Convert KSEG{0,1} to physical. */
+	if ((addr & 0xc000000000000000ull) == 0x8000000000000000ull)
+		addr &= 0x07ffffffffffffffull; /* Convert XKPHYS to pysical */
+
+	host_addr = guest_flat_to_host(vcpu->kvm, addr);
+	if (!host_addr) {
+		pr_warning("hypercall_write_cons unmapped physaddr %llx", (unsigned long long)addr);
+		return false;
+	}
+
+	if ((len <= 0) || !host_ptr_in_ram(vcpu->kvm, host_addr + len)) {
+		pr_warning("hypercall_write_cons len out of range <%d>", len);
+		return false;
+	}
+
+	term_putc(host_addr, len, term);
+
+	return true;
+}
+
+bool kvm_cpu__handle_exit(struct kvm_cpu *vcpu)
+{
+	switch(vcpu->kvm_run->exit_reason) {
+	case KVM_EXIT_HYPERCALL:
+		if (vcpu->kvm_run->hypercall.nr == 0) {
+			return kvm_cpu__hypercall_write_cons(vcpu);
+		} else {
+			pr_warning("KVM_EXIT_HYPERCALL unrecognized call %llu",
+				   (unsigned long long)vcpu->kvm_run->hypercall.nr);
+			return false;
+		}
+	case KVM_EXIT_EXCEPTION:
+	case KVM_EXIT_INTERNAL_ERROR:
+		return false;
+	default:
+		break;
+	}
+	return false;
+}
+
+void kvm_cpu__arch_nmi(struct kvm_cpu *cpu)
+{
+}
+
+void kvm_cpu__show_registers(struct kvm_cpu *vcpu)
+{
+	struct kvm_regs regs;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_GET_REGS, &regs) < 0)
+		die("KVM_GET_REGS failed");
+	dprintf(debug_fd, "\n Registers:\n");
+	dprintf(debug_fd,   " ----------\n");
+	dprintf(debug_fd, "$0   : %016llx %016llx %016llx %016llx\n",
+		(unsigned long long)regs.gpr[0],
+		(unsigned long long)regs.gpr[1],
+		(unsigned long long)regs.gpr[2],
+		(unsigned long long)regs.gpr[3]);
+	dprintf(debug_fd, "$4   : %016llx %016llx %016llx %016llx\n",
+		(unsigned long long)regs.gpr[4],
+		(unsigned long long)regs.gpr[5],
+		(unsigned long long)regs.gpr[6],
+		(unsigned long long)regs.gpr[7]);
+	dprintf(debug_fd, "$8   : %016llx %016llx %016llx %016llx\n",
+		(unsigned long long)regs.gpr[8],
+		(unsigned long long)regs.gpr[9],
+		(unsigned long long)regs.gpr[10],
+		(unsigned long long)regs.gpr[11]);
+	dprintf(debug_fd, "$12  : %016llx %016llx %016llx %016llx\n",
+		(unsigned long long)regs.gpr[12],
+		(unsigned long long)regs.gpr[13],
+		(unsigned long long)regs.gpr[14],
+		(unsigned long long)regs.gpr[15]);
+	dprintf(debug_fd, "$16  : %016llx %016llx %016llx %016llx\n",
+		(unsigned long long)regs.gpr[16],
+		(unsigned long long)regs.gpr[17],
+		(unsigned long long)regs.gpr[18],
+		(unsigned long long)regs.gpr[19]);
+	dprintf(debug_fd, "$20  : %016llx %016llx %016llx %016llx\n",
+		(unsigned long long)regs.gpr[20],
+		(unsigned long long)regs.gpr[21],
+		(unsigned long long)regs.gpr[22],
+		(unsigned long long)regs.gpr[23]);
+	dprintf(debug_fd, "$24  : %016llx %016llx %016llx %016llx\n",
+		(unsigned long long)regs.gpr[24],
+		(unsigned long long)regs.gpr[25],
+		(unsigned long long)regs.gpr[26],
+		(unsigned long long)regs.gpr[27]);
+	dprintf(debug_fd, "$28  : %016llx %016llx %016llx %016llx\n",
+		(unsigned long long)regs.gpr[28],
+		(unsigned long long)regs.gpr[29],
+		(unsigned long long)regs.gpr[30],
+		(unsigned long long)regs.gpr[31]);
+
+	dprintf(debug_fd, "hi   : %016llx\n", (unsigned long long)regs.hi);
+	dprintf(debug_fd, "lo   : %016llx\n", (unsigned long long)regs.lo);
+	dprintf(debug_fd, "epc  : %016llx\n", (unsigned long long)regs.pc);
+
+	dprintf(debug_fd, "\n");
+}
+
+void kvm_cpu__show_code(struct kvm_cpu *vcpu)
+{
+}
+
+void kvm_cpu__show_page_tables(struct kvm_cpu *vcpu)
+{
+}
diff --git a/tools/kvm/mips/kvm.c b/tools/kvm/mips/kvm.c
new file mode 100644
index 0000000..9eecfb5
--- /dev/null
+++ b/tools/kvm/mips/kvm.c
@@ -0,0 +1,128 @@
+#include "kvm/kvm.h"
+#include "kvm/ioport.h"
+#include "kvm/virtio-console.h"
+
+#include <linux/kvm.h>
+
+#include <ctype.h>
+#include <unistd.h>
+
+struct kvm_ext kvm_req_ext[] = {
+	{ 0, 0 }
+};
+
+void kvm__arch_read_term(struct kvm *kvm)
+{
+	virtio_console__inject_interrupt(kvm);
+}
+
+void kvm__init_ram(struct kvm *kvm)
+{
+	u64	phys_start, phys_size;
+	void	*host_mem;
+
+	phys_start = 0;
+	phys_size  = kvm->ram_size;
+	host_mem   = kvm->ram_start;
+
+	kvm__register_mem(kvm, phys_start, phys_size, host_mem);
+}
+
+void kvm__arch_delete_ram(struct kvm *kvm)
+{
+	munmap(kvm->ram_start, kvm->ram_size);
+}
+
+void kvm__arch_set_cmdline(char *cmdline, bool video)
+{
+
+}
+
+/* Architecture-specific KVM init */
+void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
+{
+	int ret;
+
+	kvm->ram_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, ram_size);
+	kvm->ram_size = ram_size;
+
+	if (kvm->ram_start == MAP_FAILED)
+		die("out of memory");
+
+	madvise(kvm->ram_start, kvm->ram_size, MADV_MERGEABLE);
+
+	ret = ioctl(kvm->vm_fd, KVM_CREATE_IRQCHIP);
+	if (ret < 0)
+		die_perror("KVM_CREATE_IRQCHIP ioctl");
+}
+
+void kvm__irq_line(struct kvm *kvm, int irq, int level)
+{
+	struct kvm_irq_level irq_level;
+	int ret;
+
+	irq_level.irq = irq;
+	irq_level.level = level ? 1 : 0;
+
+	ret = ioctl(kvm->vm_fd, KVM_IRQ_LINE, &irq_level);
+	if (ret < 0)
+		die_perror("KVM_IRQ_LINE ioctl");
+}
+
+void kvm__irq_trigger(struct kvm *kvm, int irq)
+{
+	struct kvm_irq_level irq_level;
+	int ret;
+
+	irq_level.irq = irq;
+	irq_level.level = 1;
+
+	ret = ioctl(kvm->vm_fd, KVM_IRQ_LINE, &irq_level);
+	if (ret < 0)
+		die_perror("KVM_IRQ_LINE ioctl");
+}
+
+void ioport__setup_arch(struct kvm *kvm)
+{
+}
+
+bool kvm__arch_cpu_supports_vm(void)
+{
+	return true;
+}
+bool kvm__load_firmware(struct kvm *kvm, const char *firmware_filename)
+{
+	return false;
+}
+int kvm__arch_setup_firmware(struct kvm *kvm)
+{
+	return 0;
+}
+
+/* Load at the 1M point. */
+#define KERNEL_LOAD_ADDR 0x1000000
+int load_flat_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *kernel_cmdline)
+{
+	void *p;
+	void *k_start;
+	int nr;
+
+	if (lseek(fd_kernel, 0, SEEK_SET) < 0)
+		die_perror("lseek");
+
+	p = k_start = guest_flat_to_host(kvm, KERNEL_LOAD_ADDR);
+
+	while ((nr = read(fd_kernel, p, 65536)) > 0)
+		p += nr;
+
+	kvm->arch.is64bit = true;
+	kvm->arch.entry_point = 0xffffffff81000000ull;
+
+	pr_info("Loaded kernel to 0x%x (%ld bytes)", KERNEL_LOAD_ADDR, (long int)(p - k_start));
+
+	return true;
+}
+
+void ioport__map_irq(u8 *irq)
+{
+}
-- 
1.7.9.5
