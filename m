Received:  by oss.sgi.com id <S554371AbRB0PxV>;
	Tue, 27 Feb 2001 07:53:21 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:43393 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554363AbRB0Pwx>;
	Tue, 27 Feb 2001 07:52:53 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA04477;
	Tue, 27 Feb 2001 16:13:34 +0100 (MET)
Date:   Tue, 27 Feb 2001 16:13:33 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Fabrice Bellard <bellard@email.enst.fr>
cc:     linux-mips@oss.sgi.com
Subject: Re: Serious bug in uaccess.h
In-Reply-To: <Pine.GSO.4.02.10102271534030.22188-100000@donjuan.enst.fr>
Message-ID: <Pine.GSO.3.96.1010227155414.2952A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 27 Feb 2001, Fabrice Bellard wrote:

> I found a serious bug in the assembler macros in asm-mips/uaccess.h. They
> all do something like that:
> 
> 		__asm__ __volatile__( \
> 			"move\t$4, %1\n\t" \
> 			"move\t$5, %2\n\t" \
> 			"move\t$6, %3\n\t" \
> 			".set\tnoreorder\n\t" \
> 			__MODULE_JAL(__copy_user) \
> ...
> 
> The problem is that you cannot assume that gcc will not put %1, %2 or %3
> in registers different from $4, $5 or $6. For example, if %2 is put in $4,
> the code is incorrect. (With gcc-2.95.2 I got a bug in
> generic_file_write!).

 Hmm, haven't looked through gcc sources, but docs state: "It is an error
for a clobber description to overlap an input or output operand (for
example, an operand describing a register class with one member, mentioned
in the clobber list)."  I guess it implies clobbers are not used for input
or output.  It's reasonable anyway and if gcc acts otherwise, you might
just have caught a bug in gcc.

> A possible fix would be to use asm registers:
> 
> #define copy_from_user(to,from,n) ({ \
> 	register void *__cu_to asm("$4"); \
> 	register const void *__cu_from asm("$5"); \
> 	register long __cu_len asm("$6"); \
> 	\
> 	__cu_to = (to); \
> 	__cu_from = (from); \
> 	__cu_len = (n); \
> 	if (access_ok(VERIFY_READ, __cu_from, __cu_len)) \
> 		__asm__ __volatile__( \
> 			".set\tnoreorder\n\t" \
> 			__MODULE_JAL(__copy_user) \
> ...
> 
> But I am not sure that it is always correct. Any idea ?

 This is fine and saves us three instructions.  Go on, make a patch (I'd
suggest using "__asm__" for consistency, though)! 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
