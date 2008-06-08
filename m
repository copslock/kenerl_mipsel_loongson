Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jun 2008 23:13:46 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:27641 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20027182AbYFHWNo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Jun 2008 23:13:44 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m58MDa9d022937;
	Mon, 9 Jun 2008 00:13:36 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m58MDN0g022933;
	Sun, 8 Jun 2008 23:13:32 +0100
Date:	Sun, 8 Jun 2008 23:13:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Luke -Jr <luke@dashjr.org>
cc:	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: bcm33xx port
In-Reply-To: <200806081527.31221.luke@dashjr.org>
Message-ID: <Pine.LNX.4.55.0806082249330.15673@cliff.in.clinika.pl>
References: <200806072113.26433.luke@dashjr.org> <200806081357.02601.luke@dashjr.org>
 <Pine.LNX.4.55.0806082041150.15673@cliff.in.clinika.pl> <200806081527.31221.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 8 Jun 2008, Luke -Jr wrote:

> Is merging with mainline something I can help with, being a beginner in this 
> area generally and not having any part in writing them?

 Well, you can certainly serve as a messenger telling them if they want
people to get proper support from upstream maintainers they better merge
sooner rather than later.  Otherwise it is them who should really be
bothered with cases like yours.

 The general principle is: "merge as soon as you can, even if code is
incomplete" as you get more attention and perhaps developers involved as a
result, some free support (e.g. with bulk changes done automatically to
all the relevant bits in the tree) and avoid duplicated work; also when at
the time of the merge you are told to rewrite your code differently.

> >  Not exactly.  Try harder -- this is simple arithmetic and you've got all
> > the data given above already. :)
> 
> 200 / 2? I'm not really sure what a 'jiffy' is..

 Hmm, I have thought it can be inferred from the code involved or failing
that -- Google...  Well, anyway, a jiffy is a tick of the kernel timer or,
specifically in this context and to be more precise, the interval between
such two consecutive ticks or, in other words, 1/HZ.

> >  I have seen that already and wrote these stores in __bzero are protected.
> > Perhaps the fixup fails for some reason, but you need to investigate it
> > and this is why I suggested to see how the RI handler is reached.  Since
> > this is a known point the failure leads to, you should be able to work
> > backwards from there quite easily.
> 
> Ah, so what you're saying is that perhaps the 'sw' is triggering a TLB 
> exception, and the handler for *that* is causing the RI problem?

 This is almost certain what happens here.  The pointer involved is a
valid (user) address and is correctly aligned, so you cannot get an
address error exception.  A TLB exception is next on the list to check.

 Of course you cannot rule out I-cache corruption or suchlike, but if I
were you, I would start with simple assumptions first.

  Maciej
