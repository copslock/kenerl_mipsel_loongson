Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:30:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39527 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010992AbbARWaePybh8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:30:34 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B4CB4DA6BEDC;
        Sun, 18 Jan 2015 22:30:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:30:28 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:30:18 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/36] MIPS: jz4740: probe CPU interrupt controller via DT
Date:   Sun, 18 Jan 2015 14:27:15 -0800
Message-ID: <1421620067-23933-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Use the generic irqchip_init function to probe irqchip drivers using DT,
and add the appropriate node to the jz4740 devicetree in place of the
call to mips_cpu_irq_init.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/boot/dts/jz4740.dtsi | 7 +++++++
 arch/mips/jz4740/irq.c         | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
index c538691f..2d64765c 100644
--- a/arch/mips/boot/dts/jz4740.dtsi
+++ b/arch/mips/boot/dts/jz4740.dtsi
@@ -2,4 +2,11 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 	compatible = "ingenic,jz4740";
+
+	cpuintc: cpuintc@0 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
 };
diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 2531da1..9c94f7b 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/irqchip.h>
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -27,7 +28,6 @@
 
 #include <asm/io.h>
 #include <asm/mipsregs.h>
-#include <asm/irq_cpu.h>
 
 #include <asm/mach-jz4740/base.h>
 
@@ -81,7 +81,7 @@ void __init arch_init_irq(void)
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	mips_cpu_irq_init();
+	irqchip_init();
 
 	jz_intc_base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
 
-- 
2.2.1
