Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 11:09:49 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:56852 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824782Ab3FQJJlnK-Sb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 11:09:41 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Expose missing pci_io{map,unmap} declarations
Date:   Mon, 17 Jun 2013 10:09:00 +0100
Message-ID: <1371460140-5626-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_17_10_09_35
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The GENERIC_PCI_IOMAP does not depend on CONFIG_PCI so move
it to the CONFIG_MIPS symbol so it's always selected for MIPS.
This fixes the missing pci_iomap declaration for MIPS.
Moreover, the pci_iounmap function was not defined in the
io.h header file if the CONFIG_PCI symbol is not set,
but it should since MIPS is not using CONFIG_GENERIC_IOMAP.

This fixes the following problem on a allyesconfig:

drivers/net/ethernet/3com/3c59x.c:1031:2: error: implicit declaration of
function 'pci_iomap' [-Werror=implicit-function-declaration]
drivers/net/ethernet/3com/3c59x.c:1044:3: error: implicit declaration of
function 'pci_iounmap' [-Werror=implicit-function-declaration]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com> 
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/Kconfig          | 2 +-
 arch/mips/include/asm/io.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a58ab9..e53e2b4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -27,6 +27,7 @@ config MIPS
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select IRQ_FORCED_THREADING
@@ -2412,7 +2413,6 @@ config PCI
 	bool "Support for PCI controller"
 	depends on HW_HAS_PCI
 	select PCI_DOMAINS
-	select GENERIC_PCI_IOMAP
 	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index b7e5985..b84e1fb 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -170,6 +170,11 @@ static inline void * isa_bus_to_virt(unsigned long address)
 extern void __iomem * __ioremap(phys_t offset, phys_t size, unsigned long flags);
 extern void __iounmap(const volatile void __iomem *addr);
 
+#ifndef CONFIG_PCI
+struct pci_dev;
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {}
+#endif
+
 static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
 	unsigned long flags)
 {
-- 
1.8.2.1
