Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 02:56:35 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:26560
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225202AbTGaB4c>; Thu, 31 Jul 2003 02:56:32 +0100
Received: (qmail 22153 invoked from network); 31 Jul 2003 01:52:42 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 31 Jul 2003 01:52:42 -0000
Message-ID: <3F287738.1040203@ict.ac.cn>
Date: Thu, 31 Jul 2003 09:56:08 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: RM7k cache_flush_sigtramp
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

hi,

r4k_cache_flush_sigtrap seems not enough for RM7000 cpus because
there is a writebuffer between L1 dcache & L2 cache,so the written back
block may not be seen by icache. This small patch fixes crashes of my
Xserver
on ev64240.


--- r4kcache.h.ori 2003-07-31 09:51:01.000000000 +0800
+++ r4kcache.h 2003-07-31 09:51:57.000000000 +0800
@@ -94,6 +94,9 @@
".set noreorder\n\t"
".set mips3\n"
"1:\tcache %0,(%1)\n"
+#ifdef CONFIG_CPU_RM7000
+ "sync\n\t"
+#endif
"2:\t.set mips0\n\t"
".set reorder\n\t"
".section\t__ex_table,\"a\"\n\t"
