Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2012 03:04:01 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35979 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903683Ab2DQBDq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2012 03:03:46 +0200
Received: by obcni5 with SMTP id ni5so253525obc.36
        for <linux-mips@linux-mips.org>; Mon, 16 Apr 2012 18:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=IbXiqUm0AMna2BwLRrZNaLIJIYxv8keH17EhIBKOe4w=;
        b=oOu+yMtY+IqjRkW3gXFGVT7kHK9nUOVF7Ihtq51+w4Xq/4modxoYZ5l2RND58kCsyB
         n2nlPTcL4bq1lB+fqeFOPwtN3IagUkETtqBKf8jlU58JY42TcNgaD30AkMSRwIotk8/w
         oDPpUs4B489GAXNfGGO3su00i5UwnwoYF5I4uGdFqWCDscqoalZW457KPkfOXGnn/tJp
         7ENDFnCTXv5BJDGIaGygUwlMZcQD8r61EOnKRLsTEHfVbRptMr6rhi5YfxyKAukXHS4o
         DF8jjvwSryVykEXWkruIBd0JM34Whn5b08Cn4fRA0/xky2/XvLTV07PrZQYaZFxuuuvm
         ld7A==
Received: by 10.182.86.165 with SMTP id q5mr18820549obz.0.1334624620607;
        Mon, 16 Apr 2012 18:03:40 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id m2sm21374979obk.9.2012.04.16.18.03.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 18:03:39 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3H13YoE026701;
        Mon, 16 Apr 2012 18:03:35 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3H13Uls026700;
        Mon, 16 Apr 2012 18:03:30 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v3 0/3] netdev/of/phy: MDIO bus multiplexer support.
Date:   Mon, 16 Apr 2012 18:03:25 -0700
Message-Id: <1334624608-26667-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32947
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
