Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Sep 2015 01:13:21 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:9363 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008253AbbILXNSL6WGO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Sep 2015 01:13:18 +0200
Message-Id: <20150912225607.984707151@1wt.eu>
User-Agent: quilt/0.63-1
Date:   Sun, 13 Sep 2015 00:56:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mips@linux-mips.org, David Daney <ddaney@cavium.com>,
        Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias <mathias.rulf@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2.6.32 33/62] MIPS: Octeon: Remove udelay() causing huge IRQ latency
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
In-Reply-To: <08d3b586eb2e764308c3de9ee398a17c@local>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

2.6.32-longterm review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

commit 73bf3c2a500b2db8ac966469591196bf55afb409 upstream.

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
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
(cherry picked from commit 53493d44a771a3155ee12b6ac668fb2543d21a7a)

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/include/asm/octeon/pci-octeon.h | 3 ---
 arch/mips/pci/pci-octeon.c                | 6 ------
 arch/mips/pci/pcie-octeon.c               | 3 ---
 3 files changed, 12 deletions(-)

diff --git a/arch/mips/include/asm/octeon/pci-octeon.h b/arch/mips/include/asm/octeon/pci-octeon.h
index 6ac5d3e..5eda9f0 100644
--- a/arch/mips/include/asm/octeon/pci-octeon.h
+++ b/arch/mips/include/asm/octeon/pci-octeon.h
@@ -11,9 +11,6 @@
 
 #include <linux/pci.h>
 
-/* Some PCI cards require delays when accessing config space. */
-#define PCI_CONFIG_SPACE_DELAY 10000
-
 /*
  * pcibios_map_irq() is defined inside pci-octeon.c. All it does is
  * call the Octeon specific version pointed to by this variable. This
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 9cb0c80..dae7ff7 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -274,9 +274,6 @@ static int octeon_read_config(struct pci_bus *bus, unsigned int devfn,
 	pci_addr.s.func = devfn & 0x7;
 	pci_addr.s.reg = reg;
 
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	switch (size) {
 	case 4:
 		*val = le32_to_cpu(cvmx_read64_uint32(pci_addr.u64));
@@ -311,9 +308,6 @@ static int octeon_write_config(struct pci_bus *bus, unsigned int devfn,
 	pci_addr.s.func = devfn & 0x7;
 	pci_addr.s.reg = reg;
 
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	switch (size) {
 	case 4:
 		cvmx_write64_uint32(pci_addr.u64, cpu_to_le32(val));
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 6aa5c54..97813f3 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1192,9 +1192,6 @@ static inline int octeon_pcie_write_config(int pcie_port, struct pci_bus *bus,
 					devfn & 0x7, reg, val);
 		return PCIBIOS_SUCCESSFUL;
 	}
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	return PCIBIOS_FUNC_NOT_SUPPORTED;
 }
 
-- 
1.7.12.2.21.g234cd45.dirty
