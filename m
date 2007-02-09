Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 20:32:53 +0000 (GMT)
Received: from xyzzy.farnsworth.org ([65.39.95.219]:52743 "HELO farnsworth.org")
	by ftp.linux-mips.org with SMTP id S20039615AbXBIUct (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Feb 2007 20:32:49 +0000
Received: (qmail 18094 invoked by uid 1000); 9 Feb 2007 13:31:43 -0700
From:	"Dale Farnsworth" <dale@farnsworth.org>
Date:	Fri, 9 Feb 2007 13:31:43 -0700
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Fix eth2 platform device id for jaguar_atx and ocelot_3 platforms
Message-ID: <20070209203142.GA17729@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <dale@farnsworth.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dale@farnsworth.org
Precedence: bulk
X-list: linux-mips


From: Dale Farnsworth <dale@farnsworth.org>

Signed-off-by: Dale Farnsowrth <dale@farnsworth.org>

diff --git a/arch/mips/momentum/jaguar_atx/platform.c b/arch/mips/momentum/jaguar_atx/platform.c
index 035ea51..8103770 100644
--- a/arch/mips/momentum/jaguar_atx/platform.c
+++ b/arch/mips/momentum/jaguar_atx/platform.c
@@ -129,7 +129,7 @@ static struct mv643xx_eth_platform_data
 
 static struct platform_device eth2_device = {
 	.name		= MV643XX_ETH_NAME,
-	.id		= 1,
+	.id		= 2,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth2_resources),
 	.resource	= mv64x60_eth2_resources,
 	.dev = {
diff --git a/arch/mips/momentum/ocelot_3/platform.c b/arch/mips/momentum/ocelot_3/platform.c
index eefe584..57cfe5c 100644
--- a/arch/mips/momentum/ocelot_3/platform.c
+++ b/arch/mips/momentum/ocelot_3/platform.c
@@ -129,7 +129,7 @@ static struct mv643xx_eth_platform_data
 
 static struct platform_device eth2_device = {
 	.name		= MV643XX_ETH_NAME,
-	.id		= 1,
+	.id		= 2,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth2_resources),
 	.resource	= mv64x60_eth2_resources,
 	.dev = {
