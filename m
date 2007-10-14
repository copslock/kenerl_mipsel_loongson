Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 14:20:02 +0100 (BST)
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6334 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20034480AbXJNNTw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 14:19:52 +0100
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id CA45B182DD4;
	Sun, 14 Oct 2007 15:20:10 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 8A3403CE30F; Sun, 14 Oct 2007 15:19:48 +0200 (CEST)
Date:	Sun, 14 Oct 2007 15:19:48 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: -git mips defconfig compile error
Message-ID: <20071014131948.GF4211@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit 05dc8c02bf40090e9ed23932b1980ead48eb8870 causes the following 
compile error with the mips defconfig:

<--  snip  -->

...
  CC      drivers/video/logo/logo.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c: In function 'fb_find_logo':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c:91: error: 'mips_machgroup' undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c:91: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c:91: error: for each function it appears in.)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c:91: error: 'MACH_GROUP_SGI' undeclared (first use in this function)
make[4]: *** [drivers/video/logo/logo.o] Error 1

<--  snip  -->

It seems the drivers/net/jazzsonic.c and drivers/video/logo/logo.c parts 
that are part of the corresponding commit in the mips git tree got lost
somewhere.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
