Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 08:24:43 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:61538 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab1HXGYi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2011 08:24:38 +0200
Received: by gxk2 with SMTP id 2so810167gxk.36
        for <multiple recipients>; Tue, 23 Aug 2011 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EtCL2rnjZnaT5XyP9vzdzzfoMfoSlfmNlsJoHFFTVHM=;
        b=p+v3ojsuibG7F9uWltJjckpTUWT3V7vXe8yTzz1PDGZYwO8By2ur53Zd7pxOLgr3Q2
         toOzLRojqDrYPMuyY3OgFI8UJJgBZ1x5ljBMLL2ZaonTTzdloa6gus8yttL5DdPTiSc8
         wYFRLa8t6HzE3b0kRsvNDpVmilxF/CE6KLOO4=
Received: by 10.236.191.198 with SMTP id g46mr27912583yhn.41.1314167071908;
        Tue, 23 Aug 2011 23:24:31 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id f4sm1134483yhn.27.2011.08.23.23.24.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 23:24:31 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     jbarnes@virtuousgeek.org, ralf@linux-mips.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Subject: [RFC PATCH 0/3] Pass resources to pci_create_bus() and fix MIPS PCI resources
Date:   Wed, 24 Aug 2011 14:24:20 +0800
Message-Id: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 30961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17573

For MIPS PCI, use the resources-list style to set up root resources rather than
filling in pci_bus->resource[] array directly. This will hide some ugly
implementation details.

In addition, change the pci_create_bus() interface to pass in available
resources to get them settled down early. This is to avoid possible resource
conflicts while doing pci_scan_slot() in pci_scan_child_bus(). Note that
pcibios_fixup_bus() can get rid of such conflicts, but it's done AFTER scanning
slots.

Deng-Cheng Zhu (3):
  MIPS: PCI: Use pci_bus_remove_resources()/pci_bus_add_resource() to
    set up root resources
  PCI: Pass available resources into pci_create_bus()
  MIPS: PCI: Pass controller's resources to pci_create_bus() in
    pcibios_scanbus()

 arch/microblaze/pci/pci-common.c |    3 +-
 arch/mips/pci/pci.c              |   49 +++++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/pci-common.c |    3 +-
 arch/sparc/kernel/pci.c          |    3 +-
 arch/x86/pci/acpi.c              |    2 +-
 drivers/pci/probe.c              |   15 ++++++++---
 include/linux/pci.h              |    3 +-
 7 files changed, 66 insertions(+), 12 deletions(-)
