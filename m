Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 13:10:16 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2002 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823001Ab3APMKK7XMR3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jan 2013 13:10:10 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 16 Jan 2013 04:04:40 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 irvexchcas06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server id 14.1.355.2; Wed, 16 Jan 2013 04:09:53 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 34D0040FE3; Wed, 16
 Jan 2013 04:09:51 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 03/10] MIPS: PCI: Byteswap not needed in little-endian
 mode
Date:   Wed, 16 Jan 2013 17:42:40 +0530
Message-ID: <1358338361-15499-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358231908-14458-2-git-send-email-jchandra@broadcom.com>
References: <1358231908-14458-2-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CE848D23Q43158774-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35465
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Rename function xlp_enable_pci_bswap() to xlp_config_pci_bswap(), which
is a better description for its functionality.  When compiled in
big-endian mode, xlp_config_pci_bswap() will configure the PCIe links
to byteswap.  In little-endian mode, no swap configuration is needed
for the PCIe controller, and the function is empty.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
[ New version with updated #ifdef style ]

 arch/mips/pci/pci-xlp.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 140557a..5077148 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -191,7 +191,13 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-static int xlp_enable_pci_bswap(void)
+/*
+ * If big-endian, enable hardware byteswap on the PCIe bridges.
+ * This will make both the SoC and PCIe devices behave consistently with
+ * readl/writel.
+ */
+#ifdef __BIG_ENDIAN
+static void xlp_config_pci_bswap(void)
 {
 	uint64_t pciebase, sysbase;
 	int node, i;
@@ -222,8 +228,11 @@ static int xlp_enable_pci_bswap(void)
 		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_LIMIT0 + i);
 		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_LIM, reg | 0xfff);
 	}
-	return 0;
 }
+#else
+/* Swap configuration not needed in little-endian mode */
+static inline void xlp_config_pci_bswap(void) {}
+#endif /* __BIG_ENDIAN */
 
 static int __init pcibios_init(void)
 {
@@ -235,7 +244,7 @@ static int __init pcibios_init(void)
 	ioport_resource.start =  0;
 	ioport_resource.end   = ~0;
 
-	xlp_enable_pci_bswap();
+	xlp_config_pci_bswap();
 	set_io_port_base(CKSEG1);
 	nlm_pci_controller.io_map_base = CKSEG1;
 
-- 
1.7.9.5
