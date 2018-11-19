Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 18:01:21 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994783AbeKSRBGbA6GK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Nov 2018 18:01:06 +0100
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E375622353;
        Mon, 19 Nov 2018 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646865;
        bh=gIXLsj21ktHFZcioVfzvXisGqKPQ1v2Iu0zsKUNAErA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWQC7g+hfldsj47iLmxzttR9xscEm3I5n97IvP/7XhfCrO/Z6P88atKrT+XDyakcy
         Ws1gfGIUzlZeBcs0b0KpX7JH1XFJ4g5U67/AZ2H3G9bR2w66D8eJK9ST7Nd1WPNIyh
         /3mAULfNhQAm8GYSLd9S/mt07ZYRho9jH9N1dgb0=
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
Subject: [PATCH 4.4 121/160] MIPS: Loongson-3: Fix BRIDGE irq delivery problem
Date:   Mon, 19 Nov 2018 17:29:20 +0100
Message-Id: <20181119162642.345044623@linuxfoundation.org>
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
X-archive-position: 67376
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

[ Upstream commit 360fe725f8849aaddc53475fef5d4a0c439b05ae ]

After commit e509bd7da149dc349160 ("genirq: Allow migration of chained
interrupts by installing default action") Loongson-3 fails at here:

setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);

This is because both chained_action and cascade_irqaction don't have
IRQF_SHARED flag. This will cause Loongson-3 resume fails because HPET
timer interrupt can't be delivered during S3. So we set the irqchip of
the chained irq to loongson_irq_chip which doesn't disable the chained
irq in CP0.Status.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20434/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mach-loongson64/irq.h |  2 +-
 arch/mips/loongson64/loongson-3/irq.c       | 13 +++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/include/asm/mach-loongson64/irq.h
index d18c45c7c394..19ff9ce46c02 100644
--- a/arch/mips/include/asm/mach-loongson64/irq.h
+++ b/arch/mips/include/asm/mach-loongson64/irq.h
@@ -9,7 +9,7 @@
 #define MIPS_CPU_IRQ_BASE 56
 
 #define LOONGSON_UART_IRQ   (MIPS_CPU_IRQ_BASE + 2) /* UART */
-#define LOONGSON_HT1_IRQ    (MIPS_CPU_IRQ_BASE + 3) /* HT1 */
+#define LOONGSON_BRIDGE_IRQ (MIPS_CPU_IRQ_BASE + 3) /* CASCADE */
 #define LOONGSON_TIMER_IRQ  (MIPS_CPU_IRQ_BASE + 7) /* CPU Timer */
 
 #define LOONGSON_HT1_CFG_BASE		loongson_sysconf.ht_control_base
diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 53424f2a53f3..241cb88f9c03 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -42,12 +42,6 @@ void mach_irq_dispatch(unsigned int pending)
 	}
 }
 
-static struct irqaction cascade_irqaction = {
-	.handler = no_action,
-	.flags = IRQF_NO_SUSPEND,
-	.name = "cascade",
-};
-
 static inline void mask_loongson_irq(struct irq_data *d) { }
 static inline void unmask_loongson_irq(struct irq_data *d) { }
 
@@ -88,11 +82,10 @@ void __init mach_init_irq(void)
 	init_i8259_irqs();
 	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
 			&loongson_irq_chip, handle_percpu_irq);
+	irq_set_chip_and_handler(LOONGSON_BRIDGE_IRQ,
+			&loongson_irq_chip, handle_percpu_irq);
 
-	/* setup HT1 irq */
-	setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);
-
-	set_c0_status(STATUSF_IP2 | STATUSF_IP6);
+	set_c0_status(STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP6);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.17.1
