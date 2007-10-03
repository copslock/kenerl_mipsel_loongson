Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 01:21:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62413 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024040AbXJCAVU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 01:21:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l930LIQA012991;
	Wed, 3 Oct 2007 01:21:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l930LIoR012990;
	Wed, 3 Oct 2007 01:21:18 +0100
Date:	Wed, 3 Oct 2007 01:21:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Fix a typo in an R4600 v2 erratum
	workaround
Message-ID: <20071003002118.GA12964@linux-mips.org>
References: <Pine.LNX.4.64N.0710021435200.32726@blysk.ds.pg.gda.pl> <20071003000425.GA11833@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071003000425.GA11833@linux-mips.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 03, 2007 at 01:04:25AM +0100, Ralf Baechle wrote:

> >  Restore a load from KSEG1 done as a workaround for an R4600 v2 
> > erratum, dropped with 211be16de99a7424e66c0b6c0d00e2c970508ac2.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> > ---
> > Thiemo,
> > 
> >  It reverts your change of Sep 1st, 2005; given the way the code is 
> > written, I am assuming the change was accidental, correct?  At the moment 
> > the load never happens.
> 
> But it should ...  So this seems to be the right thing, no?

Ah, I see.  So I applied your patch.

  Ralf
