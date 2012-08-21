Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:45:30 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:36603 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2HUSpY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:45:24 +0200
Received: by dajq27 with SMTP id q27so80720daj.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ViZKYSshV0qxAKJv3qPy6FmESQqi/41HI9dPWxO9+Ck=;
        b=vxkmTWQbbxGE+HCi+z2m9O9WjwuChhosq8GIapN3PIyOhKAxkDhIQa+/tS5kwKmO2v
         htuf6QGr3FtdYKmGJQzzNz/NktQT561tOu1iSLgantfTo6uc6BEVnGXgRd130RKzN+Qz
         WhZxf/Svs+RQIt0mL4NtulM7VjuBUhg2mooIlmF5DQL6/anejVMQ6t3Guu9KXQ4XGri0
         DMUBjHJ39r05mcrWU/9TR8Ou2uSCcQACz9sUO5CAmatJgsa/X9sqd9lzmvvP+pFAZB/Y
         zBP9oWm3MBgZQ852yZAsX5jWaDekCXIqtNH7WanTaYP/3VEyajMVmwbf3BpacK04srUb
         aXuQ==
Received: by 10.68.241.99 with SMTP id wh3mr46649459pbc.16.1345574718265;
        Tue, 21 Aug 2012 11:45:18 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id tv6sm1958056pbc.24.2012.08.21.11.45.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:45:17 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7LIjF6f021487;
        Tue, 21 Aug 2012 11:45:15 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7LIjEoO021485;
        Tue, 21 Aug 2012 11:45:14 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/8] netdev/MIPS: Improvements to octeon_mgmt Ethernet driver.
Date:   Tue, 21 Aug 2012 11:45:04 -0700
Message-Id: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
X-archive-position: 34317
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

Recent additions to the OCTEON SoC family have included enhancements
to the MIX (octeon_mgmt) Ethernet hardware.  These include:

o 1Gig support (up from 100M).

o Hardware timestamping for PTP.

Here we add support for these two features as well as some ethtool
improvements and cleanup of the MAC address handling.

Patch 1/8 is a prerequisite for the rest, and lives in the MIPS
architecture part of the tree.  Since octeon_mgmt devices are only
found in OCTEON SoCs we could merge the whole set via Ralf's tree, or
get Ralf to affix his Acked-by and have it go via the netdev tree.


Chad Reese (1):
  netdev: octeon_mgmt: Add hardware timestamp support.

David Daney (7):
  MIPS: Octeon: Add octeon_io_clk_delay() function.
  netdev: octeon_mgmt: Add support for 1Gig ports.
  netdev: octeon_mgmt: Improve ethtool_ops.
  netdev: octeon_mgmt: Set the parent device.
  netdev: octeon_mgmt: Cleanup and modernize MAC address handling.
  netdev: octeon_mgmt: Remove some useless 'inline'
  netdev: octeon_mgmt: Make multi-line comment style consistent.

 arch/mips/cavium-octeon/csrc-octeon.c     |  93 +++--
 arch/mips/cavium-octeon/setup.c           |   3 +-
 arch/mips/include/asm/octeon/octeon.h     |   1 +
 drivers/net/ethernet/octeon/octeon_mgmt.c | 554 ++++++++++++++++++++++++------
 4 files changed, 512 insertions(+), 139 deletions(-)

-- 
1.7.11.4
