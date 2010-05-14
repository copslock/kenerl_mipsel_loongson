Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:22:55 +0200 (CEST)
Received: from mail.gmx.net ([213.165.64.20]:52260 "HELO mail.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491825Ab0ENLWw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 May 2010 13:22:52 +0200
Received: (qmail invoked by alias); 14 May 2010 11:22:45 -0000
Received: from dslb-084-056-063-164.pools.arcor-ip.net (EHLO lamer.localnet) [84.56.63.164]
  by mail.gmx.net (mp072) with SMTP; 14 May 2010 13:22:45 +0200
X-Authenticated: #12255092
X-Provags-ID: V01U2FsdGVkX1/DzRoU6IvDsVW8Tx8zfZyChf7gGzJvDCYLOsCoyr
        Z5GwU/sbdBheI5
From:   Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
To:     linux-next@vger.kernel.org.
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
Date:   Fri, 14 May 2010 13:22:41 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.33.2; KDE/4.3.5; x86_64; ; )
Cc:     Paul Mundt <lethal@linux-sh.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linuxppc-dev@ozlabs.org, "David H?rdeman" <david@hardeman.nu>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mips@linux-mips.org,
        linux-m68k@lists.linux-m68k.org
References: <201005051720.22617.PeterHuewe@gmx.de> <201005112042.14889.PeterHuewe@gmx.de> <20100514060240.GD12002@linux-sh.org>
In-Reply-To: <20100514060240.GD12002@linux-sh.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005141322.41370.PeterHuewe@gmx.de>
X-Y-GMX-Trusted: 0
Return-Path: <PeterHuewe@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26719
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
Forwarded to linux-next mailing list - 
breakage still exists in linux-next of 20100514 - please apply

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
