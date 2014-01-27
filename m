Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:29:13 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4489 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824815AbaA0P2gga34r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:28:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 11/15] mips: detect the MSA ASE
Date:   Mon, 27 Jan 2014 15:23:10 +0000
Message-ID: <1390836194-26286-12-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_28_31
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39105
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

This patch adds support for probing the MSAP bit within the Config3
register in order to detect the presence of the MSA ASE. Presence of the
ASE will be indicated in /proc/cpuinfo. The value of the MSA
implementation register will be displayed at boot to aid debugging and
verification of a correct setup, as is done for the FPU.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig                    | 19 +++++++++++++++++++
 arch/mips/include/asm/cpu-features.h |  6 ++++++
 arch/mips/include/asm/cpu-info.h     |  1 +
 arch/mips/include/asm/cpu.h          |  1 +
 arch/mips/kernel/cpu-probe.c         | 22 ++++++++++++++++++++++
 arch/mips/kernel/proc.c              |  1 +
 6 files changed, 50 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 87dc0c3..bb08f1a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1202,6 +1202,7 @@ config CPU_MIPS32_R2
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_MSA
 	select HAVE_KVM
 	help
 	  Choose this option to build a kernel for release 2 or later of the
@@ -1237,6 +1238,7 @@ config CPU_MIPS64_R2
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select CPU_SUPPORTS_MSA
 	help
 	  Choose this option to build a kernel for release 2 or later of the
 	  MIPS64 architecture.  Many modern embedded systems with a 64-bit
@@ -2045,6 +2047,20 @@ config CPU_MICROMIPS
 	  When this option is enabled the kernel will be built using the
 	  microMIPS ISA
 
+config CPU_HAS_MSA
+	bool "Support for the MIPS SIMD Architecture"
+	depends on CPU_SUPPORTS_MSA
+	default y
+	help
+	  MIPS SIMD Architecture (MSA) introduces 128 bit wide vector registers
+	  and a set of SIMD instructions to operate on them. When this option
+	  is enabled the kernel will support detection of the MSA ASE. If you
+	  know that your kernel will only be running on CPUs which do not
+	  support MSA then you may wish to say N here to reduce the size of
+	  your kernel.
+
+	  If unsure, say Y.
+
 config CPU_HAS_WB
 	bool
 
@@ -2110,6 +2126,9 @@ config SYS_SUPPORTS_SMARTMIPS
 config SYS_SUPPORTS_MICROMIPS
 	bool
 
+config CPU_SUPPORTS_MSA
+	bool
+
 config ARCH_FLATMEM_ENABLE
 	def_bool y
 	depends on !NUMA && !CPU_LOONGSON2
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 6e70b03..390795d 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -299,4 +299,10 @@
 #define cpu_has_vz		(cpu_data[0].ases & MIPS_ASE_VZ)
 #endif
 
+#if defined(CONFIG_CPU_HAS_MSA) && !defined(cpu_has_msa)
+# define cpu_has_msa		(cpu_data[0].ases & MIPS_ASE_MSA)
+#elif !defined(cpu_has_msa)
+# define cpu_has_msa		0
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 8f7adf0..359cea1 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -49,6 +49,7 @@ struct cpuinfo_mips {
 	unsigned long		ases;
 	unsigned int		processor_id;
 	unsigned int		fpu_id;
+	unsigned int		msa_id;
 	unsigned int		cputype;
 	int			isa_level;
 	int			tlbsize;
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 76411df..0008277 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -370,5 +370,6 @@ enum cpu_type_enum {
 #define MIPS_ASE_MIPSMT		0x00000020 /* CPU supports MIPS MT */
 #define MIPS_ASE_DSP2P		0x00000040 /* Signal Processing ASE Rev 2 */
 #define MIPS_ASE_VZ		0x00000080 /* Virtualization ASE */
+#define MIPS_ASE_MSA		0x00000100 /* MIPS SIMD Architecture */
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 530f832..852e085 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -23,6 +23,7 @@
 #include <asm/cpu-type.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
+#include <asm/msa.h>
 #include <asm/watch.h>
 #include <asm/elf.h>
 #include <asm/spram.h>
@@ -126,6 +127,20 @@ static inline int __cpu_has_fpu(void)
 	return ((cpu_get_fpu_id() & FPIR_IMP_MASK) != FPIR_IMP_NONE);
 }
 
+static inline unsigned long cpu_get_msa_id(void)
+{
+	unsigned long status, conf5, msa_id;
+
+	status = read_c0_status();
+	__enable_fpu(FPU_64BIT);
+	conf5 = read_c0_config5();
+	enable_msa();
+	msa_id = read_msa_ir();
+	write_c0_config5(conf5);
+	write_c0_status(status);
+	return msa_id;
+}
+
 static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
 {
 #ifdef __NEED_VMBITS_PROBE
@@ -301,6 +316,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_VZ;
 	if (config3 & MIPS_CONF3_SC)
 		c->options |= MIPS_CPU_SEGMENTS;
+	if (config3 & MIPS_CONF3_MSA)
+		c->ases |= MIPS_ASE_MSA;
 
 	return config3 & MIPS_CONF_M;
 }
@@ -1176,6 +1193,9 @@ void cpu_probe(void)
 	else
 		c->srsets = 1;
 
+	if (cpu_has_msa)
+		c->msa_id = cpu_get_msa_id();
+
 	cpu_probe_vmbits(c);
 
 #ifdef CONFIG_64BIT
@@ -1192,4 +1212,6 @@ void cpu_report(void)
 		smp_processor_id(), c->processor_id, cpu_name_string());
 	if (c->options & MIPS_CPU_FPU)
 		printk(KERN_INFO "FPU revision is: %08x\n", c->fpu_id);
+	if (cpu_has_msa)
+		pr_info("MSA revision is: %08x\n", c->msa_id);
 }
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 00d2097..ca1d48e 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -95,6 +95,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_mipsmt)	seq_printf(m, "%s", " mt");
 	if (cpu_has_mmips)	seq_printf(m, "%s", " micromips");
 	if (cpu_has_vz)		seq_printf(m, "%s", " vz");
+	if (cpu_has_msa)	seq_printf(m, "%s", " msa");
 	seq_printf(m, "\n");
 
 	if (cpu_has_mmips) {
-- 
1.8.5.3
