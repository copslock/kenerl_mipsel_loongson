Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:08:17 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39641 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012459AbaKBBFL0PR9c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:05:11 +0100
Received: by mail-pa0-f49.google.com with SMTP id lj1so9862513pab.8
        for <multiple recipients>; Sat, 01 Nov 2014 18:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q9A+KOKRVnsIdnf9T9VJNXBBWPoqysk2/kaR6xWpve4=;
        b=Ju8g7FXotGA4Wy7q/Ni0mv0xfB1Ic0nyqglMACsnKyRoHMPohpOW8I1fo7C5pp+eXw
         TU5IF0fSioEiYJm34dOGFrAdOdEZ4T/nR1lc2EW3SQ2tIc+9oTla1emSwIQJ9hezcL5r
         0FY9Do9cLk8gHxwZKr0k/d+ZroTItN2Hh6DYJdQD81ySs6970qc8uSjUun6NNxfCLwtR
         6eOQTAklmIzJHnvVJAKgryVxeY1dKRX8i0n4C2LM3dFcllHeon4IoXLaSxy8q6xYlF8J
         THB0RODH8OeA2240d+I5Vjb3GnIP7qbViPKSgGCno/aAYQFcOKi8hD4oPJ5uFgN3Tfg0
         mqCg==
X-Received: by 10.66.147.227 with SMTP id tn3mr13597pab.108.1414890305144;
        Sat, 01 Nov 2014 18:05:05 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.05.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:05:04 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 12/14] irqchip: bcm7120-l2: Decouple driver from brcmstb-l2
Date:   Sat,  1 Nov 2014 18:03:59 -0700
Message-Id: <1414890241-9938-13-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43834
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
