Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2018 04:42:40 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:34239
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991172AbeBEDmd1gghm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Feb 2018 04:42:33 +0100
Received: by mail-pl0-x242.google.com with SMTP id q17so8694621pll.1;
        Sun, 04 Feb 2018 19:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=X+Jr9F0bW81pmfLfVbLbs+3OZUzsr/JU83gBHHt5Xzc=;
        b=CvYdsLEhY0+6zeLM/YOh9591C4T9g/bQOAUM+qAHIRTRpwrnV09YEqdZBiCWuEtMDN
         pnNY2LjbI9a/rmuIyDg13v1PxpQaiJy9FR4EyzuiZ0Zddccq1Zh80RYCGYrrlJQhOrRC
         hGJrNMM8fWx2HR27Xb/tmQ5qn6ZjNNdA5vs3Fe89FlYA4YXyJkAF9p44fAwSYoLBzKOs
         jBrgi962NzML0AlL9NZb9RRExhcqr6Zl9q93r9L5k06wiqziDHhOSEXpqJY2LfQcsuA3
         MgvzzNs02j9drkvcso0sdj5BdXtHPDw4xEo9A0BjQXqbJ4DzoURxHDO9KZZ/E26fYncb
         kUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=X+Jr9F0bW81pmfLfVbLbs+3OZUzsr/JU83gBHHt5Xzc=;
        b=CHQU03Ou52+Ai/oCYDSJZTbcfgUgQMmLjnXOPF8eFOeJZHE+bYJULJICzobK8HiHoz
         5ccmvc+81tBG83tjGWk5+SvEwooP/s8fHRhVFvGj+9xf+X+3KBpubWlbEyD0CfDdz6+B
         A1N1QWk1xUTJ3FX5HwkXnaQWnIiikTlS5JZlGtY15jUJ+g8xkgnqtUd+VZLGJXmXNuTC
         M3PwiqXPx2f2unQPcun8kqkMbJ9fCWvTiUxBFK+bvn6k94f9NfUu5s/3kV3sqvIKKs5I
         wxVocDm+iwfrc6nq7xAND90YenR3Oo438IYWW0zQmyR49yM/xvS+YvF63p6j/6InXztq
         3UFA==
X-Gm-Message-State: AKwxyteMce3N/bMEZ2z/quEimXod9HcmhscR2fhRUYgd4Msen9P7EEeR
        uPyZcdozNQYDEekpGX9ZL/tRrA==
X-Google-Smtp-Source: AH8x227hEyE+XXnOvYK70SFfZB413OHMT127k0YBSUyfdUbAo2+AU1bMssu0qA6HtTTfOW0qsHiuPw==
X-Received: by 2002:a17:902:b20b:: with SMTP id t11-v6mr11758851plr.348.1517802146692;
        Sun, 04 Feb 2018 19:42:26 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g63sm4633610pfg.17.2018.02.04.19.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Feb 2018 19:42:25 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix arch_trigger_cpumask_backtrace()
Date:   Mon,  5 Feb 2018 11:42:47 +0800
Message-Id: <1517802167-20340-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62438
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

SysRq-L and RCU stall detector call arch_trigger_cpumask_backtrace() to
trigger other CPU's backtrace, but its behavior is totally broken. The
root cause is arch_trigger_cpumask_backtrace() use call-function IPI in
irq context, which trigger deadlocks in smp_call_function_single() and
smp_call_function_many().

This patch fix arch_trigger_cpumask_backtrace() by:
1, Use a dedecated IPI (SMP_CPU_BACKTRACE) to trigger backtraces;
2, If myself is in target cpumask, do backtrace and clear myself;
3, Use a spinlock to avoid parallel backtrace output;
4, Handle SMP_CPU_BACKTRACE IPI for Loongson-3.

I have attempted to implement SMP_CPU_BACKTRACE for all MIPS CPUs, but I
failed because some of their IPIs are not extensible. :(

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/smp.h           |  3 +++
 arch/mips/kernel/process.c            | 23 ++++++++++++++++++-----
 arch/mips/loongson64/loongson-3/smp.c |  6 ++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 88ebd83..b0521f4 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -43,6 +43,7 @@ extern int __cpu_logical_map[NR_CPUS];
 /* Octeon - Tell another core to flush its icache */
 #define SMP_ICACHE_FLUSH	0x4
 #define SMP_ASK_C0COUNT		0x8
+#define SMP_CPU_BACKTRACE	0x10
 
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
@@ -81,6 +82,8 @@ static inline void __cpu_die(unsigned int cpu)
 extern void play_dead(void);
 #endif
 
+void arch_dump_stack(void);
+
 /*
  * This function will set up the necessary IPIs for Linux to communicate
  * with the CPUs in mask.
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 57028d4..647e15d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -655,26 +655,39 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ALMASK;
 }
 
-static void arch_dump_stack(void *info)
+void arch_dump_stack(void)
 {
 	struct pt_regs *regs;
+	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
 
+	arch_spin_lock(&lock);
 	regs = get_irq_regs();
 
 	if (regs)
 		show_regs(regs);
 
 	dump_stack();
+	arch_spin_unlock(&lock);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
 	long this_cpu = get_cpu();
+	struct cpumask backtrace_mask;
+	extern const struct plat_smp_ops *mp_ops;
+
+	cpumask_copy(&backtrace_mask, mask);
+	if (cpumask_test_cpu(this_cpu, mask)) {
+		if (!exclude_self) {
+			struct pt_regs *regs = get_irq_regs();
+			if (regs)
+				show_regs(regs);
+			dump_stack();
+		}
+		cpumask_clear_cpu(this_cpu, &backtrace_mask);
+	}
 
-	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
-		dump_stack();
-
-	smp_call_function_many(mask, arch_dump_stack, NULL, 1);
+	mp_ops->send_ipi_mask(&backtrace_mask, SMP_CPU_BACKTRACE);
 
 	put_cpu();
 }
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 8501109..0655114 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -291,6 +291,12 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 		__wbflush(); /* Let others see the result ASAP */
 	}
 
+	if (action & SMP_CPU_BACKTRACE) {
+		irq_enter();
+		arch_dump_stack();
+		irq_exit();
+	}
+
 	if (irqs) {
 		int irq;
 		while ((irq = ffs(irqs))) {
-- 
2.7.0
