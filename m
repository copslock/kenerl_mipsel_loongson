Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jul 2013 19:29:26 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:35020 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827441Ab3GYR3XmjtYR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jul 2013 19:29:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id D6E525A6DAF;
        Thu, 25 Jul 2013 20:29:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id Aor6W0LK5Te3; Thu, 25 Jul 2013 20:29:18 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id 8E8195BC012;
        Thu, 25 Jul 2013 20:29:18 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Faidon Liambotis <paravoid@debian.org>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v3] MIPS: cavium-octeon: fix I/O space setup on non-PCI systems
Date:   Thu, 25 Jul 2013 20:26:48 +0300
Message-Id: <1374773208-2827-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37374
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
that purpose we can just allocate some normal memory initially. Drivers
trying to reserve a region will fail early as we set the size to 0. If
a real I/O space is present, the PCI/PCIe support code will re-adjust
the values accordingly.

Tested with EdgeRouter Lite by enabling CONFIG_SERIO_I8042 that caused
the originally reported crash.

Reported-by: Faidon Liambotis <paravoid@debian.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: David Daney <david.daney@cavium.com>
---

	v3: Move octeon_no_pci_init() to core_initcall
	    (http://marc.info/?t=137452306500001&r=1&w=2).

	v2: Address the issues found from the first version of the patch
	    (http://marc.info/?t=137434204000002&r=1&w=2).

 arch/mips/cavium-octeon/setup.c | 28 ++++++++++++++++++++++++++++
 arch/mips/pci/pci-octeon.c      |  9 +++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 48b08eb..b212ae1 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -8,6 +8,7 @@
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
 #include <linux/compiler.h>
+#include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/console.h>
@@ -1139,3 +1140,30 @@ static int __init edac_devinit(void)
 	return err;
 }
 device_initcall(edac_devinit);
+
+static void __initdata *octeon_dummy_iospace;
+
+static int __init octeon_no_pci_init(void)
+{
+	/*
+	 * Initially assume there is no PCI. The PCI/PCIe platform code will
+	 * later re-initialize these to correct values if they are present.
+	 */
+	octeon_dummy_iospace = vzalloc(IO_SPACE_LIMIT);
+	set_io_port_base((unsigned long)octeon_dummy_iospace);
+	ioport_resource.start = MAX_RESOURCE;
+	ioport_resource.end = 0;
+	return 0;
+}
+core_initcall(octeon_no_pci_init);
+
+static int __init octeon_no_pci_release(void)
+{
+	/*
+	 * Release the allocated memory if a real IO space is there.
+	 */
+	if ((unsigned long)octeon_dummy_iospace != mips_io_port_base)
+		vfree(octeon_dummy_iospace);
+	return 0;
+}
+late_initcall(octeon_no_pci_release);
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 95c2ea8..59cccd9 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -586,15 +586,16 @@ static int __init octeon_pci_setup(void)
 	else
 		octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_BIG;
 
-	/* PCI I/O and PCI MEM values */
-	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
-	ioport_resource.start = 0;
-	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
 	if (!octeon_is_pci_host()) {
 		pr_notice("Not in host mode, PCI Controller not initialized\n");
 		return 0;
 	}
 
+	/* PCI I/O and PCI MEM values */
+	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
+	ioport_resource.start = 0;
+	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
+
 	pr_notice("%s Octeon big bar support\n",
 		  (octeon_dma_bar_type ==
 		  OCTEON_DMA_BAR_TYPE_BIG) ? "Enabling" : "Disabling");
-- 
1.8.3.2
