Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2014 10:01:05 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:41528 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007575AbaIMIAswnfHw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Sep 2014 10:00:48 +0200
Received: by mail-pd0-f175.google.com with SMTP id z10so2772388pdj.20
        for <multiple recipients>; Sat, 13 Sep 2014 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aVCQzbaayVc23UUblmKCtgFZGZ5wsr/0hJ4hWJKCnpU=;
        b=LJM5Nc8bl+PurV0wNG+e3cGwXxRj3cfQUsJfNtGocweVXdHvQconHoFHLhV5ELOwg/
         jwaoZRBwKA0SUPS5e7jrbUKIk3xpkls8Fc18XrDhggPZbIgqnxCPRFLXlO/03/syN3xd
         FLhkCFE8gqr4wSUxNacTVbENoji8MsPomBLH1RFy78TSfkuVtPyRHVj5mYfV7C1c2QcN
         9MCbZnZ0/MFwfpw95Q2SYEOr+lkyBk+u4rZ6jQqQJpxLR2c+V1iJigb+/lzpa+h0LXzd
         10ybAgTGJPyktP0JcIS3eAc19zUa9lJUdmkmycYq2yQsrwiCn6MXx3PR8xiumqnQhpxb
         fQuA==
X-Received: by 10.70.138.102 with SMTP id qp6mr21875733pdb.127.1410595242799;
        Sat, 13 Sep 2014 01:00:42 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id wh10sm6062397pac.20.2014.09.13.01.00.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 01:00:42 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 01/11] MIPS: Loongson: set Loongson-3's ISA level to MIPS64R1
Date:   Sat, 13 Sep 2014 15:59:59 +0800
Message-Id: <1410595207-10994-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1410595207-10994-1-git-send-email-chenhc@lemote.com>
References: <1410595207-10994-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42529
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
index 08dc945..d5a4f38 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -757,26 +757,29 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
