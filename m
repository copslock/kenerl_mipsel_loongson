Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 May 2004 21:54:31 +0100 (BST)
Received: from ispmxmta05-srv.alltel.net ([IPv6:::ffff:166.102.165.166]:9903
	"EHLO ispmxmta05-srv.alltel.net") by linux-mips.org with ESMTP
	id <S8225790AbUEIUya>; Sun, 9 May 2004 21:54:30 +0100
Received: from lahoo.priv ([69.40.150.122]) by ispmxmta05-srv.alltel.net
          with ESMTP
          id <20040509205420.OXDL6615.ispmxmta05-srv.alltel.net@lahoo.priv>;
          Sun, 9 May 2004 15:54:20 -0500
Received: from prefect.priv ([10.1.1.141] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 1BMvE7-0004l5-00; Sun, 09 May 2004 16:48:47 -0400
Message-ID: <012701c43607$83aa65f0$8d01010a@prefect>
From: "Bradley D. LaRonde" <brad@laronde.org>
To: "Richard Sandiford" <rsandifo@redhat.com>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
References: <045b01c43155$1e06cd80$8d01010a@prefect> <874qqpg2ti.fsf@redhat.com>
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol table entry st_value
Date: Sun, 9 May 2004 16:52:17 -0400
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
X-archive-position: 4953
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
Sent: Sunday, May 09, 2004 9:14 AM
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol
table entry st_value


> "Bradley D. LaRonde" <brad@laronde.org> writes:
> > I guess that the point of these procedure stubs is to keep
> > pointer-to-function values consistent between executables and share
> > libraries.  Is that what binutils is trying to accomplish here?
>
> No, it's to enable lazy binding.  The idea is that when the dynamic
> loader loads libpthread.so, it doesn't need to resolve malloc()
> immediately, it can just leave the GOT entry pointing to the stub.
> Then, when the stub is called, it will ask the dynamic linker to
> find the true address of malloc() and update the GOT accordingly.
> This is supposed to reduce start-up time.
>
> An object should never use stubs if takes the address of the function.
> It should only use a stub for some symbol foo if every use of foo is
> for a direct call.

OK.  So in a case where an object does take a pointer, does that mean that
ld.so must fix the GOT entry for that symbol before handing control to the
app (i.e. no lazy binding for that symbol)?


> If the dynamic loader is choosing libpthread's stub over the real
> definition in libc.so, that sounds on the face of it like a dynamic
> loader bug.

OK.


> > But should stubs really be getting involved here?  As Thiemo Seufer
pointed
> > out to me, readelf shows me that every undefined symbol in every shared
> > library in /lib on my x86 debian box has the st_value member for the
symbol
> > table entry set to zero.
>
> The x86 and MIPS ABIs are very different though.

I notice that the debian mipsel libpthread.so.0 in
http://ftp.debian.org/pool/main/g/glibc/libc6_2.2.5-11.5_mipsel.deb has
st_value == 0 for every UND FUNC, just like my x86 debian libraries.  This
is very different than the uClibc libpthread.so where every UND FUNC has
st_value != 0.  Interestingly if I link glibc's libpthread with uClibc's
libc.so I see that most UND FUNCs then have st_value != 0.

I would like to see how uClibc ld.so behaves I could somehow get ld to not
generate any stubs in  libpthread.  Any idea why libpthread gets full stubs
when linked with uClibc libc.so but no stubs when linked with glibc libc.so?


Regards,
Brad
