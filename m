Received:  by oss.sgi.com id <S42242AbQGDVWq>;
	Tue, 4 Jul 2000 14:22:46 -0700
Received: from u-179.karlsruhe.ipdial.viaginterkom.de ([62.180.18.179]:19463
        "EHLO u-179.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42207AbQGDVW1>; Tue, 4 Jul 2000 14:22:27 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403794AbQGDVWQ>;
        Tue, 4 Jul 2000 23:22:16 +0200
Date:   Tue, 4 Jul 2000 23:22:16 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     Ulf Carlsson <ulfc@oss.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000704232215.B4977@bacchus.dhis.org>
References: <20000702193011Z42202-29274+369@oss.sgi.com> <XFMail.000704192753.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <XFMail.000704192753.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Tue, Jul 04, 2000 at 07:27:53PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 04, 2000 at 07:27:53PM +0200, Harald Koerfgen wrote:

> > Log message:
> >       We have to clobber ``hi'' and ``lo'' in __udelay.  Nasty bug.
> 
> Unfortunately my compilers don't like it.
> 
> mipsel-linux-gcc: egcs-2.90.29 980515 (egcs-1.0.3 release) (rpm from oss):
> 
> timer.c: In function `sys_nanosleep':
> timer.c:848: fixed or forbidden register was spilled.
> This may be due to a compiler bug or to impossible asm
> statements or clauses.

I've commited a fix for this.  It only tackles the __udelay() functions
for mips and mips64 but not the other multu instruction in the
DECstation HZ_TO_STD function.  Can you take a look at this one?

  Ralf
