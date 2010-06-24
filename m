Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jun 2010 21:15:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16164 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492301Ab0FXTPC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jun 2010 21:15:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c23aeca0001>; Thu, 24 Jun 2010 12:15:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Jun 2010 12:14:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 24 Jun 2010 12:14:59 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5OJEskP026349;
        Thu, 24 Jun 2010 12:14:54 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5OJEses026348;
        Thu, 24 Jun 2010 12:14:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] netdev: octeon_mgmt: Fix section mismatch errors.
Date:   Thu, 24 Jun 2010 12:14:47 -0700
Message-Id: <1277406888-26309-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1277406888-26309-1-git-send-email-ddaney@caviumnetworks.com>
References: <1277406888-26309-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jun 2010 19:14:59.0190 (UTC) FILETIME=[89D7B960:01CB13D1]
X-archive-position: 27249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16957

We started getting:

WARNING: drivers/net/built-in.o(.data+0x10f0): Section mismatch in
reference from the variable octeon_mgmt_driver to the function
.init.text:octeon_mgmt_probe()

This fixes it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/net/octeon/octeon_mgmt.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/octeon/octeon_mgmt.c b/drivers/net/octeon/octeon_mgmt.c
index 000e792..f4a0f08 100644
--- a/drivers/net/octeon/octeon_mgmt.c
+++ b/drivers/net/octeon/octeon_mgmt.c
@@ -1067,7 +1067,7 @@ static const struct net_device_ops octeon_mgmt_ops = {
 #endif
 };
 
-static int __init octeon_mgmt_probe(struct platform_device *pdev)
+static int __devinit octeon_mgmt_probe(struct platform_device *pdev)
 {
 	struct resource *res_irq;
 	struct net_device *netdev;
@@ -1124,7 +1124,7 @@ err:
 	return -ENOENT;
 }
 
-static int __exit octeon_mgmt_remove(struct platform_device *pdev)
+static int __devexit octeon_mgmt_remove(struct platform_device *pdev)
 {
 	struct net_device *netdev = dev_get_drvdata(&pdev->dev);
 
@@ -1139,7 +1139,7 @@ static struct platform_driver octeon_mgmt_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= octeon_mgmt_probe,
-	.remove		= __exit_p(octeon_mgmt_remove),
+	.remove		= __devexit_p(octeon_mgmt_remove),
 };
 
 extern void octeon_mdiobus_force_mod_depencency(void);
-- 
1.6.6.1
