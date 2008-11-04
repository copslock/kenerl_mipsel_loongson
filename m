Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 07:14:53 +0000 (GMT)
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:11149 "EHLO
	QMTA10.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23098462AbYKDHOu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2008 07:14:50 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by QMTA10.emeryville.ca.mail.comcast.net with comcast
	id auw61a0011HpZEsAAvEirl; Tue, 04 Nov 2008 07:14:42 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA14.emeryville.ca.mail.comcast.net with comcast
	id avEe1a00158Be2l8avEgxU; Tue, 04 Nov 2008 07:14:41 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=Yv_C9k0Iy-NrJJFgaA0A:9 a=gnEl6mJtNNo7FjMNDpgA:7
 a=9kavZkAXTwxhRsv0S9budOjKw9UA:4 a=w6-myHctKckA:10 a=WeOa-AV5lc8A:10
 a=4iXfik_MsjQA:10
Message-ID: <490FF63A.7010900@gentoo.org>
Date:	Tue, 04 Nov 2008 02:14:02 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>	<87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org> <87myggilk2.fsf@firetop.home>
In-Reply-To: <87myggilk2.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> 
> Agreed, but that's just as true of option 1.  Each option is as correct
> as the other.  It's just a question of whether we need the combination:
> 
>   -mips1 -mllsc -mfix-r10000
> 
> to be accepted, or whether we can treat it as a compile-time error.

Hmm, which do you think makes sense?  From a usage perspective, most developers 
are working in the MIPS32/MIPS64 ISA stuff.  In Gentoo, the mips port mostly 
supports SGI systems, mostly anything with a MIPS-IV capable processor (haven't 
decided on MIPS-III's fate just yet).  Debian I know has switched off of MIPS-I 
being the default for their binaries, and I think is MIPS-II now.  In all these 
cases, the target OS is usually Linux, although I know there are some Irix folks 
still out there, plus the *BSDs all got their own ports.

But I guess the question I'm pondering, is just how rare would it be for someone 
to actually need a MIPS-I binary with ll/sc and branch-likely fixes to run on 
something like an R10000?  Rare enough to justify denying them that particular 
command argument combination, and thus taking Option #1?  Or go the extra mile 
for Option #2?  I don't know if that's my call to really make, since I lack the 
statistical data to know who would be affected, and in what ways (i.e., do they 
have alternative methods, such as MIPS-II, etc..).


> If you do go for option 2, you then have to decide whether to insert
> 28 nops after every LL/SC loop, or whether you try to do some analysis
> to avoid unnecessary nops.  The natural place for this analysis would
> be mips_avoid_hazard.

Hmm, just looking at this out of curiosity to get an idea of what I might have 
to tackle, but this particular sequence looks like the key:

   /* Work out how many nops are needed.  Note that we only care about
      registers that are explicitly mentioned in the instruction's pattern.
      It doesn't matter that calls use the argument registers or that they
      clobber hi and lo.  */
   if (*hilo_delay < 2 && reg_set_p (lo_reg, pattern))
     nops = 2 - *hilo_delay;
   else if (*delayed_reg != 0 && reg_referenced_p (*delayed_reg, pattern))
     nops = 1;
   else
     nops = 0;

I'd have to do some reading around the code to get an understanding of how this 
function works and is called, but I'm taking a guess that it's just an extra 
'else if ... nops = 28 ...' for the simple approach (more complex if one were to 
try actual analysis).  Ot at minimum, another entire if block, since this does 
look like it's specifically for HI/LO checks.


> If you go for option 1, you could replace things like:
> 
>   "\tbeq\t%@,%.,1b\n"				\
>   "\tnop\n"					\
> 
> with:
> 
>   "\tbeq%?\t%@,%.,1b\n"				\
>   "\tnop\n"					\

Looks simple enough.  I found the block explaining what the %? parameter does. 
Is that in any actual documentation aside from a comment block in mips.c?  I'm 
only looking at the 4.3.2 Internals Manual, cause I don't know if 4.4.x 
Internals is online yet.  Wasn't sure if that was addressed from a documentation 
standpoint (or whether it's something that even needs to be listed online).


> and make the .md insn do:
> 
>   mips_branch_likely = TARGET_FIX_R10000;

Can this go anywhere in sync.md (i.e., at the top in a proper place), or does it 
need to go before any call to the macro templates?


> But something nattier is needed for MIPS_SYNC_NEW_OP and MIPS_SYNC_NEW_NAND,
> where the branch delay slot is not a nop.  In this case, we need to replace
> things like:
> 
>   "\tbeq\t%@,%.,1b\n"				\
>   "\t" INSN "\t%0,%0,%2\n"			\
> 
> with:
> 
>   "\tbeql\t%@,%.,1b\n"				\
>   "\tnop\n"					\
>   "\t" INSN "\t%0,%0,%2\n"			\

Looking at what %# and %/ do, Maybe a new punctuation character that simply 
dumps out a nop instead if mips_branch_likely is true?  I.e.:

     case '~':
       if (mips_branch_likely)
         fputs ("\n\tnop", file);
       break;

And:

     "\tbeq%?\t%@,%.,1b%~\n"				\
     "\t" INSN "\t%0,%0,%2\n"			\

'~' seems to be one of the last unused characters on my keyboard.  Seems like a 
good fit.


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
