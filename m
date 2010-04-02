Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2010 03:19:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10744 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492107Ab0DBBS6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Apr 2010 03:18:58 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bb5460c0002>; Thu, 01 Apr 2010 18:19:08 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 1 Apr 2010 18:18:07 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 1 Apr 2010 18:18:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o321I3tg012790;
        Thu, 1 Apr 2010 18:18:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o321I3rT012789;
        Thu, 1 Apr 2010 18:18:03 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Cc:     davem@davemloft.net, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] netdev: phy/mdio-octeon: Enable the hardware before using it.
Date:   Thu,  1 Apr 2010 18:17:54 -0700
Message-Id: <1270171075-12741-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1270171075-12741-1-git-send-email-ddaney@caviumnetworks.com>
References: <1270171075-12741-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 02 Apr 2010 01:18:07.0584 (UTC) FILETIME=[5A09CE00:01CAD202]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In some cases the mdio bus is not enabled at the time of probing.
This prevents anything from working, so we will enable it before
trying to use it, and disable it when the driver is removed.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/net/phy/mdio-octeon.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/mdio-octeon.c b/drivers/net/phy/mdio-octeon.c
index 61a4461..dfaaf30 100644
--- a/drivers/net/phy/mdio-octeon.c
+++ b/drivers/net/phy/mdio-octeon.c
@@ -87,6 +87,7 @@ static int octeon_mdiobus_write(struct mii_bus *bus, int phy_id,
 static int __init octeon_mdiobus_probe(struct platform_device *pdev)
 {
 	struct octeon_mdiobus *bus;
+	union cvmx_smix_en smi_en;
 	int i;
 	int err = -ENOENT;
 
@@ -102,6 +103,10 @@ static int __init octeon_mdiobus_probe(struct platform_device *pdev)
 	if (!bus->mii_bus)
 		goto err;
 
+	smi_en.u64 = 0;
+	smi_en.s.en = 1;
+	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
+
 	/*
 	 * Standard Octeon evaluation boards don't support phy
 	 * interrupts, we need to poll.
@@ -132,17 +137,22 @@ err_register:
 
 err:
 	devm_kfree(&pdev->dev, bus);
+	smi_en.u64 = 0;
+	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
 	return err;
 }
 
 static int __exit octeon_mdiobus_remove(struct platform_device *pdev)
 {
 	struct octeon_mdiobus *bus;
+	union cvmx_smix_en smi_en;
 
 	bus = dev_get_drvdata(&pdev->dev);
 
 	mdiobus_unregister(bus->mii_bus);
 	mdiobus_free(bus->mii_bus);
+	smi_en.u64 = 0;
+	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
 	return 0;
 }
 
-- 
1.6.6.1
