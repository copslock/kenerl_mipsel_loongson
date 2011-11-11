Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 01:30:59 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:33240 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904252Ab1KKAaA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 01:30:00 +0100
Received: by yenl9 with SMTP id l9so3141774yen.36
        for <multiple recipients>; Thu, 10 Nov 2011 16:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=pAuF3Iq9hIeenu+rpB3RuyTPh+sKDbG9sVbpufT95TA=;
        b=mMF/I8oCewaE6vsEFoyZIcHDv8y/CY18O+hUIJJgK5Xh20TAV+w0B7ogtUriztSNmI
         jdCyj7q7IByAdKfvL5wy1ismZYi/wZhR3i3zq35Gg7DU/fhmXRQJ3UR51XdZEyft087Z
         ilu5il9DBrQcxCaKVgFquiSsdXseBErkQ5aFI=
Received: by 10.101.45.15 with SMTP id x15mr4400929anj.5.1320971394034;
        Thu, 10 Nov 2011 16:29:54 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id f32sm28650207ani.20.2011.11.10.16.29.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 16:29:53 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAB0Tpnr029379;
        Thu, 10 Nov 2011 16:29:51 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAB0ToBB029378;
        Thu, 10 Nov 2011 16:29:50 -0800
From:   ddaney.cavm@gmail.com
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de, devel@driverdev.osuosl.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] Move some Octeon support files out of staging.
Date:   Thu, 10 Nov 2011 16:29:44 -0800
Message-Id: <1320971387-29343-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9870

From: David Daney <david.daney@cavium.com>

First patch:

In preparation for my next set of patches to add device tree support
for Octeon, move some files out of drivers/staging/octeon to common
location.  There are two basic types of files I am moving:

1) Register definition files.  Most Octeon register definition files
   are in arch/mips/include/asm/octeon, put the rest there too.

2) Low level packet port type probing code.  This is needed by both
   the Ethernet driver and the code that fixes up the in-kernel device
   trees.  Although new board pass a device tree to the kernel,
   support of legacy boards requires that this probing code be used to
   fix up an in-kernel device tree template.


Second patch:

Update support for legacy boards.


Third patch:

Seperate probing and initialization of packet ports.


Since these are MIPS architecture files we could merge via Ralf's tree
if approved.

David Daney (3):
  MIPS: Octeon: Move some Ethernet support files out of staging.
  MIPS: Octeon: Update bootloader board type constants.
  MIPS: Octeon: Rearrange CVMX files in preperation for device tree

 arch/mips/cavium-octeon/executive/Makefile         |    5 +
 .../mips/cavium-octeon/executive}/cvmx-cmd-queue.c |    8 +-
 .../mips/cavium-octeon/executive}/cvmx-fpa.c       |    0
 .../cavium-octeon/executive}/cvmx-helper-board.c   |   38 +++--
 .../cavium-octeon/executive}/cvmx-helper-fpa.c     |    0
 .../cavium-octeon/executive}/cvmx-helper-loop.c    |    6 +-
 .../cavium-octeon/executive}/cvmx-helper-npi.c     |    6 +-
 .../cavium-octeon/executive}/cvmx-helper-rgmii.c   |   17 +-
 .../cavium-octeon/executive}/cvmx-helper-sgmii.c   |   18 ++-
 .../cavium-octeon/executive}/cvmx-helper-spi.c     |   20 ++-
 .../cavium-octeon/executive}/cvmx-helper-util.c    |   16 +-
 .../cavium-octeon/executive}/cvmx-helper-xaui.c    |   32 ++--
 .../mips/cavium-octeon/executive}/cvmx-helper.c    |  120 ++++++++++----
 .../executive}/cvmx-interrupt-decodes.c            |   10 +-
 .../cavium-octeon/executive}/cvmx-interrupt-rsl.c  |    4 +-
 .../mips/cavium-octeon/executive}/cvmx-pko.c       |    8 +-
 .../mips/cavium-octeon/executive}/cvmx-spi.c       |   12 +-
 .../mips/include/asm}/octeon/cvmx-address.h        |    0
 .../mips/include/asm}/octeon/cvmx-asxx-defs.h      |    0
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |   72 ++++++++-
 .../mips/include/asm}/octeon/cvmx-cmd-queue.h      |    0
 .../mips/include/asm}/octeon/cvmx-config.h         |    0
 .../mips/include/asm}/octeon/cvmx-dbg-defs.h       |    0
 .../mips/include/asm}/octeon/cvmx-fau.h            |    0
 .../mips/include/asm}/octeon/cvmx-fpa-defs.h       |    0
 .../mips/include/asm}/octeon/cvmx-fpa.h            |    0
 .../mips/include/asm}/octeon/cvmx-gmxx-defs.h      |    0
 .../mips/include/asm}/octeon/cvmx-helper-board.h   |    6 +
 .../mips/include/asm}/octeon/cvmx-helper-fpa.h     |    0
 .../mips/include/asm}/octeon/cvmx-helper-loop.h    |    1 +
 .../mips/include/asm}/octeon/cvmx-helper-npi.h     |    1 +
 .../mips/include/asm}/octeon/cvmx-helper-rgmii.h   |    1 +
 .../mips/include/asm}/octeon/cvmx-helper-sgmii.h   |    1 +
 .../mips/include/asm}/octeon/cvmx-helper-spi.h     |    1 +
 .../mips/include/asm}/octeon/cvmx-helper-util.h    |    0
 .../mips/include/asm}/octeon/cvmx-helper-xaui.h    |    1 +
 .../mips/include/asm}/octeon/cvmx-helper.h         |    1 +
 .../mips/include/asm}/octeon/cvmx-ipd.h            |    0
 .../mips/include/asm}/octeon/cvmx-mdio.h           |    0
 .../mips/include/asm}/octeon/cvmx-pcsx-defs.h      |    0
 .../mips/include/asm}/octeon/cvmx-pcsxx-defs.h     |    0
 .../mips/include/asm}/octeon/cvmx-pip-defs.h       |    0
 .../mips/include/asm}/octeon/cvmx-pip.h            |    0
 .../mips/include/asm}/octeon/cvmx-pko-defs.h       |    0
 .../mips/include/asm}/octeon/cvmx-pko.h            |    0
 .../mips/include/asm}/octeon/cvmx-pow.h            |    0
 .../mips/include/asm}/octeon/cvmx-scratch.h        |    0
 .../mips/include/asm}/octeon/cvmx-spi.h            |    0
 .../mips/include/asm}/octeon/cvmx-spxx-defs.h      |    0
 .../mips/include/asm}/octeon/cvmx-srxx-defs.h      |    0
 .../mips/include/asm}/octeon/cvmx-stxx-defs.h      |    0
 .../mips/include/asm}/octeon/cvmx-wqe.h            |    0
 drivers/staging/octeon/Makefile                    |    5 -
 drivers/staging/octeon/cvmx-packet.h               |   65 -------
 drivers/staging/octeon/cvmx-smix-defs.h            |  178 --------------------
 drivers/staging/octeon/ethernet-defines.h          |    2 +-
 drivers/staging/octeon/ethernet-mdio.c             |    4 +-
 drivers/staging/octeon/ethernet-mem.c              |    2 +-
 drivers/staging/octeon/ethernet-rgmii.c            |    4 +-
 drivers/staging/octeon/ethernet-rx.c               |   14 +-
 drivers/staging/octeon/ethernet-rx.h               |    2 +-
 drivers/staging/octeon/ethernet-sgmii.c            |    4 +-
 drivers/staging/octeon/ethernet-spi.c              |    6 +-
 drivers/staging/octeon/ethernet-tx.c               |   12 +-
 drivers/staging/octeon/ethernet-xaui.c             |    4 +-
 drivers/staging/octeon/ethernet.c                  |   14 +-
 66 files changed, 326 insertions(+), 395 deletions(-)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-cmd-queue.c (98%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-fpa.c (100%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-board.c (96%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-fpa.c (100%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-loop.c (95%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-npi.c (96%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-rgmii.c (97%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-sgmii.c (98%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-spi.c (94%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-util.c (97%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper-xaui.c (97%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-helper.c (93%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-interrupt-decodes.c (98%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-interrupt-rsl.c (97%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-pko.c (98%)
 rename {drivers/staging/octeon => arch/mips/cavium-octeon/executive}/cvmx-spi.c (99%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-address.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-asxx-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-cmd-queue.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-config.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-dbg-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-fau.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-fpa-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-fpa.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-gmxx-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-board.h (96%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-fpa.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-loop.h (96%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-npi.h (96%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-rgmii.h (98%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-sgmii.h (98%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-spi.h (98%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-util.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper-xaui.h (98%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-helper.h (99%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-ipd.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-mdio.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-pcsx-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-pcsxx-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-pip-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-pip.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-pko-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-pko.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-pow.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-scratch.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-spi.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-spxx-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-srxx-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-stxx-defs.h (100%)
 rename {drivers/staging => arch/mips/include/asm}/octeon/cvmx-wqe.h (100%)
 delete mode 100644 drivers/staging/octeon/cvmx-packet.h
 delete mode 100644 drivers/staging/octeon/cvmx-smix-defs.h

-- 
1.7.2.3
