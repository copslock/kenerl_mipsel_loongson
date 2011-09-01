Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2011 04:57:37 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:49984 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491197Ab1IAC53 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Sep 2011 04:57:29 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id p812mblQ000533;
        Wed, 31 Aug 2011 19:48:37 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Wed, 31 Aug 2011
 19:48:35 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>,
        <ralf@linux-mips.org>, <monstr@monstr.eu>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <davem@davemloft.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <eyal@mips.com>, <zenon@mips.com>,
        <dczhu@mips.com>, <dengcheng.zhu@gmail.com>
Subject: [RESEND PATCH v3 0/2] Pass resources to pci_create_bus() and fix MIPS PCI resources
Date:   Thu, 1 Sep 2011 10:48:27 +0800
Message-ID: <1314845309-3277-1-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: eJnRtwcEeRdoqM5qEDla1Q==
X-archive-position: 31025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 133

(Resending the patch set to include more arch maintainers.)

Change the pci_create_bus() interface to pass in available resources to get them
settled down early. This is to avoid possible resource conflicts while doing
pci_scan_slot() in pci_scan_child_bus(). Note that pcibios_fixup_bus() can get
rid of such conflicts, but it's done AFTER scanning slots.

In addition, MIPS PCI resources are now fixed using this new interface.

-- Changes --
v3 - v2:
o Do not do fixups for root buses in pcibios_fixup_bus().
o Skip bus creation when bus resources cannot be allocated.
o PCI domain/bus numbers added to the error info in controller_resources().

v2 - v1:
o Merge [PATCH 1/3] to [PATCH 3/3], so now 2 patches in total.
o Add more info to patch description.
o Fix arch breaks in default resource setup discovered by Bjorn Helgaas.

Deng-Cheng Zhu (2):
  PCI: Pass available resources into pci_create_bus()
  MIPS: PCI: Pass controller's resources to pci_create_bus() in
    pcibios_scanbus()

 arch/microblaze/pci/pci-common.c |    3 +-
 arch/mips/pci/pci.c              |   61 +++++++++++++++++++++++++++++++++-----
 arch/powerpc/kernel/pci-common.c |    3 +-
 arch/sparc/kernel/pci.c          |    3 +-
 arch/x86/pci/acpi.c              |    2 +-
 drivers/pci/probe.c              |   15 +++++++--
 include/linux/pci.h              |    3 +-
 7 files changed, 73 insertions(+), 17 deletions(-)
