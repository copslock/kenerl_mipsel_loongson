Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 21:16:24 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:47324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904616Ab1KXUQP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 21:16:15 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAOKFcB6001765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 24 Nov 2011 15:15:38 -0500
Received: from redhat.com (vpn1-7-27.ams2.redhat.com [10.36.7.27])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id pAOKFNt2010413;
        Thu, 24 Nov 2011 15:15:23 -0500
Date:   Thu, 24 Nov 2011 22:17:02 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <rob.herring@calxeda.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Fabio Baltieri <fabio.baltieri@gmail.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        "John W. Linville" <linville@tuxdriver.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Arend van Spriel <arend@broadcom.com>,
        Franky Lin <frankyl@broadcom.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linux@openrisc.net, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH-RFC 02/10] lib: add GENERIC_PCI_IOMAP
Message-ID: <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1322163031.git.mst@redhat.com>
X-Mutt-Fcc: =sent
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
To:     unlisted-recipients:; (no To-header on input)
X-archive-position: 31980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21063

Many architectures want a generic pci_iomap but
not the rest of iomap.c. Split that to a separate .c
file and add a new config symbol. select automatically
by GENERIC_IOMAP.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/asm-generic/io.h        |    5 +--
 include/asm-generic/iomap.h     |    7 +----
 include/asm-generic/pci_iomap.h |   26 +++++++++++++++++++++
 lib/Kconfig                     |    4 +++
 lib/Makefile                    |    1 +
 lib/iomap.c                     |   38 +-----------------------------
 lib/pci_iomap.c                 |   48 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 85 insertions(+), 44 deletions(-)
 create mode 100644 include/asm-generic/pci_iomap.h
 create mode 100644 lib/pci_iomap.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 9120887..c8a67345 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -19,6 +19,8 @@
 #include <asm-generic/iomap.h>
 #endif
 
+#include <asm-generic/pci_iomap.h>
+
 #ifndef mmiowb
 #define mmiowb() do {} while (0)
 #endif
@@ -283,9 +285,6 @@ static inline void writesb(const void __iomem *addr, const void *buf, int len)
 #define __io_virt(x) ((void __force *) (x))
 
 #ifndef CONFIG_GENERIC_IOMAP
-/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
-struct pci_dev;
-extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 {
 }
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 98dcd76..fdcddcb 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -69,16 +69,13 @@ extern void ioport_unmap(void __iomem *);
 #ifdef CONFIG_PCI
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 #else
 struct pci_dev;
-static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
-{
-	return NULL;
-}
 static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 { }
 #endif
 
+#include <asm-generic/pci_iomap.h>
+
 #endif
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
new file mode 100644
index 0000000..e08b3bd
--- /dev/null
+++ b/include/asm-generic/pci_iomap.h
@@ -0,0 +1,26 @@
+/* Generic I/O port emulation, based on MN10300 code
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+#ifndef __ASM_GENERIC_PCI_IOMAP_H
+#define __ASM_GENERIC_PCI_IOMAP_H
+
+#ifdef CONFIG_PCI
+/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
+struct pci_dev;
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+#else
+struct pci_dev;
+static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __ASM_GENERIC_IO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 0058927..36884b4 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -19,8 +19,12 @@ config RATIONAL
 config GENERIC_FIND_FIRST_BIT
 	bool
 
+config GENERIC_PCI_IOMAP
+	bool
+
 config GENERIC_IOMAP
 	bool
+	select GENERIC_PCI_IOMAP
 
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
diff --git a/lib/Makefile b/lib/Makefile
index a4da283..609b2adc 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -33,6 +33,7 @@ endif
 
 lib-$(CONFIG_HOTPLUG) += kobject_uevent.o
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
diff --git a/lib/iomap.c b/lib/iomap.c
index 5dbcb4b..ada922a 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -242,45 +242,11 @@ EXPORT_SYMBOL(ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT */
 
 #ifdef CONFIG_PCI
-/**
- * pci_iomap - create a virtual mapping cookie for a PCI BAR
- * @dev: PCI device that owns the BAR
- * @bar: BAR number
- * @maxlen: length of the memory to map
- *
- * Using this function you will get a __iomem address to your device BAR.
- * You can access it using ioread*() and iowrite*(). These functions hide
- * the details if this is a MMIO or PIO address space and will just do what
- * you expect from them in the correct way.
- *
- * @maxlen specifies the maximum length to map. If you want to get access to
- * the complete BAR without checking for its length first, pass %0 here.
- * */
-void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
-{
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-	if (!len || !start)
-		return NULL;
-	if (maxlen && len > maxlen)
-		len = maxlen;
-	if (flags & IORESOURCE_IO)
-		return ioport_map(start, len);
-	if (flags & IORESOURCE_MEM) {
-		if (flags & IORESOURCE_CACHEABLE)
-			return ioremap(start, len);
-		return ioremap_nocache(start, len);
-	}
-	/* What? */
-	return NULL;
-}
-
+/* Hide the details if this is a MMIO or PIO address space and just do what
+ * you expect in the correct way. */
 void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 {
 	IO_COND(addr, /* nothing */, iounmap(addr));
 }
-EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
 #endif /* CONFIG_PCI */
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
new file mode 100644
index 0000000..40b26cb
--- /dev/null
+++ b/lib/pci_iomap.c
@@ -0,0 +1,48 @@
+/*
+ * Implement the default iomap interfaces
+ *
+ * (C) Copyright 2004 Linus Torvalds
+ */
+#include <linux/pci.h>
+#include <linux/io.h>
+
+#include <linux/module.h>
+
+#ifdef CONFIG_PCI
+/**
+ * pci_iomap - create a virtual mapping cookie for a PCI BAR
+ * @dev: PCI device that owns the BAR
+ * @bar: BAR number
+ * @maxlen: length of the memory to map
+ *
+ * Using this function you will get a __iomem address to your device BAR.
+ * You can access it using ioread*() and iowrite*(). These functions hide
+ * the details if this is a MMIO or PIO address space and will just do what
+ * you expect from them in the correct way.
+ *
+ * @maxlen specifies the maximum length to map. If you want to get access to
+ * the complete BAR without checking for its length first, pass %0 here.
+ * */
+void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
+{
+	resource_size_t start = pci_resource_start(dev, bar);
+	resource_size_t len = pci_resource_len(dev, bar);
+	unsigned long flags = pci_resource_flags(dev, bar);
+
+	if (!len || !start)
+		return NULL;
+	if (maxlen && len > maxlen)
+		len = maxlen;
+	if (flags & IORESOURCE_IO)
+		return ioport_map(start, len);
+	if (flags & IORESOURCE_MEM) {
+		if (flags & IORESOURCE_CACHEABLE)
+			return ioremap(start, len);
+		return ioremap_nocache(start, len);
+	}
+	/* What? */
+	return NULL;
+}
+
+EXPORT_SYMBOL(pci_iomap);
+#endif /* CONFIG_PCI */
-- 
1.7.5.53.gc233e
