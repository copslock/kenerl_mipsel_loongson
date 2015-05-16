Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:37:03 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:27895 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026237AbbEPOe5J9s6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:57 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEYCID004139
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYC2E016153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:12 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYBGC012916;
        Sat, 16 May 2015 14:34:11 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:11 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mips@linux-mips.org, David Daney <ddaney@cavium.com>,
        Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias <mathias.rulf@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Octeon: Remove udelay() causing huge IRQ latency
Date:   Sat, 16 May 2015 10:33:14 -0400
Message-Id: <1431786833-25487-6-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 73bf3c2a500b2db8ac966469591196bf55afb409 ]

udelay() in PCI/PCIe read/write callbacks cause 30ms IRQ latency on Octeon
platforms because these operations are called from PCI_OP_READ() and
PCI_OP_WRITE() under raw_spin_lock_irqsave().

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-mips@linux-mips.org
Cc: David Daney <ddaney@cavium.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masanari Iida <standby24x7@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mathias <mathias.rulf@nokia.com>
Patchwork: https://patchwork.linux-mips.org/patch/9576/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/include/asm/octeon/pci-octeon.h | 3 ---
 arch/mips/pci/pci-octeon.c                | 6 ------
 arch/mips/pci/pcie-octeon.c               | 8 --------
 3 files changed, 17 deletions(-)

diff --git a/arch/mips/include/asm/octeon/pci-octeon.h b/arch/mips/include/asm/octeon/pci-octeon.h
index 64ba56a..1884609 100644
--- a/arch/mips/include/asm/octeon/pci-octeon.h
+++ b/arch/mips/include/asm/octeon/pci-octeon.h
@@ -11,9 +11,6 @@
 
 #include <linux/pci.h>
 
-/* Some PCI cards require delays when accessing config space. */
-#define PCI_CONFIG_SPACE_DELAY 10000
-
 /*
  * The physical memory base mapped by BAR1.  256MB at the end of the
  * first 4GB.
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 59cccd9..1fa13ee 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -271,9 +271,6 @@ static int octeon_read_config(struct pci_bus *bus, unsigned int devfn,
 	pci_addr.s.func = devfn & 0x7;
 	pci_addr.s.reg = reg;
 
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	switch (size) {
 	case 4:
 		*val = le32_to_cpu(cvmx_read64_uint32(pci_addr.u64));
@@ -308,9 +305,6 @@ static int octeon_write_config(struct pci_bus *bus, unsigned int devfn,
 	pci_addr.s.func = devfn & 0x7;
 	pci_addr.s.reg = reg;
 
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	switch (size) {
 	case 4:
 		cvmx_write64_uint32(pci_addr.u64, cpu_to_le32(val));
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 5e36c33..38335af 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1762,14 +1762,6 @@ static int octeon_pcie_write_config(unsigned int pcie_port, struct pci_bus *bus,
 	default:
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
-#if PCI_CONFIG_SPACE_DELAY
-	/*
-	 * Delay on writes so that devices have time to come up. Some
-	 * bridges need this to allow time for the secondary busses to
-	 * work
-	 */
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	return PCIBIOS_SUCCESSFUL;
 }
 
-- 
2.1.0
