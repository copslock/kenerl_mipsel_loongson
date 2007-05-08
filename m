Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 07:27:44 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:49840 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20021567AbXEHG1l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 07:27:41 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l486OQiQ031655
	for <linux-mips@linux-mips.org>; Tue, 8 May 2007 02:24:30 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l486OKs2022752;
	Tue, 8 May 2007 02:24:20 -0400
Received: from 129.133.142.66
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 8 May 2007 02:24:20 -0400 (EDT)
Message-ID: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
Date:	Tue, 8 May 2007 02:24:20 -0400 (EDT)
Subject: PCI video card on SGI O2
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.192
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

I'm trying to get a PCI video card to work on my O2, currently running
Debian Etch (2.6.18). I first thought this was an X.org issue and posted
to their mailing list, and was told that Linux-MIPS might lack some
necessary support (mainly Legacy PCI Adressing), so I thought I'd roll up
my sleves and try to port this. Sadly, I ran into vast amounts of trouble.
I sent a couple e-mails to developers asking for some help but got little
response. So I thought I would try the main mailing list.

My main issues are:

1) Getting a newer kernel to boot on the O2. The 2.6.20 source I get off
of linux-mips.org will not boot. I used the same .config and gcc-4.1 as my
working 2.6.18.

2) Is legacy addressing even the issue? Compiling in generic VGA
framebuffer (or card specific framebuffer support) causes the kernel not
to boot. I can give the error from ARCs if desired. Is the issue in the O2
framebuffer code? Is this a limitation of the O2?

3) I tried a Voodoo 1, ATI Mach 64, S3 Virge DX, GX, etc., I actually have
a Millenium I but it won't fit in the O2. I mention these since they were
listed here http://www.linux-mips.org/wiki/PCI_graphics_cards as
potentially working. I'm assuming I need more kernel support?
Surprisingly, the character device drivers will compile and boot, and
lspci and other tools will recognize the card as a VGA device. I just
can't get a console or X to use them.

4) The only Linux port with working legacy addressing is ia64, which uses
seemly very different PCI structures than MIPS. Any good documentation on
this?

Thanks in advance for any help.
