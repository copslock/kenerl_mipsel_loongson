Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2008 00:02:04 +0000 (GMT)
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:8652 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S22945764AbYKBABx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2008 00:01:53 +0000
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id ZwwW1a03K17UAYkA301kd9; Sun, 02 Nov 2008 00:01:44 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id a01h1a00358Be2l8Z01iEA; Sun, 02 Nov 2008 00:01:43 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=jIaU8pm1-gN3kJ0xkRoA:9 a=NNjGI58j6UMDZfjobVMA:7
 a=D9SNIGPZLLbSsY1CB6ZXZtnIdR4A:4 a=w6-myHctKckA:10 a=q88rVGSDDDoA:10
 a=WeOa-AV5lc8A:10 a=4iXfik_MsjQA:10
Message-ID: <490CEDB9.6030600@gentoo.org>
Date:	Sat, 01 Nov 2008 20:00:57 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home>
In-Reply-To: <87tzargrn4.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> 
> To be clear, the first option above was to check -- in mips_override_options --
> that -mfix-r10000 is only used in cases where -mbranch-likely is in effect.
> If we pick that option, it would be an error to use -mfix-r10000 in
> other cases, and any code protected by TARGET_FIX_R10000 would be free
> to use branch-likely instructions.  (Actually, we should use sorry()
> instead of error() to report something like this.)

[snip]

> That's the second option above, yes.  In other words, -mfix-r10000
> would support both -mbranch-likely and -mno-branch-likely, and act
> accordingly.

So do I need to worry about modifying the asm templates at all?  Or is that only 
needed if pursuing option #2?

The branch-likely stuff is only going to work for MIPS-II or higher targets.  In 
the odd (but possible) cases where MIPS-I might be used with -mfix-r10000, I 
assume we'll still have to emit 28 nops prior to a beq/beqz instruction.  Is 
this already taken care of someplace?


> ...that's a good question.  My take is "no".  I don't think we want
> -mfix-r10000 to enable branch-likely instructions in cases where
> it isn't necessary for R10000 errata.  If we take the first option,
> we can simply raise an error if:

Hmm, okay.  Might this work to enable -mbranch-likely if -mfix-r10000?  (Kind of 
guessing by looking at other segments of code).

   if ((target_flags_explicit & MASK_BRANCHLIKELY) == 0)
     {
       if (ISA_HAS_BRANCHLIKELY
           && (optimize_size
               || (!(target_flags_explicit & MASK_FIX_R10000) == 0)
               || (mips_tune_info->tune_flags & PTF_AVOID_BRANCHLIKELY) == 0))
         target_flags |= MASK_BRANCHLIKELY;
       else
         target_flags &= ~MASK_BRANCHLIKELY;
     }



My understanding so far for -mfix-r10000:
- Gets enabled if -march=r10000 is passed (done)
- Enable -mbranch-likely if not already enabled on >= MIPS-II (working on)
- Emits beqzl in the asm templates if enabled and >= MIPS-II (unsure)
- Emits 28 nops prior to beq/beqz if enabled and == MIPS-I (unsure)
- Ditto for asm templates (unsure)
- Documentation (not done)

Missing anything?


> Yeah, I was wondering that too.  I did a search, but couldn't
> find anything.

It seems we just need to use nop only and not worry about ssnop.


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
