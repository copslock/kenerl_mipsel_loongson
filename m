Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 18:01:13 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995040AbeKSRBEGwJAK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Nov 2018 18:01:04 +0100
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89418223C8;
        Mon, 19 Nov 2018 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646863;
        bh=OBjj70zlwThvv6xlsG4aUwxANvSM2KGvA+Olkvnyakw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nn8vJbgKQCIHU/r+4tnzU8zxgpnCHP/GQGK6ikOv92xYVOdOhQTkGjqoAANWBD54t
         INFGMI0vht17QgHoMLaprFxPikU3PrUIwDRkhEP12P9E8DZ3L3+ayWlAn8HMQ597QW
         tH/VZPyP+vrPFrg+8B98TLraZzQF3oWaiAdPvdgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 120/160] MIPS: Loongson-3: Fix CPU UART irq delivery problem
Date:   Mon, 19 Nov 2018 17:29:19 +0100
Message-Id: <20181119162642.272355917@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=OXTl=N6=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d06f8a2f1befb5a3d0aa660ab1c05e9b744456ea ]

Masking/unmasking the CPU UART irq in CP0_Status (and redirecting it to
other CPUs) may cause interrupts be lost, especially in multi-package
machines (Package-0's UART irq cannot be delivered to others). So make
mask_loongson_irq() and unmask_loongson_irq() be no-ops.

The original problem (UART IRQ may deliver to any core) is also because
of masking/unmasking the CPU UART irq in CP0_Status. So it is safe to
remove all of the stuff.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20433/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/loongson64/loongson-3/irq.c | 43 ++-------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 0f75b6b3d218..53424f2a53f3 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -48,45 +48,8 @@ static struct irqaction cascade_irqaction = {
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
@@ -124,7 +87,7 @@ void __init mach_init_irq(void)
 	mips_cpu_irq_init();
 	init_i8259_irqs();
 	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
-			&loongson_irq_chip, handle_level_irq);
+			&loongson_irq_chip, handle_percpu_irq);
 
 	/* setup HT1 irq */
 	setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);
-- 
2.17.1
