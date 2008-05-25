Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 May 2008 17:45:51 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:22716 "HELO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with SMTP id S20040903AbYEYQpt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 May 2008 17:45:49 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 609F15BC045;
	Sun, 25 May 2008 19:45:46 +0300 (EEST)
Date:	Sun, 25 May 2008 19:43:11 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Chris Dearman <chris@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: mips/kernel/traps.c build error
Message-ID: <20080525164311.GB1791@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit 39b8d5254246ac56342b72f812255c8f7a74dca9
([MIPS] Add support for MIPS CMP platform.)
causes the following build error:

<--  snip  -->

...
  CC      arch/mips/kernel/traps.o
cc1: warnings being treated as errors
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/kernel/traps.c: In function 'show_raw_backtrace':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/kernel/traps.c:92: error: cast from pointer to integer of different size
make[2]: *** [arch/mips/kernel/traps.o] Error 1

<--  snip  -->

"[MIPS] Fix check for valid stack pointer during backtrace" in the mips 
tree fixes it, and should therefore also go into 2.6.26.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
