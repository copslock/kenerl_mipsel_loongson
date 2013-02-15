Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:40:58 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58604 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827605Ab3BOOidvKbu0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:33 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VjPz2X_HzF1p; Fri, 15 Feb 2013 15:38:23 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B8B1128039B;
        Fri, 15 Feb 2013 15:38:22 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 07/11] MIPS: ath79: register UART for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 15:38:21 +0100
Message-Id: <1360939105-23591-8-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Similarly to the preceding SoCs, the QCA955X SoCs
also have a built-in NS16650 compatible UART.
Register the platform device for that to make
it usable.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 9be1465..a3a2741 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -90,7 +90,8 @@ void __init ath79_register_uart(void)
 	if (soc_is_ar71xx() ||
 	    soc_is_ar724x() ||
 	    soc_is_ar913x() ||
-	    soc_is_ar934x()) {
+	    soc_is_ar934x() ||
+	    soc_is_qca955x()) {
 		ath79_uart_data[0].uartclk = clk_get_rate(clk);
 		platform_device_register(&ath79_uart_device);
 	} else if (soc_is_ar933x()) {
-- 
1.7.10
