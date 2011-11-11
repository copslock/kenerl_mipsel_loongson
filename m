Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 03:23:23 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:33058 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904257Ab1KKCWX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 03:22:23 +0100
Received: by ggno1 with SMTP id o1so3577618ggn.36
        for <multiple recipients>; Thu, 10 Nov 2011 18:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FqKqNiU7k7TZ6OnuXRlRsFt1v3T1alhotUGuOlM0LpU=;
        b=GKTJMHXfZfivANgFDWvLs/rtNZnJZy4M9YOnaSDySAYvNc2pBGQr7lNwW7F9E5rxtE
         yyciw820khQpBrMTbgTtPHmUMKCU4Qk4Y8fjmQ31k+5ROBT98X7UnGwnuB/f2Jg2FxhH
         ucVMjKewNEnQcdIe6kf9kkopf5T6N5rTXqdco=
Received: by 10.100.130.11 with SMTP id c11mr4392649and.121.1320978137091;
        Thu, 10 Nov 2011 18:22:17 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 8sm29449752anv.16.2011.11.10.18.22.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 18:22:14 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAB2MCe4013082;
        Thu, 10 Nov 2011 18:22:12 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAB2M7TU013081;
        Thu, 10 Nov 2011 18:22:07 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        linux-i2c@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
        devel@driverdev.osuosl.org
Subject: [PATCH 0/8] of/MIPS/i2c/net: Convert OCTEON to use device-tree
Date:   Thu, 10 Nov 2011 18:21:56 -0800
Message-Id: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9968

From: David Daney <david.daney@cavium.com>

This series touches several different drivers, but since OCTEON is a
MIPS based SOC, we may want to merge the whole series via Ralf's
linux-mips.org tree.

Summary of the patches:

1) Template device trees to be patched in early boot for legacy boards
   that do not supply a device tree.

2) Get rid of some garbage.

3) Interrupt mapping support.

4) Patch/fix-up device tree for lagacy boards.

5) I2C bus driver.

6) MDIO bus driver.

7,8) Ethernet drivers.

Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: devel@driverdev.osuosl.org 

David Daney (8):
  MIPS: Octeon: Add device tree source files.
  MIPS: Prune some target specific code out of prom.c
  MIPS: Octeon: Add irq_create_of_mapping() and GPIO interrupts.
  MIPS: Octeon: Initialize and fixup device tree.
  i2c: Convert i2c-octeon.c to use device tree.
  netdev: mdio-octeon.c: Convert to use device tree.
  netdev: octeon_mgmt: Convert to use device tree.
  staging: octeon_ethernet: Convert to use device tree.

 .../bindings/ata/cavium-compact-flash.txt          |   30 +
 .../bindings/gpio/cavium-octeon-gpio.txt           |   48 ++
 .../devicetree/bindings/i2c/cavium-i2c.txt         |   34 +
 .../devicetree/bindings/mips/cavium/bootbus.txt    |  126 ++++
 .../devicetree/bindings/mips/cavium/ciu.txt        |   26 +
 .../devicetree/bindings/mips/cavium/ciu2.txt       |   27 +
 .../devicetree/bindings/mips/cavium/dma-engine.txt |   21 +
 .../devicetree/bindings/mips/cavium/uctl.txt       |   47 ++
 .../devicetree/bindings/net/cavium-mdio.txt        |   27 +
 .../devicetree/bindings/net/cavium-mix.txt         |   40 ++
 .../devicetree/bindings/net/cavium-pip.txt         |   98 +++
 .../devicetree/bindings/serial/cavium-uart.txt     |   19 +
 arch/mips/Kconfig                                  |    1 +
 arch/mips/cavium-octeon/.gitignore                 |    2 +
 arch/mips/cavium-octeon/Makefile                   |   16 +
 arch/mips/cavium-octeon/octeon-irq.c               |  188 ++++++-
 arch/mips/cavium-octeon/octeon-platform.c          |  699 +++++++++++++++-----
 arch/mips/cavium-octeon/octeon_3xxx.dts            |  571 ++++++++++++++++
 arch/mips/cavium-octeon/octeon_68xx.dts            |  625 +++++++++++++++++
 arch/mips/cavium-octeon/setup.c                    |   45 ++
 arch/mips/include/asm/octeon/octeon.h              |    5 -
 arch/mips/kernel/prom.c                            |   50 --
 drivers/i2c/busses/i2c-octeon.c                    |   94 ++--
 drivers/net/ethernet/octeon/octeon_mgmt.c          |  312 ++++++---
 drivers/net/phy/mdio-octeon.c                      |   89 ++-
 drivers/staging/octeon/ethernet-mdio.c             |   28 +-
 drivers/staging/octeon/ethernet.c                  |   91 ++-
 drivers/staging/octeon/octeon-ethernet.h           |    3 +
 28 files changed, 2901 insertions(+), 461 deletions(-)
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
