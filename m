Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2008 23:10:27 +0000 (GMT)
Received: from ey-out-1920.google.com ([74.125.78.147]:55499 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S23663987AbYKMXKY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Nov 2008 23:10:24 +0000
Received: by ey-out-1920.google.com with SMTP id 4so557802eyg.54
        for <linux-mips@linux-mips.org>; Thu, 13 Nov 2008 15:10:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=RjWQHe3hDnRh9uOuC1tOfDuzTpGks1G3Yky9jdS22ho=;
        b=Fwt+P1mQpekfVWjd4wIuYL2+v0cxEOXkIYr21hl85IF9SeRnpgfETUq7oGB9dRlz2I
         2mzfi6C+7DXqDvLNdNtbT4pST4A3wv+Fx+Xl7UVx2penGHxUbfHS7Pr7cZlW8TxBE1c6
         1WNhq0xVK2rshohelkAIZqc0QjQuAEggWGa48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=uYYdjZP22z4tOTYvGODyqqG9WzsGgwzgeWrwsq9U95ctJzwa4Ahc4NRF0u5dLwol73
         ZDX91DRy76XL6qTEJk3r5Pst5fDxY5kWjq4MC1IsR+ETcV8s7/xTr9nxacMAdNFKno1q
         laDYQRqU6B0ZfjUXhtSBlgH/6NrYNIgqHxwyw=
Received: by 10.210.46.14 with SMTP id t14mr294364ebt.39.1226617823047;
        Thu, 13 Nov 2008 15:10:23 -0800 (PST)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id c24sm3354413ika.16.2008.11.13.15.10.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 15:10:21 -0800 (PST)
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
	<87y6zphn5b.fsf@firetop.home> <491A88E8.3050108@gentoo.org>
Date:	Thu, 13 Nov 2008 23:10:18 +0000
In-Reply-To: <491A88E8.3050108@gentoo.org> (kumba@gentoo.org's message of
	"Wed\, 12 Nov 2008 02\:42\:32 -0500")
Message-ID: <873ahvgr39.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Thanks for the new patch.  Generally looks good.

Kumba <kumba@gentoo.org> writes:
> Richard Sandiford wrote:
>> (Which I suppose raises the question: should
>> 
>>   -march=r10000 -mno-branch-likely
>> 
>> be an error, or should it silently disable -mfix-r10000?  My vote is
>> for "error".  You can always write -march=r10000 -mno-branch-likely
>> -mno-fix-r10000 is that's really what you mean.
>> 
>> The suggested change -- swapping these two blocks around -- should do that.)
>
> Well, the check I moved around is only calling sorry(), stating that 
> branch-likely isn't available.  Would additional checking be needed to 
> specifically look for -march=r10000 -mno-branch-likely (and not 
> -mno-fix-r10000), and then raise error() instead, warning the user about the 
> invalid flag combinations

It should be sorry() in all cases.

> (and listing them, so they don't scratch their heads wondering why,
> should such logic be buried deep in a Makefile)?  Or should the sorry
> message be made more verbose? (It looks like it completes part of a
> sentence, so I mimed the grammar I saw in other uses of it).

Well, I suppose the current sorry() is too terse even for an
explicit -mfix-r10000.  How about:

  sorry ("%qs requires branch-likely instructions\n", "-mfix-r10000");

(Done that way so that we can reuse any translations in cases where
we need branch-likely instructions for some other option.)  I think
that's OK even for "-march=r10000 -mno-branch-likely"; the documentation
should make it clear that -mfix-r10000 is the default for -march=r10000.

> Also, what about cases where -march=r12000 is passed?  GCC right now
> has no technical difference between r10k through r16k (they all map to
> r10k for scheduling, per my scheduling patch), but r12k and up should
> have this problem fixed, and thus not need it.  Do we need to go that
> far in addressing obscure combinations of the flags?
>
> Perhaps:
>
> if ((mips_matching_cpu_name_p (mips_arch_info->name, "r12000") ||
>       mips_matching_cpu_name_p (mips_arch_info->name, "r14000") ||
>       mips_matching_cpu_name_p (mips_arch_info->name, "r16000"))
>      && TARGET_FIX_R10000)
> {
>    sorry ("R10000 Errata fix not necessary on R12000 and greater CPUs");
> }

No, there's no need for anything like this.

>> Break lines longer than 80 chars.  Here and elsewhere, it's probably
>> best to use:
>> 
>>   return (mips_output_sync_insn
>>           (...stuff...));
>
> Done.  I used parenthesis on all the return statements, even if they stayed on 
> one line, for consistency.  Any qualms with that?

'Fraid so. ;)  You had those right the first time.

> Some of the lines are just shy of the 80-char limit by 2-4 chars, so
> having the parans there I suppose can preempt any future changes that
> might necessitate a newline + indentation being added.

Whoever gets to make such changes also gets to format the new version
correctly.  There's no need to preempt them by adding redundant parens
(which is against coding conventions).

>> Looks good otherwise, thanks.  We just need to sort out the build
>> problem.
>
> I added to that bug you mentioned (in another mail), as I determined
> that the problem flag is -foptimize-sibling-calls combined with -O1.
> With -O0, it will run just fine, so there's another one or more flags
> enabled by -O1 that are causing the fluke.  No idea if it's
> genautomata itself, since I peeked into SVN and that source file
> hasn't seen any activity in two months.  I figure it must be one of
> the other files that get linked in.

Thanks.  Haven't had time to look at the PR yet.  Will be the weekend
at the earliest now.

> Also, what about a test case?  This is pretty dangerous on Rev 2.5
> R10Ks, potentially locking them up, so I don't know if a testcase
> would be necessary.

A testcase would be nice, yes.  It helps people who are testing on
non-R10K hardware.  It doesn't need to be an execution test though:
just write a scan-assembler test to make sure that all __sync_*()
builtins use branch-likely instructions.  See other gcc.target/mips
tests for inspiration.

> +  /* Make sure that branch-likely instructions available when using
> +     -mfix-r10000.  The instructions are not available if either:

Minor nit, but I think the comment is easier to read if we keep the
suggested blank line here.

> +	1. -mno-branch-likely was passed.
> +	2. The selected ISA does not support branch-likely and
> +	   the command line does not include -mbranch-likely  */

You lost the "." at the end of the comment (coding conventions require it).

> diff -Naurp -x .svn gcc.orig/gcc/doc/invoke.texi gcc/gcc/doc/invoke.texi
> --- gcc.orig/gcc/doc/invoke.texi	2008-10-30 22:14:29.000000000 -0400
> +++ gcc/gcc/doc/invoke.texi	2008-11-11 22:38:37.000000000 -0500
> @@ -666,7 +666,7 @@ Objective-C and Objective-C++ Dialects}.
>  -mdivide-traps  -mdivide-breaks @gol
>  -mmemcpy  -mno-memcpy  -mlong-calls  -mno-long-calls @gol
>  -mmad  -mno-mad  -mfused-madd  -mno-fused-madd  -nocpp @gol
> --mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 @gol
> +-mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 -mfix-r10000 -mno-fix-r10000 @gol
>  -mfix-vr4120  -mno-fix-vr4120  -mfix-vr4130  -mno-fix-vr4130 @gol
>  -mfix-sb1  -mno-fix-sb1 @gol
>  -mflush-func=@var{func}  -mno-flush-func @gol

This is preformatted text, so the new line is too long.  Push it onto the
next, and push the -m{no-,}-fix-vr4130 options down to the following line.

You need to document what -mfix-r10000 does as well. ;)  See the other
-mfix-* options for the general idea.

Richard
