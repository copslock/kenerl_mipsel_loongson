Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2009 20:54:14 +0100 (BST)
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:38551 "EHLO
	gw02.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S20022018AbZC3Txp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Mar 2009 20:53:45 +0100
Received: from localhost.localdomain (a88-114-245-69.elisa-laajakaista.fi [88.114.245.69])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 76D6F1399EB;
	Mon, 30 Mar 2009 22:53:41 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 1/4] [MIPS] ip32: two symbols can become static
Date:	Mon, 30 Mar 2009 22:53:23 +0300
Message-Id: <1238442806-11013-2-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1238442806-11013-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1238442806-11013-1-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The file arch/mips/mm/sc-rm7k.c needlessly defines two global symbols:

rm7k_sc_ops
rm7k_tcache_enabled

This patch makes these symbols static.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/mm/sc-rm7k.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
index e3abfb2..de69bfb 100644
--- a/arch/mips/mm/sc-rm7k.c
+++ b/arch/mips/mm/sc-rm7k.c
@@ -29,7 +29,7 @@ extern unsigned long icache_way_size, dcache_way_size;
 
 #include <asm/r4kcache.h>
 
-int rm7k_tcache_enabled;
+static int rm7k_tcache_enabled;
 
 /*
  * Writeback and invalidate the primary cache dcache before DMA.
@@ -121,7 +121,7 @@ static void rm7k_sc_disable(void)
 	clear_c0_config(RM7K_CONF_SE);
 }
 
-struct bcache_ops rm7k_sc_ops = {
+static struct bcache_ops rm7k_sc_ops = {
 	.bc_enable = rm7k_sc_enable,
 	.bc_disable = rm7k_sc_disable,
 	.bc_wback_inv = rm7k_sc_wback_inv,
-- 
1.5.6.3
