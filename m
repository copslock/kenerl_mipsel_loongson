Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 04:59:15 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43215 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011152AbaJ2D7MglTBE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 04:59:12 +0100
Received: by mail-pd0-f180.google.com with SMTP id ft15so2104020pdb.25
        for <multiple recipients>; Tue, 28 Oct 2014 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RtYVMSsmC5uHZGXP5rJemGxZYIZ3yfwE274V4LCtoaA=;
        b=RN81wLq4QCOgeGLcJHsfHVlg4PjVpxts7rVaMspCkYdFk25E545vnJfMybw8jCqKO+
         0eDCMYhBJlvgaToVt01i9XA/f0sVzbDTvRV2dlJ4B8kE12Hv6qlG+/C6wBnZ/DUNBAOv
         yR+4HwWagGxPTEroGKEoJ3FHe9UD+jlJ/5u20Zjvf6zKwTVO5eiV+R8R2cx58OVnZXNa
         e6AY5DYRIL8rkqxi3MmAFLy5SwL99hMyu7PS7nmlpVzU5uFFGb99MvA6ZA/LBc7Lck8M
         dZOJzmhm9DDt5k0TvYyfrvYwHGpPTIO5kHRv5RL378xsVoZu02luv6Urkwi27gox3JJ1
         GYNw==
X-Received: by 10.68.215.2 with SMTP id oe2mr7909669pbc.94.1414555146189;
        Tue, 28 Oct 2014 20:59:06 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id kj9sm2946249pbc.37.2014.10.28.20.59.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 20:59:05 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 01/11] irqchip: Allow irq_reg_{readl,writel} to use __raw_{readl_writel}
Date:   Tue, 28 Oct 2014 20:58:48 -0700
Message-Id: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43671
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

On big-endian systems readl/writel may perform an unwanted endian swap,
breaking generic-chip.c.  Let the platform code opt to use the __raw_
variants by selecting RAW_IRQ_ACCESSORS.

This is required in order for bcm3384 to use GENERIC_IRQ_CHIP.  Several
existing irqchip drivers also use the __raw_ accessors directly, so it
is a reasonably common requirement.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/Kconfig |  3 +++
 include/linux/irq.h     | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b21f12f..6f0e80b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -2,6 +2,9 @@ config IRQCHIP
 	def_bool y
 	depends on OF_IRQ
 
+config RAW_IRQ_ACCESSORS
+	bool
+
 config ARM_GIC
 	bool
 	select IRQ_DOMAIN
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 03f48d9..ed1ea8a 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -639,6 +639,17 @@ void arch_teardown_hwirq(unsigned int irq);
 void irq_init_desc(unsigned int irq);
 #endif
 
+#ifdef CONFIG_RAW_IRQ_ACCESSORS
+
+#ifndef irq_reg_writel
+# define irq_reg_writel(val, addr)	__raw_writel(val, addr)
+#endif
+#ifndef irq_reg_readl
+# define irq_reg_readl(addr)		__raw_readl(addr)
+#endif
+
+#else
+
 #ifndef irq_reg_writel
 # define irq_reg_writel(val, addr)	writel(val, addr)
 #endif
@@ -646,6 +657,8 @@ void irq_init_desc(unsigned int irq);
 # define irq_reg_readl(addr)		readl(addr)
 #endif
 
+#endif
+
 /**
  * struct irq_chip_regs - register offsets for struct irq_gci
  * @enable:	Enable register offset to reg_base
-- 
2.1.1
