Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:45:59 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:56649 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012003AbaKGGpLYDmK2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:11 +0100
Received: by mail-pa0-f44.google.com with SMTP id bj1so2930462pad.17
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=okvmri9WgyYh8DxuzmceCInqS8kXUdSHxBmWDsr+hT4=;
        b=y/6tzymiI+wy+Smsv6fc6oSsn/i9FjeoS8JjuetUvsNDPNYqTedJ+4QCef491OQNWw
         kl9uzk0KTVC7FTyK8ZTRb8vLMa9IS8nLnvia2l69jafA0hffvGe9fiZHeaqvl28d966Z
         qKHDGNckWxgWXTXNIXPSDroEdDpY8wEQC8XstAx+4MakfrGCgisVBjVrWzqUSpgTkab5
         O7eif8FOXP+dUIPSOayftWDVlUNgkoPH1+wmfbWnAmeIlQtY9F4Ry+YEQMBoCium8f6A
         4IBrumtZ2p/sEajXXTo/U2T0VBGjE7NYL+zkib4e1WG2AWmzkle4R6xe1a7vzRj6ifIk
         Q3ng==
X-Received: by 10.68.136.226 with SMTP id qd2mr9937651pbb.55.1415342705479;
        Thu, 06 Nov 2014 22:45:05 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:04 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 03/14] genirq: Generic chip: Allow irqchip drivers to override irq_reg_{readl,writel}
Date:   Thu,  6 Nov 2014 22:44:18 -0800
Message-Id: <1415342669-30640-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43896
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
 include/linux/irq.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index ed1135d..0fecd95 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -686,6 +686,8 @@ struct irq_chip_type {
  * struct irq_chip_generic - Generic irq chip data structure
  * @lock:		Lock to protect register and cache data access
  * @reg_base:		Register base address (virtual)
+ * @reg_readl:		Alternate I/O accessor (defaults to readl if NULL)
+ * @reg_writel:		Alternate I/O accessor (defaults to writel if NULL)
  * @irq_base:		Interrupt base nr for this chip
  * @irq_cnt:		Number of interrupts handled by this chip
  * @mask_cache:		Cached mask register shared between all chip types
@@ -710,6 +712,8 @@ struct irq_chip_type {
 struct irq_chip_generic {
 	raw_spinlock_t		lock;
 	void __iomem		*reg_base;
+	u32			(*reg_readl)(void __iomem *addr);
+	void			(*reg_writel)(u32 val, void __iomem *addr);
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
 	u32			mask_cache;
@@ -818,13 +822,19 @@ static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
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
