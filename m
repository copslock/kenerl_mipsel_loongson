Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:29:05 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2300 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903724Ab2GMQYn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:43 +0200
Received: from [10.9.200.131] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:04 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:24:19 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E1C819F9F5; Fri, 13
 Jul 2012 09:24:19 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:19 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 05/12] MIPS: PCI: Fix for byte swap for Netlogic XLP
Date:   Fri, 13 Jul 2012 21:53:18 +0530
Message-ID: <1342196605-4260-6-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E94E24989490114-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
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

The last 12 bits of the PCIe hardware swap size and limit registers
are significant, while the same bits of the bridge PCIe registers
are 0.

So, to program limits correctly, we need to set the last 12 bits of
the value read from the bridge limit registers to 1 before writing
to the PCIe limit registers.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/pci/pci-xlp.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 3e177e9..140557a 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -213,13 +213,14 @@ static int xlp_enable_pci_bswap(void)
 		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_MEM_BASE, reg);
 
 		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEMEM_LIMIT0 + i);
-		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_MEM_LIM, reg);
+		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_MEM_LIM,
+			reg | 0xfff);
 
 		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_BASE0 + i);
 		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_BASE, reg);
 
 		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_LIMIT0 + i);
-		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_LIM, reg);
+		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_LIM, reg | 0xfff);
 	}
 	return 0;
 }
-- 
1.7.9.5
