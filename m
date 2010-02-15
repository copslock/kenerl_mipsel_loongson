Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 21:13:39 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19974 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492143Ab0BOUNf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 21:13:35 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b79aaf70000>; Mon, 15 Feb 2010 12:13:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 12:13:33 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 12:13:32 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1FKDTOU003548;
        Mon, 15 Feb 2010 12:13:29 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1FKDSgD003547;
        Mon, 15 Feb 2010 12:13:28 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/4] Staging: octeon: remove unneeded includes
Date:   Mon, 15 Feb 2010 12:13:16 -0800
Message-Id: <1266264799-3510-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <4B79AAA6.60005@caviumnetworks.com>
References: <4B79AAA6.60005@caviumnetworks.com>
X-OriginalArrivalTime: 15 Feb 2010 20:13:32.0801 (UTC) FILETIME=[58D47710:01CAAE7B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/staging/octeon/ethernet-mdio.h  |    1 -
 drivers/staging/octeon/ethernet-rgmii.c |    1 -
 drivers/staging/octeon/ethernet-sgmii.c |    1 -
 drivers/staging/octeon/ethernet-spi.c   |    1 -
 drivers/staging/octeon/ethernet-xaui.c  |    1 -
 drivers/staging/octeon/ethernet.c       |    1 -
 6 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.h b/drivers/staging/octeon/ethernet-mdio.h
index 55d0614..a417d4f 100644
--- a/drivers/staging/octeon/ethernet-mdio.h
+++ b/drivers/staging/octeon/ethernet-mdio.h
@@ -32,7 +32,6 @@
 #include <linux/ip.h>
 #include <linux/string.h>
 #include <linux/ethtool.h>
-#include <linux/mii.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <net/dst.h>
diff --git a/drivers/staging/octeon/ethernet-rgmii.c b/drivers/staging/octeon/ethernet-rgmii.c
index 3820f1e..f90d46e 100644
--- a/drivers/staging/octeon/ethernet-rgmii.c
+++ b/drivers/staging/octeon/ethernet-rgmii.c
@@ -26,7 +26,6 @@
 **********************************************************************/
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
-#include <linux/mii.h>
 #include <net/dst.h>
 
 #include <asm/octeon/octeon.h>
diff --git a/drivers/staging/octeon/ethernet-sgmii.c b/drivers/staging/octeon/ethernet-sgmii.c
index 6061d01..2d8589e 100644
--- a/drivers/staging/octeon/ethernet-sgmii.c
+++ b/drivers/staging/octeon/ethernet-sgmii.c
@@ -26,7 +26,6 @@
 **********************************************************************/
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
-#include <linux/mii.h>
 #include <net/dst.h>
 
 #include <asm/octeon/octeon.h>
diff --git a/drivers/staging/octeon/ethernet-spi.c b/drivers/staging/octeon/ethernet-spi.c
index 00dc0f4..b58b897 100644
--- a/drivers/staging/octeon/ethernet-spi.c
+++ b/drivers/staging/octeon/ethernet-spi.c
@@ -26,7 +26,6 @@
 **********************************************************************/
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
-#include <linux/mii.h>
 #include <net/dst.h>
 
 #include <asm/octeon/octeon.h>
diff --git a/drivers/staging/octeon/ethernet-xaui.c b/drivers/staging/octeon/ethernet-xaui.c
index ee3dc41..3fca1cc 100644
--- a/drivers/staging/octeon/ethernet-xaui.c
+++ b/drivers/staging/octeon/ethernet-xaui.c
@@ -26,7 +26,6 @@
 **********************************************************************/
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
-#include <linux/mii.h>
 #include <net/dst.h>
 
 #include <asm/octeon/octeon.h>
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9d63202..5afece0 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -29,7 +29,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/delay.h>
 #include <linux/phy.h>
 
 #include <net/dst.h>
-- 
1.6.6
