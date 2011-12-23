Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:30:00 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46112 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903753Ab1LWS0S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:18 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E846923C008B;
        Fri, 23 Dec 2011 19:26:16 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 09/16] MIPS: ath79: register UART device for AR934X SoCs
Date:   Fri, 23 Dec 2011 19:25:35 +0100
Message-Id: <1324664742-3648-10-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19097

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
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
