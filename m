Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2008 01:29:16 +0000 (GMT)
Received: from chilli.pcug.org.au ([203.10.76.44]:15562 "EHLO smtps.tip.net.au")
	by ftp.linux-mips.org with ESMTP id S20031848AbYBCB3G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2008 01:29:06 +0000
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 9EE15368003;
	Sun,  3 Feb 2008 12:29:02 +1100 (EST)
Date:	Sun, 3 Feb 2008 12:29:06 +1100
From:	Stephen Rothwell <sfr@canb.auug.org.au>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] [TRIVIAL] sm1250: constify three stings.
Message-Id: <20080203122906.eefb3ac4.sfr@canb.auug.org.au>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

This was noticed because sbmac_string is passed to
platform_device_register_simple() which now takes a "const char *"
as it first argument.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/sb1250-mac.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

This has not even been compiled, but is fairly trivial.

diff --git a/drivers/net/sb1250-mac.c b/drivers/net/sb1250-mac.c
index 7b53d65..d83471a 100644
--- a/drivers/net/sb1250-mac.c
+++ b/drivers/net/sb1250-mac.c
@@ -350,10 +350,10 @@ static int sbmac_mii_write(struct mii_bus *bus, int phyaddr, int regidx,
  *  Globals
  ********************************************************************* */
 
-static char sbmac_string[] = "sb1250-mac";
-static char sbmac_pretty[] = "SB1250 MAC";
+static const char sbmac_string[] = "sb1250-mac";
+static const char sbmac_pretty[] = "SB1250 MAC";
 
-static char sbmac_mdio_string[] = "sb1250-mac-mdio";
+static const char sbmac_mdio_string[] = "sb1250-mac-mdio";
 
 
 /**********************************************************************
-- 
1.5.3.8

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
