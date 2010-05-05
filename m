Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 17:20:38 +0200 (CEST)
Received: from mail.gmx.net ([213.165.64.20]:47422 "HELO mail.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491881Ab0EEPUe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 May 2010 17:20:34 +0200
Received: (qmail invoked by alias); 05 May 2010 15:20:25 -0000
Received: from dslb-084-056-016-121.pools.arcor-ip.net (EHLO lamer.localnet) [84.56.16.121]
  by mail.gmx.net (mp051) with SMTP; 05 May 2010 17:20:25 +0200
X-Authenticated: #12255092
X-Provags-ID: V01U2FsdGVkX18pY/R/rIIpJ9uiu2JJcJX/dK/00VibGwhRrrD3Pf
        UT28aMR26MyiFu
From:   Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linuxppc-dev@ozlabs.org
Subject: [PATCH] media/IR: Add missing include file to rc-map.c
Date:   Wed, 5 May 2010 17:20:21 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.33.2; KDE/4.3.5; x86_64; ; )
Cc:     "David =?iso-8859-1?q?H=E4rdeman?=" <david@hardeman.nu>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mips@linux-mips.org,
        linux-m68k@lists.linux-m68k.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201005051720.22617.PeterHuewe@gmx.de>
X-Y-GMX-Trusted: 0
Return-Path: <PeterHuewe@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: PeterHuewe@gmx.de
Precedence: bulk
X-list: linux-mips

From: Peter Huewe <peterhuewe@gmx.de>

This patch adds a missing include linux/delay.h to prevent
build failures[1-5]

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next-20100505

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2571452/
[2] http://kisskb.ellerman.id.au/kisskb/buildresult/2571188/
[3] http://kisskb.ellerman.id.au/kisskb/buildresult/2571479/
[4] http://kisskb.ellerman.id.au/kisskb/buildresult/2571429/
[5] http://kisskb.ellerman.id.au/kisskb/buildresult/2571432/

drivers/media/IR/rc-map.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/IR/rc-map.c b/drivers/media/IR/rc-map.c
index caf6a27..46a8f15 100644
--- a/drivers/media/IR/rc-map.c
+++ b/drivers/media/IR/rc-map.c
@@ -14,6 +14,7 @@
 
 #include <media/ir-core.h>
 #include <linux/spinlock.h>
+#include <linux/delay.h>
 
 /* Used to handle IR raw handler extensions */
 static LIST_HEAD(rc_map_list);
-- 
1.6.4.4
