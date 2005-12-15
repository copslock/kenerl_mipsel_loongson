Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2005 12:49:29 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.204]:32026 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133369AbVLOMtK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Dec 2005 12:49:10 +0000
Received: by xproxy.gmail.com with SMTP id s18so271819wxc
        for <linux-mips@linux-mips.org>; Thu, 15 Dec 2005 04:49:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DI/HhQXri/5Zq02txvTyUvVTq2IMWsgZ18rR5RB3iXWHMJk5NPdSuhBqDrwyh4rjMMRrXvYvMg3q1uxL8xECpp6uIOdlFTe0XIwBaEF9QrLLwWrRkQBmoH2LxXBsyANoSjBlFNF4Xm95Ogyto+aZ9vePVwk7FDB9mo/5u5zm/Oo=
Received: by 10.70.15.6 with SMTP id 6mr2624884wxo;
        Thu, 15 Dec 2005 04:49:44 -0800 (PST)
Received: by 10.70.26.3 with HTTP; Thu, 15 Dec 2005 04:49:44 -0800 (PST)
Message-ID: <9498e5c10512150449x625a7270s168d6a6339330e29@mail.gmail.com>
Date:	Thu, 15 Dec 2005 18:19:44 +0530
From:	Shireesh Annam <annamshr@gmail.com>
To:	linux-mips@linux-mips.org
Subject: 2.4.22 Kernel Build Error
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <annamshr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: annamshr@gmail.com
Precedence: bulk
X-list: linux-mips

Hi:

I have an new AMD (Au1500) Bosporous Board and I intend to install
MIPS Kernel 2.4.22 (linux-14oct2003.tar.gz) provided on the AMD CD
provided along with the kit. I have been through the
www.linux-mips.org website.

I have installed the Linux/386 cross for big-endian target i.e. MIPS
SDE 6.02.03 from ftp.mips.com on a Red Hat host.

After that when I try to build the kernel using the following command:
$make ARCH=mips CROSS_COMPILE=mips-linux- zImage

I get the following error.

mips-linux-gcc -D__KERNEL__ -I/root/MipsLinux/oct2003/linux/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -I
/root/MipsLinux/oct2003/linux/include/asm/gcc -G 0 -mno-abicalls
-fno-pic -pipe  -mabi=32 -mcpu=r4600 -mips2 -Wa,--trap  
-DKBUILD_BASENAME=main -c -o init/main.o init/main.c
cc1: error: invalid option `-mcpu=r4600'
make: *** [init/main.o] Error 1

I have selected MIPS32 for the CPU Architecture and the toolchain
doesn't seem to recognize the r4600 option.

Could someone throw any light on this? I'm not able to move ahead
since I'm not able to build the kernel itself. Could someone help me
in recommending the right toolchain for this build?

Thanks,
Shireesh
