Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2011 22:02:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15604 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491886Ab1HaUBz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2011 22:01:55 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e5e93770000>; Wed, 31 Aug 2011 13:03:03 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 31 Aug 2011 13:01:52 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 31 Aug 2011 13:01:52 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p7VK1oWF014040;
        Wed, 31 Aug 2011 13:01:50 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p7VK1mO9014039;
        Wed, 31 Aug 2011 13:01:48 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] netdev/of/phy: MDIO bus multiplexer support.
Date:   Wed, 31 Aug 2011 13:01:43 -0700
Message-Id: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 31 Aug 2011 20:01:52.0172 (UTC) FILETIME=[D36076C0:01CC6818]
X-archive-position: 31021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23639

We have several different boards with a multiplexer in the MDIO bus.
There is an MDIO bus controller connected to a switching device with
several child MDIO busses.

Everything is wired up using device tree bindings.

 1/3 - New of_mdio_find_bus() function used to help configuring the
       driver topology.

 2/3 - MDIO bus multiplexer framework.

 3/3 - A driver for a GPIO controlled multiplexer.

I have an additional patch I am working on for an I2C controlled
multiplexer that I will follow up with once this reaches a mergable
state.

David Daney (3):
  netdev/of/phy: New function: of_mdio_find_bus().
  netdev/of/phy: Add MDIO bus multiplexer support.
  netdev/of/phy: Add MDIO bus multiplexer driven by GPIO lines.

 .../devicetree/bindings/net/mdio-mux-gpio.txt      |  127 ++++++++++++++
 Documentation/devicetree/bindings/net/mdio-mux.txt |  132 ++++++++++++++
 drivers/net/phy/Kconfig                            |   17 ++
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/mdio-mux-gpio.c                    |  143 +++++++++++++++
 drivers/net/phy/mdio-mux.c                         |  182 ++++++++++++++++++++
 drivers/net/phy/mdio_bus.c                         |    3 +-
 drivers/of/of_mdio.c                               |   26 +++
 include/linux/mdio-mux.h                           |   18 ++
 include/linux/of_mdio.h                            |    2 +
 include/linux/phy.h                                |    1 +
 11 files changed, 652 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux.txt
 create mode 100644 drivers/net/phy/mdio-mux-gpio.c
 create mode 100644 drivers/net/phy/mdio-mux.c
 create mode 100644 include/linux/mdio-mux.h

-- 
1.7.2.3
