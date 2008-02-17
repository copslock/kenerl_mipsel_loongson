Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Feb 2008 20:10:57 +0000 (GMT)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:43948 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20036015AbYBQUKP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Feb 2008 20:10:15 +0000
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 116C95BC021;
	Sun, 17 Feb 2008 22:10:15 +0200 (EET)
Date:	Sun, 17 Feb 2008 22:09:47 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: mips/bcm47xx/setup.c compile error
Message-ID: <20080217200947.GH1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit d3c319f9c8d9ee2c042c60b8a1bbd909dcc42782 causes the following 
compile error:

<--  snip  -->

...
  CC      arch/mips/bcm47xx/setup.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c: In function 'bcm47xx_get_invariants':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:95: error: 'struct ssb_sprom' has no member named 'r1'
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:97: error: 'struct ssb_sprom' has no member named 'r1'
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:99: error: 'struct ssb_sprom' has no member named 'r1'
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:101: error: 'struct ssb_sprom' has no member named 'r1'
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:103: error: 'struct ssb_sprom' has no member named 'r1'
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:105: error: 'struct ssb_sprom' has no member named 'r1'
make[2]: *** [arch/mips/bcm47xx/setup.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
