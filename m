Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2008 21:24:56 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:36137 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28594931AbYGXUYx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Jul 2008 21:24:53 +0100
Received: by nf-out-0910.google.com with SMTP id h3so992965nfh.14
        for <linux-mips@linux-mips.org>; Thu, 24 Jul 2008 13:24:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=mf0jYxduAaRV9hVSKqMpfciClg8pURTUmgKBTxTMnTI=;
        b=lRcr5JIzRZhqIrS20EqSPQ+MuycPNtMzZfkylkg/CFN4lZLTR0IqXwNsgOpBtZA4cK
         rg2NkQOSKS3yxjAuWmRHk5/1F44+L7ByxBf5wiKS1SlFix7IXILlVEwcEpG9PgUipv6t
         hxXYAKd/6g3eqr8TRTZ52KFijxGeSOzQ+Zm9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=hY5UU47liPxVDn5IT3XGy7nTWYEylGyZASYe3oRl+U4om7XEtCbQc+JpapZY5+C7dM
         LoT7C3OpsV7tPmlIQ2ejy9CASopXz2n56XTJYm1OXC0wc4EtWAxR7kSLMpD/tZceYDWc
         k21q6FAY0aiiFX+J/jSBrg++3tWCodOdforo8=
Received: by 10.210.42.20 with SMTP id p20mr886776ebp.37.1216931092257;
        Thu, 24 Jul 2008 13:24:52 -0700 (PDT)
Received: from localhost ( [79.67.114.192])
        by mx.google.com with ESMTPS id p10sm18926515gvf.7.2008.07.24.13.24.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 13:24:51 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	binutils@sourceware.org
Mail-Followup-To: binutils@sourceware.org,gcc@gcc.gnu.org,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home>
	<20080724161619.GA18842@caradoc.them.org>
Date:	Thu, 24 Jul 2008 21:24:48 +0100
In-Reply-To: <20080724161619.GA18842@caradoc.them.org> (Daniel Jacobowitz's
	message of "Thu\, 24 Jul 2008 12\:16\:20 -0400")
Message-ID: <87ej5j2fov.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz <dan@debian.org> writes:
> - Richard's ld -r support is an addition to the ABI, but does not
> conflict with anything else, so I included it.  I discovered two
> potential problems:
>
>   - If a symbol with STO_MIPS_PIC is localized using objcopy,
>   binutils will ignore the flag.  I don't think this is presently
>   worth implementing but it might be wise to add an error message.
>   I haven't done that yet.
>
>   - Superfluous la25 stubs are suppressed when a PIC2 file uses jal.
>   This is an optimization performed by gcc -mno-shared.  It will not
>   work after ld -r into a non-PIC file; the jump will appear to come
>   from a non-PIC object and be redirected to a new stub.  This is only
>   a minor performance pessimization and I do not plan to fix it.

Yeah, for the record, this second one was actually a deliberate choice.
There's no real object-level information to indicate -mno-sharedness
(unlike "PIC"ness), so any attempt to recognise it would simply be a
heuristic.

The ld -r support was really there for the same reason as the la $25
stubs: to allow "real" PIC and "new" non-PIC to be linked together.
It seems unlikely that you'd have much -mno-shared code to link in if
you're using a "new"-PIC-compatible sysroot.

> - It would be nice to generate, in some cases, both a .MIPS.stubs lazy
> binding stub and a PLT entry.  However, I determined that considerable
> additional work would be required to do this; most likely we'd need
> two entries for the same symbol in the dynamic symbol table so that
> the GOT entry could be associated with the lazy loading stub.  As
> things stand it is possible to link non-PIC and PIC code together, and
> if both call the same function and the non-PIC code takes its address,
> calls to the function from PIC code will be penalized.  I do not
> expect this case to matter.  Most applications will be predominantly
> PIC or non-PIC.

Yeah, FWIW, I think we discussed this in the original three-way thread
last year.  (I think the original proposal was to use PLTs all the time
for "new-PIC" executables.  I remember arguing in favour of keeping
.MIPS.stubs as an option because they're more efficient when handling
the cases they can.  I certainly agree that's it not worth trying to
use both .MIPS.stubs and PLTs for the same function.)

> - I've dropped support for a non-fixed $gp.  This is a handy
> optimization, but it was getting in the way and it was the part of the
> GCC patch Richard had the most comments on.  I can resubmit it after
> everything else is merged.

That's a shame.  It was also the bit I liked best ;)  What went wrong?

(My comments were only minor.)

> - Richard's implementation had __PIC__ mean abicalls.  Our patch
> changed __PIC__ to mean pic2 abicalls only.  I've included that in
> this patch.  My reasoning is that most non-pic non-abicalls code works
> properly even with pic0 abicalls; the only problem is indirect calls
> through a register other than $25.  This lets glibc automatically use
> some more efficient sequences in static applications.

Hmm, OK.  It's the less conservative choice, but I agree it's also
the best performance-wise.

> - I added pointer_equality_needed support to binutils to suppress
> setting st_value to the PLT entry in most cases.
>
> - The GCC new-static-chain.patch causes nested-func-4.exe to fail.
> _mcount is called through a PLT entry, which clobbers $15.  I believe
> we need to add this to MIPS_SAVE_REG_FOR_PROFILING_P.  I didn't fix
> this yet.
>
> - no-fn-name-already-declared.patch removed the call to
> ASM_OUTPUT_TYPE_DIRECTIVE for Linux.  .ent has similar effect, but is
> suppressed by flag_inhibit_size_directive.  This caused glibc's _init
> to be STT_OBJECT, and not get a PIC call stub.  I've changed GCC to
> emit .type for all platforms; Richard, if this should be restricted
> to the status quo (i.e. Linux) let me know.

No, that sounds right to me FWIW.

> Also the STT_FUNC check in the linker was unnecessary now that we only
> use la25 stubs for jump relocations.

Agreed.

Sorry for the bugs, and thanks for fixing them.  I'll try to have
a look at the patches over the weekend.

Richard
