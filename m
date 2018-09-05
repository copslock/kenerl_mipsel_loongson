Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:37:37 +0200 (CEST)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:38087
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994615AbeIEJheeGUXC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:37:34 +0200
Received: by mail-pg1-x541.google.com with SMTP id t84-v6so1311343pgb.5;
        Wed, 05 Sep 2018 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B1Y2x31vcv1rhmmYvvN4BM+fm1p2xpjTFylke64qdL8=;
        b=tRNA/ODTykRcz85q1p6ZuP6t3tzUB2ldb0241F4QXbphQ1db76VE8k62on0zd7RZTn
         OMoLVQNtdypktXaYAw0AaoQoF7KHJ/I7PoyCRo1O3vT7Bln269D+aLPtqZK8OHR+uqVZ
         j7MR2FvQH5Oi9CtF1RqvTj3t1PunQ78h+HIXt3nu5TXIbT9d2PxL/NMjAoBjJ9ReAAj1
         9kFahb0WBjbTxzbstdmLtCFLLIOjHdmWuyMOlGaUosCK/zSmZ09rh8h/o9Yl8ZJgG+kx
         Rp6u/9wWqE+8G4ASmP0bIaTkAqNE9pnqjx/vPffHc/2oH66e79UvzJx35IJDsBPvI6uv
         gjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=B1Y2x31vcv1rhmmYvvN4BM+fm1p2xpjTFylke64qdL8=;
        b=FaZXkxZadoCzQss5uwGKScm9SMS8UoZ3R2EZdI6zqQ1bNlpg9QMd/txrrPgmtzH+Ru
         zwI6MPFHhOn2S1npONfJNN9vJy+AZr+KNTzkyQnpKi6ENgOAMOaqV+gEU3odF1yojFfD
         tBMK6qAoGrhssvqXBMZuGxVg/zJDitDcDjABT8JA2okN1TMOT04RnFYOigPg5ooyhbvc
         95KF2T30PdK/BYx+jtoXILAav5BlFf/gnbOMjC70DKFiGKmvUYF9WF0HdcxdWP+QfR9b
         0z7iToH8A7a7NLu4Jk17Z46WJmLK5P+RjdclKgtUcmEsD32ntpUxBjBMVFq7EhXjQkKs
         KTbw==
X-Gm-Message-State: APzg51DrHGybUY7/+C2hqOg6+QgjlTFVrBHLidROZhmd/o7hATTqMQ4Y
        EkjuHgkb6RRfKyRRTEgGnmJS//mzwN0=
X-Google-Smtp-Source: ANB0VdaRT2DERFNX/6ZOZck3qyjxtrj/YJdxxPsFDFtPqKcUuxMK679QTQgauRyLzwyMBgXC61q9AA==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr36540311pgc.48.1536140248359;
        Wed, 05 Sep 2018 02:37:28 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:37:27 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V4 09/10] MIPS: Loongson-3: Fix BRIDGE irq delivery problem
Date:   Wed,  5 Sep 2018 17:33:09 +0800
Message-Id: <1536139990-11665-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65947
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
---
 arch/mips/include/asm/mach-loongson64/irq.h |  2 +-
 arch/mips/loongson64/loongson-3/irq.c       | 13 +++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/include/asm/mach-loongson64/irq.h
index 3644b68..be9f727 100644
--- a/arch/mips/include/asm/mach-loongson64/irq.h
+++ b/arch/mips/include/asm/mach-loongson64/irq.h
@@ -10,7 +10,7 @@
 #define MIPS_CPU_IRQ_BASE 56
 
 #define LOONGSON_UART_IRQ   (MIPS_CPU_IRQ_BASE + 2) /* UART */
-#define LOONGSON_HT1_IRQ    (MIPS_CPU_IRQ_BASE + 3) /* HT1 */
+#define LOONGSON_BRIDGE_IRQ (MIPS_CPU_IRQ_BASE + 3) /* CASCADE */
 #define LOONGSON_TIMER_IRQ  (MIPS_CPU_IRQ_BASE + 7) /* CPU Timer */
 
 #define LOONGSON_HT1_CFG_BASE		loongson_sysconf.ht_control_base
diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 2e115ab..5605061 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -96,12 +96,6 @@ void mach_irq_dispatch(unsigned int pending)
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
 
@@ -147,11 +141,10 @@ void __init mach_init_irq(void)
 
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
2.7.0
