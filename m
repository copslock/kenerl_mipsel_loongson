Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 12:22:53 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2998 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20022083AbXEHLWv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 12:22:51 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l48BR07K022693;
	Tue, 8 May 2007 12:27:00 +0100
Date:	Tue, 8 May 2007 12:27:00 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	sknauert@wesleyan.edu
Cc:	linux-mips@linux-mips.org
Subject: Re: PCI video card on SGI O2
Message-ID: <20070508122700.262caec4@the-village.bc.nu>
In-Reply-To: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> 3) I tried a Voodoo 1, ATI Mach 64, S3 Virge DX, GX, etc., I actually have
> a Millenium I but it won't fit in the O2. I mention these since they were
> listed here http://www.linux-mips.org/wiki/PCI_graphics_cards as
> potentially working. I'm assuming I need more kernel support?
> Surprisingly, the character device drivers will compile and boot, and
> lspci and other tools will recognize the card as a VGA device. I just
> can't get a console or X to use them.

The voodoo1 and voodoo2 should work - they are not VGA devices and don't
have any compatibility vga gunk on them at all. You will need the voodoo
frame buffer and/or X server driver, neither of which needs BIOS support.
There is no 3D support on them as I could never be bothered to write the
3D engine bootstrap code.

Alan
