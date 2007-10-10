Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 04:40:05 +0100 (BST)
Received: from post1.wesleyan.edu ([129.133.6.131]:30886 "EHLO
	post1.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20021700AbXJJDjz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 04:39:55 +0100
Received: from webmail.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier1.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l9A3dk4E013524
	for <linux-mips@linux-mips.org>; Tue, 9 Oct 2007 23:39:46 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 9 Oct 2007 23:39:46 -0400 (EDT)
Message-ID: <33485.129.133.92.31.1191987586.squirrel@webmail.wesleyan.edu>
Date:	Tue, 9 Oct 2007 23:39:46 -0400 (EDT)
Subject: PCI video on SGI O2
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.10a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

Okay, sorry to bring this up yet again, but I recently found out the PCI
legacy offset for the O2 was 0x8000000 and so I tried my original patch as
posted here: 
http://www.linux-mips.org/archives/linux-mips/2007-06/msg00164.html
again with the proper offset. Atsushi had made some suggestions (you can
browse the thread), but when I tried them the /sysfs files no longer
appeared. Sadly, I don't know why, his comments seemed reasonable.

Anyway... I got some results, X.org seemed to see the video card, its ROM,
and some registers. I still can't get it initialized, but maybe someone
here might be able to tell if this is a kernel or X.org/ Int10 problem.

I do understand that in theory /dev/mem does provides enough access to
POST the card but X.org doesn't seem to use that API, while it does use
the sysfs one. Thus, if there is an easy way to get X on Linux MIPS by
just adding a kernel API that exists on other platforms, it seems like
something reasonable to try.

Here is the relevant part of my Xorg.0.log:

[(II) ATI:  Candidate "Device" section "Generic Video Card".
(--) Chipset ATI Radeon 7500 QW (AGP/PCI) found
(II) resource ranges after xf86ClaimFixedResources() call:
        [0] -1  0       0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
        [1] -1  0       0x000f0000 - 0x000fffff (0x10000) MX[B]
        [2] -1  0       0x000c0000 - 0x000effff (0x30000) MX[B]
        [3] -1  0       0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [4] -1  0       0x0000ffff - 0x0000ffff (0x1) IX[B]
        [5] -1  0       0x00000000 - 0x000000ff (0x100) IX[B]
        [6] -1  0       0x00001400 - 0x000014ff (0x100) IX[B]
        [7] -1  0       0x00001000 - 0x000010ff (0x100) IX[B]
        [8] -1  0       0x00001800 - 0x000018ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Loading /usr/lib/xorg/modules/drivers/radeon_drv.so
(II) Module radeon: vendor="X.Org Foundation"
        compiled for 7.1.1, module version = 4.2.0
        Module class: X.Org Video Driver
        ABI class: X.Org Video Driver, version 1.0
(EE) end of block range 0xfef < begin 0xfffffff0
(EE) end of block range 0xfef < begin 0xfffffff0
(EE) end of block range 0xffef < begin 0xfffffff0
(EE) end of block range 0x7ffffef < begin 0xfffffff0
(EE) end of block range 0xffef < begin 0xfffffff0
(EE) end of block range 0xffef < begin 0xfffffff0
(II) resource ranges after probing:
        [0] -1  0       0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
        [1] -1  0       0x000f0000 - 0x000fffff (0x10000) MX[B]
        [2] -1  0       0x000c0000 - 0x000effff (0x30000) MX[B]
        [3] -1  0       0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [4] 0   0       0x000a0000 - 0x000affff (0x10000) MS[B]
        [5] 0   0       0x000b0000 - 0x000b7fff (0x8000) MS[B]
        [6] 0   0       0x000b8000 - 0x000bffff (0x8000) MS[B]
        [7] -1  0       0x0000ffff - 0x0000ffff (0x1) IX[B]
        [8] -1  0       0x00000000 - 0x000000ff (0x100) IX[B]
        [9] -1  0       0x00001400 - 0x000014ff (0x100) IX[B]
        [10] -1 0       0x00001000 - 0x000010ff (0x100) IX[B]
        [11] -1 0       0x00001800 - 0x000018ff (0x100) IX[B](B)
        [12] 0  0       0x000003b0 - 0x000003bb (0xc) IS[B]
        [13] 0  0       0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(**) RADEON(0): RADEONPreInit
(II) RADEON(0): MMIO registers at 0x88040000: size 64KB

Fatal server error:
xf86MapVidMem: Could not mmap framebuffer (0xfffffff0,0x10000) (Value too
large for defined data type)

Any comments or suggestions would be helpful.
Thanks in advance,
- Scott
