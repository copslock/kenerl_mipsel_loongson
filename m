Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 22:00:37 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18395 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20022016AbXJIVA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 22:00:28 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.14.1/8.13.8) with ESMTP id l99L5Uew018056;
	Tue, 9 Oct 2007 22:05:31 +0100
Date:	Tue, 9 Oct 2007 22:05:30 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: paging problem with ide-cs driver
Message-ID: <20071009220530.0416792b@the-village.bc.nu>
In-Reply-To: <20071009132657.64ec9158@ripper.onstor.net>
References: <20071009132657.64ec9158@ripper.onstor.net>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.10.14; i386-redhat-linux-gnu)
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
X-archive-position: 16919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> Before I dive into this, does any of this ring a bell for anyone?
> I'm using the ide-cs driver, TI yenta cardbus adapter driver, and sibyte
> everything else.

That has cache coherency painted all over it in bright flashing letters.

Can you build and try the libata drivers and the libata pata_pcmcia
driver. The two are essentially the same at the hardware management level
but go up via different stacks which should give clues depending on
how/if the libata one fails in comparison.
