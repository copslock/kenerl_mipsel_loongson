Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Mar 2003 00:16:34 +0000 (GMT)
Received: from [IPv6:::ffff:195.101.176.125] ([IPv6:::ffff:195.101.176.125]:60043
	"EHLO magma.kin.home") by linux-mips.org with ESMTP
	id <S8225232AbTCPAQd>; Sun, 16 Mar 2003 00:16:33 +0000
Received: from rabuzou.kin.home ([172.20.0.98] helo=localhost)
	by magma.kin.home with smtp (Exim 3.35 #1 (Debian))
	id 18uLpA-0001mZ-00
	for <linux-mips@linux-mips.org>; Sun, 16 Mar 2003 01:16:24 +0100
Date: Sun, 16 Mar 2003 01:16:13 +0100
From: Arthur Petitpierre <arthur.petitpierre@gadz.org>
To: linux-mips@linux-mips.org
Subject: kernel compilation error on indy with r4600
Message-Id: <20030316011613.766aa81d.arthur.petitpierre@gadz.org>
Organization: KIN
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <arthur.petitpierre@gadz.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arthur.petitpierre@gadz.org
Precedence: bulk
X-list: linux-mips

	Hi,

I've got an Indy whith a r46000 cpu and a Debian installed on it, and when I try to compile a new kernel (with gcc-2.95),
I do 'make menuconfig', 'make dep' without any problem and when I try 'make vmlinux', I got error as following :

gcc -D__KERNEL__ -I/usr/src/kernel-source-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I /usr/src/kernel-source-2.4.19/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
as: unrecognized option `-mcpu=r4600'
init/main.c: In function `calibrate_delay':
init/main.c:199: Internal compiler error:
init/main.c:199: output pipe has been closed
make: *** [init/main.o] Error 1

Any solution to fix it. Thanks,
		Arthur
