Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 07:25:28 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:53290 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903681Ab2FWFXy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jun 2012 07:23:54 +0200
Received: (qmail 25625 invoked from network); 23 Jun 2012 05:23:51 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Jun 2012 05:23:51 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 22 Jun 2012 22:23:51 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     <ffainelli@freebox.fr>, <mbizon@freebox.fr>,
        <jonas.gorski@gmail.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 4/7] MIPS: BCM63XX: Add register definitions for USBD
 dependencies
Date:   Fri, 22 Jun 2012 22:14:54 -0700
Message-Id: <ded04898978561c06a6e757e1d79204d@localhost>
In-Reply-To: <0f67eabbb0d5c59add27e42a08b94944@localhost>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 33793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

The USB 2.0 device depends on some functionality in other blocks, such
as GPIO and USBH.  Add those register definitions here.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  | 6 +++---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index e104ddb..2b59ae4 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -184,9 +184,9 @@ enum bcm63xx_regs_set {
 #define BCM_6328_SPI_BASE		(0xdeadbeef)
 #define BCM_6328_UDC0_BASE		(0xdeadbeef)
 #define BCM_6328_USBDMA_BASE		(0xdeadbeef)
-#define BCM_6328_OHCI0_BASE		(0xdeadbeef)
+#define BCM_6328_OHCI0_BASE		(0xb0002600)
 #define BCM_6328_OHCI_PRIV_BASE		(0xdeadbeef)
-#define BCM_6328_USBH_PRIV_BASE		(0xdeadbeef)
+#define BCM_6328_USBH_PRIV_BASE		(0xb0002700)
 #define BCM_6328_MPI_BASE		(0xdeadbeef)
 #define BCM_6328_PCMCIA_BASE		(0xdeadbeef)
 #define BCM_6328_PCIE_BASE		(0xb0e40000)
@@ -199,7 +199,7 @@ enum bcm63xx_regs_set {
 #define BCM_6328_ENETDMAC_BASE		(0xb000da00)
 #define BCM_6328_ENETDMAS_BASE		(0xb000dc00)
 #define BCM_6328_ENETSW_BASE		(0xb0e00000)
-#define BCM_6328_EHCI0_BASE		(0x10002500)
+#define BCM_6328_EHCI0_BASE		(0xb0002500)
 #define BCM_6328_SDRAM_BASE		(0xdeadbeef)
 #define BCM_6328_MEMC_BASE		(0xdeadbeef)
 #define BCM_6328_DDR_BASE		(0xb0003000)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index b970940..ad2db9c 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -543,6 +543,12 @@
 #define GPIO_MODE_6368_SPI_SSN5		(1 << 31)
 
 
+#define GPIO_PINMUX_OTHR_REG		0x24
+#define GPIO_PINMUX_OTHR_6328_USB_SHIFT	12
+#define GPIO_PINMUX_OTHR_6328_USB_MASK	(3 << GPIO_PINMUX_OTHR_6328_USB_SHIFT)
+#define GPIO_PINMUX_OTHR_6328_USB_HOST	(1 << GPIO_PINMUX_OTHR_6328_USB_SHIFT)
+#define GPIO_PINMUX_OTHR_6328_USB_DEV	(2 << GPIO_PINMUX_OTHR_6328_USB_SHIFT)
+
 #define GPIO_BASEMODE_6368_REG		0x38
 #define GPIO_BASEMODE_6368_UART2	0x1
 #define GPIO_BASEMODE_6368_GPIO		0x0
@@ -776,6 +782,8 @@
 #define USBH_PRIV_SWAP_6358_REG		0x0
 #define USBH_PRIV_SWAP_6368_REG		0x1c
 
+#define USBH_PRIV_SWAP_USBD_SHIFT	6
+#define USBH_PRIV_SWAP_USBD_MASK	(1 << USBH_PRIV_SWAP_USBD_SHIFT)
 #define USBH_PRIV_SWAP_EHCI_ENDN_SHIFT	4
 #define USBH_PRIV_SWAP_EHCI_ENDN_MASK	(1 << USBH_PRIV_SWAP_EHCI_ENDN_SHIFT)
 #define USBH_PRIV_SWAP_EHCI_DATA_SHIFT	3
-- 
1.7.11.1
