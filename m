Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 19:05:36 +0100 (BST)
Received: from ispmxmta05-srv.alltel.net ([IPv6:::ffff:166.102.165.166]:48055
	"EHLO ispmxmta05-srv.alltel.net") by linux-mips.org with ESMTP
	id <S8225718AbUEJSFf>; Mon, 10 May 2004 19:05:35 +0100
Received: from lahoo.priv ([69.40.149.10]) by ispmxmta05-srv.alltel.net
          with ESMTP
          id <20040510180527.JJO6615.ispmxmta05-srv.alltel.net@lahoo.priv>;
          Mon, 10 May 2004 13:05:27 -0500
Received: from prefect.priv
	([10.1.1.141] helo=prefect ident=ambassador)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 1BNF65-0000tL-00; Mon, 10 May 2004 14:01:49 -0400
Message-ID: <00e201c436b9$5fa0f450$8d01010a@prefect>
From: "Bradley D. LaRonde" <brad@laronde.org>
To: "Richard Sandiford" <rsandifo@redhat.com>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
References: <045b01c43155$1e06cd80$8d01010a@prefect><874qqpg2ti.fsf@redhat.com> <012701c43607$83aa65f0$8d01010a@prefect> <87pt9cwwzu.fsf@redhat.com>
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol table entry st_value
Date: Mon, 10 May 2004 14:05:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Return-Path: <brad@laronde.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@laronde.org
Precedence: bulk
X-list: linux-mips

----- Original Message ----- 
From: "Richard Sandiford" <rsandifo@redhat.com>
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: <uclibc@uclibc.org>; <linux-mips@linux-mips.org>
Sent: Monday, May 10, 2004 3:40 AM
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol
table entry st_value


> "Bradley D. LaRonde" <brad@laronde.org> writes:
> >> An object should never use stubs if takes the address of the function.
> >> It should only use a stub for some symbol foo if every use of foo is
> >> for a direct call.
> >
> > OK.  So in a case where an object does take a pointer, does that mean
that
> > ld.so must fix the GOT entry for that symbol before handing control to
the
> > app (i.e. no lazy binding for that symbol)?
>
> Right.  Such objects won't use a stub, they'll just have a normal
> reference to an undefined symbol.  The dynamic loader must resolve
> it in the usual way.
>
> > I notice that the debian mipsel libpthread.so.0 in
> > http://ftp.debian.org/pool/main/g/glibc/libc6_2.2.5-11.5_mipsel.deb has
> > st_value == 0 for every UND FUNC, just like my x86 debian libraries.
This
> > is very different than the uClibc libpthread.so where every UND FUNC has
> > st_value != 0.  Interestingly if I link glibc's libpthread with uClibc's
> > libc.so I see that most UND FUNCs then have st_value != 0.
>
> You said in your original message that you'd recently upgraded to binutils
> 2.15-based tools.  Was your libpthread.so built with them?  If so, that
would
> explain it.  I think earlier versions of ld were overly pessimistic about
when
> stubs could be used.

Actually I did this round of testing with 2.14.90.0.7 to try and match
debian.


> FWIW, I have a glibc-based sysroot built with gcc 3.4 and binutils 2.15.
> Its libpthread uses plenty of stubs.

That's encouraging.  I'll switch back to 2.15 and see if I can find why
uClibc ld.so chooses the libpthread stub for libdl's malloc pointer.

Even though it is pointing libdl to the libpthread stub for malloc, should
it crash?  The first call of the stub should cause the libdl GOT entry to be
adjusted to point to the libc malloc?  Should a subsequent call of the stub
cause a crash?


Regards,
Brad
