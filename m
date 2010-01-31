Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 21:08:37 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:52947 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493120Ab0AaUId (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2010 21:08:33 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1Nbg5t-0006Ix-Pj
        for linux-mips@linux-mips.org; Sun, 31 Jan 2010 21:08:29 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 21:08:29 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 21:08:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH 2/3] MIPS: AR7 fix usb slave mem range mistype
Date:   Sun, 31 Jan 2010 19:38:52 +0000
Message-ID: <cr2h37-ch6.ln1@chipmunk.wormnet.eu>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
X-archive-position: 25792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 185

MIPS: AR7 fix usb slave mem range mistype

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/ar7/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 76a358e..65facec 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -348,7 +348,7 @@ static struct resource usb_res[] = {
 		.name	= "mem",
 		.flags	= IORESOURCE_MEM,
 		.start	= 0x03400000,
-		.end	= 0x034001fff,
+		.end	= 0x03401fff,
 	},
 };
 
-- 
1.6.6
