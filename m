Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 15:17:09 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2808 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823088Ab3JNNPqkxKe2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 15:15:46 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Oct 2013 06:15:12 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 14 Oct 2013 06:15:22 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 14 Oct 2013 06:15:22 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 4B04C246A6; Mon, 14
 Oct 2013 06:15:21 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 09/18] MIPS: Netlogic: update iomap.h for XLP9XX
Date:   Mon, 14 Oct 2013 18:51:05 +0530
Message-ID: <1381756874-22616-10-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E4531EA2E41366911-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Most IO block offsets have changed in XLP9XX. Update iomap.h to add the
new addresses of different SoC blocks like PIC, SYS, UART etc. that are
needed by the base code.

On XLP9xx, the SoC blocks of other nodes are seen on a PCI bus
corresponding to the node. Update iomap code to reflect this.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mach-netlogic/multi-node.h |    1 +
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h   |   45 +++++++++++++++++++++-
 arch/mips/netlogic/xlp/nlm_hal.c                 |    4 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-netlogic/multi-node.h b/arch/mips/include/asm/mach-netlogic/multi-node.h
index beeb36b..df9869d 100644
--- a/arch/mips/include/asm/mach-netlogic/multi-node.h
+++ b/arch/mips/include/asm/mach-netlogic/multi-node.h
@@ -59,6 +59,7 @@ struct nlm_soc_info {
 	uint64_t	picbase;	/* PIC block base */
 	spinlock_t	piclock;	/* lock for PIC access */
 	cpumask_t	cpumask;	/* logical cpu mask for node */
+	unsigned int	socbus;
 };
 
 extern struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
index 55eee77..92fd866 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -48,8 +48,10 @@
 #define XLP_IO_SIZE			(64 << 20)	/* ECFG space size */
 #define XLP_IO_PCI_HDRSZ		0x100
 #define XLP_IO_DEV(node, dev)		((dev) + (node) * 8)
-#define XLP_HDR_OFFSET(node, bus, dev, fn)	(((bus) << 20) | \
-				((XLP_IO_DEV(node, dev)) << 15) | ((fn) << 12))
+#define XLP_IO_PCI_OFFSET(b, d, f)	(((b) << 20) | ((d) << 15) | ((f) << 12))
+
+#define XLP_HDR_OFFSET(node, bus, dev, fn) \
+		XLP_IO_PCI_OFFSET(bus, XLP_IO_DEV(node, dev), fn)
 
 #define XLP_IO_BRIDGE_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 0, 0)
 /* coherent inter chip */
@@ -109,6 +111,36 @@
 #define XLP_IO_MMC_OFFSET(node, slot)	\
 		((XLP_IO_SD_OFFSET(node))+(slot*0x100)+XLP_IO_PCI_HDRSZ)
 
+/* Things have changed drastically in XLP 9XX */
+#define XLP9XX_HDR_OFFSET(n, d, f)	\
+			XLP_IO_PCI_OFFSET(xlp9xx_get_socbus(n), d, f)
+
+#define XLP9XX_IO_BRIDGE_OFFSET(node)	XLP_IO_PCI_OFFSET(0, 0, node)
+#define XLP9XX_IO_PIC_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 2, 0)
+#define XLP9XX_IO_UART_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 2, 2)
+#define XLP9XX_IO_SYS_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 6, 0)
+#define XLP9XX_IO_FUSE_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 6, 1)
+#define XLP9XX_IO_JTAG_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 6, 4)
+
+#define XLP9XX_IO_PCIE_OFFSET(node, i)	XLP9XX_HDR_OFFSET(node, 1, i)
+#define XLP9XX_IO_PCIE0_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 1, 0)
+#define XLP9XX_IO_PCIE2_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 1, 2)
+#define XLP9XX_IO_PCIE3_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 1, 3)
+
+/* XLP9xx USB block */
+#define XLP9XX_IO_USB_OFFSET(node, i)		XLP9XX_HDR_OFFSET(node, 4, i)
+#define XLP9XX_IO_USB_XHCI0_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 4, 1)
+#define XLP9XX_IO_USB_XHCI1_OFFSET(node)	XLP9XX_HDR_OFFSET(node, 4, 2)
+
+/* XLP9XX on-chip SATA controller */
+#define XLP9XX_IO_SATA_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 3, 2)
+
+#define XLP9XX_IO_NOR_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 0)
+#define XLP9XX_IO_NAND_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 1)
+#define XLP9XX_IO_SPI_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 2)
+/* SD flash */
+#define XLP9XX_IO_MMCSD_OFFSET(node)		XLP9XX_HDR_OFFSET(node, 7, 3)
+
 /* PCI config header register id's */
 #define XLP_PCI_CFGREG0			0x00
 #define XLP_PCI_CFGREG1			0x01
@@ -161,6 +193,15 @@
 #define nlm_read_pci_reg(b, r)		nlm_read_reg(b, r)
 #define nlm_write_pci_reg(b, r, v)	nlm_write_reg(b, r, v)
 
+static inline int xlp9xx_get_socbus(int node)
+{
+	uint64_t socbridge;
+
+	if (node == 0)
+		return 1;
+	socbridge = nlm_pcicfg_base(XLP9XX_IO_BRIDGE_OFFSET(node));
+	return (nlm_read_pci_reg(socbridge, 0x6) >> 8) & 0xff;
+}
 #endif /* !__ASSEMBLY */
 
 #endif /* __NLM_HAL_IOMAP_H__ */
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 5693021..5f191f5 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -57,6 +57,10 @@ void nlm_node_init(int node)
 	nodep->sysbase = nlm_get_sys_regbase(node);
 	nodep->picbase = nlm_get_pic_regbase(node);
 	nodep->ebase = read_c0_ebase() & (~((1 << 12) - 1));
+	if (cpu_is_xlp9xx())
+		nodep->socbus = xlp9xx_get_socbus(node);
+	else
+		nodep->socbus = 0;
 	spin_lock_init(&nodep->piclock);
 }
 
-- 
1.7.9.5
