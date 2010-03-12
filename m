Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 20:40:25 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:52572 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492294Ab0CLTkV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Mar 2010 20:40:21 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1NqAiX-0000lw-Ef
        for linux-mips@linux-mips.org; Fri, 12 Mar 2010 20:40:17 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Fri, 12 Mar 2010 20:40:17 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Fri, 12 Mar 2010 20:40:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH] MIPS: AR7: fix phat finger of reset bit in vlynq_high_data
Date:   Fri, 12 Mar 2010 19:39:48 +0000
Message-ID: <4thq67-rjo.ln1@chipmunk.wormnet.eu>
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Seems in my whitespace cleanup 7084338eb8eb0cc021ba86c340157bad397f3f0b
caused AR7 to no longer get as far as init.  Fixed my phat fingering.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/ar7/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 246df7a..0bd5f67 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -168,7 +168,7 @@ static struct plat_vlynq_data vlynq_high_data = {
 		.on	= vlynq_on,
 		.off	= vlynq_off,
 	},
-	.reset_bit	= 26,
+	.reset_bit	= 16,
 	.gpio_bit	= 19,
 };
 
-- 
1.7.0
