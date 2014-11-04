Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:14:28 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:50580 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011073AbaKDGOAx28dn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:14:00 +0100
Received: by mail-pd0-f178.google.com with SMTP id fp1so13001036pdb.37
        for <multiple recipients>; Mon, 03 Nov 2014 22:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tAUdeygn4PG2IyzWqp4l2XN8bC4WcUo9GquJsaColIM=;
        b=RqhINmJ16PYV+9LeUl+O5e26o4QvaZYTugu8X3BsfJFkuA7a/EaDly61R0LJuIg+vg
         RHNfkBd1VaEjSZD7XYSvX7xebR1GXJKgqQstawSZwuz8QYeW//hssGc80QF0+a4ewFBC
         6u9IhglM8g6trLOLy/4QdI0Vby/LWee9HZS7U1mm5OmhssCIPVnLu8wq0rfLWJcLm9CK
         Wu6itvcqjKYRE8MOrXYJTT9YRPmiT2zfzahVoXfEBBoe2Lq62ZPMuwJWUoI86RKBqRof
         NrmVgfBw3CDxFZNSeXy0l7u87XzV6ZN+LXdqpJuV5F2E0h4lHTXJRO+xc2vecFdVHw38
         t24Q==
X-Received: by 10.70.22.176 with SMTP id e16mr26905765pdf.89.1415081634794;
        Mon, 03 Nov 2014 22:13:54 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.13.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:13:54 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 02/12] MIPS: Loongson: set Loongson-3's ISA level to MIPS64R1
Date:   Tue,  4 Nov 2014 14:13:23 +0800
Message-Id: <1415081610-25639-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43851
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

In CPU manual Loongson-3 is MIPS64R2 compatible, but during tests we
found that its EI/DI instructions have problems. So we just set the ISA
level to MIPS64R1.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 .../asm/mach-loongson/cpu-feature-overrides.h      |    2 --
 arch/mips/kernel/cpu-probe.c                       |    5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index 7d28f95..6d69332 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -41,10 +41,8 @@
 #define cpu_has_mcheck		0
 #define cpu_has_mdmx		0
 #define cpu_has_mips16		0
-#define cpu_has_mips32r1	0
 #define cpu_has_mips32r2	0
 #define cpu_has_mips3d		0
-#define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 #define cpu_has_mipsmt		0
 #define cpu_has_prefetch	0
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 929e524..b27e7ff 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -817,26 +817,29 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			c->cputype = CPU_LOONGSON2;
 			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2e");
+			set_isa(c, MIPS_CPU_ISA_III);
 			break;
 		case PRID_REV_LOONGSON2F:
 			c->cputype = CPU_LOONGSON2;
 			__cpu_name[cpu] = "ICT Loongson-2";
 			set_elf_platform(cpu, "loongson2f");
+			set_isa(c, MIPS_CPU_ISA_III);
 			break;
 		case PRID_REV_LOONGSON3A:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
+			set_isa(c, MIPS_CPU_ISA_M64R1);
 			break;
 		case PRID_REV_LOONGSON3B_R1:
 		case PRID_REV_LOONGSON3B_R2:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3b");
+			set_isa(c, MIPS_CPU_ISA_M64R1);
 			break;
 		}
 
-		set_isa(c, MIPS_CPU_ISA_III);
 		c->options = R4K_OPTS |
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
 			     MIPS_CPU_32FPR;
-- 
1.7.7.3
