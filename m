Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2008 15:27:33 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57579 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S23792141AbYKTP0z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2008 15:26:55 +0000
Received: from localhost.localdomain (p2225-ipad206funabasi.chiba.ocn.ne.jp [222.145.76.225])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0F7A69E17; Fri, 21 Nov 2008 00:26:51 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, rtc-linux@googlegroups.com,
	a.zummo@towertech.it
Subject: [PATCH 4/4] TXx9: Add support for TX4939 internal RTC
Date:	Fri, 21 Nov 2008 00:26:55 +0900
Message-Id: <1227194815-16200-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21342
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
index 5eeefd1..af456c7 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -543,5 +543,6 @@ void tx4939_mtd_init(int ch);
 void tx4939_ata_init(void);
 void tx4939_ndfmc_init(unsigned int hold, unsigned int spw,
 		       unsigned char ch_mask, unsigned char wide_mask);
+void tx4939_rtc_init(void);
 
 #endif /* __ASM_TXX9_TX4939_H */
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index eb5ea88..ec56b91 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -452,6 +452,28 @@ void __init tx4939_ndfmc_init(unsigned int hold, unsigned int spw,
 	txx9_ndfmc_init(TX4939_NDFMC_REG & 0xfffffffffULL, &plat_data);
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
index e5d2b93..74839f2 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -340,6 +340,7 @@ static void __init rbtx4939_device_init(void)
 	rbtx4939_led_setup();
 	tx4939_wdt_init();
 	tx4939_ata_init();
+	tx4939_rtc_init();
 }
 
 static void __init rbtx4939_setup(void)
-- 
1.5.6.3
