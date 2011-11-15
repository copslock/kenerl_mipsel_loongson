Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 00:46:34 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:58740 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903743Ab1KOXq1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 00:46:27 +0100
Received: by ywp31 with SMTP id 31so7230850ywp.36
        for <multiple recipients>; Tue, 15 Nov 2011 15:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rAPvagx/Oq94fGMCMMndYWJ/TYast2vDqT5mZJQgWUU=;
        b=kMmNwXYGpYKjm2hIPsMiW33SrsY3E4D39eykJQis6nHFra7mtBGuA/LGb7Luka6HwP
         nxjSB8Q30SJpdXLB/EV+UGo2rI1UHbwNLezmYL8WiTvUwkTpTCL1SU36NjyZB3jZUhwV
         YYekT98+IQGqo9SPN3TsUT3Fqy9JCuJQtyfEk=
Received: by 10.101.95.3 with SMTP id x3mr3554117anl.92.1321400780911;
        Tue, 15 Nov 2011 15:46:20 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id m33sm78959841ann.4.2011.11.15.15.46.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 15:46:20 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAFNkHZQ032390;
        Tue, 15 Nov 2011 15:46:18 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAFNkGjm032389;
        Tue, 15 Nov 2011 15:46:16 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/5] MIPS: Octeon: PCI{,e} updates for Octeon II SOCs
Date:   Tue, 15 Nov 2011 15:46:10 -0800
Message-Id: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12940

From: David Daney <david.daney@cavium.com>

Nothing earth shattering.  The bulk of the change is the register
definitions for the new PCIe hardware.

David Daney (5):
  MIPS: Octeon: Update SOC PCI related register definitions for new
    chips.
  MIPS: Octeon: Update feature test functions for new chips and
    features.
  MIPS: Octeon: Update DMA mapping operations for OCTEON II processors.
  MIPS: Octeon: Update PCI Latency timer, PCIe payload, and PCIe max
    read to allow larger transactions
  MIPS: Octeon: Add support for OCTEON II PCIe

 arch/mips/cavium-octeon/dma-octeon.c             |   23 +-
 arch/mips/include/asm/octeon/cvmx-dpi-defs.h     |  643 +++++++
 arch/mips/include/asm/octeon/cvmx-npei-defs.h    |    4 +-
 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h |  609 ++++++-
 arch/mips/include/asm/octeon/cvmx-pemx-defs.h    |  509 +++++
 arch/mips/include/asm/octeon/cvmx-pexp-defs.h    |   19 +-
 arch/mips/include/asm/octeon/cvmx-sli-defs.h     | 2172 ++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-sriox-defs.h   | 1036 +++++++++++
 arch/mips/include/asm/octeon/cvmx.h              |   42 +-
 arch/mips/include/asm/octeon/octeon-feature.h    |  114 ++-
 arch/mips/include/asm/octeon/pci-octeon.h        |    3 +-
 arch/mips/pci/pci-octeon.c                       |   26 +-
 arch/mips/pci/pcie-octeon.c                      | 1349 ++++++++++----
 13 files changed, 6097 insertions(+), 452 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-dpi-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pemx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-sli-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-sriox-defs.h

-- 
1.7.2.3
