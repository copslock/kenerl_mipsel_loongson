Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:55:36 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:12931 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225219AbTC0Cyr>;
	Thu, 27 Mar 2003 02:54:47 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id C272046A59; Thu, 27 Mar 2003 03:53:20 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: move unused variable to right ifdef branch
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:53:20 +0100
Message-ID: <m2fzp9ed0f.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

config1 was only usend inside the ifdef.  Move definition there.

Once here, make things u32 instead of unsigned int.

Later, Juan.

 build/arch/mips/mm/tlb-r4k.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -puN build/arch/mips/mm/tlb-r4k.c~move_unused_var_tlb-r4k.c build/arch/mips/mm/tlb-r4k.c
--- 24/build/arch/mips/mm/tlb-r4k.c~move_unused_var_tlb-r4k.c	2003-03-21 02:03:48.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/tlb-r4k.c	2003-03-21 02:05:07.000000000 +0100
@@ -333,9 +333,8 @@ out:
 
 static void __init probe_tlb(unsigned long config)
 {
-	unsigned int prid, config1;
+	u32 prid = read_c0_prid() & 0xff00;
 
-	prid = read_c0_prid() & 0xff00;
 	if (prid == PRID_IMP_RM7000 || !(config & (1 << 31)))
 		/*
 		 * Not a MIPS32 complianant CPU.  Config 1 register not
@@ -345,11 +344,13 @@ static void __init probe_tlb(unsigned lo
 		return;
 
 #if defined(CONFIG_CPU_MIPS32) || defined (CONFIG_CPU_MIPS64)
-	config1 = read_c0_config1();
 	if (!((config >> 7) & 3))
 		panic("No MMU present");
-	else
+	else {
+		u32 config1 = read_c0_config1();
+
 		mips_cpu.tlbsize = ((config1 >> 25) & 0x3f) + 1;
+	}
 #endif
 }
 

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
