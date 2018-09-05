Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:37:10 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:37863
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeIEJhBl6CuC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:37:01 +0200
Received: by mail-pf1-x443.google.com with SMTP id h69-v6so3194813pfd.4;
        Wed, 05 Sep 2018 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0bfcEAuBAdj0CTgb25vgXr+0MlZLbnVdhbv6VqKzRh4=;
        b=hoXf8mkfjIdnfSh7sL3CdIX6d8pkOvuohO7Vv89uJyCvpuThefkoEMNDXFbpompL5C
         1/BIMne6683RvYA3Q0F5rYX5z4jOkFYFr+mDciovGLQG80G2xZLg4I9VkzLdkcvzRch2
         C+838gFs4lu/rEWrqwrWwkfxfOcJBu36TV18mHHHXQMZAh8tyzfLguQVJ4gs8q1xvjjF
         05E0Q1j+aXQIR8e/LOUi+zu5K2+lyFiny8s/bFzqKt4ThyB0aVqxwPqY+OR1ysrtUXYP
         iYLFn8NgSBXw7QBURhEWHqnrOmB2OzCQP+lU5Y0g1wgF+mi444wG1Lw+O1mVEHLa3vai
         D26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0bfcEAuBAdj0CTgb25vgXr+0MlZLbnVdhbv6VqKzRh4=;
        b=BBqT+NqBfrO8Q6I3aNMI589t2zqrBdmXcf0h/xuexxj7T+KUo6ofDdnxrUJbbFrQLD
         AWPIz8olnltgMcLp65c9tyvk2YFv/BlzUJTVUSR0cpXXwUz67LNBZOc01h+RMBg/Fis4
         aD6r34Ld1+9pZDUip00w5fD/7KQdDNMHgKyhilI+3g8L/wSyU4cqX/o/wwmgm7U43cqu
         yOe3mQc8mfKzdojfE9+vwBsI6sHsCL3T5asayisS24FHDmGdL+WqZXcjQNuEQu8Nu9Uc
         qBDqHtzUDu76JvlWd0iDkGQc1At/fvbZ0hqmcGSs2Amx+GRPaN6UxAa9TGZ7/Ve11Z2K
         G1QA==
X-Gm-Message-State: APzg51CfHlgl7a4012M2yRafbfzse0R0tDzEfH1pvEaI6bC7TEBVAoEs
        bbkPDcFBuMIrWvMjNM9w+x/f90o75MM=
X-Google-Smtp-Source: ANB0VdaLeJlx0UMCh7cPX/79njRpIli88bE1+hQXmeXeq8XbGBWuszTYTS65ztu1jYT44rIXcnKhMA==
X-Received: by 2002:a63:2f45:: with SMTP id v66-v6mr34834594pgv.91.1536140214744;
        Wed, 05 Sep 2018 02:36:54 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:36:54 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V4 08/10] MIPS: Loongson-3: Fix CPU UART irq delivery problem
Date:   Wed,  5 Sep 2018 17:33:08 +0800
Message-Id: <1536139990-11665-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65946
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

Masking/unmasking the CPU UART irq in CP0_Status (and redirecting it to
other CPUs) may cause interrupts be lost, especially in multi-package
machines (Package-0's UART irq cannot be delivered to others). So make
mask_loongson_irq() and unmask_loongson_irq() be no-ops.

The original problem (UART IRQ may deliver to any core) is also because
of masking/unmasking the CPU UART irq in CP0_Status. So it is safe to
remove all of the stuff.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/loongson-3/irq.c | 43 +++--------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index cbeb20f..2e115ab 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -102,45 +102,8 @@ static struct irqaction cascade_irqaction = {
 	.name = "cascade",
 };
 
-static inline void mask_loongson_irq(struct irq_data *d)
-{
-	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
-	irq_disable_hazard();
-
-	/* Workaround: UART IRQ may deliver to any core */
-	if (d->irq == LOONGSON_UART_IRQ) {
-		int cpu = smp_processor_id();
-		int node_id = cpu_logical_map(cpu) / loongson_sysconf.cores_per_node;
-		int core_id = cpu_logical_map(cpu) % loongson_sysconf.cores_per_node;
-		u64 intenclr_addr = smp_group[node_id] |
-			(u64)(&LOONGSON_INT_ROUTER_INTENCLR);
-		u64 introuter_lpc_addr = smp_group[node_id] |
-			(u64)(&LOONGSON_INT_ROUTER_LPC);
-
-		*(volatile u32 *)intenclr_addr = 1 << 10;
-		*(volatile u8 *)introuter_lpc_addr = 0x10 + (1<<core_id);
-	}
-}
-
-static inline void unmask_loongson_irq(struct irq_data *d)
-{
-	/* Workaround: UART IRQ may deliver to any core */
-	if (d->irq == LOONGSON_UART_IRQ) {
-		int cpu = smp_processor_id();
-		int node_id = cpu_logical_map(cpu) / loongson_sysconf.cores_per_node;
-		int core_id = cpu_logical_map(cpu) % loongson_sysconf.cores_per_node;
-		u64 intenset_addr = smp_group[node_id] |
-			(u64)(&LOONGSON_INT_ROUTER_INTENSET);
-		u64 introuter_lpc_addr = smp_group[node_id] |
-			(u64)(&LOONGSON_INT_ROUTER_LPC);
-
-		*(volatile u32 *)intenset_addr = 1 << 10;
-		*(volatile u8 *)introuter_lpc_addr = 0x10 + (1<<core_id);
-	}
-
-	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
-	irq_enable_hazard();
-}
+static inline void mask_loongson_irq(struct irq_data *d) { }
+static inline void unmask_loongson_irq(struct irq_data *d) { }
 
  /* For MIPS IRQs which shared by all cores */
 static struct irq_chip loongson_irq_chip = {
@@ -183,7 +146,7 @@ void __init mach_init_irq(void)
 	chip->irq_set_affinity = plat_set_irq_affinity;
 
 	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
-			&loongson_irq_chip, handle_level_irq);
+			&loongson_irq_chip, handle_percpu_irq);
 
 	/* setup HT1 irq */
 	setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);
-- 
2.7.0
