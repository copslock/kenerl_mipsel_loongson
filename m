Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2011 17:24:05 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47525 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491156Ab1HJPYA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Aug 2011 17:24:00 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7AFNlxq008208;
        Wed, 10 Aug 2011 16:23:47 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7AFNkbD008205;
        Wed, 10 Aug 2011 16:23:46 +0100
Date:   Wed, 10 Aug 2011 16:23:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Don Fry <pcnet32@frontier.com>, netdev@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Subject: [PATCH] PCnet: Fix section mismatch
Message-ID: <20110810152346.GA6092@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7663

Building MIPS mtx1_defconfig results in:

  MODPOST 735 modules
WARNING: drivers/net/pcnet32.o(.devinit.text+0x11ec): Section mismatch in reference from the function pcnet32_probe_vlbus.constprop.22() to the variable .init.data:pcnet32_portlist
The function __devinit pcnet32_probe_vlbus.constprop.22() references
a variable __initdata pcnet32_portlist.
If pcnet32_portlist is only used by pcnet32_probe_vlbus.constprop.22 then
annotate pcnet32_portlist with a matching annotation.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
As recently discussed in the discussion of submission of a fix for a
similar bug in another driver remove __initdata rather than replace it
with __devinitdata.

 drivers/net/pcnet32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
index 8b3090d..80b6f36 100644
--- a/drivers/net/pcnet32.c
+++ b/drivers/net/pcnet32.c
@@ -82,7 +82,7 @@ static int cards_found;
 /*
  * VLB I/O addresses
  */
-static unsigned int pcnet32_portlist[] __initdata =
+static unsigned int pcnet32_portlist[] =
     { 0x300, 0x320, 0x340, 0x360, 0 };
 
 static int pcnet32_debug;
