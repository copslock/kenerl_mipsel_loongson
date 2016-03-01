Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 01:48:31 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35888 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27015055AbcCAAsPAe7b8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 01:48:15 +0100
Received: by mail-pf0-f195.google.com with SMTP id q129so3617953pfb.3;
        Mon, 29 Feb 2016 16:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YrAyeDoAUw1OYcFmYNrtZuT3JK14hRKtrMvztJQRsB4=;
        b=E2eqimM7sLZ1UknrDKVXh1FGjhP9learNS5BUSKt8ybrU9GTi1OgWa83lBnnea2XLh
         KRdG6PkuKOflo7H4b0CHQ49NF1ZtP1ytYe5bjd3ZC3PmEiOR+9RSajUmTxRl0sPmOa3l
         N6QDMABuZxv0B5XtiQCorDZyofioNoAXVtEOAgzYa4wt1NqS2pPpx1V040pbS6c9e0hr
         VTiqYQ8uqKC9YD4hG7DSGm+lHXECuAoe8KJKcbeDvwEny/8FcAK5lLitV2zAaFE/W9hk
         JljI4T68WidSJ1j7tsg2skic3jVGkjMb1SVFX0JqBs50xwxq5jWkzuvmDlTfxpgLm66t
         9dPA==
X-Gm-Message-State: AD7BkJL/zMhpQ4Yr5s17xbKml8Kzc5nhheOn4J8vItn4fmMRKcZ2/HNuY70haZ7xlymZyQ==
X-Received: by 10.98.7.11 with SMTP id b11mr14220711pfd.38.1456793289334;
        Mon, 29 Feb 2016 16:48:09 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id s197sm40683975pfs.62.2016.02.29.16.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 16:48:08 -0800 (PST)
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v3 1/8] MIPS: Loongson: Add basic Loongson-1A CPU support
Date:   Tue,  1 Mar 2016 08:48:09 +0800
Message-Id: <1456793296-17120-2-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
Return-Path: <zhoubb.aaron@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

The Loongson 1A is similar with Loongson 1B, which is a 32-bit SoC.
It implements the MIPS32 release 2 instruction set.

They share the same PRID, so we rewrite the PRID_REV_LOONGSON1B to
PRID_REV_LOONGSON1A_1B, and use their CPU macros to distinguish.

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-type.h    | 3 ++-
 arch/mips/include/asm/cpu.h         | 2 +-
 arch/mips/kernel/cpu-probe.c        | 6 +++++-
 arch/mips/loongson32/Platform       | 1 +
 arch/mips/loongson32/common/setup.c | 6 +++++-
 arch/mips/mm/c-r4k.c                | 7 +++++++
 6 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index abee2bf..dd6bf46 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -24,7 +24,8 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_LOONGSON3:
 #endif
 
-#ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
+#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1A) || \
+    defined(CONFIG_SYS_HAS_CPU_LOONGSON1B)
 	case CPU_LOONGSON1:
 #endif
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 7bea0f3..0c02803 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -236,7 +236,7 @@
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
-#define PRID_REV_LOONGSON1B	0x0020
+#define PRID_REV_LOONGSON1A_1B	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 #define PRID_REV_LOONGSON3A	0x0005
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 9ad6157..012ff8c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1199,8 +1199,12 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_LOONGSON1;
 
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON1B:
+		case PRID_REV_LOONGSON1A_1B:
+#ifdef CONFIG_CPU_LOONGSON1A
+			__cpu_name[cpu] = "Loongson 1A";
+#else
 			__cpu_name[cpu] = "Loongson 1B";
+#endif
 			break;
 		}
 
diff --git a/arch/mips/loongson32/Platform b/arch/mips/loongson32/Platform
index ebb6dc2..e114c85 100644
--- a/arch/mips/loongson32/Platform
+++ b/arch/mips/loongson32/Platform
@@ -4,4 +4,5 @@ cflags-$(CONFIG_CPU_LOONGSON1)	+= \
 
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
+load-$(CONFIG_LOONGSON1_LS1A)		+= 0xffffffff80200000
 load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80100000
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 62f41af..c3d2036 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -21,8 +21,12 @@ const char *get_system_type(void)
 	unsigned int processor_id = (&current_cpu_data)->processor_id;
 
 	switch (processor_id & PRID_REV_MASK) {
-	case PRID_REV_LOONGSON1B:
+	case PRID_REV_LOONGSON1A_1B:
+#ifdef CONFIG_CPU_LOONGSON1A
+		return "LOONGSON LS1A";
+#else
 		return "LOONGSON LS1B";
+#endif
 	default:
 		return "LOONGSON (unknown)";
 	}
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index caac3d7..1ffeb46 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1289,6 +1289,13 @@ static void probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
 			break;
 		}
+	case CPU_LOONGSON1:
+		if ((read_c0_config7() & (1 << 16))) {
+			/* effectively physically indexed dcache,
+			   thus no virtual aliases. */
+			c->dcache.flags |= MIPS_CACHE_PINDEX;
+			break;
+		}
 	default:
 		if (has_74k_erratum || c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
-- 
1.9.1
