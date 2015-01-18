Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:32:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28535 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010992AbbARWccPx2Kb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:32:32 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7AC6582A456C2;
        Sun, 18 Jan 2015 22:32:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:32:26 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:32:22 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/36] MIPS: jz4740: probe interrupt controller via DT
Date:   Sun, 18 Jan 2015 14:27:20 -0800
Message-ID: <1421620067-23933-10-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 45258
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

Add the appropriate DT node to probe the interrupt controller driver
using the devicetree, and remove the call to jz4740_intc_init.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/boot/dts/jz4740.dtsi | 11 +++++++++++
 arch/mips/jz4740/setup.c       |  2 --
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
index 2d64765c..3841024 100644
--- a/arch/mips/boot/dts/jz4740.dtsi
+++ b/arch/mips/boot/dts/jz4740.dtsi
@@ -9,4 +9,15 @@
 		interrupt-controller;
 		compatible = "mti,cpu-interrupt-controller";
 	};
+
+	intc: intc@10001000 {
+		compatible = "ingenic,jz4740-intc";
+		reg = <0x10001000 0x14>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <2>;
+	};
 };
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 4808730..8c08d7d 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -25,7 +25,6 @@
 #include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/irq.h>
 
 #include "reset.h"
 
@@ -84,5 +83,4 @@ const char *get_system_type(void)
 void __init arch_init_irq(void)
 {
 	irqchip_init();
-	jz4740_intc_init();
 }
-- 
2.2.1
