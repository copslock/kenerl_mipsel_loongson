Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 11:46:50 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:15260 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20021779AbXIKKqK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 11:46:10 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IV3Fy-0005TV-00; Tue, 11 Sep 2007 12:46:10 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 1DD52C3318; Tue, 11 Sep 2007 12:43:55 +0200 (CEST)
Date:	Tue, 11 Sep 2007 12:43:55 +0200
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] IP22: fix wrong argument order
Message-ID: <20070911104354.GA7624@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

fix wrong argument order; this is just a minimal fix for the half baked
reda7b/writeb() conversation

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sgi-ip22/ip22-time.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-time.c b/arch/mips/sgi-ip22/ip22-time.c
index 8e88a44..de3d018 100644
--- a/arch/mips/sgi-ip22/ip22-time.c
+++ b/arch/mips/sgi-ip22/ip22-time.c
@@ -114,8 +114,8 @@ static unsigned long dosample(void)
 	} while (msb);
 
 	/* Stop the counter. */
-	writeb(sgint->tcword, (SGINT_TCWORD_CNT2 | SGINT_TCWORD_CALL |
-			       SGINT_TCWORD_MSWST));
+	writeb(SGINT_TCWORD_CNT2 | SGINT_TCWORD_CALL | SGINT_TCWORD_MSWST,
+	       &sgint->tcword);
 	/*
 	 * Return the difference, this is how far the r4k counter increments
 	 * for every 1/HZ seconds. We round off the nearest 1 MHz of master
-- 
1.4.4.4

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
