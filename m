Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:11:55 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33220 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833263Ab3A1TJ1BG2mL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 80ECBBF5194;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XVjgjarMwhcX; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id A5EDCBF5197;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 08/13] MIPS: BCM63XX: introduce BCM63XX_EHCI configuration symbol
Date:   Mon, 28 Jan 2013 20:06:26 +0100
Message-Id: <1359399991-2236-9-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35591
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
EHCI controller, and ensures that all relevant EHCI-related
configuration options are selected. So far BCM6328, BCM6358 and BCM6368
have an EHCI controller and do select this symbol. Update
drivers/usb/host/Kconfig with BCM63XX to update direct unmet
dependencies.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/Kconfig |    9 +++++++++
 drivers/usb/host/Kconfig  |    5 +++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index 23b1ffd..b899359 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -7,10 +7,17 @@ config BCM63XX_OHCI
 	select USB_OHCI_BIG_ENDIAN_DESC if USB_OHCI_HCD
 	select USB_OHCI_BIG_ENDIAN_MMIO if USB_OHCI_HCD
 
+config BCM63XX_EHCI
+	bool
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_BIG_ENDIAN_DESC if USB_EHCI_HCD
+	select USB_EHCI_BIG_ENDIAN_MMIO if USB_EHCI_HCD
+
 config BCM63XX_CPU_6328
 	bool "support 6328 CPU"
 	select HW_HAS_PCI
 	select BCM63XX_OHCI
+	select BCM63XX_EHCI
 
 config BCM63XX_CPU_6338
 	bool "support 6338 CPU"
@@ -28,11 +35,13 @@ config BCM63XX_CPU_6358
 	bool "support 6358 CPU"
 	select HW_HAS_PCI
 	select BCM63XX_OHCI
+	select BCM63XX_EHCI
 
 config BCM63XX_CPU_6368
 	bool "support 6368 CPU"
 	select HW_HAS_PCI
 	select BCM63XX_OHCI
+	select BCM63XX_EHCI
 endmenu
 
 source "arch/mips/bcm63xx/boards/Kconfig"
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d6bb128..e16b2cb 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -115,14 +115,15 @@ config USB_EHCI_BIG_ENDIAN_MMIO
 	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || \
 				    ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
 				    PPC_MPC512x || CPU_CAVIUM_OCTEON || \
-				    PMC_MSP || SPARC_LEON || MIPS_SEAD3)
+				    PMC_MSP || SPARC_LEON || MIPS_SEAD3 || \
+				    BCM63XX)
 	default y
 
 config USB_EHCI_BIG_ENDIAN_DESC
 	bool
 	depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
 				    PPC_MPC512x || PMC_MSP || SPARC_LEON || \
-				    MIPS_SEAD3)
+				    MIPS_SEAD3 || BCM63XX)
 	default y
 
 config XPS_USB_HCD_XILINX
-- 
1.7.10.4
