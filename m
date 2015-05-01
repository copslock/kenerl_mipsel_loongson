Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:38:10 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49076 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025960AbbEAThua8fNu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id F057756F430;
        Fri,  1 May 2015 22:37:50 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id sR0UYpvwTXKj; Fri,  1 May 2015 22:37:46 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id ED7A35BC003;
        Fri,  1 May 2015 22:37:45 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 00/11] MIPS: OCTEON: move all octeon-ethernet code to staging
Date:   Fri,  1 May 2015 22:37:02 +0300
Message-Id: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

In order to octeon-ethernet staging work to proceed, we should have all
the code in the same tree (staging). Currently, most of the driver code
actually lives in the MIPS tree in the "cvmx" helper or OS abstraction
routines and include files. Majority of this code needs refactoring
(or deletion) for the octeon-ethernet to become a normal Linux driver.
Since rest of the kernel does not need this code at all, it should
make sense to move it all into the same place while the driver
is being developed.

This series does not make any functional changes, just moves the code.
Tested on EdgeRouter Lite, EdgeRouter Pro and D-Link DSR-1000N. Also build
tested with octeon-ethernet as built-in, module and completely disabled.
Patches are based on staging-next.

A.

Aaro Koskinen (11):
  MIPS: OCTEON: cvmx-helper: use function to access interface_port_count
  MIPS: OCTEON: move ethernet-specific helpers into a separate file
  MIPS: OCTEON: make __cvmx_helper_sgmii/xaui_probe void
  MIPS: OCTEON: move interface enumeration helpers to cvmx-helper
  MIPS: OCTEON: delete calls to __cvmx_helper_npi/rgmii_probe
  MIPS: OCTEON: rename __cvmx_helper_npi/rgmii_probe
  MIPS: OCTEON: make all interface enumeration helpers static
  MIPS: OCTEON: move the link helpers into a separate file
  MIPS: OCTEON: move ethernet-specific helpers to staging
  MIPS: OCTEON: ethernet: delete unneeded symbol exports
  MIPS: OCTEON: move all ethernet-specific headers to staging

 arch/mips/cavium-octeon/executive/Makefile         |    7 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    |  512 +---------
 arch/mips/cavium-octeon/executive/cvmx-helper.c    | 1017 +++-----------------
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |   70 --
 arch/mips/include/asm/octeon/cvmx-helper.h         |  124 ---
 drivers/staging/octeon/Makefile                    |   15 +-
 .../asm => drivers/staging}/octeon/cvmx-address.h  |    0
 .../staging}/octeon/cvmx-asxx-defs.h               |    0
 .../staging/octeon}/cvmx-cmd-queue.c               |   12 +-
 .../staging}/octeon/cvmx-cmd-queue.h               |    4 +-
 .../asm => drivers/staging}/octeon/cvmx-dbg-defs.h |    0
 .../asm => drivers/staging}/octeon/cvmx-fau.h      |    0
 .../asm => drivers/staging}/octeon/cvmx-fpa-defs.h |    0
 .../asm => drivers/staging}/octeon/cvmx-fpa.h      |    4 +-
 drivers/staging/octeon/cvmx-helper-ethernet.c      |  914 ++++++++++++++++++
 drivers/staging/octeon/cvmx-helper-ethernet.h      |  219 +++++
 .../staging/octeon}/cvmx-helper-loop.c             |    6 +-
 .../staging}/octeon/cvmx-helper-loop.h             |    1 -
 .../staging/octeon}/cvmx-helper-npi.c              |   44 +-
 .../staging}/octeon/cvmx-helper-npi.h              |   12 -
 .../staging/octeon}/cvmx-helper-rgmii.c            |   63 +-
 .../staging}/octeon/cvmx-helper-rgmii.h            |   10 +-
 .../staging/octeon}/cvmx-helper-sgmii.c            |   20 +-
 .../staging}/octeon/cvmx-helper-sgmii.h            |    5 +-
 .../staging/octeon}/cvmx-helper-spi.c              |   19 +-
 .../staging}/octeon/cvmx-helper-spi.h              |    3 +-
 .../staging/octeon}/cvmx-helper-util.c             |   22 +-
 .../staging}/octeon/cvmx-helper-util.h             |    3 +
 .../staging/octeon}/cvmx-helper-xaui.c             |   28 +-
 .../staging}/octeon/cvmx-helper-xaui.h             |    5 +-
 .../staging/octeon}/cvmx-interrupt-decodes.c       |   11 +-
 .../staging/octeon}/cvmx-interrupt-rsl.c           |    5 +-
 .../asm => drivers/staging}/octeon/cvmx-ipd.h      |    3 +-
 drivers/staging/octeon/cvmx-link.c                 |  531 ++++++++++
 .../asm => drivers/staging}/octeon/cvmx-mdio.h     |    0
 .../staging}/octeon/cvmx-pcsx-defs.h               |    0
 .../staging}/octeon/cvmx-pcsxx-defs.h              |    0
 .../asm => drivers/staging}/octeon/cvmx-pip-defs.h |    0
 .../asm => drivers/staging}/octeon/cvmx-pip.h      |    6 +-
 .../asm => drivers/staging}/octeon/cvmx-pko-defs.h |    0
 .../staging/octeon}/cvmx-pko.c                     |    8 +-
 .../asm => drivers/staging}/octeon/cvmx-pko.h      |    8 +-
 .../asm => drivers/staging}/octeon/cvmx-pow.h      |    5 +-
 .../asm => drivers/staging}/octeon/cvmx-scratch.h  |    0
 .../staging/octeon}/cvmx-spi.c                     |   13 +-
 .../staging}/octeon/cvmx-spxx-defs.h               |    0
 .../staging}/octeon/cvmx-srxx-defs.h               |    0
 .../staging}/octeon/cvmx-stxx-defs.h               |    0
 .../asm => drivers/staging}/octeon/cvmx-wqe.h      |    0
 drivers/staging/octeon/ethernet-mem.c              |    6 +-
 drivers/staging/octeon/ethernet-rgmii.c            |   18 +-
 drivers/staging/octeon/ethernet-rx.c               |   24 +-
 drivers/staging/octeon/ethernet-rx.h               |    4 +-
 drivers/staging/octeon/ethernet-spi.c              |   17 +-
 drivers/staging/octeon/ethernet-tx.c               |   19 +-
 drivers/staging/octeon/ethernet-xaui.c             |   14 +-
 drivers/staging/octeon/ethernet.c                  |   40 +-
 drivers/staging/octeon/octeon-ethernet.h           |    3 +-
 58 files changed, 1949 insertions(+), 1925 deletions(-)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-address.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-asxx-defs.h (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-cmd-queue.c (98%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-cmd-queue.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-dbg-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-fau.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-fpa-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-fpa.h (99%)
 create mode 100644 drivers/staging/octeon/cvmx-helper-ethernet.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-ethernet.h
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-loop.c (97%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-loop.h (96%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-npi.c (68%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-npi.h (81%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-rgmii.c (92%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-rgmii.h (92%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-sgmii.c (98%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-sgmii.h (96%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-spi.c (95%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-spi.h (98%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-util.c (97%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-util.h (99%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-xaui.c (95%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-helper-xaui.h (96%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-interrupt-decodes.c (98%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-interrupt-rsl.c (98%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-ipd.h (99%)
 create mode 100644 drivers/staging/octeon/cvmx-link.c
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-mdio.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pcsx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pcsxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pip-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pip.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pko-defs.h (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-pko.c (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pko.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-pow.h (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-scratch.h (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-spi.c (99%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-spxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-srxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-stxx-defs.h (100%)
 rename {arch/mips/include/asm => drivers/staging}/octeon/cvmx-wqe.h (100%)

-- 
2.3.3
