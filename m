Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 17:57:08 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27124 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225366AbTIKQ5I>;
	Thu, 11 Sep 2003 17:57:08 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA25688;
	Thu, 11 Sep 2003 09:57:03 -0700
Subject: Re: cache coherent io on au1500
From:	Pete Popov <ppopov@mvista.com>
To:	Bruno Randolf <bruno.randolf@4g-systems.biz>
Cc:	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <200309111605.13050.bruno.randolf@4g-systems.biz>
References: <200309111605.13050.bruno.randolf@4g-systems.biz>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1063299520.23653.3.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date:	11 Sep 2003 09:58:40 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


Take a look at ftp.linux-mips.org:/pub/linux/mips/people/ppopov.
There's a README there that describes patches that are not in the tree.
One of them is a tiny patch called coherent_cow.patch that fixes the
compilation problem below. Ralf was looking for a more permanent fix, so
he hasn't applied this patch.

Pete

On Thu, 2003-09-11 at 07:05, Bruno Randolf wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> hello!
> 
> i have an Au1500, silicon stepping AD (mtx-1 board) which as far as i 
> understand should be able to do cache coherent io. but if i change 
> CONFIG_NONCOHERENT_IO to "n" compilation of 2.4.21 fails with 
> 
> mipsel-linux-gcc -D__KERNEL__ -I/data/kernel/mtx-2.4.21/include -Wall 
> - -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> - -fomit-frame-pointer -I /data/kernel/mtx-2.4.21/include/asm/gcc -G 0 
> - -mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap   -nostdinc 
> - -iwithprefix include -DKBUILD_BASENAME=fork  -c -o fork.o fork.c
> In file included from fork.c:20:
> /data/kernel/mtx-2.4.21/include/linux/vmalloc.h: In function `vmalloc':
> /data/kernel/mtx-2.4.21/include/linux/vmalloc.h:36: `_CACHE_CACHABLE_COW' 
> undeclared (first use in this function)
> /data/kernel/mtx-2.4.21/include/linux/vmalloc.h:36: (Each undeclared 
> identifier is reported only once
> /data/kernel/mtx-2.4.21/include/linux/vmalloc.h:36: for each function it 
> appears in.)
> /data/kernel/mtx-2.4.21/include/linux/vmalloc.h: In function `vmalloc_dma':
> /data/kernel/mtx-2.4.21/include/linux/vmalloc.h:45: `_CACHE_CACHABLE_COW' 
> undeclared (first use in this function)
> /data/kernel/mtx-2.4.21/include/linux/vmalloc.h: In function `vmalloc_32':
> /data/kernel/mtx-2.4.21/include/linux/vmalloc.h:54: `_CACHE_CACHABLE_COW' 
> undeclared (first use in this function)
> make[2]: *** [fork.o] Error 1
> 
> how could i fix that?
> 
> thanks,
> bruno
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> 
> iD8DBQE/YIEZfg2jtUL97G4RAm0pAJ47FLT9fJaNWIqE0gHJ5zsPlZhPngCfY+AY
> ZOEDI2hvDJ/zbdk98TzCm9k=
> =FcHD
> -----END PGP SIGNATURE-----
> 
> 
> 
