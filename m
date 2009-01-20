Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2009 14:07:42 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:13523 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21365133AbZATOHj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2009 14:07:39 +0000
Received: from localhost.localdomain (p1210-ipad205funabasi.chiba.ocn.ne.jp [222.146.96.210])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 65E94A108; Tue, 20 Jan 2009 23:07:34 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: Add support for TX4939 internal RTC
Date:	Tue, 20 Jan 2009 23:07:41 +0900
Message-Id: <1232460461-4325-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add platform support to use rtc-tx4939 driver.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/txx9/tx4939.h   |    1 +
 arch/mips/txx9/generic/setup_tx4939.c |   22 ++++++++++++++++++++++
 arch/mips/txx9/rbtx4939/setup.c       |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/txx9/tx4939.h b/arch/mips/include/asm/txx9/tx4939.h
index 88badb4..964ef7e 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -541,5 +541,6 @@ void tx4939_irq_init(void);
 int tx4939_irq(void);
 void tx4939_mtd_init(int ch);
 void tx4939_ata_init(void);
+void tx4939_rtc_init(void);
 
 #endif /* __ASM_TXX9_TX4939_H */
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index 6c0049a..5544096 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -435,6 +435,28 @@ void __init tx4939_ata_init(void)
 		platform_device_register(&ata1_dev);
 }
 
+void __init tx4939_rtc_init(void)
+{
+	static struct resource res[] = {
+		{
+			.start = TX4939_RTC_REG & 0xfffffffffULL,
+			.end = (TX4939_RTC_REG & 0xfffffffffULL) + 0x100 - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = TXX9_IRQ_BASE + TX4939_IR_RTC,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	static struct platform_device rtc_dev = {
+		.name = "tx4939rtc",
+		.id = -1,
+		.num_resources = ARRAY_SIZE(res),
+		.resource = res,
+	};
+
+	platform_device_register(&rtc_dev);
+}
+
 static void __init tx4939_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 98fbd93..656603b 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -336,6 +336,7 @@ static void __init rbtx4939_device_init(void)
 	rbtx4939_led_setup();
 	tx4939_wdt_init();
 	tx4939_ata_init();
+	tx4939_rtc_init();
 }
 
 static void __init rbtx4939_setup(void)
-- 
1.5.6.3
