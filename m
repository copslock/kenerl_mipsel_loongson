Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 22:54:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:35265 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011995AbbLGVyIO2n0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Dec 2015 22:54:08 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 9EF6A20532;
        Mon,  7 Dec 2015 21:54:05 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C5320461;
        Mon,  7 Dec 2015 21:54:01 +0000 (UTC)
Date:   Mon, 7 Dec 2015 15:53:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>, dja@axtens.net,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-alpha@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
        Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH part3 v12 00/10] Cleanup platform pci_domain_nr()
Message-ID: <20151207215356.GD14429@localhost>
References: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

On Mon, Jul 20, 2015 at 08:01:08PM +0800, Yijing Wang wrote:
> This series is splitted out from previous patchset
> "Refine PCI scan interfaces and make generic pci host bridge".
> It try to clean up all platform pci_domain_nr(), save domain
> in pci_host_bridge, so we could get domain number from the
> common interface. 
> 
> v11->v12:
>   Introduce wrap function pci_create_root_bus_generic()
>   and pci_create_root_bus_generic() for arm/arm64 which
>   enable CONFIG_PCI_DOMAINS_GENERIC.
>   Rebased this series based 4.2-rc1
> 
> Yijing Wang (10):
>   PCI: Save domain in pci_host_bridge
>   PCI: Move pci_bus_assign_domain_nr() declaration into
>     drivers/pci/pci.h
>   PCI: Remove declaration for pci_get_new_domain_nr()
>   PCI: Introduce pci_host_assign_domain_nr() to assign domain
>   powerpc/PCI: Rename pcibios_root_bridge_prepare() to
>     pcibios_root_bus_prepare()
>   PCI: Make pci_host_bridge hold sysdata in drvdata
>   PCI: Create pci host bridge prior to root bus
>   PCI: Introduce common pci_domain_nr() and remove platform specific
>     code
>   PCI: Remove pci_bus_assign_domain_nr()
>   IA64/PCI: Fix build warning found by kbuild test
> 
>  arch/alpha/include/asm/pci.h             |    2 -
>  arch/alpha/kernel/pci.c                  |    4 +-
>  arch/alpha/kernel/sys_nautilus.c         |    2 +-
>  arch/arm/kernel/bios32.c                 |    2 +-
>  arch/arm/mach-dove/pcie.c                |    2 +-
>  arch/arm/mach-iop13xx/pci.c              |    4 +-
>  arch/arm/mach-mv78xx0/pcie.c             |    2 +-
>  arch/arm/mach-orion5x/pci.c              |    4 +-
>  arch/frv/mb93090-mb00/pci-vdk.c          |    3 +-
>  arch/ia64/include/asm/pci.h              |    1 -
>  arch/ia64/pci/pci.c                      |    6 +-
>  arch/ia64/sn/kernel/io_acpi_init.c       |    6 +-
>  arch/ia64/sn/kernel/io_init.c            |    6 +-
>  arch/m68k/coldfire/pci.c                 |    2 +-
>  arch/microblaze/include/asm/pci.h        |    2 -
>  arch/microblaze/pci/pci-common.c         |   15 +----
>  arch/mips/include/asm/pci.h              |    2 -
>  arch/mips/pci/pci.c                      |    4 +-
>  arch/mn10300/unit-asb2305/pci.c          |    3 +-
>  arch/powerpc/include/asm/machdep.h       |    2 +-
>  arch/powerpc/include/asm/pci.h           |    2 -
>  arch/powerpc/kernel/pci-common.c         |   21 ++-----
>  arch/powerpc/platforms/pseries/pci.c     |    2 +-
>  arch/powerpc/platforms/pseries/pseries.h |    2 +-
>  arch/powerpc/platforms/pseries/setup.c   |    2 +-
>  arch/s390/include/asm/pci.h              |    1 -
>  arch/s390/pci/pci.c                      |   10 +---
>  arch/sh/drivers/pci/pci.c                |    4 +-
>  arch/sh/include/asm/pci.h                |    2 -
>  arch/sparc/include/asm/pci_64.h          |    1 -
>  arch/sparc/kernel/leon_pci.c             |    2 +-
>  arch/sparc/kernel/pci.c                  |   21 +------
>  arch/sparc/kernel/pcic.c                 |    2 +-
>  arch/tile/include/asm/pci.h              |    2 -
>  arch/tile/kernel/pci.c                   |    4 +-
>  arch/tile/kernel/pci_gx.c                |    4 +-
>  arch/unicore32/kernel/pci.c              |    2 +-
>  arch/x86/include/asm/pci.h               |    6 --
>  arch/x86/pci/acpi.c                      |    6 +-
>  arch/x86/pci/common.c                    |    2 +-
>  arch/xtensa/kernel/pci.c                 |    2 +-
>  drivers/parisc/dino.c                    |    2 +-
>  drivers/parisc/lba_pci.c                 |    2 +-
>  drivers/pci/host/pci-versatile.c         |    3 +-
>  drivers/pci/host/pci-xgene.c             |    2 +-
>  drivers/pci/host/pcie-designware.c       |    2 +-
>  drivers/pci/host/pcie-iproc.c            |    2 +-
>  drivers/pci/host/pcie-xilinx.c           |    2 +-
>  drivers/pci/hotplug/ibmphp_core.c        |    2 +-
>  drivers/pci/pci.c                        |   31 ++++++++--
>  drivers/pci/pci.h                        |    1 +
>  drivers/pci/probe.c                      |   92 +++++++++++++++++-------------
>  drivers/pci/xen-pcifront.c               |    2 +-
>  include/linux/pci.h                      |   39 ++++++-------
>  54 files changed, 161 insertions(+), 195 deletions(-)

Doesn't apply to v4.4-rc2.  Please refresh and repost if this is still
relevant.

Bjorn
