Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 04:17:30 +0100 (CET)
Received: from smtpbg65.qq.com ([103.7.28.233]:3391 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992241AbcKNDRYK0bRm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Nov 2016 04:17:24 +0100
X-QQ-mid: bizesmtp1t1479093385tq9s1h65c
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 14 Nov 2016 11:15:49 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72000A0000000
X-QQ-FEAT: PZCthXlvpNxKY2jZ1JhswwmT2Nl/3muBubTkAlZB52n/yjyJJPSuhEfSK/mNF
        t5xkmz8adHoDkyIpjK1UUCqOnFNw1CVbEz9PBd8HQTXTA6LvRq55Y7F2cVN2q8KmSZjw67a
        2dHDksTfkqoWjoW+Fb6KLf6dSu+NW6j2Im47ujEuI7dYmN5BNOBAuqh7uNyPqP7EUW0cOZc
        ThhP601IRvJh6//tdGItlrFcZBrEz5jJ7mVqkOo9iHd7WgW09N3cJ9ZXYPNbSRroOv/ubho
        RKU69GTSzNSAW8fJN89+6PN1k=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 6/7] MIPS: Add __cpu_full_name[] to make CPU names more human-readable
Date:   Mon, 14 Nov 2016 11:12:44 +0800
Message-Id: <1479093165-625-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1479093165-625-1-git-send-email-chenhc@lemote.com>
References: <1479093165-625-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55815
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

This is only used by Loongson now.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-info.h |  2 ++
 arch/mips/kernel/cpu-probe.c     | 13 +++++++++++++
 arch/mips/kernel/proc.c          |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index edbe273..0f12cb3 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -120,7 +120,9 @@ extern void cpu_probe(void);
 extern void cpu_report(void);
 
 extern const char *__cpu_name[];
+extern const char *__cpu_full_name[];
 #define cpu_name_string()	__cpu_name[raw_smp_processor_id()]
+#define cpu_full_name_string()	__cpu_full_name[raw_smp_processor_id()]
 
 struct seq_file;
 struct notifier_block;
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 3432c83..05421c5 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1467,6 +1467,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			set_elf_platform(cpu, "loongson2e");
 			set_isa(c, MIPS_CPU_ISA_III);
 			c->fpu_msk31 |= FPU_CSR_CONDX;
+			__cpu_full_name[cpu] = "ICT Loongson-2E";
 			break;
 		case PRID_REV_LOONGSON2F:
 			c->cputype = CPU_LOONGSON2;
@@ -1474,19 +1475,28 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			set_elf_platform(cpu, "loongson2f");
 			set_isa(c, MIPS_CPU_ISA_III);
 			c->fpu_msk31 |= FPU_CSR_CONDX;
+			__cpu_full_name[cpu] = "ICT Loongson-2F";
 			break;
 		case PRID_REV_LOONGSON3A_R1:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R1);
+			__cpu_full_name[cpu] = "ICT Loongson-3A R1 (Loongson-3A1000)";
 			break;
 		case PRID_REV_LOONGSON3B_R1:
+			c->cputype = CPU_LOONGSON3;
+			__cpu_name[cpu] = "ICT Loongson-3";
+			set_elf_platform(cpu, "loongson3b");
+			set_isa(c, MIPS_CPU_ISA_M64R1);
+			__cpu_full_name[cpu] = "ICT Loongson-3B R1 (Loongson-3B1000)";
+			break;
 		case PRID_REV_LOONGSON3B_R2:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3b");
 			set_isa(c, MIPS_CPU_ISA_M64R1);
+			__cpu_full_name[cpu] = "ICT Loongson-3B R2 (Loongson-3B1500)";
 			break;
 		}
 
@@ -1820,12 +1830,14 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
+			__cpu_full_name[cpu] = "ICT Loongson-3A R2 (Loongson-3A2000)";
 			break;
 		case PRID_REV_LOONGSON3A_R3:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
+			__cpu_full_name[cpu] = "ICT Loongson-3A R3 (Loongson-3A3000)";
 			break;
 		}
 
@@ -1945,6 +1957,7 @@ EXPORT_SYMBOL(__ua_limit);
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
-- 
2.7.0
