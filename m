Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:55:16 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:12419 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225213AbTC0Cyd>;
	Thu, 27 Mar 2003 02:54:33 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 3148946A59; Thu, 27 Mar 2003 03:53:07 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: Same cp0 regs are 64bits and other 32bit
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:53:07 +0100
Message-ID: <m2he9ped0s.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

*some* cp0 regs are unsigned long, not unsigned int.

Later, Juan.


 build/arch/mips/kernel/traps.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN build/arch/mips/kernel/traps.c~cp0_regs_are_unsigned_long build/arch/mips/kernel/traps.c
--- 24/build/arch/mips/kernel/traps.c~cp0_regs_are_unsigned_long	2003-03-25 22:35:22.000000000 +0100
+++ 24-quintela/build/arch/mips/kernel/traps.c	2003-03-25 22:36:59.000000000 +0100
@@ -788,9 +788,8 @@ asmlinkage void cache_parity_error(void)
 	unsigned int reg_val;
 
 	/* For the moment, report the problem and hang. */
-	reg_val = read_c0_errorepc();
 	printk("Cache error exception:\n");
-	printk("cp0_errorepc == %08x\n", read_c0_errorepc());
+	printk("cp0_errorepc == %08lx\n", read_c0_errorepc());
 	reg_val = read_c0_cacheerr();
 	printk("c0_cacheerr == %08x\n", reg_val);
 
@@ -809,10 +808,10 @@ asmlinkage void cache_parity_error(void)
 
 #if defined(CONFIG_CPU_MIPS32) || defined (CONFIG_CPU_MIPS64)
 	if (reg_val & (1<<22))
-		printk("DErrAddr0: 0x%08x\n", read_c0_derraddr0());
+		printk("DErrAddr0: 0x%08lx\n", read_c0_derraddr0());
 
 	if (reg_val & (1<<23))
-		printk("DErrAddr1: 0x%08x\n", read_c0_derraddr1());
+		printk("DErrAddr1: 0x%08lx\n", read_c0_derraddr1());
 #endif
 
 	panic("Can't handle the cache error!");

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
