Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 16:28:02 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7379 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20022234AbXEHP2B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 16:28:01 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l48FUB8a023313;
	Tue, 8 May 2007 16:30:11 +0100
Date:	Tue, 8 May 2007 16:30:10 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	sknauert@wesleyan.edu
Cc:	linux-mips@linux-mips.org
Subject: Re: PCI video card on SGI O2
Message-ID: <20070508163010.1d2dd724@the-village.bc.nu>
In-Reply-To: <55699.129.133.92.31.1178637383.squirrel@webmail.wesleyan.edu>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
	<20070508122700.262caec4@the-village.bc.nu>
	<55699.129.133.92.31.1178637383.squirrel@webmail.wesleyan.edu>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> I agree the Voodoo 1 should work. The issue here is that I can compile in
> tdfx character support for the kernel and still have it boot, but can't
> boot with tdfx framebuffer support on the O2 for some reason. With just
> character support lspci IDs the card
> 
> 00:03.0 PCI VGA compatible controller: ...

That isn't a Voodoo 1 if it reports PCI VGA compatible controller. What
PCI ident values does it show. Also the tdfx framebuffer is for the later
chips not the Voodoo1 or Voodoo2 - they use sstfb.

It looks like your card is something else - a Banshee or Rush perhaps ?
