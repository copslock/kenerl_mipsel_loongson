Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Dec 2013 17:49:02 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:18600 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824789Ab3LBQtAHat1j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Dec 2013 17:49:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/3] MIPS: Malta: mux & enable SERIRQ interrupt
Date:   Mon, 2 Dec 2013 16:48:37 +0000
Message-ID: <1386002918-32270-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1386002918-32270-1-git-send-email-paul.burton@imgtec.com>
References: <1386002918-32270-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_12_02_16_48_53
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This patch causes the kernel to mux the SERIRQ interrupt to the SERIRQ
pin of the PIIX4 and to enable that interrupt. The kernel depends upon
the interrupt when using the SuperIO UARTs (ttyS0 & ttyS1) but
previously would not configure it, instead relying upon the bootloader
having done so. If that is not the case then the typical result is that
the system appears to hang once it reaches userland as no output is
displayed on the UART.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mips-boards/piix4.h |  7 +++++++
 arch/mips/pci/fixup-malta.c               | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/mips/include/asm/mips-boards/piix4.h b/arch/mips/include/asm/mips-boards/piix4.h
index e332279..836e2ed 100644
--- a/arch/mips/include/asm/mips-boards/piix4.h
+++ b/arch/mips/include/asm/mips-boards/piix4.h
@@ -26,6 +26,10 @@
 #define   PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_DISABLE	(1 << 7)
 #define   PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MASK		0xf
 #define   PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MAX		16
+/* SERIRQ Control */
+#define PIIX4_FUNC0_SERIRQC			0x64
+#define   PIIX4_FUNC0_SERIRQC_EN			(1 << 7)
+#define   PIIX4_FUNC0_SERIRQC_CONT			(1 << 6)
 /* Top Of Memory */
 #define PIIX4_FUNC0_TOM				0x69
 #define   PIIX4_FUNC0_TOM_TOP_OF_MEMORY_MASK		0xf0
@@ -34,6 +38,9 @@
 #define   PIIX4_FUNC0_DLC_USBPR_EN			(1 << 2)
 #define   PIIX4_FUNC0_DLC_PASSIVE_RELEASE_EN		(1 << 1)
 #define   PIIX4_FUNC0_DLC_DELAYED_TRANSACTION_EN	(1 << 0)
+/* General Configuration */
+#define PIIX4_FUNC0_GENCFG			0xb0
+#define   PIIX4_FUNC0_GENCFG_SERIRQ			(1 << 16)
 
 /* IDE Timing */
 #define PIIX4_FUNC1_IDETIM_PRIMARY_LO		0x40
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index df36e23..7a0eda7 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -54,6 +54,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 static void malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
+	u32 reg_val32;
 	/* PIIX PIRQC[A:D] irq mappings */
 	static int piixirqmap[PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MAX] = {
 		0,  0,	0,  3,
@@ -83,6 +84,16 @@ static void malta_piix_func0_fixup(struct pci_dev *pdev)
 		pci_write_config_byte(pdev, PIIX4_FUNC0_TOM, reg_val |
 				PIIX4_FUNC0_TOM_TOP_OF_MEMORY_MASK);
 	}
+
+	/* Mux SERIRQ to its pin */
+	pci_read_config_dword(pdev, PIIX4_FUNC0_GENCFG, &reg_val32);
+	pci_write_config_dword(pdev, PIIX4_FUNC0_GENCFG,
+			       reg_val32 | PIIX4_FUNC0_GENCFG_SERIRQ);
+
+	/* Enable SERIRQ */
+	pci_read_config_byte(pdev, PIIX4_FUNC0_SERIRQC, &reg_val);
+	reg_val |= PIIX4_FUNC0_SERIRQC_EN | PIIX4_FUNC0_SERIRQC_CONT;
+	pci_write_config_byte(pdev, PIIX4_FUNC0_SERIRQC, reg_val);
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
-- 
1.8.4.2
