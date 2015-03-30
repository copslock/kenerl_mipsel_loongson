Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 18:01:32 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:41418 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014766AbbC3QBPAMawZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2015 18:01:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id B23CB460BC3
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:01:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iFmYHISvgZru for <linux-mips@linux-mips.org>;
        Mon, 30 Mar 2015 17:01:03 +0100 (BST)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 86B47460BC2
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:01:03 +0100 (BST)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1Ycc7b-0007nd-0q
        for linux-mips@linux-mips.org; Mon, 30 Mar 2015 17:01:03 +0100
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: [PATCH 00/10] MIPS: OCTEON: Little Endian roll-up
Date:   Mon, 30 Mar 2015 17:00:53 +0100
Message-Id: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

This is an experimental patch set for enabling Little Endian working on 
the Cavium Octeon II.  It may work for other Octeon models but has not 
been tested on them.

It's been extensively tested on a Ubiquiti EdgeRouter Pro, building a 
current GNU/Linux toolchain from sources using an external USB drive.

My contributions (with the exception of the changes to octeon-md5) are 
mainly cherry-picked from the GPL tarball released by Ubiquiti, and 
appear to have originally been authored by Cavium.

David Daney (3):
  MIPS: OCTEON: Handle bootloader structures in little-endian mode.
  MIPS: OCTEON: Add mach-cavium-octeon/mangle-port.h
  MIPS: OCTEON: Enable little endian kernel.

Paul Martin (7):
  MIPS: OCTEON: Turn hardware bitfields and structures inside out.
  MIPS: OCTEON: Set appropriate endianness in L2C registers
  MIPS: OCTEON: Reverse the order of register accesses to the FAU
  MIPS: OCTEON: Set up ethernet hardware for little endian
  MIPS: OCTEON: Make octeon-md5 driver endian-agnostic
  MIPS: OCTEON: Fix to IP checksum offloading in Little Endian
  MIPS: OCTEON: Fix Kconfig file typo

 arch/mips/Kconfig                                  |   3 +-
 arch/mips/cavium-octeon/crypto/octeon-crypto.h     |   8 +-
 arch/mips/cavium-octeon/executive/cvmx-l2c.c       |  45 ++++
 arch/mips/cavium-octeon/octeon-platform.c          |  12 +
 arch/mips/cavium-octeon/octeon_boot.h              |  23 ++
 .../include/asm/mach-cavium-octeon/mangle-port.h   |  74 ++++++
 arch/mips/include/asm/octeon/cvmx-address.h        |  67 ++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |  55 +++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |  14 ++
 arch/mips/include/asm/octeon/cvmx-fau.h            |  22 ++
 arch/mips/include/asm/octeon/cvmx-fpa.h            |   7 +
 arch/mips/include/asm/octeon/cvmx-l2c.h            |   9 +
 arch/mips/include/asm/octeon/cvmx-packet.h         |   8 +
 arch/mips/include/asm/octeon/cvmx-pko.h            |  31 +++
 arch/mips/include/asm/octeon/cvmx-pow.h            | 247 +++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-wqe.h            |  71 ++++++
 drivers/staging/octeon/ethernet-tx.c               |   5 +-
 drivers/staging/octeon/ethernet.c                  |  10 +
 18 files changed, 705 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/mangle-port.h

-- 
2.1.4
