Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 11:02:51 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49452 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022560AbZFCKCo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Jun 2009 11:02:44 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n53A2GcZ013772;
	Wed, 3 Jun 2009 11:02:16 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n53A2FUC013770;
	Wed, 3 Jun 2009 11:02:15 +0100
Date:	Wed, 3 Jun 2009 11:02:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Herbert Xu <herbert@gondor.apana.org.au>
Cc:	Matt Mackall <mpm@selenic.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver (v2)
Message-ID: <20090603100215.GA13250@linux-mips.org>
References: <1243954462-18149-1-git-send-email-anemo@mba.ocn.ne.jp> <1243973584.22069.182.camel@calx> <20090603090238.GH23561@linux-mips.org> <20090603092610.GA11258@gondor.apana.org.au> <20090603092927.GA11369@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090603092927.GA11369@gondor.apana.org.au>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 03, 2009 at 07:29:27PM +1000, Herbert Xu wrote:

> On Wed, Jun 03, 2009 at 07:26:10PM +1000, Herbert Xu wrote:
> > On Wed, Jun 03, 2009 at 10:02:38AM +0100, Ralf Baechle wrote:
> >
> > > Ok, I'll send this to Linus for 2.6.31 then.
> > 
> > Actually I've already added it to my tree since I'm looking after
> > the hwrng drivers.
>
> But if this causes any conflicts for you, then please let me know
> and I'll back it out.

Ah, I was looking at MAINTAINERS which said Mack who had acked it was
handling it.

There is no conflict on the drivers/char/hw_random/ part, so I'll drop
that one.  The platform part in arch/mips/ has to go through the MIPS
tree as it depends on another patch.

  Ralf
