Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 20:47:38 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:60271 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S23076296AbYKCUrb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Nov 2008 20:47:31 +0000
Received: by nf-out-0910.google.com with SMTP id h3so533108nfh.14
        for <linux-mips@linux-mips.org>; Mon, 03 Nov 2008 12:47:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=a1CdvJRbamfQn3OOQm8jTVHwd8CvmbrEFMOkK66ZKgw=;
        b=vA6jzeimbN6yCI3p25iXweZ06xBlTuOrWderq0+5ieP9QbI5TZRH3wyqxIr0UWx6UZ
         Ux7ttj9agBTXo+qxV6qvuWecBfn3rGKrtARGL7TgAWcNjtROPMPb2aU72zCIWYn9scDU
         bVDYB0NJVPKrsrrINkW2fN9RYndDcxPkC7ARM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=po5Hc21LKGTV1rRnWNCP82GEmStLETKsOVWwDS1V34yCDWyJd3jWFnhlKKsCbMqC3o
         bfmITgwYegN2g9yOJpuIyhZeyMxFNcYXdA8Cj9gZwNQbsJDR4RCSFJeiUM0Qs6v12Lxv
         gthmlfpwjOC8OZrjqx0J3+gNzdVNMBOcEZ1dY=
Received: by 10.210.128.5 with SMTP id a5mr636351ebd.151.1225745250285;
        Mon, 03 Nov 2008 12:47:30 -0800 (PST)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id b30sm5957283ika.3.2008.11.03.12.47.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 12:47:29 -0800 (PST)
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
Date:	Mon, 03 Nov 2008 20:47:25 +0000
In-Reply-To: <490EBDE2.6010709@gentoo.org> (kumba@gentoo.org's message of
	"Mon\, 03 Nov 2008 04\:01\:22 -0500")
Message-ID: <87myggilk2.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Kumba <kumba@gentoo.org> writes:
>>    2) Implement both (a) and (b).  In this case, any gcc code guarded
>>       by TARGET_FIX_R10000 would need to check whether branch-likely
>>       instructions are available.  If they are, we can use either
>>       workaround (a) or workaroudn (b).  If they aren't, we must
>>       use workaround (b).
>
> I think it's better to target this path.  While it's probably an
> extremely rare case, because this problem only affects a specific set
> of processor revisions, triggering a problem only noticed (so far) on
> SGI machines running Linux, I tend to err on the side of caution and
> think it's probably a good idea to do it right the first time.

Agreed, but that's just as true of option 1.  Each option is as correct
as the other.  It's just a question of whether we need the combination:

  -mips1 -mllsc -mfix-r10000

to be accepted, or whether we can treat it as a compile-time error.

If you do go for option 2, you then have to decide whether to insert
28 nops after every LL/SC loop, or whether you try to do some analysis
to avoid unnecessary nops.  The natural place for this analysis would
be mips_avoid_hazard.

>> You need to modify the asm templates whatever you do.
>
> This is what has me a little perplexed.  The asm templates are #define
> macros, and it's kind of dawned on me that my attempts made so far to
> correct the errata has me using preprocessor macros that are going to
> get translated into something else when gcc itself is compiled, rather
> than gcc changing what it outputs based on the flags we send it.
>
> So I'm assuming that, poking around in the sync.md file some, the better 
> approach might be to pass an extra argument to these atomic macros as they're 
> evaluated in sync.md.  This extra argument being the resultant branch likely 
> instruction:
>
> 	- If -mfix-r10000 isn't needed or -mbranch-likely isn't called,
> 	  "beq" gets passed in.
> 	- If -mfix-r10000 is called, and ISA_HAS_BRANCHLIKELY is false,
> 	  pass in 28 nops plus "beq" (is there some kind of macro that can
> 	  expand a single nop 28 times?).
> 	- If -mfix-r10000 is called and ISA_HAS_BRANCHLIKELY is true
> 	  and -mno-branch-likely was not called, then pass in the beqzl
> 	  instruction.
>
> I think that's all the relevant combinations.  It's also probably a
> good idea too to determine the value to pass as the extra argument
> before the atomic macro is called.

If you go for option 1, you could replace things like:

  "\tbeq\t%@,%.,1b\n"				\
  "\tnop\n"					\

with:

  "\tbeq%?\t%@,%.,1b\n"				\
  "\tnop\n"					\

and make the .md insn do:

  mips_branch_likely = TARGET_FIX_R10000;

But something nattier is needed for MIPS_SYNC_NEW_OP and MIPS_SYNC_NEW_NAND,
where the branch delay slot is not a nop.  In this case, we need to replace
things like:

  "\tbeq\t%@,%.,1b\n"				\
  "\t" INSN "\t%0,%0,%2\n"			\

with:

  "\tbeql\t%@,%.,1b\n"				\
  "\tnop\n"					\
  "\t" INSN "\t%0,%0,%2\n"			\

(INSN does not need to be executed when the branch is taken.)

I suppose adding a macro parameter would work, but it would lead
to combinatorial explosion.  I think we need to replace these
MIPS_SYNC_* macros with a function that uses output_asm_insn
to emit the loop insn-by-insn.  (This might make it possible
to factor things more than they're factored now.)

>> Yes, provided that you never override an explicit -mfix-r10000 or
>> -mno-fix-r10000.
>
> I copied the same code for R4000 and R4400 for this:
>
>    /* Default to working around R10000 errata only if the processor
>       was selected explicitly.  */
>    if ((target_flags_explicit & MASK_FIX_R10000) == 0
>        && mips_matching_cpu_name_p (mips_arch_info->name, "r10000"))
>      target_flags |= MASK_FIX_R10000;

Looks good.

> I assume that won't fire on r12000/r14000/r16000, right?

Right.

>> Actually, I meant: I was wondering about the fact that there seems
>> to be no online copy of the errata sheet that describes this problem.
>> I've only ever seen a description of the workaround.  I've never seen
>> a verbatim copy of the errata itself.
>
> I tried seeing whether archive.org had anything old off of the
> mips.com site, but nothing close to the old directory structure seems
> to exist.  If I new what the PDF file name was, it might be possible
> to track something down on Google pertaining to the last publicly
> released revision.  Bit surprised, too, on why NEC doesn't have
> anything on necel.com.  They produced the actual silicon and had a
> hand in designing it, if I'm not mistaken.  I'd think they would at
> least have a copy if no one else.

Yeah.  Maybe they just want to erase bad memories ;)

Richard
