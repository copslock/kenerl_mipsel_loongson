Received:  by oss.sgi.com id <S553901AbQKDCyF>;
	Fri, 3 Nov 2000 18:54:05 -0800
Received: from u-120.karlsruhe.ipdial.viaginterkom.de ([62.180.10.120]:12036
        "EHLO u-120.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553896AbQKDCxt>; Fri, 3 Nov 2000 18:53:49 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869106AbQKDCx0>;
        Sat, 4 Nov 2000 03:53:26 +0100
Date:   Sat, 4 Nov 2000 03:53:26 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Kernel compiler
Message-ID: <20001104035326.A29005@bacchus.dhis.org>
References: <20001103221926.A26082@bacchus.dhis.org> <5029.973305862@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <5029.973305862@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Sat, Nov 04, 2000 at 01:44:22PM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Nov 04, 2000 at 01:44:22PM +1100, Keith Owens wrote:

> On Fri, 3 Nov 2000 22:19:26 +0100, 
> Ralf Baechle <ralf@oss.sgi.com> wrote:
> >Due to compiler bugs with named initializers the use of egcs 1.1.2 has
> >ben deprecated for Linux; Linux 2.4.0-test10 will refuse to compile with
> >older compilers.
> 
> Correction.  gcc 2.7 has been deprecated, the recommended version is
> gcc 2.91.66 (also known as egcs 1.1.2) or better.  Unfortunately RedHat
> created an unofficial 2.96 which is known to miscompile the kernel, so
> you cannot just use the "latest" gcc.  It is believed that gcc versions
> 2.91.66 through 2.95 inclusive are safe, as long as you use
> -fno-strict-aliasing.

Sigh, yes you're right as other have already pointed out on IRC ...

Gcc 2.7 is no longer being used for Linux/MIPS since a long time and I'd
simply bitbucket any bugreport related to it.  Most people are using egcs
1.0.3a for everything which is older than the required minimum version 1.1.2,
so we're in some trouble.

I've got reports regarding the 1.1.2 crosscompiler which say that it
misscompiles MIPS kernels, sigh ...

The reports regarding egcs 2.96 and newer misscompiling the kernel only
affect x86 or are other architecture affected as well?  I don't have any
pending compiler >= 2.96 related bug reports.

  Ralf
