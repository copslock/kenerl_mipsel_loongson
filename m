Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2012 01:57:23 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:38135 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903792Ab2CAA5Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2012 01:57:16 +0100
Received: by ghbf11 with SMTP id f11so16291ghb.36
        for <multiple recipients>; Wed, 29 Feb 2012 16:57:10 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.115.105 as permitted sender) client-ip=10.236.115.105;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.115.105 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.236.115.105])
        by 10.236.115.105 with SMTP id d69mr3867440yhh.89.1330563430273 (num_hops = 1);
        Wed, 29 Feb 2012 16:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PfD6qaTj1g4qWYZ3Z9cQLOW+nS4BpGLqbpVi5hAf5QY=;
        b=fj6eZnfvnmo1SWE6InvK2E1O4SCeAbPeyoY1sita2jTBjlamVSgZ/BL1WwmBV6Psgi
         KqcKYrecHIMQw52Aj6DM2sBRHUsfbkl/La8WHU+oHXRHbRmCMeckNRoJTiHWIXKimtsA
         DfSCsvxFaWUuzseBvHlieCa7nzN8HVdPczJIM=
Received: by 10.236.115.105 with SMTP id d69mr3046257yhh.89.1330563430229;
        Wed, 29 Feb 2012 16:57:10 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id h30sm509495yhk.4.2012.02.29.16.57.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 16:57:09 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q210v7Vb014115;
        Wed, 29 Feb 2012 16:57:07 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q210v57m014114;
        Wed, 29 Feb 2012 16:57:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 0/5] MIPS: Octeon: Use Device Tree.
Date:   Wed, 29 Feb 2012 16:56:57 -0800
Message-Id: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

This code has now had extensive testing, it is running on more
than 10 different boards and SOC combinations.

The patches in this set are all in the arch/mips tree and should
probably be merged by Ralf.

They do depend on this libfdt patch:

http://marc.info/?l=linux-kernel&m=133054335203615

New in v6:

o Device Tree bindings updated based on feedback and more actual use.

o Use of irq_domain support added to recent kernels.

New in v5:

o New irq triggering mode constants.

o Boot protocol to pass flattened device tree from bootloader.  This
  protocol may change based on attempts to arrive at a common protocol
  for all MIPS boards.

New in v4:

o Cleanup and error checking suggested by Sergei Shtylyov.

o Use device tree passed by bootloader if present.

New in v3:

o More updates to device tree bindings, and perhaps more importantly
  descriptions/definitions of the bindings

o Cleanup and style improvements as suggested by Grant Likley.

o Omitted all the driver changes, as they are unchanged from the last
  set, and at this stage the patches are just an RFC.

New in v2:

o Changed many device tree bindings.  They should be closer to the
  standard naming scheme now.

o Editing of the template device tree is done in the flattened form
  using libfdt.

o Standard platform driver functions used in preference to the
  of_platform variety.

v1:

Background: The Octeon family of SOCs has a variety of on-chip
controllers for Ethernet, MDIO, I2C, and several other I/O devices.
These chips are used on boards with a great variety of different
configurations.  To date, the configuration and bus topology
information has been hard coded in the drivers and support code.

To facilitate supporting new chips and boards, we are using the Device
Tree to encode the configuration information.  The migration from the
legacy approach to the device tree is as follows:

o A device tree template is statically linked into the kernel image.
  Based on SOC type and board type, legacy configuration probing code
  is used to prune and patch the device tree template.

o New SOCs and boards will directly use a device tree passed by the
  bootloader.


David Daney (5):
  MIPS: Octeon: Add device tree source files.
  MIPS: Don't define early_init_devtree() and device_tree_init() in
    prom.c for CPU_CAVIUM_OCTEON
  MIPS: Octeon: Add irq handlers for GPIO interrupts.
  MIPS: Octeon: Setup irq_domains for interrupts.
  MIPS: Octeon: Initialize and fixup device tree.

 .../bindings/ata/cavium-compact-flash.txt          |   30 +
 .../bindings/gpio/cavium-octeon-gpio.txt           |   48 ++
 .../devicetree/bindings/i2c/cavium-i2c.txt         |   34 ++
 .../devicetree/bindings/mips/cavium/bootbus.txt    |  126 ++++
 .../devicetree/bindings/mips/cavium/ciu.txt        |   26 +
 .../devicetree/bindings/mips/cavium/ciu2.txt       |   27 +
 .../devicetree/bindings/mips/cavium/dma-engine.txt |   21 +
 .../devicetree/bindings/mips/cavium/uctl.txt       |   47 ++
 .../devicetree/bindings/net/cavium-mdio.txt        |   27 +
 .../devicetree/bindings/net/cavium-mix.txt         |   40 ++
 .../devicetree/bindings/net/cavium-pip.txt         |   98 +++
 .../devicetree/bindings/serial/cavium-uart.txt     |   19 +
 arch/mips/Kconfig                                  |    3 +
 arch/mips/cavium-octeon/.gitignore                 |    2 +
 arch/mips/cavium-octeon/Makefile                   |   16 +
 arch/mips/cavium-octeon/octeon-irq.c               |  395 +++++++++++--
 arch/mips/cavium-octeon/octeon-platform.c          |  523 ++++++++++++++++-
 arch/mips/cavium-octeon/octeon_3xxx.dts            |  571 ++++++++++++++++++
 arch/mips/cavium-octeon/octeon_68xx.dts            |  625 ++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c                    |   45 ++
 arch/mips/kernel/prom.c                            |    2 +
 21 files changed, 2661 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/cavium-compact-flash.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/cavium-octeon-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/cavium-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/bootbus.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/ciu.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/ciu2.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/dma-engine.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/uctl.txt
 create mode 100644 Documentation/devicetree/bindings/net/cavium-mdio.txt
 create mode 100644 Documentation/devicetree/bindings/net/cavium-mix.txt
 create mode 100644 Documentation/devicetree/bindings/net/cavium-pip.txt
 create mode 100644 Documentation/devicetree/bindings/serial/cavium-uart.txt
 create mode 100644 arch/mips/cavium-octeon/.gitignore
 create mode 100644 arch/mips/cavium-octeon/octeon_3xxx.dts
 create mode 100644 arch/mips/cavium-octeon/octeon_68xx.dts

-- 
1.7.2.3
