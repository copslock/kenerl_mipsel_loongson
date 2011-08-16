Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2011 19:12:02 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:9211 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492003Ab1HPRLr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Aug 2011 19:11:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e4aa4d60000>; Tue, 16 Aug 2011 13:11:50 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 16 Aug 2011 10:11:05 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 16 Aug 2011 10:11:05 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p7GHB1N8024516;
        Tue, 16 Aug 2011 10:11:02 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p7GHAwvH024515;
        Tue, 16 Aug 2011 10:10:58 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] staging: octeon-ethernet: Add missing #includes.
Date:   Tue, 16 Aug 2011 10:10:56 -0700
Message-Id: <1313514656-24482-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 16 Aug 2011 17:11:05.0727 (UTC) FILETIME=[7BD2C8F0:01CC5C37]
X-archive-position: 30886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11792

I looks like something used to implicitly include linux/interrupt.h,
and no longer does.  Fix the resulting build error by explicitly
including it.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---

This could go via Ralf's linux-mips.org tree as Octeon is a MIPS
archecture SOC.  It would be nice to get in before the final 3.1 as it
is a build breaker.

 drivers/staging/octeon/ethernet-rgmii.c |    1 +
 drivers/staging/octeon/ethernet-spi.c   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
index 9c0d293..c3d73f8 100644
--- a/drivers/staging/octeon/ethernet-rgmii.c
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -26,6 +26,7 @@
 **********************************************************************/
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/interrupt.h>
 #include <linux/phy.h>
 #include <linux/ratelimit.h>
 #include <net/dst.h>
diff --git a/drivers/staging/octeon/ethernet-spi.c b/drivers/staging/octeon/ethernet-spi.c
index 9708254..d0e2d51 100644
--- a/drivers/staging/octeon/ethernet-spi.c
+++ b/drivers/staging/octeon/ethernet-spi.c
@@ -26,6 +26,7 @@
 **********************************************************************/
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/interrupt.h>
 #include <net/dst.h>
 
 #include <asm/octeon/octeon.h>
-- 
1.7.2.3
