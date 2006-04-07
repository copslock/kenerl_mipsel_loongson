Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 17:21:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:5857 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133569AbWDGQVs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 17:21:48 +0100
Received: from localhost (p8176-ipad03funabasi.chiba.ocn.ne.jp [219.160.88.176])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5E1EEA96E; Sat,  8 Apr 2006 01:33:12 +0900 (JST)
Date:	Sat, 08 Apr 2006 01:33:31 +0900 (JST)
Message-Id: <20060408.013331.71086855.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use __ffs() instead of ffs() on waybit calculation
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index d88c668..4182e11 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -750,12 +750,12 @@ static void __init probe_pcache(void)
 		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
-		c->icache.waybit = ffs(icache_size/2) - 1;
+		c->icache.waybit = __ffs(icache_size/2);
 
 		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
 		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
-		c->dcache.waybit= ffs(dcache_size/2) - 1;
+		c->dcache.waybit= __ffs(dcache_size/2);
 
 		c->options |= MIPS_CPU_CACHE_CDEX_P;
 		break;
@@ -838,12 +838,12 @@ static void __init probe_pcache(void)
 		icache_size = 1 << (10 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 2;
-		c->icache.waybit = ffs(icache_size/2) - 1;
+		c->icache.waybit = __ffs(icache_size/2);
 
 		dcache_size = 1 << (10 + ((config & CONF_DC) >> 6));
 		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 2;
-		c->dcache.waybit = ffs(dcache_size/2) - 1;
+		c->dcache.waybit = __ffs(dcache_size/2);
 
 		c->options |= MIPS_CPU_CACHE_CDEX_P;
 		break;
@@ -874,12 +874,12 @@ static void __init probe_pcache(void)
 		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
 		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
 		c->icache.ways = 4;
-		c->icache.waybit = ffs(icache_size / c->icache.ways) - 1;
+		c->icache.waybit = __ffs(icache_size / c->icache.ways);
 
 		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
 		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
 		c->dcache.ways = 4;
-		c->dcache.waybit = ffs(dcache_size / c->dcache.ways) - 1;
+		c->dcache.waybit = __ffs(dcache_size / c->dcache.ways);
 
 #if !defined(CONFIG_SMP) || !defined(RM9000_CDEX_SMP_WAR)
 		c->options |= MIPS_CPU_CACHE_CDEX_P;
@@ -907,7 +907,7 @@ static void __init probe_pcache(void)
 		icache_size = c->icache.sets *
 		              c->icache.ways *
 		              c->icache.linesz;
-		c->icache.waybit = ffs(icache_size/c->icache.ways) - 1;
+		c->icache.waybit = __ffs(icache_size/c->icache.ways);
 
 		if (config & 0x8)		/* VI bit */
 			c->icache.flags |= MIPS_CACHE_VTAG;
@@ -927,7 +927,7 @@ static void __init probe_pcache(void)
 		dcache_size = c->dcache.sets *
 		              c->dcache.ways *
 		              c->dcache.linesz;
-		c->dcache.waybit = ffs(dcache_size/c->dcache.ways) - 1;
+		c->dcache.waybit = __ffs(dcache_size/c->dcache.ways);
 
 		c->options |= MIPS_CPU_PREFETCH;
 		break;
diff --git a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
index 3b6cc9b..31ec730 100644
--- a/arch/mips/mm/sc-rm7k.c
+++ b/arch/mips/mm/sc-rm7k.c
@@ -138,7 +138,7 @@ void __init rm7k_sc_init(void)
 
 	c->scache.linesz = sc_lsize;
 	c->scache.ways = 4;
-	c->scache.waybit= ffs(scache_size / c->scache.ways) - 1;
+	c->scache.waybit= __ffs(scache_size / c->scache.ways);
 	c->scache.waysize = scache_size / c->scache.ways;
 	c->scache.sets = scache_size / (c->scache.linesz * c->scache.ways);
 	printk(KERN_INFO "Secondary cache size %dK, linesize %d bytes.\n",
