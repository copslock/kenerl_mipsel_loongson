Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:22:10 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:32999
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeA0DWANZveB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:22:00 +0100
Received: by mail-pf0-x241.google.com with SMTP id t5so1463063pfi.0;
        Fri, 26 Jan 2018 19:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ylZf//lfYgCuIvr/w54Aqr10pgd/Tvs8BddhPSxnxjo=;
        b=ayTOsdSTf0Og0X6Ub3rtMTlW5ga/qqgqWiN7Zz7cjfmSD2qo4xeQemZHjYDsy9Uemu
         wE9TTVPUdWOOLsFZZpb848vtA7K3NQlBvrH1bmaTsLWd/W/cZwSOZ/2d3kw7qoIjqiJr
         CIz75l1MrrzjNwwp37VD32VSnymBSj5RlOJ0AwlV3AjX7i11hAAmHeeovKOf8iiWi0OK
         LcCT/R0JqsrnLyvJM94jnnNs7Wz/NdYNN/mU159fDUFjwmAsRG/L3YPpTyljSLn0QYZB
         hgOuHD22cRjaVZ6T6r5lXYh2JL+AIUInyAUjEXscKEKhqb6HF2IYkyjdn2KDs0C6uuf/
         2xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ylZf//lfYgCuIvr/w54Aqr10pgd/Tvs8BddhPSxnxjo=;
        b=h1X2xWPrskOIOjPFyjRCfFGxcIhWT2ZJtdeMsHIGMjw/c+SGpgz9EsjJUVOzTjjvhB
         HeyrQ0+8DGu8QwarYhFPk6xY18/kxk3zc4cXQcCPMvUI5XOjhVXgXA3taIDQv3jMuDYx
         dnQFLL2QlWjiFgwhgQwEx3eDfCLg45VC47o9rFOHRjEUELcV9WE3pzqRnrKC8rkB2+OB
         mxopVpSHfBsykqJ303eCfV2QrZJ+HJfYPXO8Yjc7wWKdxgEMLGswOONEVuEuHXnU39hM
         8kuVJ1TW60CVbYSIn/ZFoU7aCwpR8h0GRVeSvPDhjx23qbWhStE9+0jsD+1iqFeapWPm
         8NoA==
X-Gm-Message-State: AKwxytet3XJmFc+WHoJjSd1agi79YpsNOLfvsOPUwjHUNqwzpAva+EqD
        v1wFomP2viu4swkOrvP+8I86NA==
X-Google-Smtp-Source: AH8x224UFnCnzJnMpMFJG3/bWT+up/WrjHN1EzAVjZgAw4qA7xFSDYWobPeRjDCzrHoOg4IJfTA9MQ==
X-Received: by 10.98.65.193 with SMTP id g62mr20764834pfd.60.1517023312179;
        Fri, 26 Jan 2018 19:21:52 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 8sm26843303pfh.170.2018.01.26.19.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:21:51 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 07/12] MIPS: Add __cpu_full_name[] to make CPU names more human-readable
Date:   Sat, 27 Jan 2018 11:22:14 +0800
Message-Id: <1517023336-17575-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62350
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

The CPU frequency in "model name" is the default value (highest), and
there is also a "CPU MHz" whose value can be changed by cpufreq.

This is only used by Loongson now (ICT is dropped in cpu name, and cpu
name can be overwritten by BIOS).

Reviewed-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-info.h                   |  2 ++
 arch/mips/include/asm/mach-loongson64/boot_param.h |  1 +
 arch/mips/include/asm/time.h                       |  2 ++
 arch/mips/kernel/cpu-probe.c                       | 25 ++++++++++++++++------
 arch/mips/kernel/proc.c                            |  7 ++++++
 arch/mips/kernel/time.c                            |  2 ++
 arch/mips/loongson64/common/env.c                  | 13 +++++++++++
 arch/mips/loongson64/loongson-3/smp.c              |  1 +
 arch/mips/loongson64/loongson-3/smp.h              |  1 +
 9 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index a41059d..6128a37 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -116,7 +116,9 @@ extern void cpu_probe(void);
 extern void cpu_report(void);
 
 extern const char *__cpu_name[];
+extern const char *__cpu_full_name[];
 #define cpu_name_string()	__cpu_name[raw_smp_processor_id()]
+#define cpu_full_name_string()	__cpu_full_name[raw_smp_processor_id()]
 
 struct seq_file;
 struct notifier_block;
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index 8c286be..1d69e4c 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -58,6 +58,7 @@ struct efi_cpuinfo_loongson {
 	u16 reserved_cores_mask;
 	u32 cpu_clock_freq; /* cpu_clock */
 	u32 nr_cpus;
+	char cpuname[64];
 } __packed;
 
 #define MAX_UARTS 64
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 17d4cd2..efbfc48 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -35,6 +35,8 @@ extern int rtc_mips_set_mmss(unsigned long);
  */
 extern void plat_time_init(void);
 
+extern unsigned int mips_cpu_frequency;
+
 /*
  * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
  * counter as a timer interrupt source.
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 83317d6..b7acf35 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1461,30 +1461,40 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
 
@@ -1830,16 +1840,18 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON3A_R2:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
+			__cpu_full_name[cpu] = "Loongson-3A R2 (Loongson-3A2000)";
 			break;
 		case PRID_REV_LOONGSON3A_R3_0:
 		case PRID_REV_LOONGSON3A_R3_1:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
+			__cpu_full_name[cpu] = "Loongson-3A R3 (Loongson-3A3000)";
 			break;
 		}
 
@@ -1959,6 +1971,7 @@ EXPORT_SYMBOL(__ua_limit);
 #endif
 
 const char *__cpu_name[NR_CPUS];
+const char *__cpu_full_name[NR_CPUS];
 const char *__elf_platform;
 
 void cpu_probe(void)
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index b2de408..b4c31b0 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -15,6 +15,7 @@
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
 #include <asm/prom.h>
+#include <asm/time.h>
 
 unsigned int vced_count, vcei_count;
 
@@ -63,6 +64,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, fmt, __cpu_name[n],
 		      (version >> 4) & 0x0f, version & 0x0f,
 		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
+	if (__cpu_full_name[n])
+		seq_printf(m, "model name\t\t: %s\n", __cpu_full_name[n]);
+	if (mips_cpu_frequency)
+		seq_printf(m, "CPU MHz\t\t\t: %u.%02u\n",
+			      mips_cpu_frequency / 1000000,
+			      (mips_cpu_frequency / 10000) % 100);
 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
 		      cpu_data[n].udelay_val / (500000/HZ),
 		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index a6ebc81..5c096c2 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -69,6 +69,8 @@ EXPORT_SYMBOL(perf_irq);
  * 2) calculate a couple of cached variables for later usage
  */
 
+unsigned int mips_cpu_frequency;
+EXPORT_SYMBOL_GPL(mips_cpu_frequency);
 unsigned int mips_hpt_frequency;
 EXPORT_SYMBOL_GPL(mips_hpt_frequency);
 
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 8f68ee0..2928ac5 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -18,6 +18,7 @@
  * option) any later version.
  */
 #include <linux/export.h>
+#include <asm/time.h>
 #include <asm/bootinfo.h>
 #include <loongson.h>
 #include <boot_param.h>
@@ -25,6 +26,7 @@
 
 u32 cpu_clock_freq;
 EXPORT_SYMBOL(cpu_clock_freq);
+char cpu_full_name[64];
 struct efi_memory_map_loongson *loongson_memmap;
 struct loongson_system_configuration loongson_sysconf;
 
@@ -45,6 +47,7 @@ do {									\
 void __init prom_init_env(void)
 {
 	/* pmon passes arguments in 32bit pointers */
+	char freq[12];
 	unsigned int processor_id;
 
 #ifndef CONFIG_LEFI_FIRMWARE_INTERFACE
@@ -151,6 +154,10 @@ void __init prom_init_env(void)
 	loongson_sysconf.nr_nodes = (loongson_sysconf.nr_cpus +
 		loongson_sysconf.cores_per_node - 1) /
 		loongson_sysconf.cores_per_node;
+	if (!strncmp(ecpu->cpuname, "Loongson", 8))
+		strncpy(cpu_full_name, ecpu->cpuname, sizeof(cpu_full_name));
+	if (cpu_full_name[0] == 0)
+		strncpy(cpu_full_name, __cpu_full_name[0], sizeof(cpu_full_name));
 
 	loongson_sysconf.pci_mem_start_addr = eirq_source->pci_mem_start_addr;
 	loongson_sysconf.pci_mem_end_addr = eirq_source->pci_mem_end_addr;
@@ -211,5 +218,11 @@ void __init prom_init_env(void)
 			break;
 		}
 	}
+	mips_cpu_frequency = cpu_clock_freq;
 	pr_info("CpuClock = %u\n", cpu_clock_freq);
+
+	/* Append default cpu frequency with round-off */
+	sprintf(freq, " @ %uMHz", (cpu_clock_freq + 500000) / 1000000);
+	strncat(cpu_full_name, freq, sizeof(cpu_full_name));
+	__cpu_full_name[0] = cpu_full_name;
 }
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index fea95d0..470e9c1 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -340,6 +340,7 @@ static void loongson3_init_secondary(void)
 		initcount = core0_c0count[cpu] + i/2;
 
 	write_c0_count(initcount);
+	__cpu_full_name[cpu] = cpu_full_name;
 }
 
 static void loongson3_smp_finish(void)
diff --git a/arch/mips/loongson64/loongson-3/smp.h b/arch/mips/loongson64/loongson-3/smp.h
index 957bde8..6112d9d 100644
--- a/arch/mips/loongson64/loongson-3/smp.h
+++ b/arch/mips/loongson64/loongson-3/smp.h
@@ -3,6 +3,7 @@
 #define __LOONGSON_SMP_H_
 
 /* for Loongson-3 smp support */
+extern char cpu_full_name[64];
 extern unsigned long long smp_group[4];
 
 /* 4 groups(nodes) in maximum in numa case */
-- 
2.7.0
