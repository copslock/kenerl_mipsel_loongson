Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 15:58:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52681 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6826484Ab3F0N6mjUnBg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 15:58:42 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5RDwfG7014000;
        Thu, 27 Jun 2013 15:58:41 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5RDweKP013999;
        Thu, 27 Jun 2013 15:58:40 +0200
Date:   Thu, 27 Jun 2013 15:58:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Expose missing pci_io{map,unmap} declarations
Message-ID: <20130627135840.GA10727@linux-mips.org>
References: <1371460140-5626-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371460140-5626-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Jun 17, 2013 at 10:09:00AM +0100, Markos Chandras wrote:

> The GENERIC_PCI_IOMAP does not depend on CONFIG_PCI so move
> it to the CONFIG_MIPS symbol so it's always selected for MIPS.
> This fixes the missing pci_iomap declaration for MIPS.
> Moreover, the pci_iounmap function was not defined in the
> io.h header file if the CONFIG_PCI symbol is not set,
> but it should since MIPS is not using CONFIG_GENERIC_IOMAP.
> 
> This fixes the following problem on a allyesconfig:
> 
> drivers/net/ethernet/3com/3c59x.c:1031:2: error: implicit declaration of
> function 'pci_iomap' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/3com/3c59x.c:1044:3: error: implicit declaration of
> function 'pci_iounmap' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com> 

Hmm...  Looking at the code I find that it appears that GENERIC_PCI_IOMAP
was never really meant to be enabled with PCI (though some architectures
are using that) so I was wondering if maybe something like below would
have been better.  Either way, you sent the first patch, so I'm applying
that one.

Thanks!

  Ralf

 arch/mips/include/asm/io.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index b7e5985..dc81131 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -620,4 +620,17 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
  */
 #define xlate_dev_kmem_ptr(p)	p
 
+#ifndef CONFIG_PCI
+struct pci_dev;
+
+static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar,
+	unsigned long max)
+{
+	return NULL;
+}
+
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {}
+
+#endif /* CONFIG_PCI */
+
 #endif /* _ASM_IO_H */
