Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Feb 2008 20:10:31 +0000 (GMT)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:57808 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20036010AbYBQUKK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Feb 2008 20:10:10 +0000
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id ED0CA5BC016;
	Sun, 17 Feb 2008 22:10:09 +0200 (EET)
Date:	Sun, 17 Feb 2008 22:09:42 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	Dmitry Torokhov <dtor@mail.ru>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: cdev removal broke cobalt_btns.c compilation
Message-ID: <20080217200942.GF1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit 0c1efd365306c9b04df5abdd41e9b4dc721e84fb broke the compilation of 
cobalt_btns.c:

<--  snip  -->

...
  CC      drivers/input/misc/cobalt_btns.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c: In function 'cobalt_buttons_probe':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:100: error: 'struct input_dev' has no member named 'cdev'
...
make[4]: *** [drivers/input/misc/cobalt_btns.o] Error 1
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
