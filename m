Received:  by oss.sgi.com id <S553906AbQKDDKp>;
	Fri, 3 Nov 2000 19:10:45 -0800
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:51874 "EHLO convert rfc822-to-8bit
        mta5.snfc21.pbi.net") by oss.sgi.com with ESMTP id <S553902AbQKDDKf>;
	Fri, 3 Nov 2000 19:10:35 -0800
Received: from zeus.mvista.com ([63.192.220.206])
 by mta5.snfc21.pbi.net (Sun Internet Mail Server sims.3.5.2000.01.05.12.18.p9)
 with SMTP id <0G3H00AX7CNA8J@mta5.snfc21.pbi.net>; Fri,
 3 Nov 2000 19:06:47 -0800 (PST)
Date:   Sat, 04 Nov 2000 03:10:50 +0000 (GMT)
From:   Pete Popov <ppopov@pacbell.net>
Subject: Re: Kernel compiler
In-reply-to: <20001104035326.A29005@bacchus.dhis.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Keith Owens <kaos@melbourne.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Message-id: <20001104.3105000@zeus.mvista.com>
MIME-version: 1.0
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <20001103221926.A26082@bacchus.dhis.org>
 <5029.973305862@ocs3.ocs-net> <20001104035326.A29005@bacchus.dhis.org>
X-Priority: 3 (Normal)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



>>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<

On 11/3/00, 6:53:26 PM, Ralf Baechle <ralf@oss.sgi.com> wrote regarding Re: 
Kernel compiler:


> On Sat, Nov 04, 2000 at 01:44:22PM +1100, Keith Owens wrote:

> > On Fri, 3 Nov 2000 22:19:26 +0100,
> > Ralf Baechle <ralf@oss.sgi.com> wrote:
> > >Due to compiler bugs with named initializers the use of egcs 1.1.2 has
> > >ben deprecated for Linux; Linux 2.4.0-test10 will refuse to compile with
> > >older compilers.
> >
> > Correction.  gcc 2.7 has been deprecated, the recommended version is
> > gcc 2.91.66 (also known as egcs 1.1.2) or better.  Unfortunately RedHat
> > created an unofficial 2.96 which is known to miscompile the kernel, so
> > you cannot just use the "latest" gcc.  It is believed that gcc versions
> > 2.91.66 through 2.95 inclusive are safe, as long as you use
> > -fno-strict-aliasing.

> Sigh, yes you're right as other have already pointed out on IRC ...

> Gcc 2.7 is no longer being used for Linux/MIPS since a long time and I'd
> simply bitbucket any bugreport related to it.  Most people are using egcs
> 1.0.3a for everything which is older than the required minimum version 
1.1.2,
> so we're in some trouble.

> I've got reports regarding the 1.1.2 crosscompiler which say that it
> misscompiles MIPS kernels, sigh ...

What are the symptoms of a "miscompiled" kernel and how does one detect 
that (assuming that the kernel actually compiles successfully, but has 
problems running).

Pete
