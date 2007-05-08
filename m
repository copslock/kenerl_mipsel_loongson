Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 16:19:43 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:39380 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022229AbXEHPTk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 May 2007 16:19:40 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l48FGOtI002450
	for <linux-mips@linux-mips.org>; Tue, 8 May 2007 11:16:24 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l48FGNac028599;
	Tue, 8 May 2007 11:16:23 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 8 May 2007 11:16:23 -0400 (EDT)
Message-ID: <55699.129.133.92.31.1178637383.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070508122700.262caec4@the-village.bc.nu>
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu>
    <20070508122700.262caec4@the-village.bc.nu>
Date:	Tue, 8 May 2007 11:16:23 -0400 (EDT)
Subject: Re: PCI video card on SGI O2
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
X-archive-position: 14994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

>> 3) I tried a Voodoo 1, ATI Mach 64, S3 Virge DX, GX, etc., I actually
>> have
>> a Millenium I but it won't fit in the O2. I mention these since they
>> were
>> listed here http://www.linux-mips.org/wiki/PCI_graphics_cards as
>> potentially working. I'm assuming I need more kernel support?
>> Surprisingly, the character device drivers will compile and boot, and
>> lspci and other tools will recognize the card as a VGA device. I just
>> can't get a console or X to use them.
>
> The voodoo1 and voodoo2 should work - they are not VGA devices and don't
> have any compatibility vga gunk on them at all. You will need the voodoo
> frame buffer and/or X server driver, neither of which needs BIOS support.
> There is no 3D support on them as I could never be bothered to write the
> 3D engine bootstrap code.
>
> Alan
>
>
I agree the Voodoo 1 should work. The issue here is that I can compile in
tdfx character support for the kernel and still have it boot, but can't
boot with tdfx framebuffer support on the O2 for some reason. With just
character support lspci IDs the card

00:03.0 PCI VGA compatible controller: ...

However, trying to start X.org gives the following errors:

(EE) TDFX(0): V_BIOS address 0x0 out of range
(EE) end of block range 0x1ffffef < begin 0xfffffff0
(EE) end of block range 0xfef < begin 0xffffff0
