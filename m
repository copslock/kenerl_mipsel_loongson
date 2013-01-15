Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 07:16:48 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:1877 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832184Ab3AOGQog7lFb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Jan 2013 07:16:44 +0100
Received: from [10.9.200.131] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 22:11:14 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 14 Jan 2013 22:16:25 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C8A0C40FE3; Mon, 14
 Jan 2013 22:16:23 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 03/10] MIPS: PCI: Byteswap not needed in little-endian
 mode
Date:   Tue, 15 Jan 2013 11:49:06 +0530
Message-ID: <1358230746-13785-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-4-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-4-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEA2C883Q42207037-02-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35439
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

Wrap the xlp_enable_pci_bswap() function and its call with
'#ifdef __BIG_ENDIAN'. On Netlogic XLP, the PCIe initialization code
to setup to byteswap is needed only in big-endian mode.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/pci/pci-xlp.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 140557a..d201efa 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -191,8 +191,14 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-static int xlp_enable_pci_bswap(void)
+/*
+ * If big-endian, enable hardware byteswap on the PCIe bridges.
+ * This will make both the SoC and PCIe devices behave consistently with
+ * readl/writel.
+ */
+static void xlp_config_pci_bswap(void)
 {
+#ifdef __BIG_ENDIAN
 	uint64_t pciebase, sysbase;
 	int node, i;
 	u32 reg;
@@ -222,7 +228,7 @@ static int xlp_enable_pci_bswap(void)
 		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_LIMIT0 + i);
 		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_LIM, reg | 0xfff);
 	}
-	return 0;
+#endif
 }
 
 static int __init pcibios_init(void)
@@ -235,7 +241,7 @@ static int __init pcibios_init(void)
 	ioport_resource.start =  0;
 	ioport_resource.end   = ~0;
 
-	xlp_enable_pci_bswap();
+	xlp_config_pci_bswap();
 	set_io_port_base(CKSEG1);
 	nlm_pci_controller.io_map_base = CKSEG1;
 
-- 
1.7.9.5
