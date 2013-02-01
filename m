Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Feb 2013 20:39:50 +0100 (CET)
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56056 "EHLO
        mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823006Ab3BATjrdeZ4n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Feb 2013 20:39:47 +0100
Received: by mail-pb0-f47.google.com with SMTP id rp8so2277710pbb.20
        for <multiple recipients>; Fri, 01 Feb 2013 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=7Vzhll3N3LqeAxl7wqTpLxlP7khdAYPQml7veZQ7h+Q=;
        b=zGiwXFd1Mtt7jCCMy3ivSuVBoONYMcAQkEhnLdhW257EtGCpNAH6gXXKF6UCg/SALr
         tbdgDTQxMPV56yEhCYgX/czWz2QAT+g7hQGsl8BLFFdoRsxBRZvOTC15RU4jOC4Dy3nP
         Xq1BnjogUx8xuqjVK73Wu2Wjj3v0GwrUerQHTnMcQ8cma44m45tRzHsG07qMXT5ud+6A
         +gsusXzhLmXQsBnKO20jFwkStxC9QB9BeTJWKRIb3uyl+xDClnIpulzTvOQP4p4eszE8
         bS3hnWQuRBGpXFyYKTxqx0j8NpMexXKPE3zaVmogd7wDYu/oJQYcfwVhR2fy3+q6l2cQ
         gkBA==
X-Received: by 10.68.217.104 with SMTP id ox8mr34927888pbc.105.1359747579799;
        Fri, 01 Feb 2013 11:39:39 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id vn2sm9282842pbc.31.2013.02.01.11.39.38
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 11:39:39 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r11JdbkD029059;
        Fri, 1 Feb 2013 11:39:37 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r11Jdb8V029058;
        Fri, 1 Feb 2013 11:39:37 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Probe for and report hardware virtualization support.
Date:   Fri,  1 Feb 2013 11:39:36 -0800
Message-Id: <1359747576-29025-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35678
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The presence of the MIPS Virtualization Application-Specific Extension
is indicated by CP0_Config3[23].  Probe for this and report it in
/proc/cpuinfo.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/cpu-features.h | 4 ++++
 arch/mips/include/asm/cpu.h          | 2 +-
 arch/mips/include/asm/mipsregs.h     | 1 +
 arch/mips/kernel/cpu-probe.c         | 2 ++
 arch/mips/kernel/proc.c              | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 1e83b24..e4bce0b 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -273,4 +273,8 @@
 #define cpu_has_perf_cntr_intr_bit	(cpu_data[0].options & MIPS_CPU_PCI)
 #endif
 
+#ifndef cpu_has_vz
+#define cpu_has_vz		(cpu_data[0].ases & MIPS_ASE_VZ)
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 9904697..cd9c223 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -333,6 +333,6 @@ enum cpu_type_enum {
 #define MIPS_ASE_DSP		0x00000010 /* Signal Processing ASE */
 #define MIPS_ASE_MIPSMT		0x00000020 /* CPU supports MIPS MT */
 #define MIPS_ASE_DSP2P		0x00000040 /* Signal Processing ASE Rev 2 */
-
+#define MIPS_ASE_VZ		0x00000080 /* Virtualization ASE */
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 2145162..b9ca9a1 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -595,6 +595,7 @@
 #define MIPS_CONF3_DSP2P	(_ULCAST_(1) << 11)
 #define MIPS_CONF3_RXI		(_ULCAST_(1) << 12)
 #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
+#define MIPS_CONF3_VZ		(_ULCAST_(1) << 23)
 
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
 #define MIPS_CONF4_MMUEXTDEF	(_ULCAST_(3) << 14)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 2656c89..da2222e 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -467,6 +467,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
 		c->options |= MIPS_CPU_ULRI;
+	if (config3 & MIPS_CONF3_VZ)
+		c->ases |= MIPS_ASE_VZ;
 
 	return config3 & MIPS_CONF_M;
 }
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 79d4b8e..4673fa3 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -95,6 +95,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_dsp)	seq_printf(m, "%s", " dsp");
 	if (cpu_has_dsp2)	seq_printf(m, "%s", " dsp2");
 	if (cpu_has_mipsmt)	seq_printf(m, "%s", " mt");
+	if (cpu_has_vz)		seq_printf(m, "%s", " vz");
 	seq_printf(m, "\n");
 
 	seq_printf(m, "shadow register sets\t: %d\n",
-- 
1.7.11.7
