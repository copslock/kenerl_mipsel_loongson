Received:  by oss.sgi.com id <S553913AbQKDDUf>;
	Fri, 3 Nov 2000 19:20:35 -0800
Received: from u-120.karlsruhe.ipdial.viaginterkom.de ([62.180.10.120]:15620
        "EHLO u-120.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553910AbQKDDUY>; Fri, 3 Nov 2000 19:20:24 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869106AbQKDDUC>;
        Sat, 4 Nov 2000 04:20:02 +0100
Date:   Sat, 4 Nov 2000 04:20:02 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Pete Popov <ppopov@pacbell.net>
Cc:     Keith Owens <kaos@melbourne.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Kernel compiler
Message-ID: <20001104042002.A29373@bacchus.dhis.org>
References: <20001103221926.A26082@bacchus.dhis.org> <5029.973305862@ocs3.ocs-net> <20001104035326.A29005@bacchus.dhis.org> <20001104.3105000@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001104.3105000@zeus.mvista.com>; from ppopov@pacbell.net on Sat, Nov 04, 2000 at 03:10:50AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Nov 04, 2000 at 03:10:50AM +0000, Pete Popov wrote:

> > Sigh, yes you're right as other have already pointed out on IRC ...
> 
> > Gcc 2.7 is no longer being used for Linux/MIPS since a long time and I'd
> > simply bitbucket any bugreport related to it.  Most people are using egcs
> > 1.0.3a for everything which is older than the required minimum version 
> 1.1.2,
> > so we're in some trouble.
> 
> > I've got reports regarding the 1.1.2 crosscompiler which say that it
> > misscompiles MIPS kernels, sigh ...
> 
> What are the symptoms of a "miscompiled" kernel and how does one detect 
> that (assuming that the kernel actually compiles successfully, but has 
> problems running).

When trying to work on a serial terminal hooked up to an Indy it'll oops.

Question is if the compiler is buggy or if it's particular code generation
is just triggering a bug in the kernel code.

  Ralf
