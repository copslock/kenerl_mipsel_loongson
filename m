Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 May 2008 19:05:55 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:43725 "HELO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with SMTP id S20041062AbYEYSFx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 May 2008 19:05:53 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id D8AAA5BC03B;
	Sun, 25 May 2008 21:05:51 +0300 (EEST)
Date:	Sun, 25 May 2008 21:03:16 +0300
From:	Adrian Bunk <adrian.bunk@movial.fi>
To:	Chris Dearman <chris@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] MIPS SEAD compile fix
Message-ID: <20080525180316.GF1791@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <adrian.bunk@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adrian.bunk@movial.fi
Precedence: bulk
X-list: linux-mips

This patch fixes the following compile error caused by
commit 39b8d5254246ac56342b72f812255c8f7a74dca9
([MIPS] Add support for MIPS CMP platform.):

<--  snip  -->

...
  CC      arch/mips/mips-boards/generic/time.o
cc1: warnings being treated as errors
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/mips-boards/generic/time.c:63: error: 'ledbitmask' defined but not used
make[2]: *** [arch/mips/mips-boards/generic/time.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>

---
a6622e47dd128da338d6dbae457ec1b043604814 diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index 008fd82..df23558 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -58,10 +58,14 @@ static int mips_cpu_timer_irq;
 static int mips_cpu_perf_irq;
 extern int cp0_perfcount_irq;
 
+#if defined(CONFIG_MIPS_MALTA) || defined(CONFIG_MIPS_ATLAS)
+
 DEFINE_PER_CPU(unsigned int, tickcount);
 #define tickcount_this_cpu __get_cpu_var(tickcount)
 static unsigned long ledbitmask;
 
+#endif
+
 static void mips_timer_dispatch(void)
 {
 #if defined(CONFIG_MIPS_MALTA) || defined(CONFIG_MIPS_ATLAS)
