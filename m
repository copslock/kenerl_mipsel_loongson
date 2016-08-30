Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:32:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1741 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992298AbcH3RbvIlU70 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:31:51 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 60DF7C992225D;
        Tue, 30 Aug 2016 18:31:31 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:31:34 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/26] MIPS: PCI: Support generic drivers
Date:   Tue, 30 Aug 2016 18:29:09 +0100
Message-ID: <20160830172929.16948-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Introduce support for PCI drivers using only functionality provided
generically by the PCI subsystem, by adding the minimum arch-provided
functions required.

The driver this has been developed for & tested with the xilinx-pcie on
a MIPS Boston development board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/Kconfig           |  1 +
 arch/mips/pci/Makefile      |  1 +
 arch/mips/pci/pci-generic.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 arch/mips/pci/pci-generic.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 45c7895..6c5133f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2983,6 +2983,7 @@ config PCI_DOMAINS_GENERIC
 	bool
 
 config PCI_DRIVERS_GENERIC
+	select PCI_DOMAINS_GENERIC if PCI_DOMAINS
 	bool
 
 config PCI_DRIVERS_LEGACY
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 8478210..4b82148 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -4,6 +4,7 @@
 
 obj-y				+= pci.o
 obj-$(CONFIG_PCI_DRIVERS_LEGACY)+= pci-legacy.o
+obj-$(CONFIG_PCI_DRIVERS_GENERIC)+= pci-generic.o
 
 #
 # PCI bus host bridge specific code
diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
new file mode 100644
index 0000000..dce304d
--- /dev/null
+++ b/arch/mips/pci/pci-generic.c
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * pcibios_align_resource taken from arch/arm/kernel/bios32.c.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/pci.h>
+
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ *
+ * Why? Because some silly external IO cards only decode
+ * the low 10 bits of the IO address. The 0x00-0xff region
+ * is reserved for motherboard devices that decode all 16
+ * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
+ * but we want to try to avoid allocating at 0x2900-0x2bff
+ * which might have be mirrored at 0x0100-0x03ff..
+ */
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	struct pci_dev *dev = data;
+	resource_size_t start = res->start;
+	struct pci_host_bridge *host_bridge;
+
+	if (res->flags & IORESOURCE_IO && start & 0x300)
+		start = (start + 0x3ff) & ~0x3ff;
+
+	start = (start + align - 1) & ~(align - 1);
+
+	host_bridge = pci_find_host_bridge(dev->bus);
+
+	if (host_bridge->align_resource)
+		return host_bridge->align_resource(dev, res,
+				start, size, align);
+
+	return start;
+}
+
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+	pci_read_bridge_bases(bus);
+}
-- 
2.9.3
