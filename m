Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 11:47:18 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:63200 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007052AbaIEJqRvvld9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 11:46:17 +0200
Received: from 172.24.2.119 (EHLO szxeml419-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id ATY92828;
        Fri, 05 Sep 2014 17:45:42 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml419-hub.china.huawei.com (10.82.67.158) with Microsoft SMTP Server id
 14.3.158.1; Fri, 5 Sep 2014 17:45:25 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Russell King" <linux@arm.linux.org.uk>,
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
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v1 00/21] Use MSI chip to configure MSI/MSI-X in all platforms
Date:   Fri, 5 Sep 2014 18:09:45 +0800
Message-ID: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020207.5409864A.0172,ss=1,re=0.000,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2011-05-27 18:58:46
X-Mirapoint-Loop-Id: e33c99742746a829d06c096043249d49
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42405
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

This series is based Bjorn's pci-next branch + Alexander Gordeev's two patches
"Remove arch_msi_check_device()" link: https://lkml.org/lkml/2014/7/12/41

Currently, there are a lot of weak arch functions in MSI code.
Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm.
This series use MSI chip framework to refactor MSI code across all platforms
to eliminate weak arch functions. It has been tested fine in x86(with or without
irq remap).


RFC->v1: Updated "[patch 4/21] x86/xen/MSI: Eliminate...", export msi_chip instead
         of #ifdef to fix MSI bug in xen running in x86. 
		 Rename arch_get_match_msi_chip() to arch_find_msi_chip().
		 Drop use struct device as the msi_chip argument, we will do that
		 later in another patchset.

Yijing Wang (21):
  PCI/MSI: Clean up struct msi_chip argument
  PCI/MSI: Remove useless bus->msi assignment
  MSI: Remove the redundant irq_set_chip_data()
  x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()
  PCI/MSI: Introduce weak arch_find_msi_chip() to find MSI chip
  PCI/MSI: Refactor struct msi_chip to make it become more common
  x86/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  x86/xen/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  Irq_remapping/MSI: Use MSI chip framework to configure MSI/MSI-X irq
  x86/MSI: Remove unused MSI weak arch functions
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

 arch/arm/mach-iop13xx/include/mach/pci.h |    2 +
 arch/arm/mach-iop13xx/iq81340mc.c        |    1 +
 arch/arm/mach-iop13xx/iq81340sc.c        |    1 +
 arch/arm/mach-iop13xx/msi.c              |    9 ++-
 arch/arm/mach-iop13xx/pci.c              |    6 ++
 arch/ia64/kernel/msi_ia64.c              |   18 ++++-
 arch/mips/pci/msi-octeon.c               |   35 +++++---
 arch/mips/pci/msi-xlp.c                  |   18 +++-
 arch/mips/pci/pci-xlr.c                  |   15 +++-
 arch/powerpc/kernel/msi.c                |   14 +++-
 arch/s390/pci/pci.c                      |   18 ++++-
 arch/sparc/kernel/pci.c                  |   14 +++-
 arch/tile/kernel/pci_gx.c                |   14 +++-
 arch/x86/include/asm/apic.h              |    4 +
 arch/x86/include/asm/pci.h               |    4 +-
 arch/x86/include/asm/x86_init.h          |    7 --
 arch/x86/kernel/apic/io_apic.c           |   16 ++++-
 arch/x86/kernel/x86_init.c               |   34 --------
 arch/x86/pci/xen.c                       |   60 +++++++++------
 drivers/iommu/irq_remapping.c            |    9 ++-
 drivers/irqchip/irq-armada-370-xp.c      |   12 +--
 drivers/pci/host/pci-tegra.c             |    8 +-
 drivers/pci/host/pcie-designware.c       |    4 +-
 drivers/pci/host/pcie-rcar.c             |    8 +-
 drivers/pci/msi.c                        |  123 +++++++++++++-----------------
 drivers/pci/probe.c                      |    1 -
 include/linux/msi.h                      |   26 ++-----
 27 files changed, 268 insertions(+), 213 deletions(-)
