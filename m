Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 21:20:45 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:26319 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904621Ab1KXUUh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 21:20:37 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAOKK3M5010570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 24 Nov 2011 15:20:03 -0500
Received: from redhat.com (vpn1-7-27.ams2.redhat.com [10.36.7.27])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id pAOKJmHd007866;
        Thu, 24 Nov 2011 15:19:48 -0500
Date:   Thu, 24 Nov 2011 22:21:27 +0200
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
Subject: [PATCH-RFC 10/10] sparc: switch to GENERIC_PCI_IOMAP
Message-ID: <63292221aef2eb299e7dba860b3ee38c2ed05eb8.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1322163031.git.mst@redhat.com>
X-Mutt-Fcc: =sent
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
To:     unlisted-recipients:; (no To-header on input)
X-archive-position: 31988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21072

sparc copied pci_iomap from generic code, probably to avoid
pulling the rest of iomap.c in.  Since that's in
a separate file now, we can reuse the common implementation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sparc/Kconfig             |    1 +
 arch/sparc/include/asm/io_32.h |    5 ++++-
 arch/sparc/include/asm/io_64.h |    5 ++++-
 arch/sparc/lib/iomap.c         |   23 -----------------------
 4 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index f92602e..a4644f5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -28,6 +28,7 @@ config SPARC
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_SHOW
 	select USE_GENERIC_SMP_HELPERS if SMP
+	select GENERIC_PCI_IOMAP
 
 config SPARC32
 	def_bool !64BIT
diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index c2ced21..9be8778 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -8,6 +8,10 @@
 #include <asm/page.h>      /* IO address mapping routines need this */
 #include <asm/system.h>
 
+#ifdef __KERNEL__
+#include <asm-generic/pci_iomap.h>
+#endif
+
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 
 static inline u32 flip_dword (u32 l)
@@ -324,7 +328,6 @@ extern void ioport_unmap(void __iomem *);
 
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
 /*
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 9c89654..19cd51d 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -9,6 +9,10 @@
 #include <asm/system.h>
 #include <asm/asi.h>
 
+#ifdef __KERNEL__
+#include <asm-generic/pci_iomap.h>
+#endif
+
 /* PC crapola... */
 #define __SLOW_DOWN_IO	do { } while (0)
 #define SLOW_DOWN_IO	do { } while (0)
@@ -514,7 +518,6 @@ extern void ioport_unmap(void __iomem *);
 
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
 static inline int sbus_can_dma_64bit(void)
diff --git a/arch/sparc/lib/iomap.c b/arch/sparc/lib/iomap.c
index 9ef37e1..c4d42a5 100644
--- a/arch/sparc/lib/iomap.c
+++ b/arch/sparc/lib/iomap.c
@@ -18,31 +18,8 @@ void ioport_unmap(void __iomem *addr)
 EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
 
-/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
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
 void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 {
 	/* nothing to do */
 }
-EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
-- 
1.7.5.53.gc233e
