Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 22:42:01 +0100 (BST)
Received: from mail.onstor.com ([66.201.51.107]:32944 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20022088AbXJIVla (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Oct 2007 22:41:30 +0100
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 Oct 2007 14:41:02 -0700
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 Oct 2007 14:41:01 -0700
Date:	Tue, 9 Oct 2007 14:41:01 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: paging problem with ide-cs driver
Message-ID: <20071009144101.511d4370@ripper.onstor.net>
In-Reply-To: <20071009220530.0416792b@the-village.bc.nu>
References: <20071009132657.64ec9158@ripper.onstor.net>
	<20071009220530.0416792b@the-village.bc.nu>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2007 21:41:01.0874 (UTC) FILETIME=[16447120:01C80ABD]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Tue, 9 Oct 2007 22:05:30 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote:

> > Before I dive into this, does any of this ring a bell for anyone?
> > I'm using the ide-cs driver, TI yenta cardbus adapter driver, and
> > sibyte everything else.
> 
> That has cache coherency painted all over it in bright flashing
> letters.
> 
> Can you build and try the libata drivers and the libata pata_pcmcia
> driver. The two are essentially the same at the hardware management
> level but go up via different stacks which should give clues
> depending on how/if the libata one fails in comparison.
> 

OK, went and tried that, same results.

a
