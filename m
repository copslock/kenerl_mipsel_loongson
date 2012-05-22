Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 20:00:11 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51765 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903704Ab2EVSAD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2012 20:00:03 +0200
Received: by dadm1 with SMTP id m1so9730049dad.36
        for <linux-mips@linux-mips.org>; Tue, 22 May 2012 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yAmcIVqfvrfKnY6aRMSQXiR2c6O/pX/miHTXw8CV0VI=;
        b=Qc7k0V9/D77l/C/IgBvkLnAXsbsKtceHtCoTqtjTb2Ov1Nq5yed9djyatMAWvCOwdz
         pxiL92SxI9O09F9jJ/J9yBmwIW8/zo3slMEIp7fjyTd49kLfaOIHC5b7CVLWcxKI2lfp
         A3b2VA0VM2yGo/qQECIluGC+gukvHp9YPfX6ti2uG48aBf0+jybpOwwVH6wfw/zU6lWw
         qV9w++OxwgOeIljxCEZPPpQ/oj17rEcm2URPcFHUizYNs49/6+6wYWKIMvrAlG7lPBvR
         2Zpnd5agCthGrtYp5iacIbdOfiCuUaYAKO7xEW7FUG1931Wq3DH+EYUE3VzRE6JYkm7E
         pbEA==
Received: by 10.68.221.39 with SMTP id qb7mr851400pbc.120.1337709596724;
        Tue, 22 May 2012 10:59:56 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id px4sm3554841pbb.53.2012.05.22.10.59.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 10:59:55 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4MHxs8E023393;
        Tue, 22 May 2012 10:59:54 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4MHxrkI023391;
        Tue, 22 May 2012 10:59:53 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andy Fleming <afleming@freescale.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/5] netdev/phy: 10G PHY support.
Date:   Tue, 22 May 2012 10:59:47 -0700
Message-Id: <1337709592-23347-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The existing PHY driver infrastructure supports IEEE 802.3 Clause 22
PHYs used with 10/100/1000MB Ethernet.  For 10G Ethernet, many PHYs
use 802.3 Clause 45.  These patches attempt to add core support for
this as well as drivers for several different 10G PHY devices.

This is reworked from patches I send about 9 months ago:

http://marc.info/?l=linux-netdev&m=131844282403852

Several of the patches have device tree bindings in them, so the
device tree people get to enjoy them too.


David Daney (5):
  netdev/phy: Handle IEEE802.3 clause 45 Ethernet PHYs
  netdev/phy/of: Handle IEEE802.3 clause 45 Ethernet PHYs in
    of_mdiobus_register()
  netdev/phy/of: Add more methods for binding PHY devices to drivers.
  netdev/phy: Add driver for Broadcom BCM87XX 10G Ethernet PHYs
  netdev/phy: Add driver for Cortina cs4321 quad 10G PHY.

 .../devicetree/bindings/net/broadcom-bcm87xx.txt   |   29 +
 .../devicetree/bindings/net/cortina-cs4321.txt     |   27 +
 Documentation/devicetree/bindings/net/phy.txt      |   12 +-
 drivers/net/phy/Kconfig                            |   11 +
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/bcm87xx.c                          |  237 ++
 drivers/net/phy/cs4321-ucode.h                     | 4378 ++++++++++++++++++++
 drivers/net/phy/cs4321.c                           | 1147 +++++
 drivers/net/phy/mdio_bus.c                         |    7 +
 drivers/net/phy/phy_device.c                       |  110 +-
 drivers/of/of_mdio.c                               |   14 +-
 include/linux/phy.h                                |   32 +-
 12 files changed, 5993 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/broadcom-bcm87xx.txt
 create mode 100644 Documentation/devicetree/bindings/net/cortina-cs4321.txt
 create mode 100644 drivers/net/phy/bcm87xx.c
 create mode 100644 drivers/net/phy/cs4321-ucode.h
 create mode 100644 drivers/net/phy/cs4321.c

-- 
1.7.2.3
