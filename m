Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 01:12:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16111 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097323AbZJGXK0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 01:10:26 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4acd1fd90003>; Wed, 07 Oct 2009 16:10:17 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Oct 2009 16:10:20 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Oct 2009 16:10:20 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n97NAGtr007658;
	Wed, 7 Oct 2009 16:10:17 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n97NAFxt007657;
	Wed, 7 Oct 2009 16:10:15 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/6] MIPS: Octeon: Add platform device for MDIO buses.
Date:	Wed,  7 Oct 2009 16:10:10 -0700
Message-Id: <1254957015-7633-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4ACD1F4E.8090603@caviumnetworks.com>
References: <4ACD1F4E.8090603@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2009 23:10:20.0137 (UTC) FILETIME=[572E3D90:01CA47A3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |   30 +++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index be711dd..febfdd7 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -159,6 +159,36 @@ out:
 }
 device_initcall(octeon_rng_device_init);
 
+/* Octeon SMI/MDIO interface.  */
+static int __init octeon_mdiobus_device_init(void)
+{
+	struct platform_device *pd;
+	int ret = 0;
+
+	if (octeon_is_simulation())
+		return 0; /* No mdio in the simulator. */
+
+	/* The bus number is the platform_device id.  */
+	pd = platform_device_alloc("mdio-octeon", 0);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto fail;
+
+	return ret;
+fail:
+	platform_device_put(pd);
+
+out:
+	return ret;
+
+}
+device_initcall(octeon_mdiobus_device_init);
+
 MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Platform driver for Octeon SOC");
-- 
1.6.0.6
