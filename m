Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 02:29:35 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:41773 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903663Ab2C0A2P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 02:28:15 +0200
Received: by obbup16 with SMTP id up16so7096732obb.36
        for <multiple recipients>; Mon, 26 Mar 2012 17:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=pTghsDMLlYCjZSwsy+gt/V5ELzCWHFEQs45zHIlAXRQ=;
        b=AwqVbBWOoSR0j2ZOGMcNqGQFjIQav1R2ngoW/MXk/Wgy5IZj5ay1iidgmzRzIX9Gqx
         r49zeRKEGAcQe3Pun2fnvsIQzdlOnrd7Cofh69AQBXwU/TvDNdfPTgk6mJ6hxVkPWLd7
         TMyvJ/wi81m0WehIJ4jYXr3r7VEgo8q8fO5frzUYXDOO/pszrQp4lY8JhXjSsIfaLg7T
         6IPDNGyZoWzfXJaisZbv8uGcmqU+0Qur4ercSfMWT2/8TdwoJ0GRYvbxOubmZScgFoXT
         C5KAAY1JLNKMkDuxceG+hfe4aDhSzDJucEI/F2Muf0aIEfczlehe8U3/5up8E30M/b6W
         /Rjg==
Received: by 10.182.12.6 with SMTP id u6mr30700092obb.12.1332808089619;
        Mon, 26 Mar 2012 17:28:09 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id e10sm10446009obb.1.2012.03.26.17.28.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 17:28:08 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2R0S63m008369;
        Mon, 26 Mar 2012 17:28:06 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2R0S1YB008368;
        Mon, 26 Mar 2012 17:28:01 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        " David S. Miller" <davem@davemloft.net>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>,
        linux-i2c@vger.kernel.org
Subject: [PATCH 0/5] MIPS: OCTEON: Convert some device to use Device Tree.
Date:   Mon, 26 Mar 2012 17:27:50 -0700
Message-Id: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

This patch set depends on the previous set to add Device Tree to
OCTEON.  That set can be found here:

http://www.linux-mips.org/archives/linux-mips/2012-03/msg00170.html

The patches are for drivers scattered throughout the tree, but there
is an order dependency as well as the dependency mentioned above, so
it may be preferable to merge them all via Ralf's linux-mips.org tree
rather that separately via the various device sub-system maintainers.

The mdio-octeon.c and octeon_mgmt patches were already Acked-by davem.

The i2c has been seen before, but to my knowledge was never acked.

The octeon_ethernet patch is in staging and has also been seen before.

The serial patch is new.

David Daney (5):
  i2c: Convert i2c-octeon.c to use device tree.
  netdev: mdio-octeon.c: Convert to use device tree.
  netdev: octeon_mgmt: Convert to use device tree.
  staging: octeon_ethernet: Convert to use device tree.
  MIPS: Octeon: Use device tree to register serial ports.

 arch/mips/cavium-octeon/octeon-irq.c      |    8 -
 arch/mips/cavium-octeon/octeon-platform.c |  176 ----------------
 arch/mips/cavium-octeon/serial.c          |  134 +++++--------
 arch/mips/include/asm/octeon/octeon.h     |    5 -
 drivers/i2c/busses/i2c-octeon.c           |   94 +++++----
 drivers/net/ethernet/octeon/octeon_mgmt.c |  312 +++++++++++++++++++----------
 drivers/net/phy/mdio-octeon.c             |   92 ++++++---
 drivers/staging/octeon/ethernet-mdio.c    |   28 ++--
 drivers/staging/octeon/ethernet.c         |  153 +++++++++-----
 drivers/staging/octeon/octeon-ethernet.h  |    3 +
 10 files changed, 487 insertions(+), 518 deletions(-)

Cc: netdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:  David S. Miller <davem@davemloft.net>
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
Cc: "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org
-- 
1.7.2.3
