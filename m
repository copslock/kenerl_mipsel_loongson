Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 May 2008 18:10:04 +0100 (BST)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:25818 "HELO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with SMTP id S20040918AbYEYRKB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 May 2008 18:10:01 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id 1AAA25BC065;
	Sun, 25 May 2008 20:10:00 +0300 (EEST)
Date:	Sun, 25 May 2008 20:07:24 +0300
From:	Adrian Bunk <adrian.bunk@movial.fi>
To:	Chris Dearman <chris@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: mips: CONF_CM_DEFAULT build error
Message-ID: <20080525170718.GD1791@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <adrian.bunk@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adrian.bunk@movial.fi
Precedence: bulk
X-list: linux-mips

Commit 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0
([MIPS] Allow setting of the cache attribute at run time.)
causes the following build error with pnx8550-jbs_defconfig
and pnx8550-stb810_defconfig:

<--  snip  -->

...
  CC      arch/mips/nxp/pnx8550/stb810/board_setup.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/nxp/pnx8550/stb810/board_setup.c: In function 'board_setup':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/nxp/pnx8550/stb810/board_setup.c:42: error: 'PAGE_CACHABLE_DEFAULT' undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/nxp/pnx8550/stb810/board_setup.c:42: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/nxp/pnx8550/stb810/board_setup.c:42: error: for each function it appears in.)
make[2]: *** [arch/mips/nxp/pnx8550/stb810/board_setup.o] Error 1

<--  snip  -->


The problem is due to the following:

$ grep -r CONF_CM_DEFAULT *
arch/mips/nxp/pnx8550/jbs/board_setup.c:        config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
arch/mips/nxp/pnx8550/jbs/board_setup.c:                        (CONF_CM_DEFAULT<<28));
arch/mips/nxp/pnx8550/stb810/board_setup.c:     config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
arch/mips/nxp/pnx8550/stb810/board_setup.c:                     (CONF_CM_DEFAULT<<28));
include/asm-mips/pgtable-bits.h:#define CONF_CM_DEFAULT         (PAGE_CACHABLE_DEFAULT>>_CACHE_SHIFT)
$ grep -r PAGE_CACHABLE_DEFAULT *
include/asm-mips/pgtable-bits.h:#define CONF_CM_DEFAULT         (PAGE_CACHABLE_DEFAULT>>_CACHE_SHIFT)
$ 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
