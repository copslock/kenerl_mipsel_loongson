Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 01:28:50 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:61115 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903717Ab2FFX2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 01:28:45 +0200
Received: by dadm1 with SMTP id m1so8178dad.36
        for <multiple recipients>; Wed, 06 Jun 2012 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=59jUNHwQc/1HmRo1xhil1isGb0YUokNwGXRjHCaRwQI=;
        b=lJ9sAF74qNwN15xFtkT8W8dioSOl9RAk/bapExbDDx1QVJhbUW3Ai06Fsw64tPTqCA
         w/0UYTsJfYgKezfIoOgBW/Add9DbtrzEBXGH94OBs5UMGc1tSOo8zj1HknfQyB6dP+I5
         Evh06T2Uv2F4HMDUx/wH7FQonpL4BLd3Ekv8+gC2mFt0UWo/2LdYLJ76AqH9uLkCXMgu
         j+CjwLi7CpBxSRgt2Rqip7KM9xQ3JbFV8PEAlBjYDseDMUUysuWjIJL+FiNHBw35+qUL
         1pnAPwvQh14+aM2QRsK388FtKQtgNUStMswRzOc7Hx27ZV5hEvY1rydiCyiSHQu1cRQI
         YBPw==
Received: by 10.68.194.6 with SMTP id hs6mr1039326pbc.133.1339025319140;
        Wed, 06 Jun 2012 16:28:39 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id qn1sm1907792pbc.9.2012.06.06.16.28.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 16:28:38 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56NSaAd024254;
        Wed, 6 Jun 2012 16:28:36 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56NSZkj024252;
        Wed, 6 Jun 2012 16:28:35 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 0/5] MIPS: OCTEON: Convert some device to use Device Tree.
Date:   Wed,  6 Jun 2012 16:28:29 -0700
Message-Id: <1339025314-24216-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33587
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

This patch set depends on the previous set to add Device Tree to
OCTEON.  That set can be found among other places here:

http://www.linux-mips.org/archives/linux-mips/2012-06/msg00081.html

For v3:

No functional changes, Added more Acked-bys, rebased to avoid merge
conflicts.

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

-- 
1.7.2.3
