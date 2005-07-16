Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 08:54:46 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:31996 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8226438AbVGPHy3>;
	Sat, 16 Jul 2005 08:54:29 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j6G7tnpr002968;
	Sat, 16 Jul 2005 09:55:49 +0200 (MEST)
Date:	Sat, 16 Jul 2005 09:55:41 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Linux/MIPS Development <linux-mips@linux-mips.org>
cc:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>, Andrew Morton <akpm@osdl.org>
Subject: [Linux-fbdev-devel] Re: 2.6.13-rc3-mm1 (fwd)
Message-ID: <Pine.LNX.4.62.0507160954510.4553@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips


Guess this is where it really belongs...

---------- Forwarded message ----------
Date: Fri, 15 Jul 2005 16:23:49 -0700
From: Andrew Morton <akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org,
    linux-fbdev-devel@lists.sourceforge.net,
    Antonino A. Daplas <adaplas@hotpop.com>
Subject: [Linux-fbdev-devel] Re: 2.6.13-rc3-mm1

Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
>
> Hi Andrew
> 
> I got the following error.
> 
> make ARCH=mips oldconfig
> scripts/kconfig/conf -o arch/mips/Kconfig
> drivers/video/Kconfig:7:warning: type of 'FB' redefined from 'boolean' to 'tristate'
> 
> file drivers/char/speakup/Kconfig already scanned?
> make[1]: *** [oldconfig] Error 1
> make: *** [oldconfig] Error 2
> 

Well arch/mips/Kconfig is defining CONFIG_FB as bool and
drivers/video/Kconfig was changed a while ago to define it as tristate.  I
assume this failure also happens in linus's current tree.  

It seems odd that mips is privately duplicating the generic code's
definition.  Maybe that needs to be taken out of there.

I'll cc the fbdev guys - could someone please come up with fix?  It's a
showstopper for the MIPS architecture.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
