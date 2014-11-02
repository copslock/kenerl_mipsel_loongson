Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:05:58 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:60838 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012447AbaKBBE6GOeah (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:04:58 +0100
Received: by mail-pa0-f50.google.com with SMTP id eu11so9993151pac.37
        for <multiple recipients>; Sat, 01 Nov 2014 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZhHD55oGQ1ShN5ff6/U+OGvZEYQ0qkso10MgrfY3tcg=;
        b=fzOWsz736+OtYMozvQI55u0f4UO/CEbmQk0Tw36yyTc7YJ7JFXA8xO2t4+vGYNXn2g
         ll6ao0Fp5+BRd6nYBS3XLh2qSEJ/n/oPfc7B6ZK/TW2MOMrb7pU+3Xkon4kcOgVqvyjT
         E/4HD0l8nLexxYABcqo7zMMhvcUeabBUnR0lZlRE1X8oihi+IWeghLRjdlNjbTSX18Rl
         5bK5Qh0lC8Xc1ZHOQv9Z/3nTokTDNQVJPAxkUDraFuEO/L1RmK1wAzpa/Jc35sMgoaoK
         uYvcNU6daiVBNYLrO/o/lmwu7Mv1krlbNOlZHs1b+9IgBeDyqYLqcmt5Tu+nZPS5sJFm
         G/PQ==
X-Received: by 10.70.5.130 with SMTP id s2mr1834594pds.17.1414890291884;
        Sat, 01 Nov 2014 18:04:51 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.04.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:04:51 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 04/14] genirq: Generic chip: Add big endian I/O accessors
Date:   Sat,  1 Nov 2014 18:03:51 -0700
Message-Id: <1414890241-9938-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Use io{read,write}32be if the caller specified IRQ_GC_BE_IO when creating
the irqchip.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/irq.h       |  1 +
 kernel/irq/generic-chip.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a514ef7..48b364e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -742,6 +742,7 @@ enum irq_gc_flags {
 	IRQ_GC_INIT_NESTED_LOCK		= 1 << 1,
 	IRQ_GC_MASK_CACHE_PER_TYPE	= 1 << 2,
 	IRQ_GC_NO_MASK			= 1 << 3,
+	IRQ_GC_BE_IO			= 1 << 4,
 };
 
 /*
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index db458c6..61024e8 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -191,6 +191,16 @@ int irq_gc_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+static u32 irq_readl_be(void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static void irq_writel_be(u32 val, void __iomem *addr)
+{
+	iowrite32be(val, addr);
+}
+
 static void
 irq_init_generic_chip(struct irq_chip_generic *gc, const char *name,
 		      int num_ct, unsigned int irq_base,
@@ -300,7 +310,13 @@ int irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 		dgc->gc[i] = gc = tmp;
 		irq_init_generic_chip(gc, name, num_ct, i * irqs_per_chip,
 				      NULL, handler);
+
 		gc->domain = d;
+		if (gcflags & IRQ_GC_BE_IO) {
+			gc->reg_readl = &irq_readl_be;
+			gc->reg_writel = &irq_writel_be;
+		}
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
-- 
2.1.1
