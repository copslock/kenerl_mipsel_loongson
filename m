Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 14:06:27 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:35823 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007238AbbCRNG0Mlmlu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 14:06:26 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id t2ID5Q79032086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 18 Mar 2015 13:05:26 GMT
Received: from [10.151.38.33] ([10.151.38.33])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t2ID5Lm1011223;
        Wed, 18 Mar 2015 14:05:21 +0100
Message-ID: <55097811.8050003@nokia.com>
Date:   Wed, 18 Mar 2015 14:05:21 +0100
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney@cavium.com>, ddaney.cavm@gmail.com,
        "ext Daney, David" <David.Daney@caviumnetworks.com>
CC:     Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rulf, Mathias (Nokia - DE/Ulm)" <mathias.rulf@nokia.com>
Subject: [PATCH] pci: octeon: Remove udelay() causing huge IRQ latency
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2371
X-purgate-ID: 151667::1426683926-00007F9C-137A230F/0/0
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

udelay() in PCI/PCIe read/write callbacks cause 30ms IRQ latency on Octeon
platforms because these operations are called from PCI_OP_READ() and
PCI_OP_WRITE() under raw_spin_lock_irqsave().

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/include/asm/octeon/pci-octeon.h |    3 ---
 arch/mips/pci/pci-octeon.c                |    6 ------
 arch/mips/pci/pcie-octeon.c               |    8 --------
 3 files changed, 0 insertions(+), 17 deletions(-)

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
index a04af55..01c604a 100644
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
index 1bb0b2b..99f3db4 100644
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
 
