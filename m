Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 23:05:59 +0100 (BST)
Received: from symlink.to.noone.org ([85.10.207.172]:4563 "EHLO sym.noone.org")
	by ftp.linux-mips.org with ESMTP id S20037871AbWHLWF5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2006 23:05:57 +0100
Received: by sym.noone.org (Postfix, from userid 1002)
	id CE7758942C9; Sun, 13 Aug 2006 00:07:50 +0200 (CEST)
Date:	Sun, 13 Aug 2006 00:07:50 +0200
From:	Tobias Klauser <tklauser@xenon.tklauser.home>
To:	kernel-janitors@lists.osdl.org
Cc:	linux-mips@linux-mips.org, akpm@osdl.org
Subject: [PATCH] sound/mips/au1x00: Use ARRAY_SIZE macro
Message-ID: <20060812220750.GA4718@neon.tklauser.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-OS:	Linux sym 2.6.8-11-amd64-k8 x86_64
X-Editor: Vi IMproved 6.3
User-Agent: Mutt/1.5.9i
Return-Path: <tklauser@sym.noone.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tklauser@xenon.tklauser.home
Precedence: bulk
X-list: linux-mips

Use ARRAY_SIZE macro instead of sizeof(x)/sizeof(x[0])

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 sound/mips/au1x00.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index c31b386..ff6e6fc 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -258,7 +258,7 @@ au1000_dma_interrupt(int irq, void *dev_
 
 static unsigned int rates[] = {8000, 11025, 16000, 22050};
 static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
-	.count	=  sizeof(rates) / sizeof(rates[0]),
+	.count	= ARRAY_SIZE(rates),
 	.list	= rates,
 	.mask	= 0,
 };
-- 
1.4.1
