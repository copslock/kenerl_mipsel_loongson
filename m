Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 22:12:51 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:45168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042887AbcFQUMOi2HSF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 22:12:14 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id ED2BB2017E;
        Fri, 17 Jun 2016 20:12:12 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E7A201BC;
        Fri, 17 Jun 2016 20:12:11 +0000 (UTC)
Subject: [PATCH v1 3/4] powerpc/pci: Implement pci_resource_to_user() with
 pcibios_resource_to_bus()
To:     Michal Simek <monstr@monstr.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yinghai Lu <yinghai@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     sparclinux@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Fri, 17 Jun 2016 15:12:10 -0500
Message-ID: <20160617201210.11714.5624.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

"User" addresses are shown in /sys/devices/pci.../.../resource and
/proc/bus/pci/devices and used as mmap offsets for /proc/bus/pci/BB/DD.F
files.  For I/O port resources on powerpc, these are PCI bus addresses,
i.e., raw BAR values.

Previously pci_resource_to_user() computed the user address by subtracting
"hose->io_base_virt - _IO_BASE" from the resource start:

  pci_resource_to_user()
    if (IO)
      offset = (unsigned long)hose->io_base_virt - _IO_BASE;
    *start = rsrc->start - offset;

We've already told the PCI core about that "hose->io_base_virt - _IO_BASE"
offset:

  pcibios_setup_phb_resources()
    res = &hose->io_resource;
    offset = pcibios_io_space_offset();
    /* i.e., "offset = hose->io_base_virt - _IO_BASE" */
    pci_add_resource_offset(resources, res, offset);

so pcibios_resource_to_bus() knows how to do that translation.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/powerpc/kernel/pci-common.c |   42 +++++++++++++-------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8c6beb0..6de6e0e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -581,39 +581,25 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
 			  resource_size_t *start, resource_size_t *end)
 {
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	resource_size_t offset = 0;
+	struct pci_bus_region region;
 
-	if (hose == NULL)
+	if (rsrc->flags & IORESOURCE_IO) {
+		pcibios_resource_to_bus(dev->bus, &region,
+					(struct resource *) rsrc);
+		*start = region.start;
+		*end = region.end;
 		return;
+	}
 
-	if (rsrc->flags & IORESOURCE_IO)
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-
-	/* We pass a fully fixed up address to userland for MMIO instead of
-	 * a BAR value because X is lame and expects to be able to use that
-	 * to pass to /dev/mem !
-	 *
-	 * That means that we'll have potentially 64 bits values where some
-	 * userland apps only expect 32 (like X itself since it thinks only
-	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
-	 * 32 bits CHRPs :-(
-	 *
-	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
-	 * has been fixed (and the fix spread enough), we can re-enable the
-	 * 2 lines below and pass down a BAR value to userland. In that case
-	 * we'll also have to re-enable the matching code in
-	 * __pci_mmap_make_offset().
+	/* We pass a CPU physical address to userland for MMIO instead of a
+	 * BAR value because X is lame and expects to be able to use that
+	 * to pass to /dev/mem!
 	 *
-	 * BenH.
+	 * That means we may have 64-bit values where some apps only expect
+	 * 32 (like X itself since it thinks only Sparc has 64-bit MMIO).
 	 */
-#if 0
-	else if (rsrc->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-#endif
-
-	*start = rsrc->start - offset;
-	*end = rsrc->end - offset;
+	*start = rsrc->start;
+	*end = rsrc->end;
 }
 
 /**
