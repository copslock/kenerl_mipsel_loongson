Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2012 03:16:59 +0200 (CEST)
Received: from mail-pz0-f53.google.com ([209.85.210.53]:64781 "EHLO
        mail-pz0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903780Ab2ECBQy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 May 2012 03:16:54 +0200
Received: by dadg9 with SMTP id g9so668659dad.26
        for <multiple recipients>; Wed, 02 May 2012 18:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=MjQkM6tv9H1oEqUIUiFy5gVDNF4AyYyuNIaGYIEFUsY=;
        b=EHu/7H/DkrMykWO83lXKf7mEHO/Vct9FR1iag/6d3afk1BcxYOtvXF0mhGmoDBCgjh
         Cv4q0F/tO/9kXar+Ptlkg2i6m/n9bhJR3VfFC5MnZQ85JsyS0gj4+UgvT8bPEOsv6jx0
         SJrSyam+SLJm5HoQGHeZvkpRScc0FLMmGkR1Oi3/xIW8GerioRMoFAjqk2m8abRLf5YQ
         3Ath77Q15hJ1JKxYzUH9CUWvGoQRvYl2Oi80gscFTYJ8zGW1Q7Z8bX0RCwRRMby/wRgb
         1zJdDVUX+6l+JYNm/qo8H8puLZSZg/QkeHleYuE//X67GCn+qXl+zKLAvkrnEuke/ZSu
         2Z/g==
Received: by 10.68.218.198 with SMTP id pi6mr2170557pbc.121.1336007807500;
        Wed, 02 May 2012 18:16:47 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pw10sm897013pbb.30.2012.05.02.18.16.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:16:45 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q431GiWP031052;
        Wed, 2 May 2012 18:16:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q431GfPb031049;
        Wed, 2 May 2012 18:16:41 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v6 0/3] netdev/of/phy: MDIO bus multiplexer support.
Date:   Wed,  2 May 2012 18:16:36 -0700
Message-Id: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33126
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

v6: Correct Kconfig depends in 2/3 as noticed by David Miller.  Test
    against net-next.

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
 drivers/net/phy/Kconfig                            |   19 ++
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/mdio-mux-gpio.c                    |  142 +++++++++++++++
 drivers/net/phy/mdio-mux.c                         |  192 ++++++++++++++++++++
 drivers/net/phy/mdio_bus.c                         |   32 ++++
 drivers/of/of_mdio.c                               |    2 +
 include/linux/mdio-mux.h                           |   21 ++
 include/linux/of_mdio.h                            |    2 +
 10 files changed, 675 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux.txt
 create mode 100644 drivers/net/phy/mdio-mux-gpio.c
 create mode 100644 drivers/net/phy/mdio-mux.c
 create mode 100644 include/linux/mdio-mux.h

-- 
1.7.2.3
