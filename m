Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2009 05:09:39 +0100 (BST)
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:34793
	"EHLO QMTA14.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20023278AbZDSEJa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 19 Apr 2009 05:09:30 +0100
Received: from OMTA03.emeryville.ca.mail.comcast.net ([76.96.30.27])
	by QMTA14.emeryville.ca.mail.comcast.net with comcast
	id hG6E1b0030b6N64AEG9PQZ; Sun, 19 Apr 2009 04:09:23 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA03.emeryville.ca.mail.comcast.net with comcast
	id hG9M1b00258Be2l8PG9NCK; Sun, 19 Apr 2009 04:09:23 +0000
Message-ID: <49EAA3AF.3030409@gentoo.org>
Date:	Sun, 19 Apr 2009 00:08:15 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: IP32: Enable L3 Cache on RM7000 Processor
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

The attached patch enables the tertiary cache present on RM7K CPUs.

It does this by miming the behavior for the secondary cache setup.  Been using 
it for several kernel versions with no noticeable ill effects, though I haven't 
run any benchmarks to determine if it offers any noticeable improvement.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>

  sc-rm7k.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
  1 file changed, 49 insertions(+), 11 deletions(-)



diff -Naurp a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
--- a/arch/mips/mm/sc-rm7k.c	2009-04-18 23:23:49.000000000 -0400
+++ b/arch/mips/mm/sc-rm7k.c	2009-04-18 23:52:09.690656791 -0400
@@ -25,11 +25,23 @@
  /* Secondary cache parameters. */
  #define scache_size	(256*1024)	/* Fixed to 256KiB on RM7000 */

+/* Tertiary cache parameters */
+#define tc_lsize      32
+#ifdef CONFIG_SGI_IP32
+#define tcache_size   (1024*1024)	/* IP32's RM7000 has 1MB L3 */
+#else
+#define tcache_size   (8*1024*1024)	/* 8MB (max) for all others */
+#endif
+
  extern unsigned long icache_way_size, dcache_way_size;

  #include <asm/r4kcache.h>

-static int rm7k_tcache_enabled;
+static int rm7k_tcache_enabled = 0;
+
+static char *way_string[] __initdata = { NULL, "direct mapped", "2-way",
+	"3-way", "4-way", "5-way", "6-way", "7-way", "8-way"
+};

  /*
   * Writeback and invalidate the primary cache dcache before DMA.
@@ -105,6 +117,26 @@ static __cpuinit void __rm7k_sc_enable(v
  		      :
  		      : "r" (CKSEG0ADDR(i)), "i" (Index_Store_Tag_SD));
  	}
+
+
+	/* tertiary cache */
+	set_c0_config(RM7K_CONF_TE);
+
+	write_c0_taglo(0);
+	write_c0_taghi(0);
+
+	for (i = 0; i < tcache_size; i += tc_lsize) {
+		__asm__ __volatile__ (
+		      ".set noreorder\n\t"
+		      ".set mips3\n\t"
+		      "cache %1, (%0)\n\t"
+		      ".set mips0\n\t"
+		      ".set reorder"
+		      :
+		      : "r" (CKSEG0ADDR(i)), "i" (Page_Invalidate_T));
+	}
+
+	rm7k_tcache_enabled = 1;
  }

  static __cpuinit void rm7k_sc_enable(void)
@@ -119,6 +151,12 @@ static __cpuinit void rm7k_sc_enable(voi
  static void rm7k_sc_disable(void)
  {
  	clear_c0_config(RM7K_CONF_SE);
+
+	/* tertiary cache */
+	if (!rm7k_tcache_enabled)
+		return;
+
+	clear_c0_config(RM7K_CONF_TE);
  }

  static struct bcache_ops rm7k_sc_ops = {
@@ -153,20 +191,20 @@ void __cpuinit rm7k_sc_init(void)
  	if (!(config & RM7K_CONF_TC)) {

  		/*
-		 * We can't enable the L3 cache yet. There may be board-specific
-		 * magic necessary to turn it on, and blindly asking the CPU to
-		 * start using it would may give cache errors.
-		 *
-		 * Also, board-specific knowledge may allow us to use the
+		 * Board-specific knowledge may allow us to use the
  		 * CACHE Flash_Invalidate_T instruction if the tag RAM supports
  		 * it, and may specify the size of the L3 cache so we don't have
-		 * to probe it.
+		 * to probe it.  For now, we set the size to 8MB, except on IP32
+		 * where we know the size is fixed at 1MB.
  		 */
-		printk(KERN_INFO "Tertiary cache present, %s enabled\n",
-		       (config & RM7K_CONF_TE) ? "already" : "not (yet)");
+		c->tcache.linesz = tc_lsize;
+		c->tcache.ways = 1;
+		c->tcache.waybit= __ffs(tcache_size / c->tcache.ways);
+		c->tcache.waysize = tcache_size / c->tcache.ways;
+		c->tcache.sets = tcache_size / (c->tcache.linesz * c->tcache.ways);
+		printk(KERN_INFO "Tertiary cache size %dK, %s, linesize %d bytes.\n",
+		       (tcache_size >> 10), way_string[c->tcache.ways], tc_lsize);

-		if ((config & RM7K_CONF_TE))
-			rm7k_tcache_enabled = 1;
  	}

  	bcops = &rm7k_sc_ops;
