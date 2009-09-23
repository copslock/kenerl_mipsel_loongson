Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 11:34:23 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35025 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493031AbZIWJeP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Sep 2009 11:34:15 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8N9ZT56006615;
	Wed, 23 Sep 2009 10:35:29 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8N9ZTnU006612;
	Wed, 23 Sep 2009 10:35:29 +0100
Date:	Wed, 23 Sep 2009 10:35:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	Maxime Bizon <mbizon@freebox.fr>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
	linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
Message-ID: <20090923093529.GF5457@linux-mips.org>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net> <20090919154755.GA27704@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090919154755.GA27704@pengutronix.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 19, 2009 at 05:47:55PM +0200, Wolfram Sang wrote:

> On Fri, Sep 18, 2009 at 01:21:31PM +0200, Maxime Bizon wrote:
> 
> > It seems Dominik is busy, and you're the one acking pcmcia patch at the
> > moment so I'm sending this to you.
> 
> I can't make it for 2.6.32, but will try to get it queued for 2.6.33. What
> about the second FIXME in the driver BTW?

If you're otherwise ok with the patch can handle feeding things upstream to
Linux.  Without PCMCIA / Cardbus support the value of the BCM63xx in
the upstream kernel is limited for another few months and there is no
point in being so cautious with this patch as it doesn't touch an other
files.

  Ralf
