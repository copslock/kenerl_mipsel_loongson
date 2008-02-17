Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Feb 2008 20:11:48 +0000 (GMT)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:59856 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20036025AbYBQUKV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Feb 2008 20:10:21 +0000
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 40C435BC016;
	Sun, 17 Feb 2008 22:10:21 +0200 (EET)
Date:	Sun, 17 Feb 2008 22:09:53 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Jean Delvare <khali@linux-fr.org>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: mips SMBUS_PSC_BASE compile errors
Message-ID: <20080217200953.GJ1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit 8b798c4d16b762d15f4055597ff8d87f73b35552 causes compile errors 
like the following for several system types:

<--  snip  -->

...
  CC      arch/mips/au1000/common/platform.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/au1000/common/platform.c:277: error: 'PSC0_BASE_ADDR' undeclared here (not in a function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/au1000/common/platform.c:314: warning: no previous prototype for 'au1xxx_platform_init'
make[2]: *** [arch/mips/au1000/common/platform.o] Error 1

<--  snip  -->

One or more #include <asm/mach-au1x00/au1xxx_psc.h>'s at the right 
places seem to be the correct solution, but I don't understand the mips 
subarch setup good enough for knowing where to place them.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
