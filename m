Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2008 09:37:45 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.184]:46322 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S23381062AbYKHJhm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Nov 2008 09:37:42 +0000
Received: by nf-out-0910.google.com with SMTP id h3so891122nfh.14
        for <linux-mips@linux-mips.org>; Sat, 08 Nov 2008 01:37:41 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=qmlQwlIDKMvIzgAe5ElRKTQoRbf+C8TeCiIZ1ycGJZ8=;
        b=K/4Kl2v+wvyBhQWrGPwb00CblAwwardWK9L4hayxvCuGbmyEu+lonf50D9XSZI2h6j
         IaYMMfKwPGH9t7BFo7lzN2en/kMtVixiHATYaGgBlBUGgYMnZpiEIgJf6Ara0r+WaXsD
         Kyi2pfBvS+Tx6vWtKB6b07DUfkyIpPFOsfco8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=wtmq+g6Zc1KFP3U2RWefrU0SuiQooJ2SVYEwM8QVHDMowd9ShlKpFMkzJlah27zZyK
         xI5LoRHXsINSEGqHO1jH3mYUpj9gdNlLEugCtrwmUoH9aDRctBgGV7bKJXsKpOYKyVv9
         p8KKvYGSwSunkQbDz/2vvMomiPtDHbVCKIG7I=
Received: by 10.210.75.6 with SMTP id x6mr4317175eba.61.1226137061008;
        Sat, 08 Nov 2008 01:37:41 -0800 (PST)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id y37sm227003iky.6.2008.11.08.01.37.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 01:37:39 -0800 (PST)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	Kumba <kumba@gentoo.org>
Mail-Followup-To: Kumba <kumba@gentoo.org>,gcc-patches@gcc.gnu.org,  Linux MIPS List <linux-mips@linux-mips.org>, rdsandiford@googlemail.com
Cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>
	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>
	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>
	<87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>
	<87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org>
Date:	Sat, 08 Nov 2008 09:37:32 +0000
In-Reply-To: <490FF63A.7010900@gentoo.org> (kumba@gentoo.org's message of
	"Tue\, 04 Nov 2008 02\:14\:02 -0500")
Message-ID: <8763mypnhf.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Kumba <kumba@gentoo.org> writes:
> Richard Sandiford wrote:
>> Agreed, but that's just as true of option 1.  Each option is as correct
>> as the other.  It's just a question of whether we need the combination:
>> 
>>   -mips1 -mllsc -mfix-r10000
>> 
>> to be accepted, or whether we can treat it as a compile-time error.
>
> Hmm, which do you think makes sense?  From a usage perspective, most
> developers are working in the MIPS32/MIPS64 ISA stuff.  In Gentoo, the
> mips port mostly supports SGI systems, mostly anything with a MIPS-IV
> capable processor (haven't decided on MIPS-III's fate just yet).
> Debian I know has switched off of MIPS-I being the default for their
> binaries, and I think is MIPS-II now.  In all these cases, the target
> OS is usually Linux, although I know there are some Irix folks still
> out there, plus the *BSDs all got their own ports.
>
> But I guess the question I'm pondering, is just how rare would it be
> for someone to actually need a MIPS-I binary with ll/sc and
> branch-likely fixes to run on something like an R10000?  Rare enough
> to justify denying them that particular command argument combination,
> and thus taking Option #1?  Or go the extra mile for Option #2?  I
> don't know if that's my call to really make, since I lack the
> statistical data to know who would be affected, and in what ways
> (i.e., do they have alternative methods, such as MIPS-II, etc..).

I'm not sure I have the statistical knowledge either.  I've tended
to work in embedded environments where -march=<my cpu> is almost always
the right option to use.  But like Maciej, I suspect it isn't worth
supporting the combination.  So my preference is for option #1.

You make a convincing case that the combination isn't useful for current
Linux distributions.  And it isn't useful for IRIX 6 either: the o32
system libraries are -mips2 rather than -mips1, and both GCC and
MIPSpro default to -mips2 for o32.

Also, I believe the glibc patch doesn't cope with -mips1 -mllsc either.
Is that right?  If so, that's another reason not to worry about it
for GCC.

I don't have a strong opinion though.

>> If you do go for option 2, you then have to decide whether to insert
>> 28 nops after every LL/SC loop, or whether you try to do some analysis
>> to avoid unnecessary nops.  The natural place for this analysis would
>> be mips_avoid_hazard.
>
> Hmm, just looking at this out of curiosity to get an idea of what I might have 
> to tackle, but this particular sequence looks like the key:
>
>    /* Work out how many nops are needed.  Note that we only care about
>       registers that are explicitly mentioned in the instruction's pattern.
>       It doesn't matter that calls use the argument registers or that they
>       clobber hi and lo.  */
>    if (*hilo_delay < 2 && reg_set_p (lo_reg, pattern))
>      nops = 2 - *hilo_delay;
>    else if (*delayed_reg != 0 && reg_referenced_p (*delayed_reg, pattern))
>      nops = 1;
>    else
>      nops = 0;
>
> I'd have to do some reading around the code to get an understanding of
> how this function works and is called, but I'm taking a guess that
> it's just an extra 'else if ... nops = 28 ...' for the simple approach
> (more complex if one were to try actual analysis).  Ot at minimum,
> another entire if block, since this does look like it's specifically
> for HI/LO checks.

It's a bit more complicated than that.  The current code takes advantage
of a nice property: that a gap of two instructions will avoid all the
hazards that we currently handle.  So if we come across a branch,
we only ever need to look at the branch and its delay slot; we never
need to look at the target of a branch.  For the R10000 errata,
you would either:

  (1) need to do proper global (inter-block) analaysis, which is
      a fair bit of new code; or

  (2) conservatively assume that the target of a branch might be a
      __sync_*() operation.

Also, the "nops =" part of the current code inserts "#nop" rather than
"nop" for ".set reorder" functions, because the assembler is supposed
to avoid the hazards in that case.  Unless you make GAS do the same
for this errata, you would need to:

  (1) insert a real nop instead of a hazard_nop; and

  (2) treat any asm as a potential atomic operation.

>> If you go for option 1, you could replace things like:
>> 
>>   "\tbeq\t%@,%.,1b\n"				\
>>   "\tnop\n"					\
>> 
>> with:
>> 
>>   "\tbeq%?\t%@,%.,1b\n"				\
>>   "\tnop\n"					\
>
> Looks simple enough.  I found the block explaining what the %?
> parameter does.  Is that in any actual documentation aside from a
> comment block in mips.c?  I'm only looking at the 4.3.2 Internals
> Manual, cause I don't know if 4.4.x Internals is online yet.  Wasn't
> sure if that was addressed from a documentation standpoint (or whether
> it's something that even needs to be listed online).

The internals manual intentionally doesn't cover things like this.
It's for target-independent stuff, not for internal details about
each port.  So the mips.c comment _is_ the documentation.

>> and make the .md insn do:
>> 
>>   mips_branch_likely = TARGET_FIX_R10000;
>
> Can this go anywhere in sync.md (i.e., at the top in a proper place),
> or does it need to go before any call to the macro templates?

mips_branch_likely only applies to the _current_ insn, so it needs
to go before any call the macro templates.  Please use a helper
function such as:

const char *
mips_output_sync_insn (const char *template)
{
  mips_branch_likely = TARGET_FIX_R10000;
  return template;
}

>> But something nattier is needed for MIPS_SYNC_NEW_OP and MIPS_SYNC_NEW_NAND,
>> where the branch delay slot is not a nop.  In this case, we need to replace
>> things like:
>> 
>>   "\tbeq\t%@,%.,1b\n"				\
>>   "\t" INSN "\t%0,%0,%2\n"			\
>> 
>> with:
>> 
>>   "\tbeql\t%@,%.,1b\n"				\
>>   "\tnop\n"					\
>>   "\t" INSN "\t%0,%0,%2\n"			\
>
> Looking at what %# and %/ do, Maybe a new punctuation character that simply 
> dumps out a nop instead if mips_branch_likely is true?  I.e.:
>
>      case '~':
>        if (mips_branch_likely)
>          fputs ("\n\tnop", file);
>        break;
>
> And:
>
>      "\tbeq%?\t%@,%.,1b%~\n"				\
>      "\t" INSN "\t%0,%0,%2\n"			\
>
> '~' seems to be one of the last unused characters on my keyboard.
> Seems like a good fit.

Yeah, looks good.  I'm a bit worried about running of % characters,
but like I say, we could always replace the templates with individual
output_asm_insns at some point in the future.

Richard
