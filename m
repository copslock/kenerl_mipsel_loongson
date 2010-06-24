Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jun 2010 21:15:07 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16166 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492303Ab0FXTPC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jun 2010 21:15:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c23aeca0002>; Thu, 24 Jun 2010 12:15:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Jun 2010 12:14:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Jun 2010 12:14:59 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5OJEsRH026353;
        Thu, 24 Jun 2010 12:14:54 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5OJEs3m026352;
        Thu, 24 Jun 2010 12:14:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] netdev: mdio-octeon: Fix section mismatch errors.
Date:   Thu, 24 Jun 2010 12:14:48 -0700
Message-Id: <1277406888-26309-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1277406888-26309-1-git-send-email-ddaney@caviumnetworks.com>
References: <1277406888-26309-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jun 2010 19:14:59.0533 (UTC) FILETIME=[8A0C0FD0:01CB13D1]
X-archive-position: 27248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16955

We started getting:

WARNING: vmlinux.o(.data+0x20bd0): Section mismatch in reference from
the variable octeon_mdiobus_driver to the function
.init.text:octeon_mdiobus_probe()

This fixes it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/net/phy/mdio-octeon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio-octeon.c b/drivers/net/phy/mdio-octeon.c
index f443d43..bd12ba9 100644
--- a/drivers/net/phy/mdio-octeon.c
+++ b/drivers/net/phy/mdio-octeon.c
@@ -85,7 +85,7 @@ static int octeon_mdiobus_write(struct mii_bus *bus, int phy_id,
 	return 0;
 }
 
-static int __init octeon_mdiobus_probe(struct platform_device *pdev)
+static int __devinit octeon_mdiobus_probe(struct platform_device *pdev)
 {
 	struct octeon_mdiobus *bus;
 	union cvmx_smix_en smi_en;
@@ -143,7 +143,7 @@ err:
 	return err;
 }
 
-static int __exit octeon_mdiobus_remove(struct platform_device *pdev)
+static int __devexit octeon_mdiobus_remove(struct platform_device *pdev)
 {
 	struct octeon_mdiobus *bus;
 	union cvmx_smix_en smi_en;
@@ -163,7 +163,7 @@ static struct platform_driver octeon_mdiobus_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= octeon_mdiobus_probe,
-	.remove		= __exit_p(octeon_mdiobus_remove),
+	.remove		= __devexit_p(octeon_mdiobus_remove),
 };
 
 void octeon_mdiobus_force_mod_depencency(void)
-- 
1.6.6.1
