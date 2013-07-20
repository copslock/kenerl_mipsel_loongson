Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jul 2013 19:39:34 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:50244 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815746Ab3GTRjb0Ppn9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jul 2013 19:39:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 70F8C21B80F;
        Sat, 20 Jul 2013 20:39:27 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id CUcsIlYAM3zf; Sat, 20 Jul 2013 20:39:22 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with ESMTP id 7A7535BC006;
        Sat, 20 Jul 2013 20:39:17 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Faidon Liambotis <paravoid@debian.org>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: cavium-octeon: fix I/O space setup on non-PCI systems
Date:   Sat, 20 Jul 2013 20:38:51 +0300
Message-Id: <1374341931-10591-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Fix I/O space setup, so that on non-PCI systems using inb()/outb()
won't crash the system. Some drivers may try to probe I/O space and for
that purpose we can just allocate some normal memory. Drivers trying to
reserve a region will fail early as we set the size to 0.

Tested with EdgeRouter Lite by enabling CONFIG_SERIO_I8042 that caused
the originally reported crash.

Reported-by: Faidon Liambotis <paravoid@debian.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/pci/pci-octeon.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 95c2ea8..1bfdcc8c 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/delay.h>
@@ -587,13 +588,16 @@ static int __init octeon_pci_setup(void)
 		octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_BIG;
 
 	/* PCI I/O and PCI MEM values */
-	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
-	ioport_resource.start = 0;
-	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
 	if (!octeon_is_pci_host()) {
 		pr_notice("Not in host mode, PCI Controller not initialized\n");
+		set_io_port_base((unsigned long)vzalloc(IO_SPACE_LIMIT));
+		ioport_resource.start = MAX_RESOURCE;
+		ioport_resource.end = 0;
 		return 0;
 	}
+	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
+	ioport_resource.start = 0;
+	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
 
 	pr_notice("%s Octeon big bar support\n",
 		  (octeon_dma_bar_type ==
-- 
1.8.3.2
