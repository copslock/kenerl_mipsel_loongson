Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 04:35:43 +0200 (CEST)
Received: from SMTPBG352.QQ.COM ([183.57.50.167]:35379 "EHLO smtpbg352.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992800AbdFOCfVMIWqH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Jun 2017 04:35:21 +0200
X-QQ-mid: bizesmtp15t1497494034t58cgkmo
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 15 Jun 2017 10:32:49 +0800 (CST)
X-QQ-SSF: 01100000002000F0FL92000A0000000
X-QQ-FEAT: y3iK4Lsvf4D48f7h5Nm/g1gUpweW1QJ3nB6AA1g8VxfrEYHyN4soLBWyoZUns
        bMsvH95w/lvMKgxiCDhV877U7jkYqaH3/F1Q4+IBSD/XdQRsmBy0kDpjgHESvVfNLWbzFsL
        Ofs/U1HrpxVaxLSeu8yYWkriIXdv6KIvWZuvgWC6mdK6bCSSTsYV5myIXMgDbyOb/jueL5P
        pcCROn16GlWhgcCpWGoiOKj9QLuzkmWW226KofVXjKPkwSCJPndBRitS6XW+Y/iaFzhKJKs
        pBPAEYQ2/dev/Vd47mFXRx7DUUzdrgYmJ++MtVQi/gaYMjMuK/CdvIE1c=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V5 8/9] MIPS: Add __cpu_full_name[] to make CPU names more human-readable
Date:   Thu, 15 Jun 2017 10:31:07 +0800
Message-Id: <1497493868-2446-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1497493868-2446-1-git-send-email-chenhc@lemote.com>
References: <1497492952-23877-1-git-send-email-chenhc@lemote.com>
 <1497493868-2446-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

In /proc/cpuinfo, we keep "cpu model" as is, since GCC should use it
for -march=native. Besides, we add __cpu_full_name[] to describe the
processor in a more human-readable manner. The full name is displayed
as "model name" in cpuinfo, which is needed by some userspace tools
such as gnome-system-monitor.

This is only used by Loongson now (ICT is dropped in cpu name, and cpu
name can be overwritten by BIOS).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-info.h                   |  2 ++
 arch/mips/include/asm/mach-loongson64/boot_param.h |  1 +
 arch/mips/kernel/cpu-probe.c                       | 25 ++++++++++++++++------
 arch/mips/kernel/proc.c                            |  4 ++++
 arch/mips/loongson64/common/env.c                  | 18 ++++++++++++++++
 5 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index cd6efb0..8a8a414 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -121,7 +121,9 @@ extern void cpu_probe(void);
 extern void cpu_report(void);
 
 extern const char *__cpu_name[];
+extern const char *__cpu_full_name[];
 #define cpu_name_string()	__cpu_name[raw_smp_processor_id()]
+#define cpu_full_name_string()	__cpu_full_name[raw_smp_processor_id()]
 
 struct seq_file;
 struct notifier_block;
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index 9f9bb9c..b7ed31b 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -57,6 +57,7 @@ struct efi_cpuinfo_loongson {
 	u16 reserved_cores_mask;
 	u32 cpu_clock_freq; /* cpu_clock */
 	u32 nr_cpus;
+	char cpuname[64];
 } __packed;
 
 #define MAX_UARTS 64
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 410fb7c..8c84e42 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1473,30 +1473,40 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON2E:
 			c->cputype = CPU_LOONGSON2;
-			__cpu_name[cpu] = "ICT Loongson-2";
+			__cpu_name[cpu] = "Loongson-2";
 			set_elf_platform(cpu, "loongson2e");
 			set_isa(c, MIPS_CPU_ISA_III);
 			c->fpu_msk31 |= FPU_CSR_CONDX;
+			__cpu_full_name[cpu] = "Loongson-2E";
 			break;
 		case PRID_REV_LOONGSON2F:
 			c->cputype = CPU_LOONGSON2;
-			__cpu_name[cpu] = "ICT Loongson-2";
+			__cpu_name[cpu] = "Loongson-2";
 			set_elf_platform(cpu, "loongson2f");
 			set_isa(c, MIPS_CPU_ISA_III);
 			c->fpu_msk31 |= FPU_CSR_CONDX;
+			__cpu_full_name[cpu] = "Loongson-2F";
 			break;
 		case PRID_REV_LOONGSON3A_R1:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R1);
+			__cpu_full_name[cpu] = "Loongson-3A R1 (Loongson-3A1000)";
 			break;
 		case PRID_REV_LOONGSON3B_R1:
+			c->cputype = CPU_LOONGSON3;
+			__cpu_name[cpu] = "Loongson-3";
+			set_elf_platform(cpu, "loongson3b");
+			set_isa(c, MIPS_CPU_ISA_M64R1);
+			__cpu_full_name[cpu] = "Loongson-3B R1 (Loongson-3B1000)";
+			break;
 		case PRID_REV_LOONGSON3B_R2:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "Loongson-3";
 			set_elf_platform(cpu, "loongson3b");
 			set_isa(c, MIPS_CPU_ISA_M64R1);
+			__cpu_full_name[cpu] = "Loongson-3B R2 (Loongson-3B1500)";
 			break;
 		}
 
@@ -1827,15 +1837,17 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON3A_R2:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
+			__cpu_full_name[cpu] = "Loongson-3A R2 (Loongson-3A2000)";
 			break;
 		case PRID_REV_LOONGSON3A_R3:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
+			__cpu_full_name[cpu] = "Loongson-3A R3 (Loongson-3A3000)";
 			break;
 		}
 
@@ -1955,6 +1967,7 @@ EXPORT_SYMBOL(__ua_limit);
 #endif
 
 const char *__cpu_name[NR_CPUS];
+const char *__cpu_full_name[NR_CPUS];
 const char *__elf_platform;
 
 void cpu_probe(void)
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 4eff2ae..78db63a 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -14,6 +14,7 @@
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
 #include <asm/prom.h>
+#include <asm/time.h>
 
 unsigned int vced_count, vcei_count;
 
@@ -62,6 +63,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, fmt, __cpu_name[n],
 		      (version >> 4) & 0x0f, version & 0x0f,
 		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
+	if (__cpu_full_name[n])
+		seq_printf(m, "model name\t\t: %s @ %uMHz\n",
+		      __cpu_full_name[n], mips_hpt_frequency / 500000);
 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
 		      cpu_data[n].udelay_val / (500000/HZ),
 		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 1e8a955..9ee24ea 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -25,6 +25,7 @@
 
 u32 cpu_clock_freq;
 EXPORT_SYMBOL(cpu_clock_freq);
+static char cpu_full_name[64];
 struct efi_memory_map_loongson *loongson_memmap;
 struct loongson_system_configuration loongson_sysconf;
 
@@ -151,6 +152,8 @@ void __init prom_init_env(void)
 	loongson_sysconf.nr_nodes = (loongson_sysconf.nr_cpus +
 		loongson_sysconf.cores_per_node - 1) /
 		loongson_sysconf.cores_per_node;
+	if (!strncmp(ecpu->cpuname, "Loongson", 8))
+		strncpy(cpu_full_name, ecpu->cpuname, 64);
 
 	loongson_sysconf.pci_mem_start_addr = eirq_source->pci_mem_start_addr;
 	loongson_sysconf.pci_mem_end_addr = eirq_source->pci_mem_end_addr;
@@ -212,3 +215,18 @@ void __init prom_init_env(void)
 	}
 	pr_info("CpuClock = %u\n", cpu_clock_freq);
 }
+
+static int __init overwrite_cpu_fullname(void)
+{
+	int cpu;
+
+	if (cpu_full_name[0] == 0)
+		return 0;
+
+	for(cpu = 0; cpu < NR_CPUS; cpu++)
+		__cpu_full_name[cpu] = cpu_full_name;
+
+	return 0;
+}
+
+core_initcall(overwrite_cpu_fullname);
-- 
2.7.0
