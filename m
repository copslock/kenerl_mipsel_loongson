Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2009 12:40:52 +0100 (CET)
Received: from mgw1.diku.dk ([130.225.96.91]:34639 "EHLO mgw1.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492646AbZLMLkp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2009 12:40:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by mgw1.diku.dk (Postfix) with ESMTP id 8DF0252C346;
        Sun, 13 Dec 2009 12:40:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
        by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zWsf1N6qHFyP; Sun, 13 Dec 2009 12:40:39 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
        by mgw1.diku.dk (Postfix) with ESMTP id 6D9ED52C338;
        Sun, 13 Dec 2009 12:40:39 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
        by nhugin.diku.dk (Postfix) with ESMTP
        id 1946B6DF894; Sun, 13 Dec 2009 12:36:48 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3767)
        id 52500480B; Sun, 13 Dec 2009 12:40:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by ask.diku.dk (Postfix) with ESMTP id 45DBA4225;
        Sun, 13 Dec 2009 12:40:39 +0100 (CET)
Date:   Sun, 13 Dec 2009 12:40:39 +0100 (CET)
From:   Julia Lawall <julia@diku.dk>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/9] arch/mips/alchemy: Correct code taking the size of a
 pointer
Message-ID: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

sizeof(dp) is just the size of the pointer.  Change it to the size of the
referenced structure.

A simplified version of the semantic patch that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression *x;
expression f;
type T;
@@

*f(...,(T)x,...)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/mips/alchemy/common/dbdma.c    |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 4851308..40071bd 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -612,7 +612,7 @@ u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 	dma_cache_wback_inv((unsigned long)buf, nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	au_sync();
-	dma_cache_wback_inv((unsigned long)dp, sizeof(dp));
+	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
 
 	/* Get next descriptor pointer.	*/
@@ -674,7 +674,7 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 	dma_cache_inv((unsigned long)buf, nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	au_sync();
-	dma_cache_wback_inv((unsigned long)dp, sizeof(dp));
+	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
 
 	/* Get next descriptor pointer.	*/
