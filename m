Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 12:52:18 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8224861AbTFQLwQ>; Tue, 17 Jun 2003 12:52:16 +0100
Date: Tue, 17 Jun 2003 12:52:16 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Juan Quintela <quintela@trasno.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
Message-ID: <20030617125216.E27590@ftp.linux-mips.org>
References: <867k7lsiq1.fsf@trasno.mitica> <Pine.GSO.3.96.1030617134319.22214A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030617134319.22214A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jun 17, 2003 at 01:47:08PM +0200
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 17, 2003 at 01:47:08PM +0200, Maciej W. Rozycki wrote:
> On Tue, 17 Jun 2003, Juan Quintela wrote:
> 
> > Anyways, you can use early_printk() in MIPS.  You only need to put the
> > setup of the early console sooner, as for you the setup is basically a NOP.
> 
>  Well, I would see early_printk() as advantageous if it was also capable
> to leave messages in the kernel ring buffer for dmesg or klogd to fetch. 

Ah, we probably don't understand each other. I should type EARLY_PRINTK
instead of early_printk (sorry for my lazyness, I'm usually typing in
lowercase). CONFIG_EARLY_PRINTK enables early console, you are supposed to
use printk everywhere and that way you achieve such functionality.

	ladis
