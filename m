Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:06:58 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:47589 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992769AbeENUFdAB-0- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 22:05:33 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 42E0D208BF; Mon, 14 May 2018 22:05:23 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 171C020794;
        Mon, 14 May 2018 22:05:23 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next v3 7/7] MAINTAINERS: Add entry for Microsemi Ethernet switches
Date:   Mon, 14 May 2018 22:05:00 +0200
Message-Id: <20180514200500.2953-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Add myself as a maintainer for the Microsemi Ethernet switches.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..b632deb3f503 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9280,6 +9280,12 @@ F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 F:	Documentation/scsi/smartpqi.txt
 
+MICROSEMI ETHERNET SWITCH DRIVER
+M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/mscc/
+
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.17.0
