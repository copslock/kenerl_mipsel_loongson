Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 15:05:16 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:39141
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225370AbTIKOFQ> convert rfc822-to-8bit; Thu, 11 Sep 2003 15:05:16 +0100
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 19xS4Q-0001to-00
	for linux-mips@linux-mips.org; Thu, 11 Sep 2003 16:05:14 +0200
Received: from [80.129.137.45] (helo=192.168.1.21)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 19xS4Q-0000SI-00
	for linux-mips@linux-mips.org; Thu, 11 Sep 2003 16:05:14 +0200
From:	Bruno Randolf <bruno.randolf@4g-systems.biz>
Organization: 4G Mobile Systeme
To:	linux-mips@linux-mips.org
Subject: cache coherent io on au1500
Date:	Thu, 11 Sep 2003 16:05:12 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309111605.13050.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello!

i have an Au1500, silicon stepping AD (mtx-1 board) which as far as i 
understand should be able to do cache coherent io. but if i change 
CONFIG_NONCOHERENT_IO to "n" compilation of 2.4.21 fails with 

mipsel-linux-gcc -D__KERNEL__ -I/data/kernel/mtx-2.4.21/include -Wall 
- -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
- -fomit-frame-pointer -I /data/kernel/mtx-2.4.21/include/asm/gcc -G 0 
- -mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap   -nostdinc 
- -iwithprefix include -DKBUILD_BASENAME=fork  -c -o fork.o fork.c
In file included from fork.c:20:
/data/kernel/mtx-2.4.21/include/linux/vmalloc.h: In function `vmalloc':
/data/kernel/mtx-2.4.21/include/linux/vmalloc.h:36: `_CACHE_CACHABLE_COW' 
undeclared (first use in this function)
/data/kernel/mtx-2.4.21/include/linux/vmalloc.h:36: (Each undeclared 
identifier is reported only once
/data/kernel/mtx-2.4.21/include/linux/vmalloc.h:36: for each function it 
appears in.)
/data/kernel/mtx-2.4.21/include/linux/vmalloc.h: In function `vmalloc_dma':
/data/kernel/mtx-2.4.21/include/linux/vmalloc.h:45: `_CACHE_CACHABLE_COW' 
undeclared (first use in this function)
/data/kernel/mtx-2.4.21/include/linux/vmalloc.h: In function `vmalloc_32':
/data/kernel/mtx-2.4.21/include/linux/vmalloc.h:54: `_CACHE_CACHABLE_COW' 
undeclared (first use in this function)
make[2]: *** [fork.o] Error 1

how could i fix that?

thanks,
bruno
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/YIEZfg2jtUL97G4RAm0pAJ47FLT9fJaNWIqE0gHJ5zsPlZhPngCfY+AY
ZOEDI2hvDJ/zbdk98TzCm9k=
=FcHD
-----END PGP SIGNATURE-----
