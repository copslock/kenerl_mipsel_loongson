Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jul 2015 14:09:52 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:57507 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011628AbbGTMJSH0pPy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jul 2015 14:09:18 +0200
Received: from 172.24.1.49 (EHLO szxeml432-hub.china.huawei.com) ([172.24.1.49])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id COZ21644;
        Mon, 20 Jul 2015 20:05:29 +0800 (CST)
Received: from localhost.localdomain (10.175.100.166) by
 szxeml432-hub.china.huawei.com (10.82.67.209) with Microsoft SMTP Server id
 14.3.158.1; Mon, 20 Jul 2015 20:05:13 +0800
From:   Yijing Wang <wangyijing@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>, <dja@axtens.net>,
        <linux-xtensa@linux-xtensa.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        <linux-alpha@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-am33-list@redhat.com>, Liviu Dudau <liviu@dudau.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH part3 v12 00/10] Cleanup platform pci_domain_nr()
Date:   Mon, 20 Jul 2015 20:01:08 +0800
Message-ID: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.166]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48357
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

This series is splitted out from previous patchset
"Refine PCI scan interfaces and make generic pci host bridge".
It try to clean up all platform pci_domain_nr(), save domain
in pci_host_bridge, so we could get domain number from the
common interface. 

v11->v12:
  Introduce wrap function pci_create_root_bus_generic()
  and pci_create_root_bus_generic() for arm/arm64 which
  enable CONFIG_PCI_DOMAINS_GENERIC.
  Rebased this series based 4.2-rc1

Yijing Wang (10):
  PCI: Save domain in pci_host_bridge
  PCI: Move pci_bus_assign_domain_nr() declaration into
    drivers/pci/pci.h
  PCI: Remove declaration for pci_get_new_domain_nr()
  PCI: Introduce pci_host_assign_domain_nr() to assign domain
  powerpc/PCI: Rename pcibios_root_bridge_prepare() to
    pcibios_root_bus_prepare()
  PCI: Make pci_host_bridge hold sysdata in drvdata
  PCI: Create pci host bridge prior to root bus
  PCI: Introduce common pci_domain_nr() and remove platform specific
    code
  PCI: Remove pci_bus_assign_domain_nr()
  IA64/PCI: Fix build warning found by kbuild test

 arch/alpha/include/asm/pci.h             |    2 -
 arch/alpha/kernel/pci.c                  |    4 +-
 arch/alpha/kernel/sys_nautilus.c         |    2 +-
 arch/arm/kernel/bios32.c                 |    2 +-
 arch/arm/mach-dove/pcie.c                |    2 +-
 arch/arm/mach-iop13xx/pci.c              |    4 +-
 arch/arm/mach-mv78xx0/pcie.c             |    2 +-
 arch/arm/mach-orion5x/pci.c              |    4 +-
 arch/frv/mb93090-mb00/pci-vdk.c          |    3 +-
 arch/ia64/include/asm/pci.h              |    1 -
 arch/ia64/pci/pci.c                      |    6 +-
 arch/ia64/sn/kernel/io_acpi_init.c       |    6 +-
 arch/ia64/sn/kernel/io_init.c            |    6 +-
 arch/m68k/coldfire/pci.c                 |    2 +-
 arch/microblaze/include/asm/pci.h        |    2 -
 arch/microblaze/pci/pci-common.c         |   15 +----
 arch/mips/include/asm/pci.h              |    2 -
 arch/mips/pci/pci.c                      |    4 +-
 arch/mn10300/unit-asb2305/pci.c          |    3 +-
 arch/powerpc/include/asm/machdep.h       |    2 +-
 arch/powerpc/include/asm/pci.h           |    2 -
 arch/powerpc/kernel/pci-common.c         |   21 ++-----
 arch/powerpc/platforms/pseries/pci.c     |    2 +-
 arch/powerpc/platforms/pseries/pseries.h |    2 +-
 arch/powerpc/platforms/pseries/setup.c   |    2 +-
 arch/s390/include/asm/pci.h              |    1 -
 arch/s390/pci/pci.c                      |   10 +---
 arch/sh/drivers/pci/pci.c                |    4 +-
 arch/sh/include/asm/pci.h                |    2 -
 arch/sparc/include/asm/pci_64.h          |    1 -
 arch/sparc/kernel/leon_pci.c             |    2 +-
 arch/sparc/kernel/pci.c                  |   21 +------
 arch/sparc/kernel/pcic.c                 |    2 +-
 arch/tile/include/asm/pci.h              |    2 -
 arch/tile/kernel/pci.c                   |    4 +-
 arch/tile/kernel/pci_gx.c                |    4 +-
 arch/unicore32/kernel/pci.c              |    2 +-
 arch/x86/include/asm/pci.h               |    6 --
 arch/x86/pci/acpi.c                      |    6 +-
 arch/x86/pci/common.c                    |    2 +-
 arch/xtensa/kernel/pci.c                 |    2 +-
 drivers/parisc/dino.c                    |    2 +-
 drivers/parisc/lba_pci.c                 |    2 +-
 drivers/pci/host/pci-versatile.c         |    3 +-
 drivers/pci/host/pci-xgene.c             |    2 +-
 drivers/pci/host/pcie-designware.c       |    2 +-
 drivers/pci/host/pcie-iproc.c            |    2 +-
 drivers/pci/host/pcie-xilinx.c           |    2 +-
 drivers/pci/hotplug/ibmphp_core.c        |    2 +-
 drivers/pci/pci.c                        |   31 ++++++++--
 drivers/pci/pci.h                        |    1 +
 drivers/pci/probe.c                      |   92 +++++++++++++++++-------------
 drivers/pci/xen-pcifront.c               |    2 +-
 include/linux/pci.h                      |   39 ++++++-------
 54 files changed, 161 insertions(+), 195 deletions(-)
