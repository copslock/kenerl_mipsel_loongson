Received:  by oss.sgi.com id <S42424AbQJBMBp>;
	Mon, 2 Oct 2000 05:01:45 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:54231 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42232AbQJBMBI>;
	Mon, 2 Oct 2000 05:01:08 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA09519;
	Mon, 2 Oct 2000 13:59:03 +0200 (MET DST)
Date:   Mon, 2 Oct 2000 13:59:03 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
In-Reply-To: <20000930121823.A32244@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001002134626.6563H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 30 Sep 2000, Ralf Baechle wrote:

> >  Well, I asked for testing before the commit, but nobody bothered to write
> > anything, so I assumed everything is correct, sigh...
> 
> Not sigh ...  The lesson that not speaking up is a also wrong!

 Well, if nobody reports a problem with a patch, it means it's either fine
or nobody bothered to test it.  For me both cases mean it's OK to apply
it. 

> The ddiv usage outside of do_div / do_div64_32 is actually ok because

 But can't we receive an exception for some reason???

> interrupts are always disabled.  We don't have the same guarantee for
> do_div / do_div64_32 calls.

 Yep -- it's used for printk.

> Hmm...  We got two error scenarios left - bus errors and cache errors.  If
> we get one of those doomsday is near anyway ...  Anyway, these are rare,
> so we rather make these exception handlers pay the price.

 I'd see two approaches: either wipe 64-bit code out completely (clean and
elegant -- I'd vote for it, even though there is performance penalty) or
disable interrupts around the 64-bit division (the window would be small
and it would still be a performance win, but it's ugly as hell).  What do
you think? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
