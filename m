Received:  by oss.sgi.com id <S554366AbRB0PeA>;
	Tue, 27 Feb 2001 07:34:00 -0800
Received: from enst.enst.fr ([137.194.2.16]:23028 "HELO enst.enst.fr")
	by oss.sgi.com with SMTP id <S553900AbRB0Pdn>;
	Tue, 27 Feb 2001 07:33:43 -0800
Received: from email.enst.fr (muse.enst.fr [137.194.2.33])
	by enst.enst.fr (Postfix) with ESMTP
	id 901451C913; Tue, 27 Feb 2001 16:33:38 +0100 (MET)
Received: from donjuan.enst.fr (donjuan.enst.fr [137.194.168.21])
	by email.enst.fr (8.9.3/8.9.3) with ESMTP id QAA07034;
	Tue, 27 Feb 2001 16:33:33 +0100 (MET)
Received: from localhost (bellard@localhost)
	by donjuan.enst.fr (8.9.3+Sun/8.9.3) with SMTP id QAA23114;
	Tue, 27 Feb 2001 16:33:17 +0100 (MET)
Date:   Tue, 27 Feb 2001 16:33:17 +0100 (MET)
From:   Fabrice Bellard <bellard@email.enst.fr>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Fabrice Bellard <bellard@email.enst.fr>, linux-mips@oss.sgi.com
Subject: Re: Serious bug in uaccess.h
In-Reply-To: <Pine.GSO.3.96.1010227155414.2952A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.02.10102271629230.22188-100000@donjuan.enst.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I read the gcc docs and you are right, so it seems to be a gcc bug. I am
using gcc 2.95.2. Which version of gcc is OK to compile a linux mips
kernel ?

BTW, the kernel would be smaller by moving all the asm around __copy_user
in __copy_user itself. I am currently doing that. The cost is an added
'jr' to jump to __memcpy. Do you think it is worthwhile to do that ?

Fabrice.

On Tue, 27 Feb 2001, Maciej W. Rozycki wrote:

> On Tue, 27 Feb 2001, Fabrice Bellard wrote:
> 
> > I found a serious bug in the assembler macros in asm-mips/uaccess.h. They
> > all do something like that:
> > 
> > 		__asm__ __volatile__( \
> > 			"move\t$4, %1\n\t" \
> > 			"move\t$5, %2\n\t" \
> > 			"move\t$6, %3\n\t" \
> > 			".set\tnoreorder\n\t" \
> > 			__MODULE_JAL(__copy_user) \
> > ...
> > 
> > The problem is that you cannot assume that gcc will not put %1, %2 or %3
> > in registers different from $4, $5 or $6. For example, if %2 is put in $4,
> > the code is incorrect. (With gcc-2.95.2 I got a bug in
> > generic_file_write!).
> 
>  Hmm, haven't looked through gcc sources, but docs state: "It is an error
> for a clobber description to overlap an input or output operand (for
> example, an operand describing a register class with one member, mentioned
> in the clobber list)."  I guess it implies clobbers are not used for input
> or output.  It's reasonable anyway and if gcc acts otherwise, you might
> just have caught a bug in gcc.
> 
> > A possible fix would be to use asm registers:
> > 
> > #define copy_from_user(to,from,n) ({ \
> > 	register void *__cu_to asm("$4"); \
> > 	register const void *__cu_from asm("$5"); \
> > 	register long __cu_len asm("$6"); \
> > 	\
> > 	__cu_to = (to); \
> > 	__cu_from = (from); \
> > 	__cu_len = (n); \
> > 	if (access_ok(VERIFY_READ, __cu_from, __cu_len)) \
> > 		__asm__ __volatile__( \
> > 			".set\tnoreorder\n\t" \
> > 			__MODULE_JAL(__copy_user) \
> > ...
> > 
> > But I am not sure that it is always correct. Any idea ?
> 
>  This is fine and saves us three instructions.  Go on, make a patch (I'd
> suggest using "__asm__" for consistency, though)! 
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
