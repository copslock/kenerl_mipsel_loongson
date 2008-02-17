Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Feb 2008 20:10:06 +0000 (GMT)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:59112 "EHLO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20036001AbYBQUKE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Feb 2008 20:10:04 +0000
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id 4A0A75BC03D;
	Sun, 17 Feb 2008 22:10:03 +0200 (EET)
Date:	Sun, 17 Feb 2008 22:09:35 +0200
From:	Adrian Bunk <bunk@stusta.de>
To:	Dmitry Torokhov <dtor@mail.ru>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: cobalt_btns.c <-> struct platform_device compile error
Message-ID: <20080217200935.GE1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

Commit b037b08e59633d939d79f1df9c43c6625f8db904 broke the compilation of 
cobalt_btns.c:

<--  snip  -->

...
  CC      drivers/input/misc/cobalt_btns.o
...
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c: In function 'cobalt_buttons_probe':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:101: error: 'struct platform_device' has no member named 'keymap'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:102: error: 'struct platform_device' has no member named 'keymap'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:102: error: 'struct platform_device' has no member named 'keymap'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:102: error: 'struct platform_device' has no member named 'keymap'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:102: error: 'struct platform_device' has no member named 'keymap'
...
make[4]: *** [drivers/input/misc/cobalt_btns.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
