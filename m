Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 14:46:49 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:3505 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28578845AbYFLNqr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 14:46:47 +0100
Received: from cs181133002.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 1EDD85BC051;
	Thu, 12 Jun 2008 16:46:46 +0300 (EEST)
Date:	Thu, 12 Jun 2008 16:45:40 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: pending mips build fixes
Message-ID: <20080612134539.GA20487@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I hope I'm not too annoying on this, but I like it when as many 
defconfigs as possible compile.

Please review and push the following patches for 2.6.26:

  BCM47xx: Add platform specific PCI code
  http://marc.info/?l=linux-kernel&amp;m=120876451216558&amp;w=2

  MIPS: Fix CONF_CM_DEFAULT build error
  http://lkml.org/lkml/2008/6/1/125


That would get 3 more defconfigs compiling in 2.6.26.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
