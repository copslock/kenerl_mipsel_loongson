Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2008 23:13:34 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.187]:4469 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S23620740AbYKKXN0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Nov 2008 23:13:26 +0000
Received: by nf-out-0910.google.com with SMTP id h3so84427nfh.14
        for <linux-mips@linux-mips.org>; Tue, 11 Nov 2008 15:13:25 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=cTyMF01PDv//LBvwE9kxr/nfi4JV2H5/n2loSkQzJcE=;
        b=rSrtnb2SiIsNEYNECWlPnnitx124ORWLgjxIGDNcoyoxFCg6QeVLc97GQaAcziArPe
         eJk4SiCRQS9eX8gDRSDDC+uUqwgtGWxQpeuerjtQ+TedZmHRj7Wu7bxoS2Mkij8JdzOp
         QbUr3z8moDerBO7Z2fyHMeFEbVew79JxvqXcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=iXEMiRi3GoqV7mHjnGpWtV9bkRKPYctXeNc5uEuOrUiQukHX7m2qgOYr9YJKFX+P1Z
         Q7lEhcF0X2lC4B4AULbLN3EyYvfoBOb0Vwmg0dHAF2yFxvrBZWbP7g2qGOVwzy+o2MrP
         QBa93LSw2RuYHrfuEj96AnyppE2r4viFh2AZc=
Received: by 10.210.58.13 with SMTP id g13mr9717713eba.183.1226445205116;
        Tue, 11 Nov 2008 15:13:25 -0800 (PST)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id 3sm2209794eyj.3.2008.11.11.15.13.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Nov 2008 15:13:23 -0800 (PST)
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
	<8763mypnhf.fsf@firetop.home> <4917D01B.8080508@gentoo.org>
Date:	Tue, 11 Nov 2008 23:13:20 +0000
In-Reply-To: <4917D01B.8080508@gentoo.org> (kumba@gentoo.org's message of
	"Mon\, 10 Nov 2008 01\:09\:31 -0500")
Message-ID: <87y6zphn5b.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Kumba <kumba@gentoo.org> writes:
> Richard Sandiford wrote:
>> mips_branch_likely only applies to the _current_ insn, so it needs
>> to go before any call the macro templates.  Please use a helper
>> function such as:
>> 
>> const char *
>> mips_output_sync_insn (const char *template)
>> {
>>   mips_branch_likely = TARGET_FIX_R10000;
>>   return template;
>> }
>> 
>
> Done.  This is referenced in the first patch
> (gcc-4.4-trunk-fixr10k-z1.patch).  The second patch
> (gcc-4.4-trunk-fixr10k-z2.patch) contains a form whereby I just
> re-declared mips_branch_likely and set it once-per template.  More on
> this below.

The first version looks good, except for a couple of formatting
issues.  The second version doesn't work: those static mips_branch_likely
variables are local to insn-output.c, so mips.c:print_operand will never
see them.

> Yeah, ~ is one of the last characters that doesn't seem to be
> completely used up and looks good.  That still leaves !, &, {, }, and
> a comma.  But those could look confusing with surrounding characters.

Ah, well, that's not too bad.  I wouldn't have many qualms about using
%! and %& if need be.

> So about the two patches.  Both of these appears to accomplish the
> job, and allow gcc to begin compiling, but at one point about two
> hours into the build, genautomata will segfault when attempting to
> output tmp-automata.c.  I don't know which stage this is in...it's one
> of the early stages, and it's using xgcc at this point.
>
> I tried running gdb on that particular invocation of genautomata, but
> it there's not much data I could gather, since the -O2 optimization
> removes some of the useful debugging info.  It segfaults at an
> fprintf() invocation, and tmp-automata.c is 0 bytes.
>
> Here's the last few lines I get:
>
> /usr/cvsroot/gcc/host-mips-unknown-linux-gnu/prev-gcc/xgcc 
> -B/usr/cvsroot/gcc/host-mips-unknown-linux-gnu/prev-gcc/ 
> -B/usr//mips-unknown-linux-gnu/bin/  -g -O2 -DIN_GCC   -W -Wall -Wwrite-strings 
> -Wstrict-prototypes -Wmissing-prototypes -Wcast-qual -Wold-style-definition 
> -Wc++-compat -Wmissing-format-attribute -pedantic -Wno-long-long 
> -Wno-variadic-macros -Wno-overlength-strings   -DHAVE_CONFIG_H -DGENERATOR_FILE 
>   -o build/genautomata \
>              build/genautomata.o build/rtl.o build/read-rtl.o build/ggc-none.o 
> build/vec.o build/min-insn-modes.o build/gensupport.o build/print-rtl.o 
> build/errors.o ../../host-mips-unknown-linux-gnu/libiberty/libiberty.a -lm
> build/genautomata ../.././gcc/config/mips/mips.md \
>            insn-conditions.md > tmp-automata.c
> /bin/sh: line 1: 28620 Segmentation fault      build/genautomata 
> ../.././gcc/config/mips/mips.md insn-conditions.md > tmp-automata.c
> make[3]: *** [s-automata] Error 139
> make[3]: Leaving directory `/usr/cvsroot/gcc/host-mips-unknown-linux-gnu/gcc'
> make[2]: *** [all-stage2-gcc] Error 2
> make[2]: Leaving directory `/usr/cvsroot/gcc'
> make[1]: *** [stage2-bubble] Error 2
> make[1]: Leaving directory `/usr/cvsroot/gcc'
> make: *** [all] Error 2
>
>
> I thought at first, it was the use of the helper function, so I backed
> that out and went with the form seen in the second patch, but that
> didn't help things either.  So I'm assuming this is related to the
> changes to the atomic macro templates, and xgcc must have something
> inside itself that's a little wonky.  Not real sure how to approach
> this.
>
> However, there's more.  If I rebuild genautomata by hand (using args
> from the command line), and I drop the optimization down a notch to
> -O1, then I can run the command to create tmp-automata.c, and it'll
> complete successfully (and the output in that file looks good).  So
> I'm a bit baffled.  I assume the issue is caused by my patch, unless
> I'm running into a regression in trunk that my patch simply exposes.
>
> Is there another way to maybe extract some info on what's causing this?

For avoidance of doubt, I suppose the first thing to ask is: do you get
the segfault with the same checkout after you revert your patch?
It could certainly be transient breakage on trunk, like you say.

> @@ -13824,6 +13841,17 @@ mips_override_options (void)
>      warning (0, "the %qs architecture does not support branch-likely"
>  	     " instructions", mips_arch_info->name);
>  
> +  /* Check to see whether branch-likely instructions are not available
> +     when using -mfix-r10000.  This will be true if:
> +	1. -mno-branch-likely was passed.
> +	2. The selected ISA does not support branch-likely and
> +	   the command line does not include -mbranch-likely  */

Nitlet, but "to see" is redundant.  Maybe:

  /* Make sure that branch-likely instructions available when using
     -mfix-r10000.  The instructions are not available if either:

	1. -mno-branch-likely was passed.
	2. The selected ISA does not support branch-likely and
	   the command line does not include -mbranch-likely.  */

> +  if ((TARGET_FIX_R10000
> +       && (target_flags_explicit & MASK_BRANCHLIKELY) == 0)
> +          ? !ISA_HAS_BRANCHLIKELY
> +          ? !TARGET_BRANCHLIKELY : false : false)

Should just be:

  if (TARGET_FIX_R10000
      && ((target_flags_explicit & MASK_BRANCHLIKELY) == 0
          ? !ISA_HAS_BRANCHLIKELY
          : !TARGET_BRANCHLIKEL))
    sorry ("branch-likely instructions not available");

And the check should go after...

> @@ -13971,6 +13999,12 @@ mips_override_options (void)
>        && mips_matching_cpu_name_p (mips_arch_info->name, "r4400"))
>      target_flags |= MASK_FIX_R4400;
>  
> +  /* Default to working around R10000 errata only if the processor
> +     was selected explicitly.  */
> +  if ((target_flags_explicit & MASK_FIX_R10000) == 0
> +      && mips_matching_cpu_name_p (mips_arch_info->name, "r10000"))
> +    target_flags |= MASK_FIX_R10000;
> +
>    /* Save base state of options.  */
>    mips_base_target_flags = target_flags;
>    mips_base_delayed_branch = flag_delayed_branch;

...this.

(Which I suppose raises the question: should

  -march=r10000 -mno-branch-likely

be an error, or should it silently disable -mfix-r10000?  My vote is
for "error".  You can always write -march=r10000 -mno-branch-likely
-mno-fix-r10000 is that's really what you mean.

The suggested change -- swapping these two blocks around -- should do that.)

> @@ -76,9 +76,9 @@
>    "GENERATE_LL_SC"
>  {
>    if (which_alternative == 0)
> -    return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP);
> +    return mips_output_sync_insn (MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP));
>    else
> -    return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_ZERO_OP);
> +    return mips_output_sync_insn (MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_ZERO_OP));

Break lines longer than 80 chars.  Here and elsewhere, it's probably
best to use:

  return (mips_output_sync_insn
          (...stuff...));

rather than things like:

> @@ -160,8 +160,9 @@
>     (clobber (match_scratch:SI 5 "=&d"))]
>    "GENERATE_LL_SC"
>  {
> -    return MIPS_SYNC_OLD_OP_12 ("<insn>", MIPS_SYNC_OLD_OP_12_NOT_NOP,
> -				MIPS_SYNC_OLD_OP_12_NOT_NOP_REG);	
> +    return mips_output_sync_insn (MIPS_SYNC_OLD_OP_12 ("<insn>",
> +				    MIPS_SYNC_OLD_OP_12_NOT_NOP,
> +				    MIPS_SYNC_OLD_OP_12_NOT_NOP_REG));	

...this.  Arguments should generally be indented at least as far as the
opening "(".

Looks good otherwise, thanks.  We just need to sort out the build
problem.

Richard
