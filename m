Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2012 19:33:28 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:32923 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903690Ab2DQRdO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2012 19:33:14 +0200
Received: by ggnk1 with SMTP id k1so3592997ggn.36
        for <linux-mips@linux-mips.org>; Tue, 17 Apr 2012 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=KTGIh6jmxzwJ2Yk7z+x9ak2StRtS9pl7x6VPaRsf1/I=;
        b=hY54zKcv9sxKyT99O/Q774AQl4LJ9K5XmDmUsgtAxGis5Kvt1G5syjVOhE8/4sQJja
         P0ohIxZqJZsYuJzjYs6cYC4QXtHO7/KI+1Lh16bV17GmTd/UmQfsTdETMyMc59ZqEHCa
         WgTyCBJ00EONcGB7oBjsTCgAOMNPsiX27uLwrlylX3BJraVedS8J6fSGzL9qxyRcH2ZL
         Q/Av7ylHNVYBEIj3/3zLSmFhYMX0F1eH1qtRieP7rDxMeUMawlvm9g2KOz8J0GizlZuh
         2IdlPJOlUArytGa3bKRwFJn7ebF8UzRXevSj5b+woPNtTgLcFY8mhYNPmTlcOZAgnHvy
         afYQ==
Received: by 10.60.3.99 with SMTP id b3mr22404766oeb.72.1334683988862;
        Tue, 17 Apr 2012 10:33:08 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id k2sm23768520obl.14.2012.04.17.10.33.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 10:33:07 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3HHWuNA012147;
        Tue, 17 Apr 2012 10:32:57 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3HHWq4W012146;
        Tue, 17 Apr 2012 10:32:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v4 0/3] netdev/of/phy: MDIO bus multiplexer support.
Date:   Tue, 17 Apr 2012 10:32:43 -0700
Message-Id: <1334683966-12112-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32953
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
