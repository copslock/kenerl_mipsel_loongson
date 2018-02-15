Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 20:15:42 +0100 (CET)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:16387 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991855AbeBOTPeehqtV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2018 20:15:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id AF66640402;
        Thu, 15 Feb 2018 20:15:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gRj-m2aiDqZZ; Thu, 15 Feb 2018 20:15:18 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 8C656403E1;
        Thu, 15 Feb 2018 20:15:07 +0100 (CET)
Date:   Thu, 15 Feb 2018 20:15:04 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: [RFC v2] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
Message-ID: <20180215191502.GA2736@localhost.localdomain>
References: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211075608.GC2222@localhost.localdomain>
 <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Maciej,

>  Well, but it would help if you only patched the handlers which are 
> actually used by the R5900 (and only the handlers and not other code).

Indeed, thanks. :) I'm glad this is cleared up, and greatly simplified too.
I tried to go through the details. According to 5-7 of the TX79 manual the
R5900 has six exception vector addresses:

- 0x80000000	TLB Refill EXL=0		build_r4000_tlb_refill_handler
- 0x80000080	Performance Counter
- 0x80000100	Debug, SIO
- 0x80000180	TLB Refill EXL=1, Others	except_vec3_generic
- 0x80000200	Interrupt			set_except_vector
- 0xbfc00000	Reset, NMI

Given that build_r4000_tlb_refill_handler copies 0x100 bytes with

	memcpy((void *)ebase, final_handler, 0x100);

it seems to overwrite the Performance Counter handler (ebase offset 0x80),
which isn't installed at all as I understand it (neither seems Debug, SIO).
A further complication: it seems to actually make use of up to 252 bytes:

/* The worst case length of the handler is around 18 instructions for           
 * R3000-style TLBs and up to 63 instructions for R4000-style TLBs.             
 * Maximum space available is 32 instructions for R3000 and 64                  
 * instructions for R4000.                                                      
 *                                                                              
 * We deliberately chose a buffer size of 128, so we won't scribble             
 * over anything important on overflow before we panic.                         
 */                                                                             
static u32 tlb_handler[128];                                                    

The R5900 wants two additional NOPs (8 bytes) for FLX05 and then another
five NOPs (20 bytes) for ERET (potentially up to 280 bytes):

https://www.linux-mips.org/archives/linux-mips/2018-02/msg00106.html

Fortunately, in practice, final_len ends on 31 all in all, just 4 bytes
below the 0x80 offset for the Performance Counter handler. Does the
following change make sense to at least partially address the overwrite?

--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1507,8 +1507,8 @@ static void build_r4000_tlb_refill_handler(void)
 	pr_debug("Wrote TLB refill handler (%u instructions).\n",
 		 final_len);
 
-	memcpy((void *)ebase, final_handler, 0x100);
-	local_flush_icache_range(ebase, ebase + 0x100);
+	memcpy((void *)ebase, final_handler, 4 * final_len);
+	local_flush_icache_range(ebase, ebase + 4 * final_len);
 
 	dump_handler("r4000_tlb_refill", (u32 *)ebase, 64);
 }

By the way, I tried to inspect the exception handlers via /dev/mem but this
fails with "bad address". Is it expected to work at all? A web search turned
up

https://www.linux-mips.org/archives/linux-mips/2000-12/msg00051.html

which gave some hope. :) Here is a memory layout that I think would be
interesting to access via /dev/mem:

http://www.psdevwiki.com/ps3/PS2_Emulation#PS2_Memory_and_Hardware_Mapped_Registers_Layout

>  IOW the only places that look relevant to me are: `except_vec3_generic', 
> `build_r4000_tlb_refill_handler' and `set_except_vector'.  Please update 
> your change accordingly.

Please find updated patch below. I've compiled and tested it. However, it
seems appropriate to also fix the issues with build_r4000_tlb_refill_handler
described above, and perhaps even install default handlers for the
Performance Counter, Debug and SIO?

Fredrik

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index c7b64f4a8ad3..a2bee29debe9 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -32,6 +32,10 @@
 NESTED(except_vec3_generic, 0, sp)
 	.set	push
 	.set	noat
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 #if R5432_CP0_INTERRUPT_WAR
 #ifdef CONFIG_CPU_R5900
 	sync.p
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 761b6c369321..b881b93f0418 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1949,6 +1949,11 @@ void __init *set_except_vector(int n, void *addr)
 #endif
 		u32 *buf = (u32 *)(ebase + 0x200);
 		unsigned int k0 = 26;
+
+#ifdef CONFIG_CPU_R5900
+		uasm_i_nop(&buf);
+		uasm_i_nop(&buf);
+#endif
 		if ((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
 			uasm_i_j(&buf, handler & ~jump_mask);
 			uasm_i_nop(&buf);
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a18b013fd887..f4e0e748ed8a 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1308,6 +1308,11 @@ static void build_r4000_tlb_refill_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 	memset(final_handler, 0, sizeof(final_handler));
 
+#ifdef CONFIG_CPU_R5900
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+#endif
+
 	if (IS_ENABLED(CONFIG_64BIT) && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
 		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
 							  scratch_reg);
