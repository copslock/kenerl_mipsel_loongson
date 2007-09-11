Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 11:46:20 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:15772 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20021784AbXIKKqK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 11:46:10 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IV3Fy-0005TV-02; Tue, 11 Sep 2007 12:46:10 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id A59F6C3319; Tue, 11 Sep 2007 12:46:03 +0200 (CEST)
Date:	Tue, 11 Sep 2007 12:46:03 +0200
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] IP22 wrong check for second HPC
Message-ID: <20070911104603.GC7624@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Wrong check for the second hpc on fullhouse machines, caused DBEs on
SGI Indys

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sgi-ip22/ip22-platform.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index 78b608d..28ffec8 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -150,8 +150,8 @@ static int __init sgiseeq_devinit(void)
 		return res;
 
 	/* Second HPC is missing? */
-	if (ip22_is_fullhouse() ||
-	    !get_dbe(tmp, (unsigned int *)&hpc3c1->pbdma[1]))
+	if (!ip22_is_fullhouse() ||
+	    get_dbe(tmp, (unsigned int *)&hpc3c1->pbdma[1]))
 		return 0;
 
 	sgimc->giopar |= SGIMC_GIOPAR_MASTEREXP1 | SGIMC_GIOPAR_EXP164 |
-- 
1.4.4.4

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
