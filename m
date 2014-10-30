Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:21:30 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57914 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012251AbaJ3CTw2yLub (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:19:52 +0100
Received: by mail-pa0-f49.google.com with SMTP id lj1so4397194pab.22
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsNchyzaNDJuXuUA2FNPOTr0Sn6i8TWWlVg3gv+4o+U=;
        b=eZxy0lYBb74KbTdywmWveGjUFplRuiUPI/1HR82kGaOmqaKzxn2AmxUf9Un7WxGlQk
         fpz5g1IlJdl08hZT5NtLGUK8n4rIgwMDbPycxV8uZkEcjWMLkfcQkx1cekoyf4Fr1G3V
         EApnoxnEFvokmSYOiz9iYqEyRvaIw681r38qOc6mpJrKsUGqs1yw3t9ON47n0HLyQ8MM
         mVZjyNzrZe+q8tFCZApiGGBj5RXtTTXIJewK4ypWMEb5d6TvpmqHg3PizJe/ifc5b/IF
         s6UGYDLq00K7bAWlmYb3EQ8HPfaWSvyqYSwculpHhxMkNC5QAtre0d63WI8V7opfMOLU
         EDxQ==
X-Received: by 10.70.63.9 with SMTP id c9mr14362765pds.104.1414635585941;
        Wed, 29 Oct 2014 19:19:45 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:45 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 05/15] genirq: Generic chip: Add big endian I/O accessors
Date:   Wed, 29 Oct 2014 19:17:58 -0700
Message-Id: <1414635488-14137-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43744
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
 kernel/irq/generic-chip.c | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8049e93..e69b7b2 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -739,6 +739,7 @@ enum irq_gc_flags {
 	IRQ_GC_INIT_NESTED_LOCK		= 1 << 1,
 	IRQ_GC_MASK_CACHE_PER_TYPE	= 1 << 2,
 	IRQ_GC_NO_MASK			= 1 << 3,
+	IRQ_GC_BE_IO			= 1 << 4,
 };
 
 /*
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index b2ee65d..c1890bb 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -17,16 +17,27 @@
 static LIST_HEAD(gc_list);
 static DEFINE_RAW_SPINLOCK(gc_lock);
 
+static int is_big_endian(struct irq_chip_generic *gc)
+{
+	return !!(gc->domain->gc->gc_flags & IRQ_GC_BE_IO);
+}
+
 static void irq_reg_writel(struct irq_chip_generic *gc,
 			   u32 val, int reg_offset)
 {
-	writel(val, gc->reg_base + reg_offset);
+	if (is_big_endian(gc))
+		iowrite32be(val, gc->reg_base + reg_offset);
+	else
+		writel(val, gc->reg_base + reg_offset);
 }
 
 static u32 irq_reg_readl(struct irq_chip_generic *gc,
 			 int reg_offset)
 {
-	return readl(gc->reg_base + reg_offset);
+	if (is_big_endian(gc))
+		return ioread32be(gc->reg_base + reg_offset);
+	else
+		return readl(gc->reg_base + reg_offset);
 }
 
 /**
-- 
2.1.1
