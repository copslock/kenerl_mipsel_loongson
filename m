Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:10:43 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33215 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833260Ab3A1TJ0xQTaA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 719EABF56B8;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XtEni3NcB1Rk; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id C0674BF519D;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 10/13] MIPS: BCM63XX: register EHCI controller if board enables it
Date:   Mon, 28 Jan 2013 20:06:28 +0100
Message-Id: <1359399991-2236-11-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35587
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
Return-Path: <linux-mips-bounce@linux-mips.org>

BCM63XX-based board can control the registration of the EHCI controller
by setting their has_ehci0 flag to 1. Handle this in the generic
code dealing with board registration and call the actual helper to register
the EHCI controller.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 9cdc023..0ee7ca6 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -25,6 +25,7 @@
 #include <bcm63xx_dev_flash.h>
 #include <bcm63xx_dev_pcmcia.h>
 #include <bcm63xx_dev_spi.h>
+#include <bcm63xx_dev_usb_ehci.h>
 #include <bcm63xx_dev_usb_ohci.h>
 #include <bcm63xx_dev_usb_usbd.h>
 #include <board_bcm963xx.h>
@@ -852,6 +853,9 @@ int __init board_register_devices(void)
 	if (board.has_usbd)
 		bcm63xx_usbd_register(&board.usbd);
 
+	if (board.has_ehci0)
+		bcm63xx_ehci_register();
+
 	if (board.has_ohci0)
 		bcm63xx_ohci_register();
 
-- 
1.7.10.4
