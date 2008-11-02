Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2008 10:49:51 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14820 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22970775AbYKBKtq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 2 Nov 2008 10:49:46 +0000
Date:	Sun, 2 Nov 2008 10:49:45 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
In-Reply-To: <490CEDB9.6030600@gentoo.org>
Message-ID: <alpine.LFD.1.10.0811021036330.20461@ftp.linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 1 Nov 2008, Kumba wrote:

> The branch-likely stuff is only going to work for MIPS-II or higher targets.
> In the odd (but possible) cases where MIPS-I might be used with -mfix-r10000,
> I assume we'll still have to emit 28 nops prior to a beq/beqz instruction.  Is
> this already taken care of someplace?

 MIPS I does not support LL/SC, so that case is not to be concerned.  
These instructions are emulated on such processors and as such can appear 
in assembly snippets, but GCC is expected not to emit them itself (I hope 
it hasn't changed; if it has, then we are in trouble -- I suppose a 
compiler error is justified for such an odd case).

> Hmm, okay.  Might this work to enable -mbranch-likely if -mfix-r10000?  (Kind
> of guessing by looking at other segments of code).
> 
>   if ((target_flags_explicit & MASK_BRANCHLIKELY) == 0)
>     {
>       if (ISA_HAS_BRANCHLIKELY
>           && (optimize_size
>               || (!(target_flags_explicit & MASK_FIX_R10000) == 0)
>               || (mips_tune_info->tune_flags & PTF_AVOID_BRANCHLIKELY) == 0))
>         target_flags |= MASK_BRANCHLIKELY;
>       else
>         target_flags &= ~MASK_BRANCHLIKELY;
>     }
> 
> 
> 
> My understanding so far for -mfix-r10000:
> - Gets enabled if -march=r10000 is passed (done)
> - Enable -mbranch-likely if not already enabled on >= MIPS-II (working on)
> - Emits beqzl in the asm templates if enabled and >= MIPS-II (unsure)
> - Emits 28 nops prior to beq/beqz if enabled and == MIPS-I (unsure)
> - Ditto for asm templates (unsure)
> - Documentation (not done)

 I think the best option is to leave -mbranch-likely intact and bail out 
if -mfix-r10000 and -mno-branch-likely are passed at the same time.  
Anything else is likely to cause confusion.  Then -march=r10000 should 
enable both -mfix-r10000 and -mbranch-likely.

 I believe (but have not checked) that all CPUs/ISAs that are within the 
MIPS II - MIPS IV range enable -mbranch-likely by default, so there is no 
problem here unless somebody requests -mno-branch-likely in which case 
they get what they asked for (i.e. a compiler error).  I believe all MIPS 
architecture CPUs/ISAs disable -mbranch-likely by default, but such code 
cannot run on the R10k anyway.

 I think it covers all cases.  Comments?

  Maciej
