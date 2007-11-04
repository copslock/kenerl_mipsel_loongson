Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 09:11:12 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.20]:27831 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20027427AbXKDJLD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Nov 2007 09:11:03 +0000
Received: (qmail invoked by alias); 04 Nov 2007 09:10:58 -0000
Received: from unknown (EHLO localhost.localdomain) [86.56.7.149]
  by mail.gmx.net (mp024) with SMTP; 04 Nov 2007 10:10:58 +0100
X-Authenticated: #2913508
X-Provags-ID: V01U2FsdGVkX1+ZoKpoaY6ZGIeZ/Dh+B5X9SkxZYtMgmseHfulkfa
	Kwz9B3GNbdHQmK
Date:	Sun, 04 Nov 2007 10:10:57 +0100
To:	linux-mips@linux-mips.org
Subject: "Bad eraseblock"-problem with au1550nd-NAND-driver after kernel update to 2.6.23.1
From:	"Thorsten Schulz" <stehbrettsegeln@gmx.de>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <op.t09fsjv333s53m@localhost.localdomain>
User-Agent: Opera Mail/9.24 (Linux)
X-Y-GMX-Trusted: 0
Return-Path: <stehbrettsegeln@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stehbrettsegeln@gmx.de
Precedence: bulk
X-list: linux-mips

Hi,

I am fiddeling around with an Au1550-System (Lippert CoolMoteMaster).
After I updated the Kernel from 2.6.17.7 to 2.6.23.1 the flash driver complaints about Bad eraseblocks at kernel start:

[17179570.224000] NAND device: Manufacturer ID: 0x20, Chip ID: 0xda (ST Micro NAND 256MiB 3,3V 8-bit)
[17179570.232000] Scanning device for bad blocks
[17179570.236000] Bad eraseblock 0 at 0x00000000
[17179570.240000] Bad eraseblock 1 at 0x00020000
[17179570.248000] Bad eraseblock 2 at 0x00040000
[..]
[17179579.748000] Bad eraseblock 2046 at 0x0ffc0000
[17179579.752000] Bad eraseblock 2047 at 0x0ffe0000
[17179579.756000] Creating 1 MTD partitions on "NAND 256MiB 3,3V 8-bit":
[17179579.760000] 0x00000000-0x10000000 : "NAND FS 0"
[17179579.772000] au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
[..]
I get the same output from the .17.7. kernel apart from the 'Bad'-messages. The size seems correct, as I should get one 256MB-flash-device. I did use the patch from Lippert to set their platform data, which was intended for 2.6.17.7. With small changes it also succeeds on 2.6.23.1 but this doesn't mean that it's correct ;)
The 2.6.17.7 kernel still runs fine with that flash.

I am quite new to kernel hacking and after some cause searching I'm still lost. Were there any changes in the necessary configuration / platform setup that I am missing? Any ideas / hints what I can look for? Any common mistakes?

ciao,
Thorsten
