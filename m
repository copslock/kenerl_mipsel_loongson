Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 19:58:12 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2656 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834994Ab3FRR4e13CX9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 19:56:34 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Jun 2013 10:52:41 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 18 Jun 2013 10:56:21 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 18 Jun 2013 10:56:21 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-244.bri.broadcom.com [10.178.5.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id D0648F2D72; Tue, 18
 Jun 2013 10:56:13 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 6/7] MIPS: BCM63XX: let board specify an external GPIO
 to reset PHY
Date:   Tue, 18 Jun 2013 18:55:43 +0100
Message-ID: <1371578144-12794-7-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371578144-12794-1-git-send-email-florian@openwrt.org>
References: <1371578144-12794-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
X-WSS-ID: 7DDE41E231W38705332-03-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36985
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

Some boards may need to reset their external PHY or switch they are
attached to, add a hook for doing this along with providing custom
linux/gpio.h flags for doing this.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c           | 4 ++++
 arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 46eabb9..611a420 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -883,5 +883,9 @@ int __init board_register_devices(void)
 
 	platform_device_register(&bcm63xx_gpio_leds);
 
+	if (board.ephy_reset_gpio && board.ephy_reset_gpio_flags)
+		gpio_request_one(board.ephy_reset_gpio,
+				board.ephy_reset_gpio_flags, "ephy-reset");
+
 	return 0;
 }
diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
index 682bcf3..5981fe0 100644
--- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -45,6 +45,12 @@ struct board_info {
 
 	/* GPIO LEDs */
 	struct gpio_led leds[5];
+
+	/* External PHY reset GPIO */
+	unsigned int ephy_reset_gpio;
+
+	/* External PHY reset GPIO flags from gpio.h */
+	unsigned long ephy_reset_gpio_flags;
 };
 
 #endif /* ! BOARD_BCM963XX_H_ */
-- 
1.8.1.2
