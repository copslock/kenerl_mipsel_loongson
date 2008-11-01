Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 18:50:25 +0000 (GMT)
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:2717 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S22931460AbYKASuN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2008 18:50:13 +0000
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id ZuFE1a00j0FhH24A2uq5eK; Sat, 01 Nov 2008 18:50:05 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA08.emeryville.ca.mail.comcast.net with comcast
	id Zuq31a00358Be2l8Uuq4LH; Sat, 01 Nov 2008 18:50:05 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=JDIJrWWbvAlX_w-enlgA:9 a=P6SsapNdiOh3WgKqRoIA:7
 a=a6S2sZ5keg1bGVh2vSNHfV6o79EA:4 a=w6-myHctKckA:10 a=oVP8SKXuTwoA:10
 a=q88rVGSDDDoA:10 a=WeOa-AV5lc8A:10 a=4iXfik_MsjQA:10
Message-ID: <490CA4C8.40904@gentoo.org>
Date:	Sat, 01 Nov 2008 14:49:44 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home>
In-Reply-To: <87abcjibsl.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> 
> As Maciej said, this should really be controlled by an -mfix-r10000
> command-line option, not by the _MIPS_ARCH_* macro.  (In this context,
> _MIPS_ARCH_* is a property of the compiler that you're using to build
> gcc itself.)
> 
> There are two ways we could handle this:
> 
>   - Make -mfix-r10000 require -mbranch-likely.  (It mustn't _imply_
>     -mbranch-likely.  It should simply check that -mbranch-likely is
>     already in effect.)
> 
>   - Make -mfix-r10000 insert nops when -mbranch-likely is not in effect.

Does using -mbranch-likely change the output of those specific asm commands that 
my original patch was altering?  Or will -mfix-r10000 need to not only check the 
status of -mbranch-likely and set it if not set, but also need to modify the 
referenced beq/beqzl sets in mips.h?

If so, I assume a test for both TARGET_FIX_R10000 and TARGET_BRANCHLIKELY would 
be needed, and then if TARGET_BRANCHLIKELY doesn't exist, but TARGET_FIX_R10000 
is, insert 28 nops before beq.  Sound correct?


On setting -mbranch-likely, I found what I think is the appropriate section in 
mips.c around Line 13810:

   /* If neither -mbranch-likely nor -mno-branch-likely was given
      on the command line, set MASK_BRANCHLIKELY based on the target
      architecture and tuning flags.  Annulled delay slots are a
      size win, so we only consider the processor-specific tuning
      for !optimize_size.  */
   if ((target_flags_explicit & MASK_BRANCHLIKELY) == 0)
     {
       if (ISA_HAS_BRANCHLIKELY
           && (optimize_size
               || (mips_tune_info->tune_flags & PTF_AVOID_BRANCHLIKELY) == 0))
         target_flags |= MASK_BRANCHLIKELY;
       else
         target_flags &= ~MASK_BRANCHLIKELY;
     }
   else if (TARGET_BRANCHLIKELY && !ISA_HAS_BRANCHLIKELY)
     warning (0, "the %qs architecture does not support branch-likely"
              " instructions", mips_arch_info->name);

I'm kind of thinking that the -mfix-r10000 setting to include -mbranch-likely 
would fit here (Assuming this is what can enable/disable that option via 
MASK_BRANCHLIKELY), but if I'm reading it right, optimizing for size disables 
brach-likely instructions.  Shouldn't -mfix-r10000 override that?

Would an equivalent conditional like this be close?:

       if (ISA_HAS_BRANCHLIKELY
           && ((optimize_size || TARGET_FIX_R10000)
               || (mips_tune_info->tune_flags & PTF_AVOID_BRANCHLIKELY) == 0))


Also, does anyone have a copy of the R10000 Silicon Errata documentation kicking 
around?  Thiemo brought up a point that we may need ssnop instead of nop, but 
I'd need to check the errata for that, and that doesn't seem to exist anywhere 
anymore.  I found an old link to it on MIPS' site, but nothing else.  I've only 
got Vr10000 manuals from SGI and NEC, and they don't seem to cover 
revision-specific errata any.

Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
