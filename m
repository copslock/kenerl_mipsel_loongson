Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:52:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45236 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992100AbcIBPvqtX-9A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:51:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AB98FAE82A4C5;
        Fri,  2 Sep 2016 16:51:27 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:51:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 07/12] MIPS: Malta: Probe RTC via DT
Date:   Fri, 2 Sep 2016 16:48:53 +0100
Message-ID: <20160902154859.24269-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160902154859.24269-1-paul.burton@imgtec.com>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55011
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

Add the DT node required to probe the RTC, and remove the platform code
that was previously doing it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/boot/dts/mti/malta.dts     | 15 +++++++++++++++
 arch/mips/mti-malta/malta-platform.c | 21 ---------------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index af765af..ee43296 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -49,4 +49,19 @@
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	isa {
+		compatible = "isa";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <1 0 0 0x1000>;
+
+		rtc: mc146818@70 {
+			compatible = "motorola,mc146818";
+			reg = <1 0x70 0x8>;
+
+			interrupt-parent = <&i8259>;
+			interrupts = <8>;
+		};
+	};
 };
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index e1dd1c1..6433a39 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -23,7 +23,6 @@
  */
 #include <linux/init.h>
 #include <linux/serial_8250.h>
-#include <linux/mc146818rtc.h>
 #include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/mtd/partitions.h>
@@ -68,25 +67,6 @@ static struct platform_device malta_uart8250_device = {
 	},
 };
 
-struct resource malta_rtc_resources[] = {
-	{
-		.start	= RTC_PORT(0),
-		.end	= RTC_PORT(7),
-		.flags	= IORESOURCE_IO,
-	}, {
-		.start	= RTC_IRQ,
-		.end	= RTC_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device malta_rtc_device = {
-	.name		= "rtc_cmos",
-	.id		= -1,
-	.resource	= malta_rtc_resources,
-	.num_resources	= ARRAY_SIZE(malta_rtc_resources),
-};
-
 static struct mtd_partition malta_mtd_partitions[] = {
 	{
 		.name =		"YAMON",
@@ -129,7 +109,6 @@ static struct platform_device malta_flash_device = {
 
 static struct platform_device *malta_devices[] __initdata = {
 	&malta_uart8250_device,
-	&malta_rtc_device,
 	&malta_flash_device,
 };
 
-- 
2.9.3
