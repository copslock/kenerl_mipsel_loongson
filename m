Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 02:24:33 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:53731 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903669Ab2FWAY3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2012 02:24:29 +0200
Received: by dadm1 with SMTP id m1so3181016dad.36
        for <linux-mips@linux-mips.org>; Fri, 22 Jun 2012 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+pyhGw/FZYQVMFidsdNs8Qu9QzvJTCVUmYb/4/qTdts=;
        b=XHhI+SC8PEk/rbCsT43BeCksErK+0JPwyDCmxTPz/ObgVWDA9kx+HCs+F6xJY3gwyp
         G6yi+kgXd0rGhMiWtFwxrAYXILZbYZ7rncyktehFpq0xTd/7/MfLqNVgUl+CInsfZesD
         BohmH6X1sVRGW9w1GVxMBfPn4i22eR/SNcTBPD/NVmvGXTLuzGRhjIyCrZV05IaMEJqQ
         IsDPOXOQVl6ZHJQIHeE5wh5iNGe0uAyli6lLTwuCRwsZZaNv7T2pcYzcPrsDVM29fGcc
         nLG5DBhPtiGhAB3yPUxFaS8rubNDEB1Nns8JZBgYseMijqQp2KJ9oTkVef+tiU294Ghp
         DN1g==
Received: by 10.68.233.132 with SMTP id tw4mr15494668pbc.61.1340411063113;
        Fri, 22 Jun 2012 17:24:23 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ms1sm604466pbb.63.2012.06.22.17.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 17:24:21 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5N0OKPX019025;
        Fri, 22 Jun 2012 17:24:20 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5N0OI1e019022;
        Fri, 22 Jun 2012 17:24:18 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/4] netdev/phy: 10G PHY support.
Date:   Fri, 22 Jun 2012 17:24:12 -0700
Message-Id: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The existing PHY driver infrastructure supports IEEE 802.3 Clause 22
PHYs used with 10/100/1000MB Ethernet.  For 10G Ethernet, many PHYs
use 802.3 Clause 45.  These patches attempt to add core support for
this as well as a driver for BCM87XX 10G PHY devices.

This is reworked from patches I send about 9 months ago:

http://marc.info/?l=linux-netdev&m=131844282403852

Several of the patches have device tree bindings in them, so the
device tree people get to enjoy them too.

David Daney (4):
  netdev/phy: Handle IEEE802.3 clause 45 Ethernet PHYs
  netdev/phy/of: Handle IEEE802.3 clause 45 Ethernet PHYs in
    of_mdiobus_register()
  netdev/phy/of: Add more methods for binding PHY devices to drivers.
  netdev/phy: Add driver for Broadcom BCM87XX 10G Ethernet PHYs

 .../devicetree/bindings/net/broadcom-bcm87xx.txt   |   29 +++
 Documentation/devicetree/bindings/net/phy.txt      |   12 +-
 drivers/net/phy/Kconfig                            |    5 +
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/bcm87xx.c                          |  239 ++++++++++++++++++++
 drivers/net/phy/mdio_bus.c                         |    7 +
 drivers/net/phy/phy_device.c                       |  110 +++++++++-
 drivers/of/of_mdio.c                               |   14 +-
 include/linux/phy.h                                |   32 +++-
 9 files changed, 436 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/broadcom-bcm87xx.txt
 create mode 100644 drivers/net/phy/bcm87xx.c

-- 
1.7.2.3
