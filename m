Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:23:59 +0100 (CET)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:37650
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994583AbeA0DWtWC77B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:22:49 +0100
Received: by mail-pf0-x242.google.com with SMTP id p1so1457039pfh.4;
        Fri, 26 Jan 2018 19:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0U3odrX4bz/fYWV0X16IrOzQmMdtZIUQA27DQT/89yI=;
        b=YRPREv1DzqIB74+Ylt1AEXiKh/F+N9I3fZdK3ovPgZLrmiS8jQpzxrIQ07QLXoAFyw
         Ztkmux2U8ECsjN7tR1y7uN4VnHmjyHQIYwz6jvzmpe5nw+LGS1PmVzDvGRhKkTejpImN
         4ay4+a1fiBqv99yAxgeqXngKxd4V5ffajWYGWK455kPpULEJeswpsBiHTIjMrkTs1RxJ
         TW2nkVyL7aSgdKu2VB+aTO8R64F56jp73XNhDBrUVgWVz/VyjjKKoNF7NGCbKk23/6dG
         W66ox678XhMFtgCRPLZXR248ZUHk89zC0U2pnU9iIsmNrO++Mf+xcFR+3y1oXxYg4Ae2
         Jc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0U3odrX4bz/fYWV0X16IrOzQmMdtZIUQA27DQT/89yI=;
        b=kf9/Hv8mE2r3vo5Js57DFIdfe+qLRzpwcKUYo4rk7yCXF0wfmyrBU3no/uZikNgKjc
         vnpjXYq9o29fr2HV7Z9y/EwlQBquRaiQqsY26YxR7gwkq8EWj2sl2cIkYflFDDC/CMrQ
         GUka7Y4jEqatK/y6W2WJ8NujIzW9HtbPwIlnYS5uhQ8VsIF51EUGNKPFLNnvPXPB10L9
         tM2skovnJDcYP3uE0zikTtMbaN1RotXgonRhZwmiJp3GpxGFu4s0ytoMi0ZWiMtFSyl5
         1KjQq6x1mccC303AVYKM5krLAuxsu8CYCHMHSH4DFC0Ev/NB8PNrvRECPy6gaR8GyZP7
         6h5Q==
X-Gm-Message-State: AKwxytcWjZRBLRSCmZovcQX1kTVx15WEMaInbWqZBuhdEgdDmkftihxK
        irURIKkzJ3a1St6PZpGgtPDUuA==
X-Google-Smtp-Source: AH8x224YEY1E9qLksxHWmgWrFH4tQKgWbwyHzTbrMji5+ibl+IpiHS0i8dlNbylCMt7oDi3vdBeNJg==
X-Received: by 10.101.80.7 with SMTP id f7mr154983pgo.35.1517023361761;
        Fri, 26 Jan 2018 19:22:41 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id r13sm8821174pgt.27.2018.01.26.19.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:22:41 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2 11/12] MIPS: Loongson-3: Fix CPU UART irq delivery problem
Date:   Sat, 27 Jan 2018 11:23:00 +0800
Message-Id: <1517023381-17624-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517023381-17624-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62354
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
