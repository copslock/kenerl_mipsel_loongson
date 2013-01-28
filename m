Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:10:26 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33216 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833259Ab3A1TJ0uk3Ml (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 6FD4EBF5189;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LaoxdXhqJQtY; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 878E6BF518E;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 05/13] MIPS: BCM63XX: introduce BCM63XX_OHCI configuration symbol
Date:   Mon, 28 Jan 2013 20:06:23 +0100
Message-Id: <1359399991-2236-6-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35586
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

This configuration symbol can be used by CPUs supporting the on-chip
OHCI controller, and ensures that all relevant OHCI-related
configuration options are correctly selected. So far, OHCI support is
available for the 6328, 6348, 6358 and 6358 SoCs.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/Kconfig |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index d03e879..23b1ffd 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -1,33 +1,38 @@
 menu "CPU support"
 	depends on BCM63XX
 
+config BCM63XX_OHCI
+	bool
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_BIG_ENDIAN_DESC if USB_OHCI_HCD
+	select USB_OHCI_BIG_ENDIAN_MMIO if USB_OHCI_HCD
+
 config BCM63XX_CPU_6328
 	bool "support 6328 CPU"
 	select HW_HAS_PCI
+	select BCM63XX_OHCI
 
 config BCM63XX_CPU_6338
 	bool "support 6338 CPU"
 	select HW_HAS_PCI
-	select USB_ARCH_HAS_OHCI
-	select USB_OHCI_BIG_ENDIAN_DESC
-	select USB_OHCI_BIG_ENDIAN_MMIO
 
 config BCM63XX_CPU_6345
 	bool "support 6345 CPU"
-	select USB_OHCI_BIG_ENDIAN_DESC
-	select USB_OHCI_BIG_ENDIAN_MMIO
 
 config BCM63XX_CPU_6348
 	bool "support 6348 CPU"
 	select HW_HAS_PCI
+	select BCM63XX_OHCI
 
 config BCM63XX_CPU_6358
 	bool "support 6358 CPU"
 	select HW_HAS_PCI
+	select BCM63XX_OHCI
 
 config BCM63XX_CPU_6368
 	bool "support 6368 CPU"
 	select HW_HAS_PCI
+	select BCM63XX_OHCI
 endmenu
 
 source "arch/mips/bcm63xx/boards/Kconfig"
-- 
1.7.10.4
