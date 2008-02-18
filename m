Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 00:43:18 +0000 (GMT)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:51666 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20036429AbYBRAnP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 00:43:15 +0000
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id F21845BC016;
	Mon, 18 Feb 2008 02:43:14 +0200 (EET)
Date:	Mon, 18 Feb 2008 02:42:46 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	Christoph Lameter <clameter@sgi.com>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: mips yosemite_defconfig compile error
Message-ID: <20080218004246.GN1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit 9e2779fa281cfda13ac060753d674bbcaa23367e also broke the
mips yosemite_defconfig:

<--  snip  -->

...
  CC      arch/mips/kernel/asm-offsets.s
In file included from 
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/kernel/asm-offsets.c:14:
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/mm.h: In function 'is_vmalloc_addr':
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/mm.h:243: error: 'PKMAP_BASE' undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/mm.h:243: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/mm.h:243: error: for each function it appears in.)
make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
