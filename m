Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2008 19:58:51 +0100 (BST)
Received: from [81.2.110.250] ([81.2.110.250]:12454 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S20162663AbYIVSr0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2008 19:47:26 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id m8MIlMOq011229;
	Mon, 22 Sep 2008 19:47:22 +0100
Date:	Mon, 22 Sep 2008 19:47:22 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
Message-ID: <20080922194722.11e9908e@lxorguk.ukuu.org.uk>
In-Reply-To: <20080923.001602.51867636.anemo@mba.ocn.ne.jp>
References: <48D51B48.2090400@ru.mvista.com>
	<20080922.235608.106262139.anemo@mba.ocn.ne.jp>
	<48D7B365.6070305@ru.mvista.com>
	<20080923.001602.51867636.anemo@mba.ocn.ne.jp>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; x86_64-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, 23 Sep 2008 00:16:02 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Mon, 22 Sep 2008 19:01:57 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > >>  BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?
> > 
> > > Yes, next plan.  It should be much simpler than the tx4939ide driver.
> > 
> >     I suspect {ide|pata}_platform could be able to cover it... though I got 
> > muddled in the timing diagrams for the TX4938 external bus...
> 
> We need .set_pio_mode routine to get best PIO speed, but current
> {ide|pata}_platform driver does not provide a hook for it (please
> correct me if I was wrong).  So current code I have does not use
> ide_platform...

You are correct. The platform driver is intended to be totally dumb. It's
not clear at what point having a specific driver is more sensible as a
libata driver is tiny anyway (especially with tejuns inherited ops stuff)
