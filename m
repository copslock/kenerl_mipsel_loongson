Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 19:58:30 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2656 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827534Ab3FRR4juwhP6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 19:56:39 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Jun 2013 10:52:50 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 18 Jun 2013 10:56:31 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 18 Jun 2013 10:56:31 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-244.bri.broadcom.com [10.178.5.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 4C6A9F2D87; Tue, 18
 Jun 2013 10:56:15 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 7/7] MIPS: BCM63XX: add support for the Netgear CVG834G
Date:   Tue, 18 Jun 2013 18:55:44 +0100
Message-ID: <1371578144-12794-8-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371578144-12794-1-git-send-email-florian@openwrt.org>
References: <1371578144-12794-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
X-WSS-ID: 7DDE41F831W38705428-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Add support for the Netgear CVG834G and enable the two UARTs, Ethernet
on the first MAC, PCI and the two leds.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 611a420..d3304dc 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -37,6 +37,38 @@
 static struct board_info board;
 
 /*
+ * known 3368 boards
+ */
+#ifdef CONFIG_BCM63XX_CPU_3368
+static struct board_info __initdata board_cvg834g = {
+	.name				= "CVG834G_E15R3921",
+	.expected_cpu_id		= 0x3368,
+
+	.has_uart0			= 1,
+	.has_uart1			= 1,
+
+	.has_enet0			= 1,
+	.has_pci			= 1,
+
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
+
+	.leds = {
+		{
+			.name		= "CVG834G:green:power",
+			.gpio		= 37,
+			.default_trigger= "default-on",
+		},
+	},
+
+	.ephy_reset_gpio		= 36,
+	.ephy_reset_gpio_flags		= GPIOF_INIT_HIGH,
+};
+#endif
+
+/*
  * known 6328 boards
  */
 #ifdef CONFIG_BCM63XX_CPU_6328
@@ -643,6 +675,9 @@ static struct board_info __initdata board_DWVS0 = {
  * all boards
  */
 static const struct board_info __initconst *bcm963xx_boards[] = {
+#ifdef CONFIG_BCM63XX_CPU_3368
+	&board_cvg834g,
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6328
 	&board_96328avng,
 #endif
-- 
1.8.1.2
