Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:55:46 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35686 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027462AbbEKRzoakoKH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:44 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 959D4BB2;
        Mon, 11 May 2015 17:55:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mips@linux-mips.org, David Daney <ddaney@cavium.com>,
        Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias <mathias.rulf@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 12/72] MIPS: Octeon: Remove udelay() causing huge IRQ latency
Date:   Mon, 11 May 2015 10:54:18 -0700
Message-Id: <20150511175437.476815265@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Commit 73bf3c2a500b2db8ac966469591196bf55afb409 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/octeon/pci-octeon.h |    3 ---
 arch/mips/pci/pci-octeon.c                |    6 ------
 arch/mips/pci/pcie-octeon.c               |    8 --------
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
@@ -271,9 +271,6 @@ static int octeon_read_config(struct pci
 	pci_addr.s.func = devfn & 0x7;
 	pci_addr.s.reg = reg;
 
-#if PCI_CONFIG_SPACE_DELAY
-	udelay(PCI_CONFIG_SPACE_DELAY);
-#endif
 	switch (size) {
 	case 4:
 		*val = le32_to_cpu(cvmx_read64_uint32(pci_addr.u64));
@@ -308,9 +305,6 @@ static int octeon_write_config(struct pc
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
@@ -1762,14 +1762,6 @@ static int octeon_pcie_write_config(unsi
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
 
