Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Feb 2003 03:06:44 +0000 (GMT)
Received: from web40804.mail.yahoo.com ([IPv6:::ffff:66.218.78.181]:4487 "HELO
	web40804.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225236AbTBZDGo>; Wed, 26 Feb 2003 03:06:44 +0000
Message-ID: <20030226030636.95154.qmail@web40804.mail.yahoo.com>
Received: from [67.29.236.2] by web40804.mail.yahoo.com via HTTP; Tue, 25 Feb 2003 19:06:36 PST
Date: Tue, 25 Feb 2003 19:06:36 -0800 (PST)
From: Jiahan Chen <jiahanchen@yahoo.com>
Subject: CVS Usage and Kernel Build
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.4.21.0302251805071.15407-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jiahanchen@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiahanchen@yahoo.com
Precedence: bulk
X-list: linux-mips


> > 
> > Where and how can I get CVS source tree to build customized 
> > Linux kernel for Mips?
> 
> http://www.google.com/search?q=Linux+MIPS+CVS
> 
> Gr{oetje,eeting}s,
>

From Mips web-site, I read:
 
cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs login
(Only needed the first time you use anonymous CVS, the password is "cvs")
cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co <repository>

I have a few questions:
1. There should be a client "cvs" in my linux PC, then to use 
   above command to get CVS source files INDIVIDUALLY?
2. After get everything from ftp site as above, do we use
   the similar procedure to re-build linux kernel for MIPS, such as
   make config; make dep; make vmlinux
3. Does this source tree support R3000 (CPU) and USB?
4. In order to add a new USB device driver, do I need update
   drivers/usb/Config.In and drivers/usb/Makefile manully?

Currently, I am in the initial phase for development, the Network
card is not available and Winmoden doesn't work with Linux,
so I have no ftp connection from my Linux box to get
CVS. In this case, is there any alternative to get CVS source
tree?

Thanks,

Jiahan

 


__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
