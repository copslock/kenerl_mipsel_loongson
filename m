Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 15:14:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5601 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20038825AbYGNOOe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 15:14:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6EEEfaL031386;
	Mon, 14 Jul 2008 15:14:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6EEEfqN031385;
	Mon, 14 Jul 2008 15:14:41 +0100
Date:	Mon, 14 Jul 2008 15:14:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mips_machtype from ARC based machines
Message-ID: <20080714141441.GD5963@linux-mips.org>
References: <20080714131140.6B5E0DE7BA@solo.franken.de> <20080714133447.GA5963@linux-mips.org> <20080714140539.GA28056@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080714140539.GA28056@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 14, 2008 at 04:05:39PM +0200, Thomas Bogendoerfer wrote:

> On Mon, Jul 14, 2008 at 02:34:47PM +0100, Ralf Baechle wrote:
> > It may be a little academic at this stage but the Acer PICA has no EISA
> > but just ISA slots.
> 
> I knew there one JAZZ maschine with ISA only, but I believe it doesn't
> make much difference without a register EISA root bus. So we could
> also kill it completly and I'll add it, if the EISA bits are sorted.

No big deal - right now we don't *really* support the Acer anymore anyway.
Guess I need to try to find out what happened to mine which I loaned
ages ago to somebody for hacking but nothing ever happened ...

  Ralf
