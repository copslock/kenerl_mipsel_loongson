Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:05:42 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42311 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012446AbaKBBE4w9Wep (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:04:56 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so9913375pab.5
        for <multiple recipients>; Sat, 01 Nov 2014 18:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=izItJW51Z7BKWslM+5YA+KMPIrRoT1DHntaHNDEfP2w=;
        b=UX/CguG5Bqo31wh5euE5dSvFcarJWKc8VpLUXBrawsczXO6FuzM7LTiHpnkyfbERT6
         xh3q6ZvH9k+YTVOq9y49eFLvTeZPXHkpDHAaTHZXbv/1nXyO10BSzX4cxF2/yEk7ZP75
         sNtaYLcjG67YsXD4HhRVTMS2kVFK82skwCR6D0znnn8dL7uJx9xhKlstSklcMiMlGW30
         /e0jhBgYclOHbHjsQnsx1MNey0RXZuB8gGijZWNkqFTgRYbbiTR9BvWc6e8Kld96gV0o
         m7az9TRoYr8Im0E1TYcP7cTU+7ov5wrDhe+A6q5J45P3G0ZpyicqrGBQzMPOhWqwBkZl
         sveA==
X-Received: by 10.70.61.68 with SMTP id n4mr34164607pdr.60.1414890290255;
        Sat, 01 Nov 2014 18:04:50 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.04.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:04:49 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 03/14] genirq: Generic chip: Allow irqchip drivers to override irq_reg_{readl,writel}
Date:   Sat,  1 Nov 2014 18:03:50 -0700
Message-Id: <1414890241-9938-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43825
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

Currently, these I/O accessors always assume little endian 32-bit
registers (readl/writel).  On some systems the IRQ registers need to be
accessed in BE mode or using 16-bit loads/stores, so we will provide a
way to override the default behavior.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/irq.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0743743..a514ef7 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/topology.h>
 #include <linux/wait.h>
+#include <linux/io.h>
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
@@ -709,6 +710,8 @@ struct irq_chip_type {
 struct irq_chip_generic {
 	raw_spinlock_t		lock;
 	void __iomem		*reg_base;
+	u32			(*reg_readl)(void __iomem *addr);
+	void			(*reg_writel)(u32 val, void __iomem *addr);
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
 	u32			mask_cache;
@@ -817,13 +820,19 @@ static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
 static inline void irq_reg_writel(struct irq_chip_generic *gc,
 				  u32 val, int reg_offset)
 {
-	writel(val, gc->reg_base + reg_offset);
+	if (gc->reg_writel)
+		gc->reg_writel(val, gc->reg_base + reg_offset);
+	else
+		writel(val, gc->reg_base + reg_offset);
 }
 
 static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 				int reg_offset)
 {
-	return readl(gc->reg_base + reg_offset);
+	if (gc->reg_readl)
+		return gc->reg_readl(gc->reg_base + reg_offset);
+	else
+		return readl(gc->reg_base + reg_offset);
 }
 
 #endif /* _LINUX_IRQ_H */
-- 
2.1.1
