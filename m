Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2012 01:23:07 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:48087 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903734Ab2DRXVI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2012 01:21:08 +0200
Received: by obcni5 with SMTP id ni5so3717470obc.36
        for <linux-mips@linux-mips.org>; Wed, 18 Apr 2012 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yU7GEu1QLe0JUy6ScOAbdi4Qb93sGUeonS6vgGiiagk=;
        b=P5k31bF/CrFsx+0DYBJM+6oFSiKLbIgJCiZZksuq8ndHT2+hp2sw8XH4BuJhJ3duaH
         Xwp29PpH79HDTNChXizrtd1IChN+5kkMddSP4Zd0QWYG3PPxdoHlIQlKntI5vkGsoemz
         bSEmaH7WBOdnBu/FyoA0E7EptPBsy/Pi1ezDvrN2QtX+3+3v+eIoLWED46tSJYNlwf3O
         uvpUMbn09P9WevUuKXlddT159MKOUIIBnq4wqGa+Nv7y2OASKPFBhGdaX/EppluYXagq
         /jfQTlXq3JkispotuSKZCcxnyRc9oZ4PmY/V6Awrejd/xVDNocHUqm11plv4s7x7+s1F
         pBzw==
Received: by 10.182.31.47 with SMTP id x15mr5547729obh.76.1334791262875;
        Wed, 18 Apr 2012 16:21:02 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id yw3sm520314obb.7.2012.04.18.16.21.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 16:21:00 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3INKwln016030;
        Wed, 18 Apr 2012 16:20:58 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3INKtb6016020;
        Wed, 18 Apr 2012 16:20:55 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v5 0/3] netdev/of/phy: MDIO bus multiplexer support.
Date:   Wed, 18 Apr 2012 16:20:51 -0700
Message-Id: <1334791254-15987-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

This code has been working well for about six months on a couple of
different configurations (boards), so I thought it would be a good
time to send it out again, and I hope get it on the path towards
merging.

v5: Correct Kconfig depends in 3/3 as noticed by David Miller.

v4: Correct some comment text and rename a couple of variables to
    better reflect their purpose.

v3: Update binding to use "mdio-mux-gpio" compatible property.
    Cleanups suggested by Grant Likely.  Now uses the driver probe
    deferral mechanism if GPIOs or parent bus not available.

v2: Update bindings to use "reg" and "mdio-parent-bus" instead of
    "cell-index" and "parent-bus"

v1:

We have several different boards with a multiplexer in the MDIO bus.
There is an MDIO bus controller connected to a switching device with
several child MDIO busses.

Everything is wired up using device tree bindings.

 1/3 - New of_mdio_find_bus() function used to help configuring the
       driver topology.

 2/3 - MDIO bus multiplexer framework.

 3/3 - A driver for a GPIO controlled multiplexer.

David Daney (3):
  netdev/of/phy: New function: of_mdio_find_bus().
  netdev/of/phy: Add MDIO bus multiplexer support.
  netdev/of/phy: Add MDIO bus multiplexer driven by GPIO lines.

 .../devicetree/bindings/net/mdio-mux-gpio.txt      |  127 +++++++++++++
 Documentation/devicetree/bindings/net/mdio-mux.txt |  136 ++++++++++++++
 drivers/net/phy/Kconfig                            |   18 ++
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/mdio-mux-gpio.c                    |  142 +++++++++++++++
 drivers/net/phy/mdio-mux.c                         |  192 ++++++++++++++++++++
 drivers/net/phy/mdio_bus.c                         |   32 ++++
 drivers/of/of_mdio.c                               |    2 +
 include/linux/mdio-mux.h                           |   21 ++
 include/linux/of_mdio.h                            |    2 +
 10 files changed, 674 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux.txt
 create mode 100644 drivers/net/phy/mdio-mux-gpio.c
 create mode 100644 drivers/net/phy/mdio-mux.c
 create mode 100644 include/linux/mdio-mux.h

-- 
1.7.2.3
