Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 16:02:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:65375 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20024052AbZEZPC0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 May 2009 16:02:26 +0100
Received: from localhost.localdomain (p1252-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.252])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6DEB2ADD2; Wed, 27 May 2009 00:02:21 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] TXx9: Add TX4939 RNG support
Date:	Wed, 27 May 2009 00:02:21 +0900
Message-Id: <1243350141-883-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add platform support for RNG of TX4939 SoC.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/txx9/tx4939.h   |    1 +
 arch/mips/txx9/generic/setup_tx4939.c |   18 ++++++++++++++++++
 arch/mips/txx9/rbtx4939/setup.c       |    1 +
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/txx9/tx4939.h b/arch/mips/include/asm/txx9/tx4939.h
index 050364d..3451499 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -547,5 +547,6 @@ void tx4939_ndfmc_init(unsigned int hold, unsigned int spw,
 void tx4939_dmac_init(int memcpy_chan0, int memcpy_chan1);
 void tx4939_aclc_init(void);
 void tx4939_sramc_init(void);
+void tx4939_rng_init(void);
 
 #endif /* __ASM_TXX9_TX4939_H */
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index df13a89..4b7293c 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -500,6 +500,24 @@ void __init tx4939_sramc_init(void)
 		txx9_sramc_init(&tx4939_sram_resource);
 }
 
+#define TX4939_RNG_REG	((TX4939_CRYPTO_REG & 0xfffffffffULL) + 0xb0)
+void __init tx4939_rng_init(void)
+{
+	static struct resource res = {
+		.start = TX4939_RNG_REG,
+		.end = TX4939_RNG_REG + 0x30 - 1,
+		.flags = IORESOURCE_MEM,
+	};
+	static struct platform_device pdev = {
+		.name = "tx4939-rng",
+		.id = -1,
+		.num_resources = 1,
+		.resource = &res,
+	};
+
+	platform_device_register(&pdev);
+}
+
 static void __init tx4939_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index b919696..c033ffe 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -502,6 +502,7 @@ static void __init rbtx4939_device_init(void)
 	tx4939_aclc_init();
 	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
 	tx4939_sramc_init();
+	tx4939_rng_init();
 }
 
 static void __init rbtx4939_setup(void)
-- 
1.5.6.5
