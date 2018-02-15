Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 22:01:45 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:43719 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992243AbeBOVBgrjFo9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2018 22:01:36 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 15 Feb 2018 21:01:21 +0000
Received: from [10.20.78.236] (10.20.78.236) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Thu, 15 Feb 2018
 12:50:23 -0800
Date:   Thu, 15 Feb 2018 20:49:12 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [RFC v2] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
In-Reply-To: <20180215191502.GA2736@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1802151934180.3553@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk> <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain> <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk> <20180211075608.GC2222@localhost.localdomain> <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk>
 <20180215191502.GA2736@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1518728479-637137-438-68460-7
X-BESS-VER: 2018.2-r1802142118
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190063
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Hi Fredrik,

> Indeed, thanks. :) I'm glad this is cleared up, and greatly simplified too.
> I tried to go through the details. According to 5-7 of the TX79 manual the
> R5900 has six exception vector addresses:
> 
> - 0x80000000	TLB Refill EXL=0		build_r4000_tlb_refill_handler
> - 0x80000080	Performance Counter
> - 0x80000100	Debug, SIO
> - 0x80000180	TLB Refill EXL=1, Others	except_vec3_generic
> - 0x80000200	Interrupt			set_except_vector
> - 0xbfc00000	Reset, NMI
> 
> Given that build_r4000_tlb_refill_handler copies 0x100 bytes with
> 
> 	memcpy((void *)ebase, final_handler, 0x100);
> 
> it seems to overwrite the Performance Counter handler (ebase offset 0x80),
> which isn't installed at all as I understand it (neither seems Debug, SIO).

 Regular MIPS processors have the XTLB Refill handler at offset 0x80 
(which we use with 64-bit kernels in place of TLB Refill, by setting 
Status KX/SX/UX bits) and the Cache Error handler at offset 0x100 (which 
uses C/KSEG1 rather than C/KSEG0 as the base).  Both Refill slots are made 
available for a single TLB/XTLB handler as we never use both at a time 
(this may eventually change, as per recent discussions about making the 
user address space wrap where possible, on a per-task basis according to 
the ABI selected).

 If R5900 support wants to use these handler slots in a different manner, 
then it is of course free to.

> A further complication: it seems to actually make use of up to 252 bytes:
> 
> /* The worst case length of the handler is around 18 instructions for           
>  * R3000-style TLBs and up to 63 instructions for R4000-style TLBs.             
>  * Maximum space available is 32 instructions for R3000 and 64                  
>  * instructions for R4000.                                                      
>  *                                                                              
>  * We deliberately chose a buffer size of 128, so we won't scribble             
>  * over anything important on overflow before we panic.                         
>  */                                                                             
> static u32 tlb_handler[128];                                                    
> 
> The R5900 wants two additional NOPs (8 bytes) for FLX05 and then another
> five NOPs (20 bytes) for ERET (potentially up to 280 bytes):
> 
> https://www.linux-mips.org/archives/linux-mips/2018-02/msg00106.html
> 
> Fortunately, in practice, final_len ends on 31 all in all, just 4 bytes
> below the 0x80 offset for the Performance Counter handler. Does the
> following change make sense to at least partially address the overwrite?
> 
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1507,8 +1507,8 @@ static void build_r4000_tlb_refill_handler(void)
>  	pr_debug("Wrote TLB refill handler (%u instructions).\n",
>  		 final_len);
>  
> -	memcpy((void *)ebase, final_handler, 0x100);
> -	local_flush_icache_range(ebase, ebase + 0x100);
> +	memcpy((void *)ebase, final_handler, 4 * final_len);
> +	local_flush_icache_range(ebase, ebase + 4 * final_len);
>  
>  	dump_handler("r4000_tlb_refill", (u32 *)ebase, 64);
>  }

 I didn't comment on the erratum workaround addressing speculative 
execution beyond ERET, because I haven't made final conclusions as to code 
will have to exactly look like.

 However please note that in reality 5 NOPs are not required in these 
generated handlers (except perhaps from the interrupt handler, which will 
have to be double-checked, due to being set up differently), because the 
lone reason for them to be inserted is to prevent from data interpreted as 
ill-formed code being speculatively executed.  But any handler that 
follows does not contain ill-formed code and the `tlb_handler' buffer is 
cleared before any generated machine code is built within, so any trailing 
padding uses the encoding of NOP.  Which means you can exclude these 5 
NOPs from calculation.

> By the way, I tried to inspect the exception handlers via /dev/mem but this
> fails with "bad address". Is it expected to work at all? A web search turned
> up
> 
> https://www.linux-mips.org/archives/linux-mips/2000-12/msg00051.html
> 
> which gave some hope. :) Here is a memory layout that I think would be
> interesting to access via /dev/mem:
> 
> http://www.psdevwiki.com/ps3/PS2_Emulation#PS2_Memory_and_Hardware_Mapped_Registers_Layout

 You could use /dev/mem to inspect exception handlers I suppose, but that 
would be awkward.  It's mostly useful to access MMIO as I described in the 
message you were kind enough to dig out from the depths of history.

 For exception handler examination I suggest using /proc/kcore instead, 
which gives you access to kernel memory via an artificial ELF image, 
making this a piece of cake.  Like this for example:

$ gdb -c /proc/kcore
[...]
#0  0x00000000 in ?? ()
(gdb) set architecture mips:isa32r2
The target architecture is assumed to be mips:isa32r2
(gdb) x /32i 0x80000000
0x80000000:	lui	k1,0x8483
0x80000004:	mfc0	k0,c0_badvaddr
0x80000008:	lw	k1,-30560(k1)
0x8000000c:	srl	k0,k0,0x1a
0x80000010:	sll	k0,k0,0x2
0x80000014:	addu	k1,k1,k0
0x80000018:	mfc0	k0,c0_context
0x8000001c:	lw	k1,0(k1)
0x80000020:	srl	k0,k0,0x3
0x80000024:	andi	k0,k0,0x3ff8
0x80000028:	addu	k1,k1,k0
0x8000002c:	lw	k0,0(k1)
0x80000030:	lw	k1,4(k1)
0x80000034:	srl	k0,k0,0x6
0x80000038:	mtc0	k0,c0_entrylo0
0x8000003c:	srl	k1,k1,0x6
0x80000040:	mtc0	k1,c0_entrylo1
0x80000044:	tlbwr
0x80000048:	eret
0x8000004c:	nop
0x80000050:	nop
0x80000054:	nop
0x80000058:	nop
0x8000005c:	nop
0x80000060:	nop
0x80000064:	nop
0x80000068:	nop
0x8000006c:	nop
0x80000070:	nop
0x80000074:	nop
0x80000078:	nop
0x8000007c:	nop
(gdb) 

Substitute `mips:5900' for `mips:isa32r2' to get R5900 disassembly.  If 
you want to see raw machine code too, use `disassemble -r', but watch out 
for the syntax, which is different.  As you can see the trailing NOPs 
required are already there. :)  You can supply `vmlinux' as the executable 
to debug too for symbolic access.

 You can also ask the kernel to dump generated handlers to the kernel log 
(and the console, if `debug' has been specified as a kernel parameter) at 
bootstrap by building tlbex.c and/or page.c with -DDEBUG, e.g.:

$ make CFLAGS_tlbex.o=-DDEBUG vmlinux

It can help if a bug in a generated handler prevents the kernel from 
starting userland.

> >  IOW the only places that look relevant to me are: `except_vec3_generic', 
> > `build_r4000_tlb_refill_handler' and `set_except_vector'.  Please update 
> > your change accordingly.
> 
> Please find updated patch below. I've compiled and tested it.

 It seems fine to me.

> However, it
> seems appropriate to also fix the issues with build_r4000_tlb_refill_handler
> described above, and perhaps even install default handlers for the
> Performance Counter, Debug and SIO?

 A handler for SIO is needed if SIOInt can be asserted without kernel 
control by PS/2 hardware.  Otherwise handlers will only be needed once the 
kernel has means to enable the respective exceptions.

  Maciej
