Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:14:17 +0100 (CET)
Received: from mail.gentoo.org ([IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4]:57843
        "EHLO smtp.gentoo.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdBGGOLF9-Nr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 07:14:11 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 06ACA341698;
        Tue,  7 Feb 2017 06:14:03 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 00/12] MIPS: BRIDGE Updates
Date:   Tue,  7 Feb 2017 01:13:44 -0500
Message-Id: <20170207061356.8270-1-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

This series performs a number of clean-ups on the code for the BRIDGE
ASIC found in several SGI platforms.  It must be applied after the
Xtalk clean-up patch series is applied.

Notable changes include:
 - Genericize the IP27 BRIDGE driver so future platforms can use it
 - Prepare the generic BRIDGE driver to become a platform_driver
 - Clean-up/replace IRIX-era structures and macros in bridge.h
 - Fix the recent PCI_PROBE_ONLY change to work for IP27 again.

Joshua Kinard (12):
  MIPS: BRIDGE: Rename pci-ip27.c to pci-bridge.c
  MIPS: IP27: Add pcibr.h header for IP27
  MIPS: PCI: Minor clean-ups to pci-legacy.c
  MIPS: PCI: Add BRIDGE 'pre_enable' hook
  MIPS: BRIDGE: Clean-up bridge.h header file
  MIPS: BRIDGE: Overhaul bridge.h header file
  MIPS: BRIDGE: Add XBRIDGE revs and SWAP bit
  MIPS: BRIDGE: Update ops-bridge.c
  MIPS: BRIDGE: Use !pci_is_root_bus(bus) to check for bus->number > 0
  MIPS: BRIDGE: Overhaul pci-bridge.c driver
  MIPS: IP27: Update IRQ code to work with the new BRIDGE code
  MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case

 arch/mips/include/asm/mach-ip27/pcibr.h |   50 +
 arch/mips/include/asm/pci.h             |    3 +
 arch/mips/include/asm/pci/bridge.h      | 1353 ++++++++++++---------
 arch/mips/pci/Makefile                  |    2 +-
 arch/mips/pci/ops-bridge.c              |  129 +-
 arch/mips/pci/pci-bridge.c              |  321 +++++
 arch/mips/pci/pci-ip27.c                |  230 ----
 arch/mips/pci/pci-legacy.c              |   74 +-
 arch/mips/sgi-ip27/ip27-irq-pci.c       |   72 +-
 arch/mips/sgi-ip27/ip27-irq.c           |    5 +
 10 files changed, 1313 insertions(+), 926 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ip27/pcibr.h
 create mode 100644 arch/mips/pci/pci-bridge.c
 delete mode 100644 arch/mips/pci/pci-ip27.c

-- 
2.11.1
