Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Mar 2009 10:37:43 +0000 (GMT)
Received: from gateway09.websitewelcome.com ([69.93.35.26]:41402 "HELO
	gateway09.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S21367474AbZCUKhh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Mar 2009 10:37:37 +0000
Received: (qmail 24306 invoked from network); 21 Mar 2009 10:38:04 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway09.websitewelcome.com with SMTP; 21 Mar 2009 10:38:04 -0000
Received: from [217.109.65.213] (port=1379 helo=[192.168.236.58])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1Lkya4-000264-DI; Sat, 21 Mar 2009 05:37:32 -0500
Message-ID: <49C4C36B.7010606@paralogos.com>
Date:	Sat, 21 Mar 2009 05:37:31 -0500
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Nils Faerber <nils.faerber@kernelconcepts.de>
CC:	linux-mips@linux-mips.org
Subject: Re: Need help iterpreting reg-dump
References: <49C42A9B.5050103@kernelconcepts.de>
In-Reply-To: <49C42A9B.5050103@kernelconcepts.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Do the programs that are failing contain floating point code?  The most 
interesting thing about your dump is that the EPC address, which should 
point to the instruction generating the fault, looks to be a user stack 
address, which suggests a trampoline function.  It just so happens that 
the FPU emulator logic sets up a sort of trampoline to deal with 
instructions in the delay slots of FP branches, and this trampoline 
deliberately causes an unaligned access trap as a way of transferring 
control back to the kernel.  Furthermore, the unaligned access trap is a 
"lw $0,1($0)", which would cause the BadVA value to be 0x00000001 - 
which is what your dump is reporting.  Unfortunately, the trampoline is 
set just *above* the top of the user stack, so the stack dump in the 
diagnostic output below won't show it, nor the "cookie" (0x0000bd36) 
that should have followed it in memory to confirm that it's a deliberate 
trap (the stack needs to be aligned anyway, so we put in a sort of 
signature).

So, while I can't prove anything conclusive based on the dump below, it 
suggests that the processor took a CP1 exception on an instruction that 
was emulated as an FP branch, so that the branch delay slot instruction 
had to be executed off the top of the stack in the delay slot emulation 
code, but that something was screwed up so that the call to 
do_dsemulret() in do_ade() returned zero, so the unaligned access 
handling threw a signal instead of ignoring it.

The diagnostic code probably hasn't been armed in years, but if you 
#define DSEMUL_TRACE when the code in arch/mips/math-emu is built (or 
just hack it into dsemul.h or dsemul.c), it would help confirm or deny 
the hypothesis.

          Regards,

          Kevin K.

Nils Faerber wrote:
> Hello all!
> By some (unlucky :) coincidence I recently came into posession of a
> Ingenic JZ4730 based subnotebook and am since trying to get a more
> recent kernel to boot. The only base I have at hand is 2.6.24.3 - sorry
> for that. I already described most of the details in an earlier post
> "Ingenic JZ4730 - illegal instruction".
> Anyway I chased the issue further an now found at lteast a single point
> in the kernel where the SIGILL for the applicaiton is generated, it is
> arch/mips/kernel/unaligned.c
>
> When I set the action to UNALIGNED_ACTION_SHOW I get the following dump
> whenever an application causes the fault to happen:
>
> [42949562.570000] Cpu 0
> [42949562.570000] $ 0   : 00000000 10000400 ffffff93 00000020
> [42949562.580000] $ 4   : 00000001 0000006d 000000c0 2aad225d
> [42949562.580000] $ 8   : 00000040 fffffffe 0000000c 0000000c
> [42949562.590000] $12   : 0000006d 00000003 00000003 00000000
> [42949562.590000] $16   : 2aad2ee8 2aad2ef0 005ab1d8 005ab1e0
> [42949562.600000] $20   : 7f8faae0 2b2a6340 7f8faa40 2aad2ee8
> [42949562.610000] $24   : 00000000 2b283010
> [42949562.610000] $28   : 2b2ae420 7f8faa08 00000001 2b27bda0
> [42949562.620000] Hi    : 00000002
> [42949562.620000] Lo    : 0f02cdc0
> [42949562.620000] epc   : 7f8faa00 0x7f8faa00     Not tainted
> [42949562.630000] ra    : 2b27bda0 0x2b27bda0
> [42949562.630000] Status: 00000413    USER EXL IE
> [42949562.640000] Cause : 00800010
> [42949562.640000] BadVA : 00000001
> [42949562.640000] PrId  : 02d0024f (Ingenic JZRISC)
> [42949562.650000] Modules linked in:
> [42949562.650000] Process gpe-info (pid: 1476, threadinfo=87cac000,
> task=87dc29d
> 8)
> [42949562.660000] Stack : 2b2ae420 7f8faa58 00000000 2b665794 2b2ae420
> 2b665794
> 2b27b8a0 2b27b8d8
> [42949562.670000]         2b750950 004b6ab8 2b74a75c 00000010 2b2ae420
> 2aad2e30
> 00000003 00000005
> [42949562.680000]         2aad2250 005a27d0 a2879f2e 547d42ae 2aad2e40
> 00000001
> 00598ad0 2aad2e30
> [42949562.680000]         005a27d0 7f8faae0 7f8faad8 2b27b72c 7f8faaf0
> 2b27c8ec
> 00000000 40237200
> [42949562.690000]         eb851eb8 401c0051 7ff80000 7ff80000 7ff80000
> 7ff80000
> 7ff80000 7ff80000
> [42949562.700000]         ...
> [42949562.710000] Call Trace:
> [42949562.710000]
> [42949562.710000]
> [42949562.710000] Code: 2aad2ef0  8fbc0010  8c000001 <0000bd36> 2b27bd7c
>  2b2ae4
> 20  7f8faa58  00000000  2b665794
>
>
> The interesting point for me is now that I always end up in the
> unaligned handler and never in some other random handler. This tells me
> that the cache is probably not the faulty part (since then different
> illegal instrcustion should occur) but rather the unalignement handling.
> I am not familiar enough with MIPS to decipher the dump into something
> useful.
> So could someone maybe give me at least a hint in which direction to
> look? A little bit more specific than just "CPU manual" would be great ;)
>
> Many thanks in advance!
>
> Cheers
>   nils faerber
>
>   
