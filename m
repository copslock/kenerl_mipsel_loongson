Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2015 02:10:42 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57105 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012000AbbHBAKiBoMmy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Aug 2015 02:10:38 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZLgqW-0002cl-KQ; Sun, 02 Aug 2015 01:09:44 +0100
Received: from ben by deadeye with local (Exim 4.86_RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1ZLgqT-0004lt-OQ; Sun, 02 Aug 2015 01:09:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Daney" <ddaney@cavium.com>,
        "Jiri Kosina" <jkosina@suse.cz>,
        "Alexander Sverdlin" <alexander.sverdlin@nokia.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Mathias" <mathias.rulf@nokia.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Masanari Iida" <standby24x7@gmail.com>,
        "Rob Herring" <robh@kernel.org>, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Sun, 02 Aug 2015 01:02:38 +0100
Message-ID: <lsq.1438473758.722316683@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 154/164] MIPS: Octeon: Remove udelay() causing huge
 IRQ latency
In-Reply-To: <lsq.1438473757.687525882@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.70-rc1 review patch.  If anyone has any objections, please let me know.

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
---
 arch/mips/include/asm/octeon/pci-octeon.h | 3 ---
 arch/mips/pci/pci-octeon.c                | 6 ------
 arch/mips/pci/pcie-octeon.c               | 8 --------
 3 files changed, 17 deletions(-)

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
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -279,9 +279,6 @@ static int octeon_read_config(struct pci
 	pci_addr.s.func = devfn & 0x7;
 	pci_addr.s.reg = reg;
 
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	switch (size) {
 	case 4:
 		*val = le32_to_cpu(cvmx_read64_uint32(pci_addr.u64));
@@ -316,9 +313,6 @@ static int octeon_write_config(struct pc
 	pci_addr.s.func = devfn & 0x7;
 	pci_addr.s.reg = reg;
 
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	switch (size) {
 	case 4:
 		cvmx_write64_uint32(pci_addr.u64, cpu_to_le32(val));
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1219,9 +1219,6 @@ static inline int octeon_pcie_write_conf
 					devfn & 0x7, reg, val);
 		return PCIBIOS_SUCCESSFUL;
 	}
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	return PCIBIOS_FUNC_NOT_SUPPORTED;
 }
 
