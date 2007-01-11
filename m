Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 13:50:40 +0000 (GMT)
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3858 "HELO
	mailout.stusta.mhn.de") by ftp.linux-mips.org with SMTP
	id S20046649AbXAKNug (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jan 2007 13:50:36 +0000
Received: (qmail 14917 invoked from network); 11 Jan 2007 13:50:30 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailhub.stusta.mhn.de with SMTP; 11 Jan 2007 13:50:30 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 194DC3A9DBA; Thu, 11 Jan 2007 14:50:37 +0100 (CET)
Date:	Thu, 11 Jan 2007 14:50:37 +0100
From:	Adrian Bunk <bunk@stusta.de>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] MIPS: remove smp_tune_scheduling()
Message-ID: <20070111135037.GK20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

Since smp_tune_scheduling() didn't do anything we can simply remove it.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/mips/kernel/smp.c |   28 ----------------------------
 1 file changed, 28 deletions(-)

--- linux-2.6.20-rc3-mm1/arch/mips/kernel/smp.c.old	2007-01-11 14:19:43.000000000 +0100
+++ linux-2.6.20-rc3-mm1/arch/mips/kernel/smp.c	2007-01-11 14:20:01.000000000 +0100
@@ -51,33 +51,6 @@
 EXPORT_SYMBOL(phys_cpu_present_map);
 EXPORT_SYMBOL(cpu_online_map);
 
-static void smp_tune_scheduling (void)
-{
-	struct cache_desc *cd = &current_cpu_data.scache;
-	unsigned long cachesize;       /* kB   */
-	unsigned long cpu_khz;
-
-	/*
-	 * Crude estimate until we actually meassure ...
-	 */
-	cpu_khz = loops_per_jiffy * 2 * HZ / 1000;
-
-	/*
-	 * Rough estimation for SMP scheduling, this is the number of
-	 * cycles it takes for a fully memory-limited process to flush
-	 * the SMP-local cache.
-	 *
-	 * (For a P5 this pretty much means we will choose another idle
-	 *  CPU almost always at wakeup time (this is due to the small
-	 *  L1 cache), on PIIs it's around 50-100 usecs, depending on
-	 *  the cache size)
-	 */
-	if (!cpu_khz)
-		return;
-
-	cachesize = cd->linesz * cd->sets * cd->ways;
-}
-
 extern void __init calibrate_delay(void);
 extern ATTRIB_NORET void cpu_idle(void);
 
@@ -245,7 +218,6 @@
 {
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
-	smp_tune_scheduling();
 	plat_prepare_cpus(max_cpus);
 #ifndef CONFIG_HOTPLUG_CPU
 	cpu_present_map = cpu_possible_map;
