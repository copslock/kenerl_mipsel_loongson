Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2009 13:54:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58280 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492249AbZGMLyf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Jul 2009 13:54:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6DBr9DK025708;
	Mon, 13 Jul 2009 12:53:10 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6DBr7aA025706;
	Mon, 13 Jul 2009 12:53:07 +0100
Date:	Mon, 13 Jul 2009 12:53:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix build failures on msp_irq_slp.c
Message-ID: <20090713115306.GA25606@linux-mips.org>
References: <200904271659.48357.florian@openwrt.org> <200904291512.19297.florian@openwrt.org> <b2b2f2320904290718pe9a28efy9a8af432887778cb@mail.gmail.com> <200906280701.32649.florian@openwrt.org> <b2b2f2320907110351o1473fc79xa3926b8af4ffc35@mail.gmail.com> <b2b2f2320907120934x6d6e4059ma318fe6236e45b19@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b2f2320907120934x6d6e4059ma318fe6236e45b19@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 12, 2009 at 10:34:45AM -0600, Shane McDonald wrote:

> >   My apologies for the delay in replying to your latest prompt -- I've been
> > on vacation with little internet access.
> >
> >   Your patch looks correct to me, but as Ralf says, the existing code is a
> > little suspect.  In my poking around, I've come across three different
> > versions of this file: the in-tree version, the latest out-of-tree patch
> > from PMC-Sierra, and an unreleased version from a colleague.  None appear to
> > be quite correct.  I think I've got enough info, though, to come up with a
> > good version.
> >
> >   I'll cook something up this weekend and get it posted.
> 
> 
> OK, I've done my cooking, and the cleanup patch will follow in a separate
> email.  It expects Florian's patch to have been applied.
> 
> Florian's patch is correct, so I'll add my:
> 
> Acked-by: Shane McDonald <mcdonald.shane@gmail.com>

Okay, applied.  Thanks!

  Ralf
