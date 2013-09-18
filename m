Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 15:26:10 +0200 (CEST)
Received: from mail-bk0-f50.google.com ([209.85.214.50]:63182 "EHLO
        mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817537Ab3IRN0HquNM1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 15:26:07 +0200
Received: by mail-bk0-f50.google.com with SMTP id mz11so2793006bkb.37
        for <multiple recipients>; Wed, 18 Sep 2013 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MTVHcsq28NcHFzglCpvCn1bkei0BRysu7Gmqou7FifQ=;
        b=NP1XvnW3KlMWpNP9X1LsR6Z8AWOod4/XLzR7UnVAeNQ22TZqOC/c87kRYRdU9puSn/
         Pb2uCGUbhgJX+MX1q420aDjEzIUozIF0JkYJ6i48soBoqsyEa3bqrhjL3i0Izplu83NB
         o0uYIdQWlZRUc4v6OgsmtjqSG0X3JlAeRAjkkKN4r00+g4peeCheKmOH+jHHENZR93NM
         WPF+ahCVq2yPlobUSW0pQ/7Ylq7hPHuXdr26q2eoTxF7Ax8MTsgjzdKN6eS9NmMCm3nF
         KZrJvc0/G3JO2+WTsBGu68pnwC59SbyZn0K2cwldoediTw7THW2omKo6qK2OgXmdRpE1
         bAIw==
X-Received: by 10.204.234.5 with SMTP id ka5mr43179bkb.5.1379510762348;
        Wed, 18 Sep 2013 06:26:02 -0700 (PDT)
Received: from localhost (port-55509.pppoe.wtnet.de. [46.59.217.135])
        by mx.google.com with ESMTPSA id nv4sm903507bkb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 06:26:01 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <rob.herring@calxeda.com>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] of/irq: Defer interrupt reference resolution
Date:   Wed, 18 Sep 2013 15:24:42 +0200
Message-Id: <1379510692-32435-1-git-send-email-treding@nvidia.com>
X-Mailer: git-send-email 1.8.4
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

Hi,

This small series allows interrupt references from the device tree to be
resolved at driver probe time, rather than at device creation time. The
current implementation resolves such references while devices are added
during the call to of_platform_populate(), which happens very early in
the boot process. This causes probe ordering issues, because all devices
that are an interrupt parent for other devices need to have been probed
by that time. This is worked around for primary interrupt controllers by
initializing them using a device tree specific way (of_irq_init()), but
it doesn't work for something like a GPIO controller that is itself a
platform device and an interrupt parent for other devices at the same
time.

Currently such drivers use explicit initcall ordering to force these
chips to be probed earlier than other devices, but that only fixes a
subset of the problematic cases. It doesn't work if the interrupt user
is itself a platform device on the same bus. There are possibly other
cases where it doesn't work either.

This patch series attempts to fix this by not resolving the interrupt
references at device creation time. Instead, some functionality is added
to the driver core to resolve them for each device immediately before it
is probed. Often this is a lot later than the point at which the device
was created, which gives interrupt parents more time and therefore a
better chance of being probed. More importantly, however, it allows the
driver core to detect when an interrupt parent isn't there yet and cause
the device to be queued for deferred probing. After all, resolving probe
ordering issues is one of the primary reason for the introduction of
deferred probing.

Unfortunately the interrupt core code isn't prepared to handle this very
well, so some preparatory work is required.

Patches 1 and 2 are cleanup. Patch 1 modifies of_irq_count() to not use
the heavyweight of_irq_to_resource(), which will actually try to create
a mapping. While not usually harmful, it causes a warning during boot if
the interrupt parent hasn't registered an IRQ domain yet. Furthermore it
is much more than the stated intention of the function, which is to
return the number of interrupts that a device node uses. Various uses of
the of_irq_to_resource() function are replaced by more simpler versions
using irq_of_parse_and_map() in patch 2.

Patches 3 introduces the __irq_create_mapping() function, equivalent to
its non-__ counterpart except that it returns a negative error code on
failure and therefore allows propagation of a precise error code instead
of 0 for all errors. This is an important prerequisite for subsequent
patches. I would've preferred not to introduce an underscore-prefixed
variant but there are about 114 callers and updating them all would've
been rather messy.

Patch 4 updates irq_create_of_mapping() to return a negative error code
on failure instead of 0. The number of the mapped interrupt is returned
in an output parameter. All callers of this function are updated.

Patch 5 adds an __-prefixed variant of irq_of_parse_and_map() which
returns a negative error code on failure instead of 0. The number of
the mapped interrupt is returned in an output parameter.

Patch 6 modifies of_irq_to_resource() to return a negative error code on
failure (so that error can be propagated) and updates all callers.

Patch 7 propagates errors from of_irq_to_resource() to users of the
of_irq_to_resource_table() function.

Patch 8 adds functionality to the platform driver code to resolve
interrupt references at probe time. It uses the negative error code of
the of_irq_to_resource_table() function to trigger deferred probing.

Patch 9 implements similar functionality for I2C devices.

Patch 10 serves as an example of the kind of cleanup that can be done
after this series. Obviously this will require quite a bit of retesting
of working setups, but I think that in the long run we're better off
without the kind of explicit probe ordering employed by the gpio-tegra
driver and many others.

Note that I've only implemented this for platform and I2C devices, but
the same can be done for SPI and possibly other subsystems as well.

There is another use-case that I'm aware of for which a similar solution
could be implemented. IOMMUs on SoCs generally need to hook themselves
up to new platform devices. This causes a similar issues as interrupt
resolution and should be fixable by extending the of_platform_probe()
function introduced in patch 7 of this series.

Changes in v2:
- use more consistent naming and calling conventions
- use less wrappers, update more callers
- make of_platform_probe() idempotent

The initial version of this patch series can be found here:

	https://lkml.org/lkml/2013/9/16/111

Thierry

Thierry Reding (10):
  of/irq: Rework of_irq_count()
  of/irq: Use irq_of_parse_and_map()
  irqdomain: Introduce __irq_create_mapping()
  irqdomain: Return errors from irq_create_of_mapping()
  of/irq: Introduce __irq_of_parse_and_map()
  of/irq: Return errors from of_irq_to_resource()
  of/irq: Propagate errors in of_irq_to_resource_table()
  of/platform: Resolve interrupt references at probe time
  of/i2c: Resolve interrupt references at probe time
  gpio: tegra: Use module_platform_driver()

 arch/arm/mach-integrator/pci_v3.c                |   8 +-
 arch/arm/mach-u300/timer.c                       |   9 +-
 arch/microblaze/pci/pci-common.c                 |   6 +-
 arch/mips/lantiq/irq.c                           |   2 +-
 arch/mips/lantiq/xway/gptu.c                     |   6 +-
 arch/mips/pci/fixup-lantiq.c                     |  12 ++-
 arch/mips/pci/pci-rt3883.c                       |   9 +-
 arch/powerpc/kernel/pci-common.c                 |   7 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c        |   2 +-
 arch/powerpc/platforms/cell/celleb_scc_pciex.c   |   8 +-
 arch/powerpc/platforms/cell/celleb_scc_sio.c     |   8 +-
 arch/powerpc/platforms/cell/spider-pic.c         |   7 +-
 arch/powerpc/platforms/cell/spu_manage.c         |   6 +-
 arch/powerpc/platforms/fsl_uli1575.c             |   7 +-
 arch/powerpc/platforms/pseries/event_sources.c   |  12 +--
 arch/powerpc/sysdev/fsl_gtm.c                    |   9 +-
 arch/powerpc/sysdev/mpic_msgr.c                  |   6 +-
 arch/sparc/kernel/of_device_common.c             |  12 ++-
 arch/x86/kernel/devicetree.c                     |  11 ++-
 drivers/base/platform.c                          |   4 +
 drivers/crypto/caam/ctrl.c                       |   2 +-
 drivers/crypto/caam/jr.c                         |   2 +-
 drivers/crypto/omap-sham.c                       |   2 +-
 drivers/gpio/gpio-tegra.c                        |   7 +-
 drivers/i2c/busses/i2c-cpm.c                     |   2 +-
 drivers/i2c/i2c-core.c                           |  24 ++++-
 drivers/input/serio/xilinx_ps2.c                 |   7 +-
 drivers/net/ethernet/arc/emac_main.c             |  10 +--
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c |   2 +-
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c |   2 +-
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c |   2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c       |   5 +-
 drivers/of/irq.c                                 |  49 +++++++----
 drivers/of/platform.c                            | 107 +++++++++++++++++++++--
 drivers/pci/host/pci-mvebu.c                     |   9 +-
 drivers/spi/spi-fsl-espi.c                       |   6 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c      |   2 +-
 drivers/tty/serial/lantiq.c                      |   2 +-
 include/linux/of_irq.h                           |  27 ++++--
 include/linux/of_platform.h                      |   7 ++
 kernel/irq/irqdomain.c                           |  87 +++++++++++-------
 41 files changed, 353 insertions(+), 161 deletions(-)

-- 
1.8.4
