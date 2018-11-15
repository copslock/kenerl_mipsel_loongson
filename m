Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 06:54:14 +0100 (CET)
Received: from mail-pl1-x641.google.com ([IPv6:2607:f8b0:4864:20::641]:33426
        "EHLO mail-pl1-x641.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991082AbeKOFw1s2-M4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 06:52:27 +0100
Received: by mail-pl1-x641.google.com with SMTP id w22-v6so8956814plk.0;
        Wed, 14 Nov 2018 21:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UN89BcuqBCUQkW3BG2Fjtc6UfsMOEijXgJVi37uvGqQ=;
        b=s36qKwnpI20rqJyvleBbK0wxEpgU73D5mO/aoStY/ZpgtLOuDqRmLXI0Bq9rEc9hCo
         ksHpi2iAXjXg55+GxNNsvQhbSt1FpR6jCMLayiBBI3n5x0TYT2oViZ/ZlYPDFJHHEApm
         m3ZAh0hU3Oi7tS8+UW3s6CbFbu3PIqqRihko/6CwESowDiggcQWXeE3L1xI+PBlJtHAt
         eE/4UqE6K/FgJUbSJxQzbFNGjkbMJrYwvkWhEnV5XNknLkPe/7P2XkAAsz5UxsfcduF6
         wYgSy+RJgJAJUqgv4+T0nL+qjLupH8s1R77KvZlmdhRJhFdO1EOeaRh81U9CGDnhA04S
         HCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=UN89BcuqBCUQkW3BG2Fjtc6UfsMOEijXgJVi37uvGqQ=;
        b=kDSxGSJYX/RAjqoGJL6CXudkDv2A/0p9zjJW3oon1l34FV0iGVfo4gawDE4JDFF5Zd
         NlDcCx2MeygsmLglkaud1OaeWbMNTOBETRslD5a0+OTIEM7zaQjrOd8xQCt7dNU0G7yN
         NgrI/+ZiTIhmcZnY4SnSSzxU80NCr4mUvvZxEJD5P0sw2AKxFUQBh9nT5yvIkg/kvXIC
         wjyDs1UbB4lQNlFwISBu974E5aCcdfk1XTtgnMs1m64q+2FtY9cxdtRiYgFdUP5Zzjt7
         BGT4MGs6X2h6dwzQNQpSm9Timy1NxGymy6I7pWNSwQHQQ/PYaQu+Mhnl8Kym+MJT63mt
         6EBA==
X-Gm-Message-State: AGRZ1gK6hgHwRZd5V4FiiSUmK9lksZaFZhPbNrSObD6NM1HyNOEAtGg1
        P/Pieph4hGM4nM/nl3KWbpc=
X-Google-Smtp-Source: AJdET5cVrdWL9WtPpcJT0ry9DeGepjP3Sp+yDVcbrcDav/hEidLGlLJ1p+fGUJFJU+hHzqWLWZQ+fw==
X-Received: by 2002:a17:902:b103:: with SMTP id q3-v6mr4927789plr.83.1542261145586;
        Wed, 14 Nov 2018 21:52:25 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id o1sm34882306pgn.63.2018.11.14.21.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 21:52:24 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: [PATCH V5 1/8] MIPS: Loongson: Add Loongson-3A R2.1 basic support
Date:   Thu, 15 Nov 2018 13:50:50 +0800
Message-Id: <1542261057-6019-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1542261057-6019-1-git-send-email-chenhc@lemote.com>
References: <1542261057-6019-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67298
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

Loongson-3A R2.1 is the bugfix revision of Loongson-3A R2.

All Loongson-3 CPU family:

Code-name         Brand-name       PRId
Loongson-3A R1    Loongson-3A1000  0x6305
Loongson-3A R2    Loongson-3A2000  0x6308
Loongson-3A R2.1  Loongson-3A2000  0x630c
Loongson-3A R3    Loongson-3A3000  0x6309
Loongson-3A R3.1  Loongson-3A3000  0x630d
Loongson-3B R1    Loongson-3B1000  0x6306
Loongson-3B R2    Loongson-3B1500  0x6307

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@mips.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
---
 arch/mips/include/asm/cpu.h                               | 3 ++-
 arch/mips/include/asm/mach-loongson64/kernel-entry-init.h | 4 ++--
 arch/mips/kernel/cpu-probe.c                              | 3 ++-
 arch/mips/kernel/idle.c                                   | 2 +-
 arch/mips/loongson64/common/env.c                         | 3 ++-
 arch/mips/loongson64/loongson-3/smp.c                     | 3 ++-
 arch/mips/mm/c-r4k.c                                      | 2 +-
 drivers/platform/mips/cpu_hwmon.c                         | 3 ++-
 8 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index dacbdb8..532b49b 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -248,8 +248,9 @@
 #define PRID_REV_LOONGSON3A_R1		0x0005
 #define PRID_REV_LOONGSON3B_R1		0x0006
 #define PRID_REV_LOONGSON3B_R2		0x0007
-#define PRID_REV_LOONGSON3A_R2		0x0008
+#define PRID_REV_LOONGSON3A_R2_0	0x0008
 #define PRID_REV_LOONGSON3A_R3_0	0x0009
+#define PRID_REV_LOONGSON3A_R2_1	0x000c
 #define PRID_REV_LOONGSON3A_R3_1	0x000d
 
 /*
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index cbac603..b5e288a 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -31,7 +31,7 @@
 	/* Enable STFill Buffer */
 	mfc0	t0, CP0_PRID
 	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
-	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
+	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2_0)
 	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
@@ -60,7 +60,7 @@
 	/* Enable STFill Buffer */
 	mfc0	t0, CP0_PRID
 	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
-	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
+	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2_0)
 	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 71dcef8..65dc2e6 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1871,7 +1871,8 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 	switch (c->processor_id & PRID_IMP_MASK) {
 	case PRID_IMP_LOONGSON_64:  /* Loongson-2/3 */
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON3A_R2:
+		case PRID_REV_LOONGSON3A_R2_0:
+		case PRID_REV_LOONGSON3A_R2_1:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 4d335b1..695f554 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -184,7 +184,7 @@ void __init check_wait(void)
 		cpu_wait = r4k_wait;
 		break;
 	case CPU_LOONGSON3:
-		if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2)
+		if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2_0)
 			cpu_wait = r4k_wait;
 		break;
 
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 8f68ee0..72e5f8f 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -197,7 +197,8 @@ void __init prom_init_env(void)
 			cpu_clock_freq = 797000000;
 			break;
 		case PRID_REV_LOONGSON3A_R1:
-		case PRID_REV_LOONGSON3A_R2:
+		case PRID_REV_LOONGSON3A_R2_0:
+		case PRID_REV_LOONGSON3A_R2_1:
 		case PRID_REV_LOONGSON3A_R3_0:
 		case PRID_REV_LOONGSON3A_R3_1:
 			cpu_clock_freq = 900000000;
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index b5c1e0a..8fba0aa 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -682,7 +682,8 @@ void play_dead(void)
 		play_dead_at_ckseg1 =
 			(void *)CKSEG1ADDR((unsigned long)loongson3a_r1_play_dead);
 		break;
-	case PRID_REV_LOONGSON3A_R2:
+	case PRID_REV_LOONGSON3A_R2_0:
+	case PRID_REV_LOONGSON3A_R2_1:
 	case PRID_REV_LOONGSON3A_R3_0:
 	case PRID_REV_LOONGSON3A_R3_1:
 		play_dead_at_ckseg1 =
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 05bd777..7e430b4 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1352,7 +1352,7 @@ static void probe_pcache(void)
 					  c->dcache.ways *
 					  c->dcache.linesz;
 		c->dcache.waybit = 0;
-		if ((prid & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2)
+		if ((prid & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2_0)
 			c->options |= MIPS_CPU_PREFETCH;
 		break;
 
diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index f66521c..42efcb8 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -25,9 +25,10 @@ int loongson3_cpu_temp(int cpu)
 	case PRID_REV_LOONGSON3A_R1:
 		reg = (reg >> 8) & 0xff;
 		break;
-	case PRID_REV_LOONGSON3A_R2:
 	case PRID_REV_LOONGSON3B_R1:
 	case PRID_REV_LOONGSON3B_R2:
+	case PRID_REV_LOONGSON3A_R2_0:
+	case PRID_REV_LOONGSON3A_R2_1:
 		reg = ((reg >> 8) & 0xff) - 100;
 		break;
 	case PRID_REV_LOONGSON3A_R3_0:
-- 
2.7.0
