Received:  by oss.sgi.com id <S553802AbRAIMMZ>;
	Tue, 9 Jan 2001 04:12:25 -0800
Received: from [194.90.113.98] ([194.90.113.98]:22547 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S553799AbRAIMMQ>;
	Tue, 9 Jan 2001 04:12:16 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id OAA00798;
	Tue, 9 Jan 2001 14:54:42 +0200
Message-ID: <3A5AFAC8.CA682600@jungo.com>
Date:   Tue, 09 Jan 2001 13:49:29 +0200
From:   Michael Shmulevich <michaels@jungo.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: User applications
References: <Pine.GSO.3.96.1010108185713.23234R-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

As a side question, I would like to to know why exactly the CPU cache operations
are
promoted to the syscall status? What is the situation that a user in its program
would like
to call cacheflush() ? Unless, of course, he is doing DoS.

I can understand why we need this in kernel, for context switch, for example, but
as a syscall?...

Michael.

"Maciej W. Rozycki" wrote:

> On Mon, 8 Jan 2001, Ralf Baechle wrote:
>
> > > $ mipsel-linux-objdump -T /usr/mipsel-linux/lib/libc-2.2.so | grep cachectl
> > > 00000000600ca0a0  w   DF *ABS*  0000000000000000  GLIBC_2.0   cachectl
> > > $ ls /usr/mipsel-linux/include/sys/cachectl.h
> > > /usr/mipsel-linux/include/sys/cachectl.h
> >
> > cachectl(2) is a syscall that is manipulates the cachability of a memory
> > area.  And not yet implemented ...
>
>  s/cachectl$/cacheflush/, of course (but the header is still valid).
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
