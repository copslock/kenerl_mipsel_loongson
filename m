Return-Path: <SRS0=AiVX=QN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3960FC169C4
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 11:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E227D2081B
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 11:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugIZh9b1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfBFL6r (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:58:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43631 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFL6r (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 6 Feb 2019 06:58:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so2781426pgk.10
        for <linux-mips@vger.kernel.org>; Wed, 06 Feb 2019 03:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1dtyN6nh3ZX5AtkXNJpt66JA5/srmFcDSMiPd9ywdJ4=;
        b=ugIZh9b1g9jom79svA8h4H9eWnLAdTTlT7dLBX+y4pULmYTBdYvdWhQ8G1CPVDOdR7
         wqLwBB2CDV+0RbzI4LKq8ZXbjOVRYcfCFprjkr/7JvSQ7GiOS1b4vt8FvmjJadz4CcGW
         Ldcb5J1kvawGU93El25awcxmEg8g7KNxgRNcHfWyzgls+TUyI25zht7h+HPeOz0gGdZh
         w1k6nDtjfgrpZnTpI0CyI3TOx+KaIta51stozYiXyujVglT8KP7Nra6Yuz3+gJ9vkr52
         agSZsYA2MMFwX6bEdmdhhNz2ZSK62L177XPkYiRhpxCBH5z5RHCio3PYzKPbP4IlI6ty
         NjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=1dtyN6nh3ZX5AtkXNJpt66JA5/srmFcDSMiPd9ywdJ4=;
        b=i/h6AcLLztfWsYHeSuV4gsaGHW0Tm5GlTDk1w4tx9dhFW/fUxh1RClGgn/bcu5ca32
         7OQNtkL7fFd7d6BB+1lOghROFybWbXyplbv5kWpOgfCmRdzOU5abvvPOX6zz/oSWvRQZ
         E6qWd/z/InfnehglQ6XcwA7lhVq1XUVZ27vGvt+uWFMTUPqVmM+AKbIBJNcg2jEB5AFM
         94pLierKQpAixuD6JSC/Ap9Fc1FkEVYdz7g8vAHjFv25Mb/6QnNLTtcluFH5YvAMc0Yp
         lin+yV7mxlW4wtcpuEeRsVz00QLdG/bpbYGjHhul4xd7A1HSKkHnReJAMmQuEPJ1r8Q+
         Cujw==
X-Gm-Message-State: AHQUAuYQUzm4sy+tUl9bRNWjhoNE4TYmpyk/rfJJ2bzftBUGJYWNBPju
        IYxKlWz9W+f8AbPYyoolSyI=
X-Google-Smtp-Source: AHgI3Ibulfy5Pnyz0H1+j2ciP9ZnKoKrGgWeXOtnMo3qkyEvKmho5i8Sfnv/40fjSLOr5dnqBx8S3w==
X-Received: by 2002:a63:a41:: with SMTP id z1mr4450524pgk.117.1549454326210;
        Wed, 06 Feb 2019 03:58:46 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id d21sm6908105pgv.37.2019.02.06.03.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 03:58:45 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Add __cpu_full_name[] to make CPU names more human-readable
Date:   Wed,  6 Feb 2019 19:58:46 +0800
Message-Id: <1549454326-8864-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

In /proc/cpuinfo, we keep "cpu model" as is, since GCC should use it
for -march=native. Besides, we add __cpu_full_name[] to describe the
processor in a more human-readable manner. The full name is displayed
as "model name" in cpuinfo, which is needed by some userspace tools
such as gnome-system-monitor.

The CPU frequency in "model name" is the default value (highest), and
there is also a "CPU MHz" whose value can be changed by cpufreq.

This is only used by Loongson now (ICT is dropped in cpu name, and cpu
name can be overwritten by BIOS).

Why drop ICT?
At the beginning, Loongson is designed by ICT, but now all Loongson
processors is designed by "Loongson Technology Corporation Limited"
which is independent from ICT. We have search the code in
https://codesearch.debian.net/, and the result is:

1, GCC searches the "cpu model" in cpuinfo, but it only matches
   "Loongson-2 V0.2" and so on, so drop "ICT" is comfortable;
2, Debian Installer searches the "cpu model" in cpuinfo and matches
   "ICT Loongson", but Yunqiang Su is modifying the code;
3, Valgrind searches the "cpu model" in cpuinfo and matches "ICT
   Loongson", and we are planning to fix it up.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-info.h                   |  2 ++
 arch/mips/include/asm/mach-loongson64/boot_param.h |  1 +
 arch/mips/include/asm/time.h                       |  2 ++
 arch/mips/kernel/cpu-probe.c                       | 25 ++++++++++++++++------
 arch/mips/kernel/proc.c                            |  6 ++++++
 arch/mips/kernel/time.c                            |  2 ++
 arch/mips/loongson64/common/env.c                  | 13 +++++++++++
 arch/mips/loongson64/loongson-3/smp.c              |  1 +
 arch/mips/loongson64/loongson-3/smp.h              |  1 +
 9 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index ed7ffe4..f5e1ce8 100644
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
index b85ec64..5cbfbec 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -26,6 +26,8 @@ extern spinlock_t rtc_lock;
  */
 extern void plat_time_init(void);
 
+extern unsigned int mips_cpu_frequency;
+
 /*
  * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
  * counter as a timer interrupt source.
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d5e335e..8a475b4 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1560,30 +1560,40 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
 
@@ -1934,16 +1944,18 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		case PRID_REV_LOONGSON3A_R2_0:
 		case PRID_REV_LOONGSON3A_R2_1:
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
 
@@ -2063,6 +2075,7 @@ EXPORT_SYMBOL(__ua_limit);
 #endif
 
 const char *__cpu_name[NR_CPUS];
+const char *__cpu_full_name[NR_CPUS];
 const char *__elf_platform;
 
 void cpu_probe(void)
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index b2de408..5ba82cc 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -15,6 +15,7 @@
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
 #include <asm/prom.h>
+#include <asm/time.h>
 
 unsigned int vced_count, vcei_count;
 
@@ -63,6 +64,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, fmt, __cpu_name[n],
 		      (version >> 4) & 0x0f, version & 0x0f,
 		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
+	if (__cpu_full_name[n])
+		seq_printf(m, "model name\t\t: %s\n", __cpu_full_name[n]);
+	if (mips_cpu_frequency)
+		seq_printf(m, "CPU MHz\t\t\t: %u.%02u\n",
+		      mips_cpu_frequency / 1000000, (mips_cpu_frequency / 10000) % 100);
 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
 		      cpu_data[n].udelay_val / (500000/HZ),
 		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index bfe02de..fc0323e 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -54,6 +54,8 @@ EXPORT_SYMBOL(perf_irq);
  * 2) calculate a couple of cached variables for later usage
  */
 
+unsigned int mips_cpu_frequency;
+EXPORT_SYMBOL_GPL(mips_cpu_frequency);
 unsigned int mips_hpt_frequency;
 EXPORT_SYMBOL_GPL(mips_hpt_frequency);
 
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 72e5f8f..d4f9979 100644
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
@@ -212,5 +219,11 @@ void __init prom_init_env(void)
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
index 8fba0aa..bfaba5b 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -341,6 +341,7 @@ static void loongson3_init_secondary(void)
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

