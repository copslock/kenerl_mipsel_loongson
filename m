Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2004 16:04:56 +0100 (BST)
Received: from pD956226F.dip.t-dialin.net ([IPv6:::ffff:217.86.34.111]:26214
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224942AbUJZPEv>; Tue, 26 Oct 2004 16:04:51 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9QF4lTF030758;
	Tue, 26 Oct 2004 17:04:47 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9QF4Xcb030757;
	Tue, 26 Oct 2004 17:04:33 +0200
Date: Tue, 26 Oct 2004 17:04:33 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Narendra Kulkarni <narendra@econtek.com>
Cc: "'Narendra Kulkarni'" <narendra@spacomp.com>,
	linux-mips@linux-mips.org
Subject: Re: errors while  insmoding usb-skeleton.o (changed to suit our requirements)
Message-ID: <20041026150433.GA30620@linux-mips.org>
References: <000b01c4bb6a$f87b1580$0e00a8c0@narendra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c4bb6a$f87b1580$0e00a8c0@narendra>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2004 at 08:19:14PM +0530, Narendra Kulkarni wrote:

> I am building a module usb-skeleton.o with following compiler options (The
> complier options are same as the options of used for building kernel)
> 
> /opt/brcm/hndtools-mipsel-linux-3.2.3/bin/mipsel-linux-gcc -D__KERNEL__  -I/
> usr/src/mipslinux/src/linux/linux/include -Wall -Wstrict-prototypes -Wno-tri
> graphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/src/
> mipslinux/src/linux/linux/../../include -I/usr/src/mipslinux/src/linux/linux
> /include/asm/gcc -G
>  -mno-abicalls -fno-pic -pipe -mips2  -mlong-calls  -nostdinc -iwithprefix
> include -DKBUILD_BASENAME=usb-skeleton  -c -o usb-skeleton.o usb-skeleton.c
> 
>  When insmoding the usb-skeleton.o,  insmod usb-skeleton.o
> I am getting the following erros
>  Using usb-skeleton.o
>  insmod: Relocation overflow of type 4 for __copy_user
>  insmod: Relocation overflow of type 4 for __copy_user
>  insmod: Relocation overflow of type 4 for __copy_user
> 
> Where am i going wrong.  Help would be appreciated.

Seems your compiler command line is missing -DMODULE.

  Ralf
