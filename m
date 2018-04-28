Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:24:22 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:33740
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeD1DYP7f9XJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:24:15 +0200
Received: by mail-pg0-x241.google.com with SMTP id i194-v6so2838555pgd.0;
        Fri, 27 Apr 2018 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rbg58FiPT7h1d3gVNfzLxd9KRcAEkPNHB8fXpwcTiE8=;
        b=aKqnHdvuaj9eNcDypFJsq3I09vyzDHU24FwmGhC1n8XjjgaBsD59MevpbbVMEOdzSB
         hWalMUt5avNr6V3gsK860TCGjbf4spWl5qwiKmmyhCHeM1hc+5ee7B8Q2IdMWQ8U8KLC
         aWQX26Z7x9ZPRn6g04iJSkq4VOiFC1lGeORXrSG7OhCSqFX28bxA8J54lGgcsE3sqnRh
         j9UnO1PpJIXhgZyuYdVm6djSykCjuB8/Em0lAQbKTOgdpzxMZrTgQvKpaHn3ezzc7yuQ
         sLfM334zFokrt6yvrmdT8hsYBub6qdja6A+b7tirG25RAfNN6ZV51kilRW355QWvAK6P
         Y9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Rbg58FiPT7h1d3gVNfzLxd9KRcAEkPNHB8fXpwcTiE8=;
        b=QKYWW6Tc3WUiaVm8YgjBP1aF8nps3x4vw9LE4eMzFt/dKSqJ/mvJHRtpBklhdnZImz
         Spaetka7gJWXtBB9jjpngdQLbywUHJezYnfHPs+v/Nu5zSwF+PdtpFrejAp6qWJ7S04I
         /7ww2MQvJ0w9uqEnxjF38h+a/Xs8Vs0ZQNJXSLAsX9RWrQbTtxGy4INjM7R5OWVFGOiv
         KjOehsXBj//ezTz6yoi2RteqGZ2Hmxa6dRzFBcIaPY4ImRPIkVvI6QTJ3Jz1r06Fa5aI
         agUpTNrk3JyNmXEFyYewf/Q9+mwlP7bZqc1STgVURpmKONwGvfDfQE34hdWJFb5NzW6Z
         Pt4g==
X-Gm-Message-State: ALQs6tCcTXKzGjIyCfhUmPuD4DhLSDMrnWLMEwqdoDHlDBJxXeOc1XKe
        lfWh4B6jwOn1ccjjW6Dl8KkouQ==
X-Google-Smtp-Source: AB8JxZpbfmbumOkVHqWxkf012++W3GAJUtAjD3DsPjaEuYgAg2JX90bjZYftBJljDBQQpGX4crNR9A==
X-Received: by 10.98.21.73 with SMTP id 70mr4418853pfv.91.1524885849566;
        Fri, 27 Apr 2018 20:24:09 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:24:09 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V3 09/10] MIPS: Loongson-3: Fix CPU UART irq delivery problem
Date:   Sat, 28 Apr 2018 11:21:33 +0800
Message-Id: <1524885694-18132-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63827
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
 arch/mips/loongson64/loongson-3/irq.c | 41 ++---------------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index cbeb20f..e8381ec 100644
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
-- 
2.7.0
