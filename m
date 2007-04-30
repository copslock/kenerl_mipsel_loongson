Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2007 16:28:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:34263 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022528AbXD3P1t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2007 16:27:49 +0100
Received: from localhost (p4067-ipad203funabasi.chiba.ocn.ne.jp [222.146.83.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ECF09A012; Tue,  1 May 2007 00:27:45 +0900 (JST)
Date:	Tue, 01 May 2007 00:27:49 +0900 (JST)
Message-Id: <20070501.002749.21593079.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	netdev@vger.kernel.org, jeff@garzik.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: [PATCH 3/5] ne: Add NEEDS_PORTLIST to control ISA auto-probe
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add NEEDS_PORTLIST cpp macro to control ISA auto-probe.
(I'm not sure M32R needs auto-probe but it is current behavior)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/net/ne.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ne.c b/drivers/net/ne.c
index 32ae91b..22d6fe4 100644
--- a/drivers/net/ne.c
+++ b/drivers/net/ne.c
@@ -78,8 +78,13 @@ static const char version2[] =
 /* Do we have a non std. amount of memory? (in units of 256 byte pages) */
 /* #define PACKETBUF_MEMSIZE	0x40 */
 
+#if !defined(MODULE) && (defined(CONFIG_ISA) || defined(CONFIG_M32R))
+/* Do we need a portlist for the ISA auto-probe ? */
+#define NEEDS_PORTLIST
+#endif
+
 /* A zero-terminated list of I/O addresses to be probed at boot. */
-#ifndef MODULE
+#ifdef NEEDS_PORTLIST
 static unsigned int netcard_portlist[] __initdata = {
 	0x300, 0x280, 0x320, 0x340, 0x360, 0x380, 0
 };
@@ -186,7 +191,7 @@ static void ne_block_output(struct net_device *dev, const int count,
 static int __init do_ne_probe(struct net_device *dev)
 {
 	unsigned long base_addr = dev->base_addr;
-#ifndef MODULE
+#ifdef NEEDS_PORTLIST
 	int orig_irq = dev->irq;
 #endif
 
@@ -202,7 +207,7 @@ static int __init do_ne_probe(struct net_device *dev)
 	if (isapnp_present() && (ne_probe_isapnp(dev) == 0))
 		return 0;
 
-#ifndef MODULE
+#ifdef NEEDS_PORTLIST
 	/* Last resort. The semi-risky ISA auto-probe. */
 	for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++) {
 		int ioaddr = netcard_portlist[base_addr];
