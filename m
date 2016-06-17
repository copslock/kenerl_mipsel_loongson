Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 22:13:13 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:45210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042898AbcFQUMVtOgrF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 22:12:21 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5F1202017E;
        Fri, 17 Jun 2016 20:12:20 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83199201BC;
        Fri, 17 Jun 2016 20:12:19 +0000 (UTC)
Subject: [PATCH v1 4/4] sparc/PCI: Implement pci_resource_to_user() with
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
Date:   Fri, 17 Jun 2016 15:12:18 -0500
Message-ID: <20160617201218.11714.38929.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 54114
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
files.  On sparc, these are PCI bus addresses, i.e., raw BAR values.

Previously pci_resource_to_user() computed the user address by
subtracting either pbm->io_space.start or pbm->mem_space.start from the
resource start.

We've already told the PCI core about those offsets here:

  pci_scan_one_pbm()
    pci_add_resource_offset(&resources, &pbm->io_space, pbm->io_space.start);
    pci_add_resource_offset(&resources, &pbm->mem_space, pbm->mem_space.start);
    pci_add_resource_offset(&resources, &pbm->mem64_space, pbm->mem_space.start);

so pcibios_resource_to_bus() knows how to do that translation.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/sparc/kernel/pci.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c2b202d..9c1878f 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -986,16 +986,18 @@ void pci_resource_to_user(const struct pci_dev *pdev, int bar,
 			  const struct resource *rp, resource_size_t *start,
 			  resource_size_t *end)
 {
-	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-	unsigned long offset;
-
-	if (rp->flags & IORESOURCE_IO)
-		offset = pbm->io_space.start;
-	else
-		offset = pbm->mem_space.start;
+	struct pci_bus_region region;
 
-	*start = rp->start - offset;
-	*end = rp->end - offset;
+	/*
+	 * "User" addresses are shown in /sys/devices/pci.../.../resource
+	 * and /proc/bus/pci/devices and used as mmap offsets for
+	 * /proc/bus/pci/BB/DD.F files (see proc_bus_pci_mmap()).
+	 *
+	 * On sparc, these are PCI bus addresses, i.e., raw BAR values.
+	 */
+	pcibios_resource_to_bus(pdev->bus, &region, (struct resource *) rp);
+	*start = region.start;
+	*end = region.end;
 }
 
 void pcibios_set_master(struct pci_dev *dev)
