Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:43:48 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34460 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903727Ab2CNJk0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:40:26 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id C231023C00DD;
        Wed, 14 Mar 2012 10:09:31 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, juhosg@openwrt.org
Subject: [PATCH v2 09/13] MIPS: ath79: register UART device for AR934X SoCs
Date:   Wed, 14 Mar 2012 11:45:27 +0100
Message-Id: <1331721931-4334-10-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
References: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
v2: - no changes

 arch/mips/ath79/dev-common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index f4956f8..45efc63 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -89,7 +89,8 @@ void __init ath79_register_uart(void)
 
 	if (soc_is_ar71xx() ||
 	    soc_is_ar724x() ||
-	    soc_is_ar913x()) {
+	    soc_is_ar913x() ||
+	    soc_is_ar934x()) {
 		ath79_uart_data[0].uartclk = clk_get_rate(clk);
 		platform_device_register(&ath79_uart_device);
 	} else if (soc_is_ar933x()) {
-- 
1.7.2.1
