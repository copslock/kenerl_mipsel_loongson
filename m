Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:48:36 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:55598 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012053AbaKGGpZjD553 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:25 +0100
Received: by mail-pd0-f174.google.com with SMTP id p10so2729908pdj.19
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q9A+KOKRVnsIdnf9T9VJNXBBWPoqysk2/kaR6xWpve4=;
        b=ITQVHXp1ihOzw/sQf8qNTQKOWtMKc/H+n7NpCOYHe/ls64xvIvL11tNcX33xjd3Sg7
         xd6IJpJTasjaAOF723C98e9TZAxfYq6fWIwgrf4wHL8mv3ZdH3pHeiZyFxfdWyGzuJTc
         FWc3TJROaVlkpP/+85aRW2zIn3Lqq6ng2f6sLwJF8RefNTKNbm8I4lFWowmUycxzuk8s
         JugJ6EW0gaWm6jyB2y5CuapxJ1gDfHvuNmCXEbdFITNhyU2VZ9KDaItOznZePWHsoL0K
         XOpOnIBVN6Aj8yLAFlW3+vu514HhqWtX3DscruP4/eZ2iwZU+RQz3jsNSMvp4S+bQRpR
         3qbA==
X-Received: by 10.68.225.99 with SMTP id rj3mr1971729pbc.97.1415342720015;
        Thu, 06 Nov 2014 22:45:20 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:19 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 12/14] irqchip: bcm7120-l2: Decouple driver from brcmstb-l2
Date:   Thu,  6 Nov 2014 22:44:27 -0800
Message-Id: <1415342669-30640-13-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43905
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

Some chips, such as BCM6328, only require bcm7120-l2.  Some BCM7xxx STB
configurations only require brcmstb-l2.  Treat them as two separate
entities, and update the mach-bcm dependencies to reflect the change.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig        | 1 +
 drivers/irqchip/Kconfig          | 5 +++++
 drivers/irqchip/Makefile         | 4 ++--
 drivers/irqchip/irq-bcm7120-l2.c | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 2abad74..bf47eb0 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -125,6 +125,7 @@ config ARCH_BRCMSTB
 	select HAVE_ARM_ARCH_TIMER
 	select BRCMSTB_GISB_ARB
 	select BRCMSTB_L2_IRQ
+	select BCM7120_L2_IRQ
 	help
 	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
 	  chipset.
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 09c79d1..afdc1f3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -48,6 +48,11 @@ config ATMEL_AIC5_IRQ
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
+config BCM7120_L2_IRQ
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config BRCMSTB_L2_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 173bb5f..f0909d0 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -35,6 +35,6 @@ obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
 obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
 obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
-obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o \
-					   irq-bcm7120-l2.o
+obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
+obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index ef4d32c..e53a3a6 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -247,5 +247,5 @@ out_unmap:
 	kfree(data);
 	return ret;
 }
-IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,bcm7120-l2-intc",
+IRQCHIP_DECLARE(bcm7120_l2_intc, "brcm,bcm7120-l2-intc",
 		bcm7120_l2_intc_of_init);
-- 
2.1.1
