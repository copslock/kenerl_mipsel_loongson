Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 19:42:20 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.170]:16487 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S22934925AbYKATmN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Nov 2008 19:42:13 +0000
Received: by ug-out-1314.google.com with SMTP id k40so1814489ugc.2
        for <linux-mips@linux-mips.org>; Sat, 01 Nov 2008 12:42:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=tpNnB/Zy4ezAudtEVEew+EEeOxHs+dFv9VuiHXseAlk=;
        b=r7nl0jvtloA3IK5VKXRsQafpBK0MwdthqN5CIvQ1UZr3xQTrgfjUK2WlLYqLsfbA9U
         S4Xc2nD57Mm097Uz5MqmBRLmR7hjuHSW9E3VliYgIkevPv26HpNA838Yg2Z5U0TbJ+++
         If2SwNO5dzOk2JpiQNQGJwATE4jZKb+vxCjsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=er9TdyWts6UygAQtaUobZDOU10hKmqmuh6POkNwMARKO31iQ09t5hL7mvgQeE2YL1x
         T/TXMwQj37Au5gPQk0CMNzrE+aOqH23CSRSxHZKneBwEVg5myEPDdfycCNP2N6QdFLBz
         F0sevJyTzFSCUhPFhUVOG04ZewrESsf9p1zXo=
Received: by 10.210.128.5 with SMTP id a5mr15381095ebd.151.1225568530163;
        Sat, 01 Nov 2008 12:42:10 -0700 (PDT)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id b33sm4275747ika.1.2008.11.01.12.42.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Nov 2008 12:42:09 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	Kumba <kumba@gentoo.org>
Mail-Followup-To: Kumba <kumba@gentoo.org>,gcc-patches@gcc.gnu.org,  Linux MIPS List <linux-mips@linux-mips.org>, rdsandiford@googlemail.com
Cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>
	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>
Date:	Sat, 01 Nov 2008 19:42:07 +0000
In-Reply-To: <490CA4C8.40904@gentoo.org> (kumba@gentoo.org's message of "Sat\,
	01 Nov 2008 14\:49\:44 -0400")
Message-ID: <87tzargrn4.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Kumba <kumba@gentoo.org> writes:
> Richard Sandiford wrote:
>> 
>> As Maciej said, this should really be controlled by an -mfix-r10000
>> command-line option, not by the _MIPS_ARCH_* macro.  (In this context,
>> _MIPS_ARCH_* is a property of the compiler that you're using to build
>> gcc itself.)
>> 
>> There are two ways we could handle this:
>> 
>>   - Make -mfix-r10000 require -mbranch-likely.  (It mustn't _imply_
>>     -mbranch-likely.  It should simply check that -mbranch-likely is
>>     already in effect.)
>> 
>>   - Make -mfix-r10000 insert nops when -mbranch-likely is not in effect.
>
> Does using -mbranch-likely change the output of those specific asm
> commands that my original patch was altering?

No.  In current sources, the asm templates never use branch-likely
instructions.

> Or will -mfix-r10000 need to not only check the status of
> -mbranch-likely and set it if not set, but also need to modify the
> referenced beq/beqzl sets in mips.h?

To be clear, the first option above was to check -- in mips_override_options --
that -mfix-r10000 is only used in cases where -mbranch-likely is in effect.
If we pick that option, it would be an error to use -mfix-r10000 in
other cases, and any code protected by TARGET_FIX_R10000 would be free
to use branch-likely instructions.  (Actually, we should use sorry()
instead of error() to report something like this.)

> If so, I assume a test for both TARGET_FIX_R10000 and
> TARGET_BRANCHLIKELY would be needed, and then if TARGET_BRANCHLIKELY
> doesn't exist, but TARGET_FIX_R10000 is, insert 28 nops before beq.
> Sound correct?

That's the second option above, yes.  In other words, -mfix-r10000
would support both -mbranch-likely and -mno-branch-likely, and act
accordingly.

> On setting -mbranch-likely, I found what I think is the appropriate
> section in mips.c around Line 13810:
>
>    /* If neither -mbranch-likely nor -mno-branch-likely was given
>       on the command line, set MASK_BRANCHLIKELY based on the target
>       architecture and tuning flags.  Annulled delay slots are a
>       size win, so we only consider the processor-specific tuning
>       for !optimize_size.  */
>    if ((target_flags_explicit & MASK_BRANCHLIKELY) == 0)
>      {
>        if (ISA_HAS_BRANCHLIKELY
>            && (optimize_size
>                || (mips_tune_info->tune_flags & PTF_AVOID_BRANCHLIKELY) == 0))
>          target_flags |= MASK_BRANCHLIKELY;
>        else
>          target_flags &= ~MASK_BRANCHLIKELY;
>      }
>    else if (TARGET_BRANCHLIKELY && !ISA_HAS_BRANCHLIKELY)
>      warning (0, "the %qs architecture does not support branch-likely"
>               " instructions", mips_arch_info->name);
>
> I'm kind of thinking that the -mfix-r10000 setting to include -mbranch-likely 
> would fit here (Assuming this is what can enable/disable that option via 
> MASK_BRANCHLIKELY), but if I'm reading it right, optimizing for size disables 
> brach-likely instructions.

Well, optimize_size _enables_ branch-likely, but...

> Shouldn't -mfix-r10000 override that?

...that's a good question.  My take is "no".  I don't think we want
-mfix-r10000 to enable branch-likely instructions in cases where
it isn't necessary for R10000 errata.  If we take the first option,
we can simply raise an error if:

  TARGET_FIX_R10000
  && (target_flags_explicit & MASK_BRANCHLIKELY) == 0
      ? !ISA_HAS_BRANCH_LIKELY
      ? !TARGET_BRANCH_LIKELY)

> Also, does anyone have a copy of the R10000 Silicon Errata
> documentation kicking around?  Thiemo brought up a point that we may
> need ssnop instead of nop, but I'd need to check the errata for that,
> and that doesn't seem to exist anywhere anymore.  I found an old link
> to it on MIPS' site, but nothing else.  I've only got Vr10000 manuals
> from SGI and NEC, and they don't seem to cover revision-specific
> errata any.

Yeah, I was wondering that too.  I did a search, but couldn't
find anything.

Richard
