Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2005 16:45:05 +0100 (BST)
Received: from ms-smtp-01-smtplb.ohiordc.rr.com ([IPv6:::ffff:65.24.5.135]:41196
	"EHLO ms-smtp-01-eri0.ohiordc.rr.com") by linux-mips.org with ESMTP
	id <S8225297AbVE1Pos>; Sat, 28 May 2005 16:44:48 +0100
Received: from [192.168.0.3] (cpe-65-24-168-255.columbus.res.rr.com [65.24.168.255])
	by ms-smtp-01-eri0.ohiordc.rr.com (8.12.10/8.12.7) with ESMTP id j4SFicWY027441;
	Sat, 28 May 2005 11:44:38 -0400 (EDT)
Subject: Re: Porting To New System
From:	Cameron Cooper <developer@phatlinux.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
In-Reply-To: <1117237244.5744.284.camel@localhost.localdomain>
References: <Pine.GSO.4.10.10505271929510.25076-100000@helios.et.put.poznan.pl>
	 <1117217584.5743.229.camel@localhost.localdomain>
	 <1117223539.2921.15.camel@phatbox>
	 <1117237244.5744.284.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Sat, 28 May 2005 11:43:03 -0400
Message-Id: <1117294983.2800.12.camel@phatbox>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <developer@phatlinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: developer@phatlinux.com
Precedence: bulk
X-list: linux-mips

> The 2.6 kernel has uclinux merged but that doesn't include MMUless
> support at the moment. The 2.4 uclinux tree is seperate and Xiptech
> released a set of patches for 2.4.19 for the mmuless mips and for the
> ucLibc if the cpu lacks mipsII and FPU instructions.

It looks like Xiptech only did a port for R3K, which is no good for me.
The issue that I'm running into right now is in
arch/mipsnommu/mm/c-r4k.c

I guess the problem is that it is trying to use things which belong to
the MM code, which are not included from mm.h becuase NO_MM is set.
c-r3k.c was rewritten for NO_MM, but not c-r4k.c. I looked into
rewriting c-r4k.c by taking ideas from c-r3k.c but unfortunatly they are
not similar enough, and I'm afraid I'm not even sure what this file
does. Can you help me understand what this file does, and what I might
do to rewrite it for NO_MM?

Below I've included my compile errors.

Thanks,
Cameron


mipsel-uclibc-gcc -D__KERNEL__
-I/home/cameron/kernel/linux-2.4.19/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-DNO_MM -I /home/cameron/kernel/linux-2.4.19/include/asm/gcc -G 0
-mno-abicalls -fno-pic -pipe -mcpu=r4300 -mips2 -Wa,--trap   -nostdinc
-I /opt/toolchain/lib/gcc-lib/mipsel-linux/3.2/include
-DKBUILD_BASENAME=c_r4k  -c -o c-r4k.o c-r4k.c
c-r4k.c: In function `r4k_flush_cache_range_s16d16i16':
c-r4k.c:130: structure has no member named `context'
c-r4k.c:137: warning: implicit declaration of function `find_vma'
c-r4k.c:137: warning: assignment makes pointer from integer without a
cast
c-r4k.c:139: structure has no member named `context'
c-r4k.c:139: structure has no member named `context'
c-r4k.c:147: warning: assignment makes pointer from integer without a
cast
c-r4k.c: In function `r4k_flush_cache_range_s32d16i16':
c-r4k.c:166: structure has no member named `context'
c-r4k.c:173: warning: assignment makes pointer from integer without a
cast
c-r4k.c:175: structure has no member named `context'
c-r4k.c:175: structure has no member named `context'
c-r4k.c:183: warning: assignment makes pointer from integer without a
cast
c-r4k.c: In function `r4k_flush_cache_range_s64d16i16':
c-r4k.c:201: structure has no member named `context'
c-r4k.c:208: warning: assignment makes pointer from integer without a
cast
c-r4k.c:210: structure has no member named `context'
c-r4k.c:210: structure has no member named `context'
c-r4k.c:218: warning: assignment makes pointer from integer without a
cast
c-r4k.c: In function `r4k_flush_cache_range_s128d16i16':
c-r4k.c:236: structure has no member named `context'
c-r4k.c:243: warning: assignment makes pointer from integer without a
cast
c-r4k.c:245: structure has no member named `context'
c-r4k.c:245: structure has no member named `context'
c-r4k.c:253: warning: assignment makes pointer from integer without a
cast
c-r4k.c: In function `r4k_flush_cache_range_s32d32i32':
c-r4k.c:271: structure has no member named `context'
c-r4k.c:278: warning: assignment makes pointer from integer without a
cast
c-r4k.c:280: structure has no member named `context'
c-r4k.c:280: structure has no member named `context'
c-r4k.c:288: warning: assignment makes pointer from integer without a
cast
c-r4k.c: In function `r4k_flush_cache_range_s64d32i32':
c-r4k.c:306: structure has no member named `context'
c-r4k.c:313: warning: assignment makes pointer from integer without a
cast
c-r4k.c:315: structure has no member named `context'
c-r4k.c:315: structure has no member named `context'
c-r4k.c:323: warning: assignment makes pointer from integer without a
cast
c-r4k.c: In function `r4k_flush_cache_range_s128d32i32':
c-r4k.c:341: structure has no member named `context'
c-r4k.c:348: warning: assignment makes pointer from integer without a
cast
c-r4k.c:350: structure has no member named `context'
c-r4k.c:350: structure has no member named `context'
c-r4k.c:358: warning: assignment makes pointer from integer without a
cast
c-r4k.c: In function `r4k_flush_cache_range_d16i16':
c-r4k.c:374: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_range_d32i32':
c-r4k.c:386: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_s16d16i16':
c-r4k.c:401: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_s32d16i16':
c-r4k.c:411: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_s64d16i16':
c-r4k.c:421: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_s128d16i16':
c-r4k.c:431: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_s32d32i32':
c-r4k.c:441: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_s64d32i32':
c-r4k.c:451: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_s128d32i32':
c-r4k.c:461: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_d16i16':
c-r4k.c:471: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_mm_d32i32':
c-r4k.c:481: structure has no member named `context'
c-r4k.c: In function `r4k_flush_cache_page_s16d16i16':
c-r4k.c:492: structure has no member named `vm_mm'
c-r4k.c:501: structure has no member named `context'
c-r4k.c:508: warning: assignment makes pointer from integer without a
cast
c-r4k.c:525: structure has no member named `context'
c-r4k.c:525: structure has no member named `context'
c-r4k.c:536: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_s32d16i16':
c-r4k.c:541: structure has no member named `vm_mm'
c-r4k.c:550: structure has no member named `context'
c-r4k.c:557: warning: assignment makes pointer from integer without a
cast
c-r4k.c:573: structure has no member named `context'
c-r4k.c:573: structure has no member named `context'
c-r4k.c:584: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_s64d16i16':
c-r4k.c:589: structure has no member named `vm_mm'
c-r4k.c:598: structure has no member named `context'
c-r4k.c:605: warning: assignment makes pointer from integer without a
cast
c-r4k.c:621: structure has no member named `context'
c-r4k.c:621: structure has no member named `context'
c-r4k.c:632: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_s128d16i16':
c-r4k.c:637: structure has no member named `vm_mm'
c-r4k.c:646: structure has no member named `context'
c-r4k.c:653: warning: assignment makes pointer from integer without a
cast
c-r4k.c:670: structure has no member named `context'
c-r4k.c:670: structure has no member named `context'
c-r4k.c:681: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_s32d32i32':
c-r4k.c:686: structure has no member named `vm_mm'
c-r4k.c:695: structure has no member named `context'
c-r4k.c:702: warning: assignment makes pointer from integer without a
cast
c-r4k.c:719: structure has no member named `context'
c-r4k.c:719: structure has no member named `context'
c-r4k.c:730: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_s64d32i32':
c-r4k.c:735: structure has no member named `vm_mm'
c-r4k.c:744: structure has no member named `context'
c-r4k.c:751: warning: assignment makes pointer from integer without a
cast
c-r4k.c:768: structure has no member named `context'
c-r4k.c:768: structure has no member named `context'
c-r4k.c:779: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_s128d32i32':
c-r4k.c:784: structure has no member named `vm_mm'
c-r4k.c:793: structure has no member named `context'
c-r4k.c:800: warning: assignment makes pointer from integer without a
cast
c-r4k.c:817: structure has no member named `context'
c-r4k.c:817: structure has no member named `context'
c-r4k.c:827: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_d16i16':
c-r4k.c:832: structure has no member named `vm_mm'
c-r4k.c:841: structure has no member named `context'
c-r4k.c:848: warning: assignment makes pointer from integer without a
cast
c-r4k.c:875: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_d32i32':
c-r4k.c:880: structure has no member named `vm_mm'
c-r4k.c:889: structure has no member named `context'
c-r4k.c:896: warning: assignment makes pointer from integer without a
cast
c-r4k.c:924: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `r4k_flush_cache_page_d32i32_r4600':
c-r4k.c:929: structure has no member named `vm_mm'
c-r4k.c:938: structure has no member named `context'
c-r4k.c:945: warning: assignment makes pointer from integer without a
cast
c-r4k.c:973: warning: deprecated use of label at end of compound
statement
c-r4k.c: In function `setup_noscache_funcs':
c-r4k.c:1360: `_dma_cache_wback_inv' undeclared (first use in this
function)
c-r4k.c:1360: (Each undeclared identifier is reported only once
c-r4k.c:1360: for each function it appears in.)
c-r4k.c:1361: `_dma_cache_wback' undeclared (first use in this function)
c-r4k.c:1362: `_dma_cache_inv' undeclared (first use in this function)
c-r4k.c: In function `setup_scache_funcs':
c-r4k.c:1443: `_dma_cache_wback_inv' undeclared (first use in this
function)
c-r4k.c:1444: `_dma_cache_wback' undeclared (first use in this function)
c-r4k.c:1445: `_dma_cache_inv' undeclared (first use in this function)
make[2]: *** [c-r4k.o] Error 1
make[2]: Leaving directory
`/home/cameron/kernel/linux-2.4.19/arch/mipsnommu/mm'make[1]: ***
[first_rule] Error 2
make[1]: Leaving directory
`/home/cameron/kernel/linux-2.4.19/arch/mipsnommu/mm'make: ***
[_dir_arch/mipsnommu/mm] Error 2
