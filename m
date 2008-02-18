Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 02:58:32 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:46599 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20036560AbYBRC63 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 02:58:29 +0000
Received: by mo.po.2iij.net (mo31) id m1I2wP8C080517; Mon, 18 Feb 2008 11:58:25 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id m1I2wNLm020911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 18 Feb 2008 11:58:23 +0900
Date:	Mon, 18 Feb 2008 11:58:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Adrian Bunk <bunk@stusta.de>
Cc:	yoichi_yuasa@tripeaks.co.jp, Dmitry Torokhov <dtor@mail.ru>,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: cobalt_btns.c <-> struct platform_device compile error
Message-Id: <20080218115824.3ae7cf29.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080217200935.GE1403@cs181133002.pp.htv.fi>
References: <20080217200935.GE1403@cs181133002.pp.htv.fi>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

I already sent a patch to Dmitry.

Yoichi

On Sun, 17 Feb 2008 22:09:35 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> Commit b037b08e59633d939d79f1df9c43c6625f8db904 broke the compilation of 
> cobalt_btns.c:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/input/misc/cobalt_btns.o
> ...
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c: In function 'cobalt_buttons_probe':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:101: error: 'struct platform_device' has no member named 'keymap'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:102: error: 'struct platform_device' has no member named 'keymap'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:102: error: 'struct platform_device' has no member named 'keymap'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:102: error: 'struct platform_device' has no member named 'keymap'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/misc/cobalt_btns.c:102: error: 'struct platform_device' has no member named 'keymap'
> ...
> make[4]: *** [drivers/input/misc/cobalt_btns.o] Error 1
> 
> <--  snip  -->
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> 
