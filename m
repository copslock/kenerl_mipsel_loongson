Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2008 16:20:31 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:47340 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28577907AbYHHPUW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2008 16:20:22 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 6B8455BC048;
	Fri,  8 Aug 2008 18:20:19 +0300 (EEST)
Date:	Fri, 8 Aug 2008 18:18:46 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Alan Cox <alan@redhat.com>, Wim Van Sebroeck <wim@iguana.be>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [2.6 patch] fix watchdog/txx9wdt.c compilation
Message-ID: <20080808151846.GA14495@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

This patch fixes the following compile error caused by
commit 8dc244f7deac4c0e95ce0ffd26f494bb6e1534c0
([WATCHDOG 48/57] txx9: Fix locking, switch to unlocked_ioctl):

<--  snip  -->

...
  CC      drivers/watchdog/txx9wdt.o
txx9wdt.c:48: warning: type defaults to 'int' in declaration of 
txx9wdt.c:48: warning: parameter names (without types) in function 
txx9wdt.c: In function 'txx9wdt_ping':
txx9wdt.c:52: error: 'txx9_lock' undeclared (first use in this function)
txx9wdt.c:52: error: (Each undeclared identifier is reported only once
txx9wdt.c:52: error: for each function it appears in.)
txx9wdt.c: In function 'txx9wdt_start':
txx9wdt.c:59: error: 'txx9_lock' undeclared (first use in this function)
txx9wdt.c: In function 'txx9wdt_stop':
txx9wdt.c:71: error: 'txx9_lock' undeclared (first use in this function)
make[3]: *** [drivers/watchdog/txx9wdt.o] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
b29c2476cf814321b4ece7e359248b9a3046fc38 
diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index dbbc018..6adab77 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -45,7 +45,7 @@ static unsigned long txx9wdt_alive;
 static int expect_close;
 static struct txx9_tmr_reg __iomem *txx9wdt_reg;
 static struct clk *txx9_imclk;
-static DECLARE_LOCK(txx9_lock);
+static DEFINE_SPINLOCK(txx9_lock);
 
 static void txx9wdt_ping(void)
 {
