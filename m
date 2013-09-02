Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2013 10:55:23 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:52055 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822681Ab3IBIzNyc3-d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Sep 2013 10:55:13 +0200
Received: from bl20-127-128.dsl.telepac.pt ([2.81.127.128] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1VGPui-0005rD-TE; Mon, 02 Sep 2013 08:55:13 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 24/58] MIPS: Expose missing pci_io{map,unmap} declarations
Date:   Mon,  2 Sep 2013 09:54:09 +0100
Message-Id: <1378112083-9475-25-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1378112083-9475-1-git-send-email-luis.henriques@canonical.com>
References: <1378112083-9475-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.5
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.5.7.21 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 78857614104a26cdada4c53eea104752042bf5a1 upstream.

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
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/5478/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/Kconfig          | 2 +-
 arch/mips/include/asm/io.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3e10fd..3811c84 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -25,6 +25,7 @@ config MIPS
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select IRQ_FORCED_THREADING
 	select HAVE_MEMBLOCK
@@ -2353,7 +2354,6 @@ config PCI
 	bool "Support for PCI controller"
 	depends on HW_HAS_PCI
 	select PCI_DOMAINS
-	select GENERIC_PCI_IOMAP
 	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 29d9c23..98ca652 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -169,6 +169,11 @@ static inline void * isa_bus_to_virt(unsigned long address)
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
1.8.3.2
