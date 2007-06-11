Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 14:37:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:18120 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024010AbXFKNhj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Jun 2007 14:37:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5BDZQqF009055;
	Mon, 11 Jun 2007 14:35:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5BDZK49009042;
	Mon, 11 Jun 2007 14:35:20 +0100
Date:	Mon, 11 Jun 2007 14:35:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] Remove MIPS SEAD support
Message-ID: <20070611133520.GB6824@linux-mips.org>
References: <11815673353523-git-send-email-fbuihuu@gmail.com> <11815673362011-git-send-email-fbuihuu@gmail.com> <Pine.LNX.4.64N.0706111425110.6714@blysk.ds.pg.gda.pl> <007b01c7ac2c$caa073c0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007b01c7ac2c$caa073c0$10eca8c0@grendel>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 11, 2007 at 03:31:16PM +0200, Kevin D. Kissell wrote:

> > > Mips Sead support is deprecated and scheduled for removal
> > > since September 2006.
> > 
> >  Oh, is it?  The last time I tried it worked.  Have you tried it and 
> > failed to build?  That should be easy to fix.
> 
> There aren't that many SEAD users out there, but then again, no
> replacement platform for SEAD has been announced, so I'm not 
> wildly enthusiastic about deleting support for it, if it still works.

It's relativly trivial to keep alive - like all the others in this
series.  Actuall the Atlas is probably the most problematic due to its
heart, the amazingly broken SAA9730 which I think I've also never seen
docs beyond a useless leaflet for.

  Ralf
