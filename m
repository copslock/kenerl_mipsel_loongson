Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2011 18:54:19 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47818 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491114Ab1FYQyO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Jun 2011 18:54:14 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5PGsARf002435;
        Sat, 25 Jun 2011 17:54:10 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5PGs9BV002429;
        Sat, 25 Jun 2011 17:54:09 +0100
Date:   Sat, 25 Jun 2011 17:54:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] NET: TC35815: Only build driver on Toshiba eval boards.
Message-ID: <20110625165409.GA1760@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21034

That's the only place where the TC35815 is known to be used.

  Ralf

 drivers/net/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index be25e92..2b4ebfb 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1516,7 +1516,8 @@ config CS89x0_NONISA_IRQ
 
 config TC35815
 	tristate "TOSHIBA TC35815 Ethernet support"
-	depends on NET_PCI && PCI && MIPS
+	depends on NET_PCI && PCI && MACH_TXX9
+	default y
 	select PHYLIB
 
 config E100
