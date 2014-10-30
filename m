Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:21:49 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36466 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012252AbaJ3CTyO9OiP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:19:54 +0100
Received: by mail-pd0-f180.google.com with SMTP id ft15so4161835pdb.39
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BNnHRGvYCUH/gimfrF4QFQtWfF183biQfiH+jgORJdo=;
        b=OFQWOcqePJI7p36WHQpL+eefQg6wFLFWCIZEEBiLXFlvJDLTv8b5rn6JPXL+b3ChPt
         mQ76Pio6x4vPHoEGrSiA5CAN2p+F++Akl9IbcLPiy7vfaGNBg3bUY67dqTeWjn/x8Jft
         sQJZH2tT6E21hQfg0L401Dqc8lXydqcEJ0tfwHV/xIg5bb08y+WdZrYiespT3vGBXtCZ
         3ylwue0j8h8yw07zigF25/PJXo3jTjA1ARiZqpZqUD6VpmWEWlkYirnyTrlFMe9IEq/e
         UtcUbFA7JwBuuocwm2Sm0jORRcYG3pDtjUF+N0YtbBycGQ9WwEp1LJxXRNhQeXzufk1d
         qkoQ==
X-Received: by 10.66.191.135 with SMTP id gy7mr13987590pac.95.1414635587480;
        Wed, 29 Oct 2014 19:19:47 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:46 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 06/15] genirq: Generic chip: Optimize for fixed-endian systems
Date:   Wed, 29 Oct 2014 19:17:59 -0700
Message-Id: <1414635488-14137-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43745
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

Allow the compiler to inline an LE MMIO access if the configuration only
supports LE registers, or a BE MMIO access if the configuration only
supports BE registers.  If the configuration supports both (possibly
a multiplatform kernel) then make the decision at runtime.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 kernel/irq/Kconfig        |  5 +++++
 kernel/irq/Makefile       |  1 +
 kernel/irq/generic-chip.c | 10 +++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 225086b..6283c8c 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -51,6 +51,11 @@ config GENERIC_IRQ_CHIP
        bool
        select IRQ_DOMAIN
 
+# Same as above, but use big-endian MMIO accesses
+config GENERIC_IRQ_CHIP_BE
+       bool
+       select IRQ_DOMAIN
+
 # Generic irq_domain hw <--> linux irq number translation
 config IRQ_DOMAIN
 	bool
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index fff1738..34c2b0f 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -1,6 +1,7 @@
 
 obj-y := irqdesc.o handle.o manage.o spurious.o resend.o chip.o dummychip.o devres.o
 obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
+obj-$(CONFIG_GENERIC_IRQ_CHIP_BE) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
 obj-$(CONFIG_PROC_FS) += proc.o
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index c1890bb..457ea48 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
+#include <linux/kconfig.h>
 #include <linux/kernel_stat.h>
 #include <linux/syscore_ops.h>
 
@@ -19,7 +20,14 @@ static DEFINE_RAW_SPINLOCK(gc_lock);
 
 static int is_big_endian(struct irq_chip_generic *gc)
 {
-	return !!(gc->domain->gc->gc_flags & IRQ_GC_BE_IO);
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP) &&
+	    !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE))
+		return 0;
+	else if (IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP_BE) &&
+		 !IS_ENABLED(CONFIG_GENERIC_IRQ_CHIP))
+		return 1;
+	else
+		return !!(gc->domain->gc->gc_flags & IRQ_GC_BE_IO);
 }
 
 static void irq_reg_writel(struct irq_chip_generic *gc,
-- 
2.1.1
