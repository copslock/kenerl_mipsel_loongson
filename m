Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2005 14:51:38 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:39429 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133453AbVLOOvR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Dec 2005 14:51:17 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jBFEpY7H003147;
	Thu, 15 Dec 2005 14:51:34 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jBFEpWRS003146;
	Thu, 15 Dec 2005 14:51:32 GMT
Date:	Thu, 15 Dec 2005 14:51:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shireesh Annam <annamshr@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.4.22 Kernel Build Error
Message-ID: <20051215145132.GA2812@linux-mips.org>
References: <9498e5c10512150449x625a7270s168d6a6339330e29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9498e5c10512150449x625a7270s168d6a6339330e29@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 15, 2005 at 06:19:44PM +0530, Shireesh Annam wrote:

> I have an new AMD (Au1500) Bosporous Board and I intend to install
> MIPS Kernel 2.4.22 (linux-14oct2003.tar.gz) provided on the AMD CD
> provided along with the kit. I have been through the
> www.linux-mips.org website.
> 
> I have installed the Linux/386 cross for big-endian target i.e. MIPS
> SDE 6.02.03 from ftp.mips.com on a Red Hat host.
> 
> After that when I try to build the kernel using the following command:
> $make ARCH=mips CROSS_COMPILE=mips-linux- zImage
> 
> I get the following error.
> 
> mips-linux-gcc -D__KERNEL__ -I/root/MipsLinux/oct2003/linux/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -fomit-frame-pointer -I
> /root/MipsLinux/oct2003/linux/include/asm/gcc -G 0 -mno-abicalls
> -fno-pic -pipe  -mabi=32 -mcpu=r4600 -mips2 -Wa,--trap  
> -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> cc1: error: invalid option `-mcpu=r4600'
> make: *** [init/main.o] Error 1
> 
> I have selected MIPS32 for the CPU Architecture and the toolchain
> doesn't seem to recognize the r4600 option.

You're trying to build a stoneage kernel with a much newer compiler -
SDE 6 uses gcc 3.4 - which doesn't work.  Use an older compiler such
as gcc <= 3.3.x.  SDE 5.x contains gcc 2.96 btw.

  Ralf
