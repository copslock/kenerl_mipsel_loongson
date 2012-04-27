Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 02:49:11 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:51541 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903683Ab2D0AsN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 02:48:13 +0200
Received: by pbbrq13 with SMTP id rq13so379120pbb.36
        for <multiple recipients>; Thu, 26 Apr 2012 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=X+rebBLsta0ImL0ARqCjrNur6i6oVsijA6FU+3sfFkc=;
        b=nYC3fUCVNMSvGVgB99CnDdkS87kE6xcNwHjcBctzreKLKv8S7S2TUTY+l6fJVbw/nn
         zHvaEfgyNKAbpbIzVjm9HGnSAG/xKF+BeZABPPs2+ix3NdO5pl+UkH1vIFEbXksNGxGo
         lb+vHfqtpc9S5iSfIK+iAzelx7B9PwGBsfvEab9wvvfcBmnLF9MJIU7JawnSEWRuzpPy
         x4Iu20g1wgzTFmx0piC9N0J/kVNXQwhgZmVbsM5QYA0ntKGp/nGDEL6qx1Vy90Bhip8K
         UlvHtr8IiqWblvxZcV0UabKYBwnZqvamO13K2w+0UPL+cy2CcSC2vcV4AWHG+7G29Bhv
         y8bw==
Received: by 10.68.244.102 with SMTP id xf6mr11506753pbc.115.1335487686741;
        Thu, 26 Apr 2012 17:48:06 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pp8sm4100867pbb.21.2012.04.26.17.48.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 17:48:04 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3R0m3nn026259;
        Thu, 26 Apr 2012 17:48:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3R0m2XJ026257;
        Thu, 26 Apr 2012 17:48:02 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v8 0/4] MIPS: OCTEON: Use Device Tree.
Date:   Thu, 26 Apr 2012 17:47:54 -0700
Message-Id: <1335487678-26223-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33015
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

https://lkml.org/lkml/2012/3/23/322

As well as thses MIPS patches:

http://www.linux-mips.org/archives/linux-mips/2012-03/msg00159.html

New in v8:

o No functional change, but minor reorganizations based on reviewer
  feedback.

New in v7:

o irq_domain support revised based on feedback from Grant and Rob.

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

David Daney (4):
  MIPS: Don't define early_init_devtree() and device_tree_init() in
    prom.c for CPU_CAVIUM_OCTEON
  MIPS: Octeon: Setup irq_domains for interrupts.
  MIPS: Octeon: Add device tree source files.
  MIPS: Octeon: Initialize and fixup device tree.

 .../bindings/ata/cavium-compact-flash.txt          |   30 +
 .../bindings/gpio/cavium-octeon-gpio.txt           |   49 ++
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
 arch/mips/Kconfig                                  |    2 +
 arch/mips/cavium-octeon/.gitignore                 |    2 +
 arch/mips/cavium-octeon/Makefile                   |   16 +
 arch/mips/cavium-octeon/octeon-irq.c               |  215 +++++++-
 arch/mips/cavium-octeon/octeon-platform.c          |  523 ++++++++++++++++-
 arch/mips/cavium-octeon/octeon_3xxx.dts            |  571 ++++++++++++++++++
 arch/mips/cavium-octeon/octeon_68xx.dts            |  625 ++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c                    |   45 ++
 arch/mips/kernel/prom.c                            |    2 +
 21 files changed, 2535 insertions(+), 10 deletions(-)
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
