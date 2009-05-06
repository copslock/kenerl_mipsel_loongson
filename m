Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 01:32:54 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15113 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023714AbZEFAct (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 01:32:49 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a00da8d0000>; Tue, 05 May 2009 20:32:13 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:32:04 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:32:04 -0700
Message-ID: <4A00DA84.5040101@caviumnetworks.com>
Date:	Tue, 05 May 2009 17:32:04 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	gregkh@suse.de, Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/7] Staging: Octeon-ethernet driver.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2009 00:32:04.0176 (UTC) FILETIME=[142FF500:01C9CDE2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch set introduces the octeon-ethernet driver into the
drivers/staging tree.  The Octeon is a mips64r2 base multi-core SOC
family.

The first five patches are small tweaks to the existing octeon support
that are required by the ethernet driver.  I would expect them to be
merged via Ralf's linux-mips.org tree.

The last two are the driver, and would probably be merged via the
drivers/staging tree.  However since they depend on the first five,
they probably shouldn't be merged until those five are merged.

I will reply with the seven patches.

David Daney (7):
  MIPS: Add named alloc functions to OCTEON boot monitor memory
    allocator.
  MIPS: Export cvmx_sysinfo_get needed by octeon-ethernet driver.
  MIPS: Cavium-Octeon: Add more board type constants.
  MIPS: Cavium-Octeon: Add more chip specific feature tests.
  MIPS: Export erratum function needed by octeon-ethernet driver.
  [Staging] Add octeon-ethernet driver files.
  [Staging] Hookup octeon-ethernet driver.

 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  104 +
 .../cavium-octeon/executive/cvmx-helper-errata.c   |    3 +
 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c   |    2 +
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |   13 +
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |   85 +
 arch/mips/include/asm/octeon/octeon-feature.h      |   27 +
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/octeon/Kconfig                     |   12 +
 drivers/staging/octeon/Makefile                    |   30 +
 drivers/staging/octeon/cvmx-address.h              |  274 +++
 drivers/staging/octeon/cvmx-asxx-defs.h            |  475 ++++
 drivers/staging/octeon/cvmx-cmd-queue.c            |  306 +++
 drivers/staging/octeon/cvmx-cmd-queue.h            |  617 +++++
 drivers/staging/octeon/cvmx-config.h               |  169 ++
 drivers/staging/octeon/cvmx-dbg-defs.h             |   72 +
 drivers/staging/octeon/cvmx-fau.h                  |  597 +++++
 drivers/staging/octeon/cvmx-fpa-defs.h             |  403 ++++
 drivers/staging/octeon/cvmx-fpa.c                  |  183 ++
 drivers/staging/octeon/cvmx-fpa.h                  |  299 +++
 drivers/staging/octeon/cvmx-gmxx-defs.h            | 2529 ++++++++++++++++++++
 drivers/staging/octeon/cvmx-helper-board.c         |  706 ++++++
 drivers/staging/octeon/cvmx-helper-board.h         |  180 ++
 drivers/staging/octeon/cvmx-helper-fpa.c           |  243 ++
 drivers/staging/octeon/cvmx-helper-fpa.h           |   64 +
 drivers/staging/octeon/cvmx-helper-loop.c          |   85 +
 drivers/staging/octeon/cvmx-helper-loop.h          |   59 +
 drivers/staging/octeon/cvmx-helper-npi.c           |  113 +
 drivers/staging/octeon/cvmx-helper-npi.h           |   60 +
 drivers/staging/octeon/cvmx-helper-rgmii.c         |  525 ++++
 drivers/staging/octeon/cvmx-helper-rgmii.h         |  110 +
 drivers/staging/octeon/cvmx-helper-sgmii.c         |  550 +++++
 drivers/staging/octeon/cvmx-helper-sgmii.h         |  104 +
 drivers/staging/octeon/cvmx-helper-spi.c           |  195 ++
 drivers/staging/octeon/cvmx-helper-spi.h           |   84 +
 drivers/staging/octeon/cvmx-helper-util.c          |  433 ++++
 drivers/staging/octeon/cvmx-helper-util.h          |  215 ++
 drivers/staging/octeon/cvmx-helper-xaui.c          |  348 +++
 drivers/staging/octeon/cvmx-helper-xaui.h          |  103 +
 drivers/staging/octeon/cvmx-helper.c               | 1058 ++++++++
 drivers/staging/octeon/cvmx-helper.h               |  227 ++
 drivers/staging/octeon/cvmx-interrupt-decodes.c    |  371 +++
 drivers/staging/octeon/cvmx-interrupt-rsl.c        |  140 ++
 drivers/staging/octeon/cvmx-ipd.h                  |  338 +++
 drivers/staging/octeon/cvmx-mdio.h                 |  506 ++++
 drivers/staging/octeon/cvmx-packet.h               |   65 +
 drivers/staging/octeon/cvmx-pcsx-defs.h            |  370 +++
 drivers/staging/octeon/cvmx-pcsxx-defs.h           |  316 +++
 drivers/staging/octeon/cvmx-pip-defs.h             | 1267 ++++++++++
 drivers/staging/octeon/cvmx-pip.h                  |  524 ++++
 drivers/staging/octeon/cvmx-pko-defs.h             | 1133 +++++++++
 drivers/staging/octeon/cvmx-pko.c                  |  506 ++++
 drivers/staging/octeon/cvmx-pko.h                  |  610 +++++
 drivers/staging/octeon/cvmx-pow.h                  | 1982 +++++++++++++++
 drivers/staging/octeon/cvmx-scratch.h              |  139 ++
 drivers/staging/octeon/cvmx-smix-defs.h            |  178 ++
 drivers/staging/octeon/cvmx-spi.c                  |  667 ++++++
 drivers/staging/octeon/cvmx-spi.h                  |  269 +++
 drivers/staging/octeon/cvmx-spxx-defs.h            |  347 +++
 drivers/staging/octeon/cvmx-srxx-defs.h            |  126 +
 drivers/staging/octeon/cvmx-stxx-defs.h            |  292 +++
 drivers/staging/octeon/cvmx-wqe.h                  |  397 +++
 drivers/staging/octeon/ethernet-common.c           |  328 +++
 drivers/staging/octeon/ethernet-common.h           |   29 +
 drivers/staging/octeon/ethernet-defines.h          |  134 +
 drivers/staging/octeon/ethernet-mdio.c             |  231 ++
 drivers/staging/octeon/ethernet-mdio.h             |   46 +
 drivers/staging/octeon/ethernet-mem.c              |  198 ++
 drivers/staging/octeon/ethernet-mem.h              |   29 +
 drivers/staging/octeon/ethernet-proc.c             |  256 ++
 drivers/staging/octeon/ethernet-proc.h             |   29 +
 drivers/staging/octeon/ethernet-rgmii.c            |  397 +++
 drivers/staging/octeon/ethernet-rx.c               |  505 ++++
 drivers/staging/octeon/ethernet-rx.h               |   33 +
 drivers/staging/octeon/ethernet-sgmii.c            |  129 +
 drivers/staging/octeon/ethernet-spi.c              |  323 +++
 drivers/staging/octeon/ethernet-tx.c               |  634 +++++
 drivers/staging/octeon/ethernet-tx.h               |   32 +
 drivers/staging/octeon/ethernet-util.h             |   81 +
 drivers/staging/octeon/ethernet-xaui.c             |  127 +
 drivers/staging/octeon/ethernet.c                  |  507 ++++
 drivers/staging/octeon/octeon-ethernet.h           |  127 +
 82 files changed, 26383 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/octeon/Kconfig
 create mode 100644 drivers/staging/octeon/Makefile
 create mode 100644 drivers/staging/octeon/cvmx-address.h
 create mode 100644 drivers/staging/octeon/cvmx-asxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-cmd-queue.c
 create mode 100644 drivers/staging/octeon/cvmx-cmd-queue.h
 create mode 100644 drivers/staging/octeon/cvmx-config.h
 create mode 100644 drivers/staging/octeon/cvmx-dbg-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-fau.h
 create mode 100644 drivers/staging/octeon/cvmx-fpa-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-fpa.c
 create mode 100644 drivers/staging/octeon/cvmx-fpa.h
 create mode 100644 drivers/staging/octeon/cvmx-gmxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-board.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-board.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-fpa.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-fpa.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-loop.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-loop.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-npi.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-npi.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-rgmii.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-rgmii.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-sgmii.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-sgmii.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-spi.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-spi.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-util.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-util.h
 create mode 100644 drivers/staging/octeon/cvmx-helper-xaui.c
 create mode 100644 drivers/staging/octeon/cvmx-helper-xaui.h
 create mode 100644 drivers/staging/octeon/cvmx-helper.c
 create mode 100644 drivers/staging/octeon/cvmx-helper.h
 create mode 100644 drivers/staging/octeon/cvmx-interrupt-decodes.c
 create mode 100644 drivers/staging/octeon/cvmx-interrupt-rsl.c
 create mode 100644 drivers/staging/octeon/cvmx-ipd.h
 create mode 100644 drivers/staging/octeon/cvmx-mdio.h
 create mode 100644 drivers/staging/octeon/cvmx-packet.h
 create mode 100644 drivers/staging/octeon/cvmx-pcsx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-pcsxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-pip-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-pip.h
 create mode 100644 drivers/staging/octeon/cvmx-pko-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-pko.c
 create mode 100644 drivers/staging/octeon/cvmx-pko.h
 create mode 100644 drivers/staging/octeon/cvmx-pow.h
 create mode 100644 drivers/staging/octeon/cvmx-scratch.h
 create mode 100644 drivers/staging/octeon/cvmx-smix-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-spi.c
 create mode 100644 drivers/staging/octeon/cvmx-spi.h
 create mode 100644 drivers/staging/octeon/cvmx-spxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-srxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-stxx-defs.h
 create mode 100644 drivers/staging/octeon/cvmx-wqe.h
 create mode 100644 drivers/staging/octeon/ethernet-common.c
 create mode 100644 drivers/staging/octeon/ethernet-common.h
 create mode 100644 drivers/staging/octeon/ethernet-defines.h
 create mode 100644 drivers/staging/octeon/ethernet-mdio.c
 create mode 100644 drivers/staging/octeon/ethernet-mdio.h
 create mode 100644 drivers/staging/octeon/ethernet-mem.c
 create mode 100644 drivers/staging/octeon/ethernet-mem.h
 create mode 100644 drivers/staging/octeon/ethernet-proc.c
 create mode 100644 drivers/staging/octeon/ethernet-proc.h
 create mode 100644 drivers/staging/octeon/ethernet-rgmii.c
 create mode 100644 drivers/staging/octeon/ethernet-rx.c
 create mode 100644 drivers/staging/octeon/ethernet-rx.h
 create mode 100644 drivers/staging/octeon/ethernet-sgmii.c
 create mode 100644 drivers/staging/octeon/ethernet-spi.c
 create mode 100644 drivers/staging/octeon/ethernet-tx.c
 create mode 100644 drivers/staging/octeon/ethernet-tx.h
 create mode 100644 drivers/staging/octeon/ethernet-util.h
 create mode 100644 drivers/staging/octeon/ethernet-xaui.c
 create mode 100644 drivers/staging/octeon/ethernet.c
 create mode 100644 drivers/staging/octeon/octeon-ethernet.h
