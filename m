Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 07:12:52 +0100 (BST)
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:21218 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23033668AbYKCJCN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Nov 2008 09:02:13 +0000
Received: from OMTA12.emeryville.ca.mail.comcast.net ([76.96.30.44])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id aYkR1a00B0x6nqcA7Z1uU5; Mon, 03 Nov 2008 09:01:54 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA12.emeryville.ca.mail.comcast.net with comcast
	id aZ1s1a00158Be2l8YZ1tJj; Mon, 03 Nov 2008 09:01:54 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=dZRdnw54RLLAP4UkDQAA:9 a=ROiGRGIIV9sf-rlHcA4A:7
 a=khN03sL6quQGr3a6YjP5gieClQkA:4 a=w6-myHctKckA:10 a=mylFLmerCdIA:10
 a=PGOabtAob_8A:10 a=NInlibteEDoA:10 a=eZPNQgvkeWMA:10 a=WeOa-AV5lc8A:10
 a=4iXfik_MsjQA:10
Message-ID: <490EBDE2.6010709@gentoo.org>
Date:	Mon, 03 Nov 2008 04:01:22 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <87prleh2hc.fsf@firetop.home>
In-Reply-To: <87prleh2hc.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:

(Quoting out of order)

> 
> I feel we're talking at cross-purposes, so just to be clear:

Not really cross-purposes.  I'm just rather new to patching something big like a 
full-blown, multi-target compiler with 20 years of history to it.  Mostly trying 
to get an appropriate understanding of your two options so I can work the logic 
out in my head and know how to go about attacking this.

This is a step up from writing a md file for processor scheduling :)


>    2) Implement both (a) and (b).  In this case, any gcc code guarded
>       by TARGET_FIX_R10000 would need to check whether branch-likely
>       instructions are available.  If they are, we can use either
>       workaround (a) or workaroudn (b).  If they aren't, we must
>       use workaround (b).

I think it's better to target this path.  While it's probably an extremely rare 
case, because this problem only affects a specific set of processor revisions, 
triggering a problem only noticed (so far) on SGI machines running Linux, I tend 
to err on the side of caution and think it's probably a good idea to do it right 
the first time.

Also, Murphy's Law.


> You need to modify the asm templates whatever you do.

This is what has me a little perplexed.  The asm templates are #define macros, 
and it's kind of dawned on me that my attempts made so far to correct the errata 
has me using preprocessor macros that are going to get translated into something 
else when gcc itself is compiled, rather than gcc changing what it outputs based 
on the flags we send it.

So I'm assuming that, poking around in the sync.md file some, the better 
approach might be to pass an extra argument to these atomic macros as they're 
evaluated in sync.md.  This extra argument being the resultant branch likely 
instruction:

	- If -mfix-r10000 isn't needed or -mbranch-likely isn't called,
	  "beq" gets passed in.
	- If -mfix-r10000 is called, and ISA_HAS_BRANCHLIKELY is false,
	  pass in 28 nops plus "beq" (is there some kind of macro that can
	  expand a single nop 28 times?).
	- If -mfix-r10000 is called and ISA_HAS_BRANCHLIKELY is true
	  and -mno-branch-likely was not called, then pass in the beqzl
	  instruction.

I think that's all the relevant combinations.  It's also probably a good idea 
too to determine the value to pass as the extra argument before the atomic macro 
is called.

Is this kind of check something that would need to be done in the md file 
directly, referencing the various macros as needed, or would it need to be 
defined as a function in mips.c and called inline in sync.md, returning a string 
value to the function as it exists?  Or is there a better way?


> Yes, provided that you never override an explicit -mfix-r10000 or
> -mno-fix-r10000.

I copied the same code for R4000 and R4400 for this:

   /* Default to working around R10000 errata only if the processor
      was selected explicitly.  */
   if ((target_flags_explicit & MASK_FIX_R10000) == 0
       && mips_matching_cpu_name_p (mips_arch_info->name, "r10000"))
     target_flags |= MASK_FIX_R10000;

I assume that won't fire on r12000/r14000/r16000, right?  I know R14K isn't 
affected, but I haven't tried plugging my old R12K module back into the system 
to see what it does.  R16K is likely safe.


> Actually, I meant: I was wondering about the fact that there seems
> to be no online copy of the errata sheet that describes this problem.
> I've only ever seen a description of the workaround.  I've never seen
> a verbatim copy of the errata itself.

I tried seeing whether archive.org had anything old off of the mips.com site, 
but nothing close to the old directory structure seems to exist.  If I new what 
the PDF file name was, it might be possible to track something down on Google 
pertaining to the last publicly released revision.  Bit surprised, too, on why 
NEC doesn't have anything on necel.com.  They produced the actual silicon and 
had a hand in designing it, if I'm not mistaken.  I'd think they would at least 
have a copy if no one else.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
