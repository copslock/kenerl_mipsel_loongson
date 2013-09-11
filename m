Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 06:57:14 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:2280 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819547Ab3IKE5K0q-b8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 06:57:10 +0200
X-Authority-Analysis: v=2.0 cv=V4T/IJbi c=1 sm=0 a=Sro2XwOs0tJUSHxCKfOySw==:17 a=Drc5e87SC40A:10 a=Ciwy3NGCPMMA:10 a=4ipN5mIW-V0A:10 a=5SG0PmZfjMsA:10 a=bbbx4UPp9XUA:10 a=meVymXHHAAAA:8 a=KGjhK52YXX0A:10 a=vcVOQ5EbMykA:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=w1o5dGyOIKqk4MLB4vYA:9 a=EDSpbFuiShEA:10 a=1DbiqZag68YA:10 a=jeBq3FmKZ4MA:10 a=Sro2XwOs0tJUSHxCKfOySw==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.255.60.225
Received: from [67.255.60.225] ([67.255.60.225:50990] helo=gandalf.local.home)
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 87/CF-26119-F18FF225; Wed, 11 Sep 2013 04:57:03 +0000
Received: from rostedt by gandalf.local.home with local (Exim 4.80)
        (envelope-from <rostedt@goodmis.org>)
        id 1VJc3P-0003Xs-R7; Wed, 11 Sep 2013 00:29:23 -0400
Message-Id: <20130911042923.766638906@goodmis.org>
User-Agent: quilt/0.60-1
Date:   Wed, 11 Sep 2013 00:30:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [190/251] MIPS: Expose missing pci_io{map,unmap} declarations
References: <20130911042707.738353451@goodmis.org>
Content-Disposition: inline; filename=0190-MIPS-Expose-missing-pci_io-map-unmap-declarations.patch
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

3.6.11.9-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

[ Upstream commit 78857614104a26cdada4c53eea104752042bf5a1 ]

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
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Patchwork: https://patchwork.linux-mips.org/patch/5478/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/Kconfig          |    2 +-
 arch/mips/include/asm/io.h |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index faf6528..5367804 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -26,6 +26,7 @@ config MIPS
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select IRQ_FORCED_THREADING
@@ -2392,7 +2393,6 @@ config PCI
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
1.7.10.4
