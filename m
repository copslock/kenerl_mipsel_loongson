Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:26:47 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:47216 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993885AbeGTMYTKG0kp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 14:24:19 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH V2 24/25] MIPS: ath79: sanitize symbols
Date:   Fri, 20 Jul 2018 13:58:41 +0200
Message-Id: <20180720115842.8406-25-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

We no longer need to select which SoCs are supported as the whole arch
code is always built. So lets drop all the SoC symbols

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/Kconfig       |  2 ++
 arch/mips/ath79/Kconfig | 44 +++++---------------------------------------
 arch/mips/pci/Makefile  |  2 +-
 3 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4d8e15a15d57..9f4e461bbc2c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -204,6 +204,8 @@ config ATH79
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_ZBOOT_UART_PROM
+	select HW_HAS_PCI
+	select USB_ARCH_HAS_EHCI
 	select USE_OF
 	select USB_EHCI_ROOT_HUB_TT if USB_EHCI_HCD_PLATFORM
 	help
diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 9496b800571c..a6a194174156 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -1,48 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 if ATH79
 
-config SOC_AR71XX
-	select HW_HAS_PCI
-	def_bool n
-
-config SOC_AR724X
-	select HW_HAS_PCI
-	select PCI_AR724X if PCI
-	def_bool n
-
-config SOC_AR913X
-	def_bool n
-
-config SOC_AR933X
-	def_bool n
-
-config SOC_AR934X
-	select HW_HAS_PCI
-	select PCI_AR724X if PCI
-	def_bool n
-
-config SOC_QCA955X
-	select HW_HAS_PCI
-	select PCI_AR724X if PCI
+config PCI_AR71XX
+	bool "PCI support for AR7100 type SoCs"
+	depends on PCI
 	def_bool n
 
 config PCI_AR724X
-	def_bool n
-
-config ATH79_DEV_GPIO_BUTTONS
-	def_bool n
-
-config ATH79_DEV_LEDS_GPIO
-	def_bool n
-
-config ATH79_DEV_SPI
-	def_bool n
-
-config ATH79_DEV_USB
-	def_bool n
-
-config ATH79_DEV_WMAC
-	depends on (SOC_AR913X || SOC_AR933X || SOC_AR934X || SOC_QCA955X)
+	bool "PCI support for AR724x type SoCs"
+	depends on PCI
 	def_bool n
 
 endif
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c4f976593061..836dbd4380cb 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
 obj-$(CONFIG_PCI_AR2315)	+= pci-ar2315.o
-obj-$(CONFIG_SOC_AR71XX)	+= pci-ar71xx.o
+obj-$(CONFIG_PCI_AR71XX)	+= pci-ar71xx.o
 obj-$(CONFIG_PCI_AR724X)	+= pci-ar724x.o
 obj-$(CONFIG_MIPS_PCI_VIRTIO)	+= pci-virtio-guest.o
 #
-- 
2.11.0
