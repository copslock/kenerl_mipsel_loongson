Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 18:10:12 +0200 (CEST)
Received: from cantor.suse.de ([195.135.220.2]:60646 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493262AbZIRQKG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Sep 2009 18:10:06 +0200
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id B2CFE8D893;
	Fri, 18 Sep 2009 18:10:03 +0200 (CEST)
Date:	Fri, 18 Sep 2009 09:07:37 -0700
From:	Greg KH <gregkh@suse.de>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	Wolfram Sang <w.sang@pengutronix.de>,
	linux-pcmcia@lists.infradead.org, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM63xx: Add PCMCIA & Cardbus support.
Message-ID: <20090918160737.GD22717@suse.de>
References: <1253272891.1627.284.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1253272891.1627.284.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Fri, Sep 18, 2009 at 01:21:31PM +0200, Maxime Bizon wrote:
> 
> Hi Wolfram & Greg,
> 
> It seems Dominik is busy, and you're the one acking pcmcia patch at the
> moment so I'm sending this to you.
> 
> 
> This is a pcmcia/cardbus driver for the bcm63xx mips SOCs, it was
> already posted twice:
> 
> last year: http://lists.infradead.org/pipermail/linux-pcmcia/2008-October/005942.html
> three months ago: http://lists.infradead.org/pipermail/linux-pcmcia/2009-July/006196.html
> 
> and got no review.
> 
> Could you please have a look at it ?

I'll trust Wolfram on these.  If he queues stuff up, I can get them to
Linus.

thanks,

greg k-h
