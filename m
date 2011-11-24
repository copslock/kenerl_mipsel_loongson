Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 21:18:13 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:62566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904622Ab1KXURw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 21:17:52 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAOKHDiD002631
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 24 Nov 2011 15:17:13 -0500
Received: from redhat.com (vpn1-7-27.ams2.redhat.com [10.36.7.27])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id pAOKGvr5016608;
        Thu, 24 Nov 2011 15:16:58 -0500
Date:   Thu, 24 Nov 2011 22:18:37 +0200
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
Subject: [PATCH-RFC 06/10] mips: switch to GENERIC_PCI_IOMAP
Message-ID: <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1322163031.git.mst@redhat.com>
X-Mutt-Fcc: =sent
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
To:     unlisted-recipients:; (no To-header on input)
X-archive-position: 31984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21068

mips copied pci_iomap from generic code, probably to avoid
pulling the rest of iomap.c in.  Since that's in
a separate file now, we can reuse the common implementation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/mips/Kconfig         |    1 +
 arch/mips/lib/iomap-pci.c |   26 --------------------------
 2 files changed, 1 insertions(+), 26 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d46f1da..b70c96f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2317,6 +2317,7 @@ config PCI
 	bool "Support for PCI controller"
 	depends on HW_HAS_PCI
 	select PCI_DOMAINS
+	select GENERIC_PCI_IOMAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
index 2ab899c..2635b1a 100644
--- a/arch/mips/lib/iomap-pci.c
+++ b/arch/mips/lib/iomap-pci.c
@@ -40,32 +40,6 @@ static void __iomem *ioport_map_pci(struct pci_dev *dev,
 	return (void __iomem *) (ctrl->io_map_base + port);
 }
 
-/*
- * Create a virtual mapping cookie for a PCI BAR (memory or IO)
- */
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
-		return ioport_map_pci(dev, start, len);
-	if (flags & IORESOURCE_MEM) {
-		if (flags & IORESOURCE_CACHEABLE)
-			return ioremap(start, len);
-		return ioremap_nocache(start, len);
-	}
-	/* What? */
-	return NULL;
-}
-
-EXPORT_SYMBOL(pci_iomap);
-
 void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 {
 	iounmap(addr);
-- 
1.7.5.53.gc233e
