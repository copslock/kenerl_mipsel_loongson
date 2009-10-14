Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:05:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1230 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493617AbZJNTE4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:04:56 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad620d30002>; Wed, 14 Oct 2009 12:04:51 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:04:48 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:04:48 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n9EJ4i64007422;
	Wed, 14 Oct 2009 12:04:44 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n9EJ4iw8007421;
	Wed, 14 Oct 2009 12:04:44 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/6] MIPS: Octeon: Add platform devices MGMT Ethernet ports.
Date:	Wed, 14 Oct 2009 12:04:39 -0700
Message-Id: <1255547082-7388-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4AD6205A.8070200@caviumnetworks.com>
References: <4AD6205A.8070200@caviumnetworks.com>
X-OriginalArrivalTime: 14 Oct 2009 19:04:48.0456 (UTC) FILETIME=[334E5C80:01CA4D01]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |   58 +++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index febfdd7..cfdb4c2 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -189,6 +189,64 @@ out:
 }
 device_initcall(octeon_mdiobus_device_init);
 
+/* Octeon mgmt port Ethernet interface.  */
+static int __init octeon_mgmt_device_init(void)
+{
+	struct platform_device *pd;
+	int ret = 0;
+	int port, num_ports;
+
+	struct resource mgmt_port_resource = {
+		.flags	= IORESOURCE_IRQ,
+		.start	= -1,
+		.end	= -1
+	};
+
+	if (!OCTEON_IS_MODEL(OCTEON_CN56XX) && !OCTEON_IS_MODEL(OCTEON_CN52XX))
+		return 0;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX))
+		num_ports = 1;
+	else
+		num_ports = 2;
+
+	for (port = 0; port < num_ports; port++) {
+		pd = platform_device_alloc("octeon_mgmt", port);
+		if (!pd) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		switch (port) {
+		case 0:
+			mgmt_port_resource.start = OCTEON_IRQ_MII0;
+			break;
+		case 1:
+			mgmt_port_resource.start = OCTEON_IRQ_MII1;
+			break;
+		default:
+			BUG();
+		}
+		mgmt_port_resource.end = mgmt_port_resource.start;
+
+		ret = platform_device_add_resources(pd, &mgmt_port_resource, 1);
+
+		if (ret)
+			goto fail;
+
+		ret = platform_device_add(pd);
+		if (ret)
+			goto fail;
+	}
+	return ret;
+fail:
+	platform_device_put(pd);
+
+out:
+	return ret;
+
+}
+device_initcall(octeon_mgmt_device_init);
+
 MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Platform driver for Octeon SOC");
-- 
1.6.0.6
