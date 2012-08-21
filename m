Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 19:28:41 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:37304 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903534Ab2HUR2f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Aug 2012 19:28:35 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: pull request for 3.7
Date:   Tue, 21 Aug 2012 19:27:08 +0200
Message-Id: <1345570028-7531-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 34305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Ralf,

first try with a pull request ... if anything foobar'ed tell me so i can fix it

Thanks,
John

The following changes since commit 9160338de92c0305329be5163a76f849806e83de:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2012-08-20 16:42:41 -0700)

are available in the git repository at:


  git://dev.phrozen.org/mips-next.git master

for you to fetch changes up to 476e9629c61a7620dabffea99f1dcc570b22245c:

  MIPS: Fix build error for non-malta VSMP kernel (2012-08-21 19:15:16 +0200)

----------------------------------------------------------------
Anoop P A (1):
      MIPS: Fix build error for non-malta VSMP kernel

David Daney (2):
      MIPS: OCTEON: Add register definitions for SPI host hardware.
      spi: Add SPI master controller for OCTEON SOCs.

Florian Fainelli (3):
      MIPS: introduce CPU_GENERIC_DUMP_TLB
      MIPS: introduce CPU_R4K_FPU
      MIPS: introduce CPU_R4K_CACHE_TLB

Ganesan Ramalingam (1):
      MIPS: Netlogic: DTS file for XLP boards

Jayachandran C (4):
      MIPS: Netlogic: merge of.c into setup.c
      MIPS: Netlogic: Move serial ports to device tree
      MIPS: Netlogic: Add support for built in DTB
      MIPS: Netlogic: XLP defconfig update

John Crispin (1):
      MIPS: lantiq: explicitly enable clkout generation

 .../devicetree/bindings/spi/spi-octeon.txt         |   33 ++
 arch/mips/Kconfig                                  |   13 +
 arch/mips/configs/nlm_xlp_defconfig                |  133 +++++---
 arch/mips/include/asm/octeon/cvmx-mpi-defs.h       |  328 +++++++++++++++++
 arch/mips/kernel/Makefile                          |   19 +-
 arch/mips/kernel/smp-mt.c                          |    2 +
 arch/mips/lantiq/xway/sysctrl.c                    |    2 +
 arch/mips/lib/Makefile                             |   21 +-
 arch/mips/mm/Makefile                              |   17 +-
 arch/mips/netlogic/Kconfig                         |   15 +
 arch/mips/netlogic/Makefile                        |    1 +
 arch/mips/netlogic/dts/Makefile                    |    4 +
 arch/mips/netlogic/dts/xlp_evp.dts                 |  124 +++++++
 arch/mips/netlogic/xlp/Makefile                    |    3 +-
 arch/mips/netlogic/xlp/of.c                        |   34 --
 arch/mips/netlogic/xlp/platform.c                  |  108 ------
 arch/mips/netlogic/xlp/setup.c                     |   32 ++-
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-octeon.c                           |  369 ++++++++++++++++++++
 20 files changed, 1024 insertions(+), 242 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mpi-defs.h
 create mode 100644 arch/mips/netlogic/dts/Makefile
 create mode 100644 arch/mips/netlogic/dts/xlp_evp.dts
 delete mode 100644 arch/mips/netlogic/xlp/of.c
 delete mode 100644 arch/mips/netlogic/xlp/platform.c
 create mode 100644 drivers/spi/spi-octeon.c
