Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2010 22:53:38 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:42979 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492537Ab0D0Uxe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Apr 2010 22:53:34 +0200
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1O6rmc-0000Mk-F1; Tue, 27 Apr 2010 22:53:30 +0200
Date:   Tue, 27 Apr 2010 22:53:30 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] mips/traps: use CKSEG1ADDR for uncache handler
Message-ID: <20100427205330.GA1390@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

since "MIPS: Calculate proper ebase value for 64-bit kernels" my mips
toy did not boot anymore.
Before that commit we always touched xkphys/shared as ebase and computed
xphsys/unchached for that area. After that commit ebase become 32bit
compat address and convert does not work anymore. So I guess now want to
touch the 32bit compat unmapped & uncached area for this. CKSEG1ADDR
does just in 32bit and 64bit.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/kernel/traps.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4e00f9b..1b57f18 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1557,12 +1557,7 @@ static char panic_null_cerr[] __cpuinitdata =
 void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
 	unsigned long size)
 {
-#ifdef CONFIG_32BIT
-	unsigned long uncached_ebase = KSEG1ADDR(ebase);
-#endif
-#ifdef CONFIG_64BIT
-	unsigned long uncached_ebase = TO_UNCAC(ebase);
-#endif
+	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
 
 	if (!addr)
 		panic(panic_null_cerr);
-- 
1.6.6.1
