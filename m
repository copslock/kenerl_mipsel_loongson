Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2009 10:50:00 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:46359 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491975AbZHBIty (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 2 Aug 2009 10:49:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 9B07419BB41;
	Sun,  2 Aug 2009 10:49:51 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15265-11; Sun,  2 Aug 2009 10:49:49 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 0CA8719BB7E;
	Sun,  2 Aug 2009 10:48:09 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A10896DFCFD; Sun,  2 Aug 2009 10:47:17 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
	id ED51B154E13; Sun,  2 Aug 2009 10:48:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ask.diku.dk (Postfix) with ESMTP id EBCE01549A9;
	Sun,  2 Aug 2009 10:48:08 +0200 (CEST)
Date:	Sun, 2 Aug 2009 10:48:08 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 10/15] arch/mips: Use DIV_ROUND_CLOSEST
Message-ID: <Pine.LNX.4.64.0908021047480.15557@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: amavisd-new at diku.dk
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

The kernel.h macro DIV_ROUND_CLOSEST performs the computation (x + d/2)/d
but is perhaps more readable.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@haskernel@
@@

#include <linux/kernel.h>

@depends on haskernel@
expression x,__divisor;
@@

- (((x) + ((__divisor) / 2)) / (__divisor))
+ DIV_ROUND_CLOSEST(x,__divisor)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/mips/nxp/pnx8550/common/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/nxp/pnx8550/common/time.c b/arch/mips/nxp/pnx8550/common/time.c
index 8df43e9..18b1927 100644
--- a/arch/mips/nxp/pnx8550/common/time.c
+++ b/arch/mips/nxp/pnx8550/common/time.c
@@ -138,7 +138,7 @@ __init void plat_time_init(void)
 	 * HZ timer interrupts per second.
 	 */
 	mips_hpt_frequency = 27UL * ((1000000UL * n)/(m * pow2p));
-	cpj = (mips_hpt_frequency + HZ / 2) / HZ;
+	cpj = DIV_ROUND_CLOSEST(mips_hpt_frequency, HZ);
 	write_c0_count(0);
 	timer_ack();
 
