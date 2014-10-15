Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2014 04:30:00 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:16221 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010645AbaJOC0FLIOV9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Oct 2014 04:26:05 +0200
Received: from 172.24.2.119 (EHLO szxeml412-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CAT35294;
        Wed, 15 Oct 2014 10:25:24 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml412-hub.china.huawei.com (10.82.67.91) with Microsoft SMTP Server id
 14.3.158.1; Wed, 15 Oct 2014 10:25:05 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        <linux-arch@vger.kernel.org>, <arnab.basu@freescale.com>,
        <Bharat.Bhushan@freescale.com>, <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        "Tony Luck" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>,
        Liviu Dudau <liviu@dudau.co.uk>,
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 00/27] Use MSI chip framework to configure MSI/MSI-X in all platforms
Date:   Wed, 15 Oct 2014 11:06:48 +0800
Message-ID: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

Now there are a lot of weak arch functions in MSI code.
Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm,
that's a better solution than overriding lots of existing weak arch functionsin. 
This series use MSI chip framework to refactor MSI code across all platforms 
to eliminate weak arch functions. Then all MSI irqs will be managed in a 
unified framework. Because this series changed a lot of ARCH MSI code, 
so tests in the related platforms are warmly welcomed!

And you may access it at:
https://github.com/YijingWang/msi-chip-v3.git master

v2->v3:
1. For patch "x86/xen/MSI: Eliminate...", introduce a new global flag "pci_msi_ignore_mask"
to control the msi mask instead of replacing the irqchip->mask with nop function,
the latter method has problem pointed out by Konrad Rzeszutek Wilk.
2. Save msi chip in arch pci sysdata instead of associating msi chip to pci bus.
Because pci devices under same host share the same msi chip, so I think associate
msi chip to pci host/pci sysdata is better than to bother every pci bus/devices.
A better solution suggested by Liviu is to rip out pci_host_bridge from pci_create_root_bus(), 
then we can save some pci host common attributes like domain_nr, msi_chip, resources,
into the generic pci_host_bridge. Because this changes to pci host bridge is also 
a large series, so I think we should go step by step, I will try to post it in another
series later.
4. Clean up arm pcibios_add_bus() and pcibios_remove_bus() which were used to associate
msi chip to pci bus.

v1->v2:
Add a patch to make s390 MSI code build happy between patch "x86/xen/MSI: E.."
and "s390/MSI: Use MSI..". Fix several typo problems found by Lucas.

RFC->v1: 
Updated "[patch 4/21] x86/xen/MSI: Eliminate...", export msi_chip instead
of #ifdef to fix MSI bug in xen running in x86. 
Rename arch_get_match_msi_chip() to arch_find_msi_chip().
Drop use struct device as the msi_chip argument, we will do that
later in another patchset.

Yijing Wang (27):
  MSI: Remove the redundant irq_set_chip_data()
  x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()
  s390/MSI: Use __msi_mask_irq() instead of default_msi_mask_irq()
  arm/MSI: Save MSI chip in pci_sys_data
  PCI: tegra: Save msi chip in pci_sys_data
  PCI: designware: Save msi chip in pci_sys_data
  PCI: rcar: Save msi chip in pci_sys_data
  PCI: mvebu: Save msi chip in pci_sys_data
  arm/PCI: Clean unused pcibios_add_bus() and pcibios_remove_bus()
  PCI/MSI: Remove useless bus->msi assignment
  PCI/MSI: Refactor struct msi_chip to make it become more common
  x86/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  x86/xen/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  Irq_remapping/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  x86/MSI: Remove unused MSI weak arch functions
  Mips/MSI: Save msi chip in pci sysdata
  MIPS/Octeon/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  MIPS/Xlp: Remove the dead function destroy_irq() to fix build error
  MIPS/Xlp/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  MIPS/Xlr/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  Powerpc/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  s390/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  arm/iop13xx/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  IA64/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  Sparc/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  tile/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  PCI/MSI: Clean up unused MSI arch functions

 arch/arm/include/asm/mach/pci.h                 |   10 +-
 arch/arm/include/asm/pci.h                      |    9 ++
 arch/arm/kernel/bios32.c                        |   19 +---
 arch/arm/mach-iop13xx/include/mach/pci.h        |    4 +
 arch/arm/mach-iop13xx/iq81340mc.c               |    3 +
 arch/arm/mach-iop13xx/iq81340sc.c               |    5 +-
 arch/arm/mach-iop13xx/msi.c                     |   11 ++-
 arch/ia64/include/asm/pci.h                     |   10 ++
 arch/ia64/kernel/msi_ia64.c                     |   14 ++-
 arch/ia64/pci/pci.c                             |    1 +
 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h |    1 +
 arch/mips/include/asm/octeon/pci-octeon.h       |    4 +
 arch/mips/include/asm/pci.h                     |   14 +++
 arch/mips/pci/msi-octeon.c                      |   31 +++---
 arch/mips/pci/msi-xlp.c                         |   15 ++-
 arch/mips/pci/pci-octeon.c                      |    3 +
 arch/mips/pci/pci-xlp.c                         |    3 +
 arch/mips/pci/pci-xlr.c                         |   17 +++-
 arch/powerpc/include/asm/pci-bridge.h           |   15 +++
 arch/powerpc/kernel/msi.c                       |   12 ++-
 arch/powerpc/kernel/pci-common.c                |    3 +
 arch/s390/include/asm/pci.h                     |    9 ++
 arch/s390/pci/pci.c                             |   16 ++-
 arch/sparc/kernel/pci.c                         |   14 ++-
 arch/sparc/kernel/pci_impl.h                    |   12 ++
 arch/tile/include/asm/pci.h                     |   10 ++
 arch/tile/kernel/pci_gx.c                       |   13 ++-
 arch/x86/include/asm/pci.h                      |   18 +++-
 arch/x86/include/asm/x86_init.h                 |    7 --
 arch/x86/kernel/apic/io_apic.c                  |   12 ++-
 arch/x86/kernel/x86_init.c                      |   34 ------
 arch/x86/pci/acpi.c                             |    1 +
 arch/x86/pci/common.c                           |    3 +
 arch/x86/pci/xen.c                              |   72 +++++++------
 drivers/iommu/irq_remapping.c                   |   13 ++-
 drivers/pci/host/pci-mvebu.c                    |   10 +--
 drivers/pci/host/pci-tegra.c                    |   13 +--
 drivers/pci/host/pcie-designware.c              |   15 +--
 drivers/pci/host/pcie-rcar.c                    |   13 +--
 drivers/pci/msi.c                               |  133 ++++++++++-------------
 drivers/pci/probe.c                             |    1 -
 include/linux/msi.h                             |   24 ++---
 include/linux/pci.h                             |    1 +
 43 files changed, 379 insertions(+), 269 deletions(-)
