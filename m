Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 21:16:51 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:12931 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904619Ab1KXUQf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 21:16:35 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAOKFx2W001789
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 24 Nov 2011 15:15:59 -0500
Received: from redhat.com (vpn1-7-27.ams2.redhat.com [10.36.7.27])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id pAOKFhbQ005250;
        Thu, 24 Nov 2011 15:15:44 -0500
Date:   Thu, 24 Nov 2011 22:17:23 +0200
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
Subject: [PATCH-RFC 03/10] alpha: switch to GENERIC_PCI_IOMAP
Message-ID: <4245e7d8f484de6512fd4a9e4cba5b90cc111899.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1322163031.git.mst@redhat.com>
X-Mutt-Fcc: =sent
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
To:     unlisted-recipients:; (no To-header on input)
X-archive-position: 31981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21064

alpha copied pci_iomap from generic code to avoid
pulling the rest of iomap.c in.  Since that's in
a separate file now, we can reuse the common implementation.

The only difference is handling of nocache flag,
that turns out to be done correctly by the
generic code since arch/alpha/include/asm/io.h
defines ioremap_nocache same as ioremap.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/alpha/Kconfig      |    1 +
 arch/alpha/kernel/pci.c |   26 +-------------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 3636b11..56a4df9 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -315,6 +315,7 @@ config ISA_DMA_API
 config PCI
 	bool
 	depends on !ALPHA_JENSEN
+	select GENERIC_PCI_IOMAP
 	default y
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index c9ab94e..f3cae27 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -508,30 +508,7 @@ sys_pciconfig_iobase(long which, unsigned long bus, unsigned long dfn)
 	return -EOPNOTSUPP;
 }
 
-/* Create an __iomem token from a PCI BAR.  Copied from lib/iomap.c with
-   no changes, since we don't want the other things in that object file.  */
-
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
-		/* Not checking IORESOURCE_CACHEABLE because alpha does
-		   not distinguish between ioremap and ioremap_nocache.  */
-		return ioremap(start, len);
-	}
-	return NULL;
-}
-
-/* Destroy that token.  Not copied from lib/iomap.c.  */
+/* Destroy an __iomem token.  Not copied from lib/iomap.c.  */
 
 void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 {
@@ -539,7 +516,6 @@ void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 		iounmap(addr);
 }
 
-EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
 
 /* FIXME: Some boxes have multiple ISA bridges! */
-- 
1.7.5.53.gc233e
