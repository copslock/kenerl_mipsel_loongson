Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 22:47:59 +0000 (GMT)
Received: from xyzzy.farnsworth.org ([65.39.95.219]:12296 "HELO farnsworth.org")
	by ftp.linux-mips.org with SMTP id S20037614AbXBTWrz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2007 22:47:55 +0000
Received: (qmail 4831 invoked by uid 1000); 20 Feb 2007 15:46:49 -0700
From:	"Dale Farnsworth" <dale@farnsworth.org>
Date:	Tue, 20 Feb 2007 15:46:49 -0700
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Fix port 0 mac address for mips mv643xx platforms
Message-ID: <20070220224649.GA4485@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <dale@farnsworth.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dale@farnsworth.org
Precedence: bulk
X-list: linux-mips

From: Dale Farnsworth <dale@farnsworth.org>

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---

Untested, but seems obvious enough.

 arch/mips/momentum/jaguar_atx/platform.c |    2 +-
 arch/mips/momentum/ocelot_3/platform.c   |    2 +-
 arch/mips/momentum/ocelot_c/platform.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: b/arch/mips/momentum/jaguar_atx/platform.c
===================================================================
--- a/arch/mips/momentum/jaguar_atx/platform.c
+++ b/arch/mips/momentum/jaguar_atx/platform.c
@@ -200,7 +200,7 @@ static int __init mv643xx_eth_add_pds(vo
 	int ret;
 
 	get_mac(mac);
-	eth_mac_add(eth1_mac_addr, mac, 0);
+	eth_mac_add(eth0_mac_addr, mac, 0);
 	eth_mac_add(eth1_mac_addr, mac, 1);
 	eth_mac_add(eth2_mac_addr, mac, 2);
 	ret = platform_add_devices(mv643xx_eth_pd_devs,
Index: b/arch/mips/momentum/ocelot_3/platform.c
===================================================================
--- a/arch/mips/momentum/ocelot_3/platform.c
+++ b/arch/mips/momentum/ocelot_3/platform.c
@@ -200,7 +200,7 @@ static int __init mv643xx_eth_add_pds(vo
 	int ret;
 
 	get_mac(mac);
-	eth_mac_add(eth1_mac_addr, mac, 0);
+	eth_mac_add(eth0_mac_addr, mac, 0);
 	eth_mac_add(eth1_mac_addr, mac, 1);
 	eth_mac_add(eth2_mac_addr, mac, 2);
 	ret = platform_add_devices(mv643xx_eth_pd_devs,
Index: b/arch/mips/momentum/ocelot_c/platform.c
===================================================================
--- a/arch/mips/momentum/ocelot_c/platform.c
+++ b/arch/mips/momentum/ocelot_c/platform.c
@@ -174,7 +174,7 @@ static int __init mv643xx_eth_add_pds(vo
 	int ret;
 
 	get_mac(mac);
-	eth_mac_add(eth1_mac_addr, mac, 0);
+	eth_mac_add(eth0_mac_addr, mac, 0);
 	eth_mac_add(eth1_mac_addr, mac, 1);
 	ret = platform_add_devices(mv643xx_eth_pd_devs,
 			ARRAY_SIZE(mv643xx_eth_pd_devs));
