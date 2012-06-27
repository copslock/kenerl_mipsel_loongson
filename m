Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2012 19:35:38 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:40857 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903540Ab2F0Rdy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2012 19:33:54 +0200
Received: by dadm1 with SMTP id m1so1815742dad.36
        for <linux-mips@linux-mips.org>; Wed, 27 Jun 2012 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wORRgnBv8RFTXhfOxoH+KsFaVPE9YsbXmi6GT4D3JpI=;
        b=g+U8ISpeHFNoqXyePWyeYermcl6JGuzKXUZKQL7h4yvZpbP6J+b5UJ4Vd8ITfMMkK2
         h9Uyv6m30kIVkRqnc0Cts5u6s5TmlWQ3ia3rRaxEDpx50Z9K5FHV7cuM10oJ2NypPCcC
         0mXm9Epg2TyDeXv+XrKrXXE8Z+53iOYdHpQ/D0iqGMzZJhm6ghm/kIpa8exhuRMbSQXP
         gyl91hesQKoEQbr9fRSlIJjs57mRaRxt6RTZ6Il6sH8884+IVa0XOX0eEH7c89+JRdmW
         TG9Oy82OlVxI3BiMFKgjIe/N9o6agg2U8vfOnAT/saR/Gthuzsxbew9t19eLwbvVx0R/
         E1zg==
Received: by 10.68.217.166 with SMTP id oz6mr65683504pbc.136.1340818426853;
        Wed, 27 Jun 2012 10:33:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id iv8sm15740397pbc.53.2012.06.27.10.33.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 10:33:45 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q5RHXh5K010417;
        Wed, 27 Jun 2012 10:33:43 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q5RHXfEi010416;
        Wed, 27 Jun 2012 10:33:41 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/4] netdev/phy: 10G PHY support.
Date:   Wed, 27 Jun 2012 10:33:34 -0700
Message-Id: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33859
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

The only non-cosmetic change from v1 is to pass an additional argument
to get_phy_device() that indicates that the PHY uses 802.3 clause 45
signaling, previously I had been using a high order bit of the addr
parameter for this.

There are also changes from v1 in the code and comment formatting.
These should now be closer to what David Miller prefers.

>From v1:

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
 drivers/net/phy/bcm87xx.c                          |  238 ++++++++++++++++++++
 drivers/net/phy/mdio_bus.c                         |    9 +-
 drivers/net/phy/phy_device.c                       |  105 ++++++++-
 drivers/of/of_mdio.c                               |   16 +-
 include/linux/phy.h                                |   24 ++-
 9 files changed, 424 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/broadcom-bcm87xx.txt
 create mode 100644 drivers/net/phy/bcm87xx.c

-- 
1.7.2.3
