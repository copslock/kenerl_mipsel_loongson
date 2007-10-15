Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 18:45:09 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52132 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037154AbXJORpH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 18:45:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9FHj5S7019959;
	Mon, 15 Oct 2007 18:45:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9FHj5tX019958;
	Mon, 15 Oct 2007 18:45:05 +0100
Date:	Mon, 15 Oct 2007 18:45:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Adrian Bunk <bunk@kernel.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: -git mips defconfig compile error
Message-ID: <20071015174505.GA19857@linux-mips.org>
References: <20071014131948.GF4211@stusta.de> <20071015095535.GB9896@linux-mips.org> <Pine.LNX.4.64N.0710151715200.16262@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710151715200.16262@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 15, 2007 at 05:19:43PM +0100, Maciej W. Rozycki wrote:

> > The logo.c bit I've sent out a few weeks ago so I'm just waiting for that
> > patch to resurface at the other end of the wormhole.
> 
>  Hmm, I would have waited for this to happen before committing the change 
> depending on it not to keep things known-broken then...  That's what I do 
> with my bits, e.g. I have an update to platform code waiting till 
> sb1250-mac.c changes come over here.

Na, much more trivial.  After a little looking into what went wrong I
found that I meant to strip only the jazzsonic segment because of another
jazzsonic patch from Fleedwood.  But I stripped the logo.c bit as well.

  Ralf
