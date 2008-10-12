Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Oct 2008 13:50:34 +0100 (BST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:22989 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S21283536AbYJLMuc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Oct 2008 13:50:32 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id C8D2F5BC02C;
	Sun, 12 Oct 2008 15:50:29 +0300 (EEST)
Date:	Sun, 12 Oct 2008 15:49:34 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Lennert Buytenhek <buytenh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [2.6 patch] net/tc35815.c: fix compilation
Message-ID: <20081012124934.GH31153@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Fix an obvious typo introduced by
commit 298cf9beb9679522de995e249eccbd82f7c51999
(phylib: move to dynamic allocation of struct mii_bus).

<--  snip  -->

...
  CC      drivers/net/tc35815.o
drivers/net/tc35815.c: In function 'tc_mii_init':
drivers/net/tc35815.c:799: error: 'err_out_free_mii_bus' undeclared (first use in this function)
drivers/net/tc35815.c:799: error: (Each undeclared identifier is reported only once
drivers/net/tc35815.c:799: error: for each function it appears in.)
drivers/net/tc35815.c:781: error: label 'err_out_free_mii_bus' used but not defined
make[3]: *** [drivers/net/tc35815.o] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index 4980b12..df20caf 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -796,7 +796,7 @@ err_out_unregister_bus:
 	mdiobus_unregister(lp->mii_bus);
 err_out_free_mdio_irq:
 	kfree(lp->mii_bus->irq);
-err_out_free_mii_bus;
+err_out_free_mii_bus:
 	mdiobus_free(lp->mii_bus);
 err_out:
 	return err;
