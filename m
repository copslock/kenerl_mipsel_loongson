Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 03:20:58 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:51888 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903683Ab2D0BUm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 03:20:42 +0200
Received: by dakb39 with SMTP id b39so245326dak.35
        for <multiple recipients>; Thu, 26 Apr 2012 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CnCYf7JCHHDLfVqcADSL/Cz+g+FOOyrc5ju91TWktAM=;
        b=VQDZVBW5peKDG7Ht6l6OK0zTaMpL+KSuUEwHdSnYNqnFM/F6xVUbxa1UGqxwMDbRyy
         anzBM3pz7FGlb5NW4vNJfTe3eYeBDJIS9XvepCGyVxCTpLXGHr2mc0k0MojfDlcCP9ZG
         DzUHOtxjE7FLLxxzzUs6AR9+N9/AXBQLPdxJVrh7e2EXdzh8xFkGlQov+E/3DXVlgsQ4
         crPLd236eqlk/eWISMttY/ho3xA69Msegi4bIiBml9mS46NBDx+NZB1wQWLkkGe/r4Mf
         Wpnoe2uzJPeC2ht54JAl9Mk6n9Txa6KTAjqnvZwGbSbX3n8SlYK2ImFfLFBESb4B4Nz5
         8LLQ==
Received: by 10.68.226.168 with SMTP id rt8mr19679601pbc.103.1335489635357;
        Thu, 26 Apr 2012 18:20:35 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id d4sm4850850pbe.36.2012.04.26.18.20.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 18:20:34 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3R1KXaG027053;
        Thu, 26 Apr 2012 18:20:33 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3R1KVRF027052;
        Thu, 26 Apr 2012 18:20:31 -0700
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
Subject: [PATCH v2 0/5] MIPS: OCTEON: Convert some device to use Device Tree.
Date:   Thu, 26 Apr 2012 18:20:25 -0700
Message-Id: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

This patch set depends on the previous set to add Device Tree to
OCTEON.  That set can be found among other places here:

http://marc.info/?l=linux-kernel&m=133548781607480

For v2:

No functional changes, but minor clean-ups to use some new device tree
helper functions.

Some Acked-bys added.

I am suggesting that all these go via Ralf's linux-mips.org tree as
they depend on other patches in that tree.

>From v1:

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
 drivers/i2c/busses/i2c-octeon.c           |   92 +++++----
 drivers/net/ethernet/octeon/octeon_mgmt.c |  312 +++++++++++++++++++----------
 drivers/net/phy/mdio-octeon.c             |   92 ++++++---
 drivers/staging/octeon/ethernet-mdio.c    |   28 ++--
 drivers/staging/octeon/ethernet.c         |  153 +++++++++-----
 drivers/staging/octeon/octeon-ethernet.h  |    3 +
 10 files changed, 484 insertions(+), 519 deletions(-)

Cc: netdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:  David S. Miller <davem@davemloft.net>
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
Cc: "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org
-- 
1.7.2.3
