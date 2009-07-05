Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 18:40:46 +0200 (CEST)
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:23627 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492222AbZGEQkj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Jul 2009 18:40:39 +0200
Received: by smtp239.poczta.interia.pl (INTERIA.PL, from userid 502)
	id 10076370BB3; Sun,  5 Jul 2009 18:34:01 +0200 (CEST)
Received: from poczta.interia.pl (mi05.te.interia.pl [10.217.12.5])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 2FF42370A01;
	Sun,  5 Jul 2009 18:33:59 +0200 (CEST)
Received: by poczta.interia.pl (INTERIA.PL, from userid 502)
	id 3B870BE187E; Sun,  5 Jul 2009 18:33:59 +0200 (CEST)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 30432BE18A6;
	Sun,  5 Jul 2009 18:33:40 +0200 (CEST)
Date:	Sun, 5 Jul 2009 18:43:19 +0200
From:	Krzysztof Helt <krzysztof.h1@poczta.fm>
To:	Paul Mundt <lethal@linux-sh.org>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, ???? <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
Subject: Re: [BUG] drivers/video/sis: deadlock introduced by
 "fbdev: add mutex for fb_mmap locking"
Message-Id: <20090705184319.6e77be82.krzysztof.h1@poczta.fm>
In-Reply-To: <20090705152557.GA10588@linux-sh.org>
References: <1246785112.14240.34.camel@falcon>
	<alpine.LFD.2.01.0907050715490.3210@localhost.localdomain>
	<20090705145203.GA8326@linux-sh.org>
	<alpine.LFD.2.01.0907050756280.3210@localhost.localdomain>
	<20090705150134.GB8326@linux-sh.org>
	<alpine.LFD.2.01.0907050816110.3210@localhost.localdomain>
	<20090705152557.GA10588@linux-sh.org>
X-Mailer: Sylpheed 2.4.3 (GTK+ 2.11.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-EMID:	38e2b138
Return-Path: <krzysztof.h1@poczta.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzysztof.h1@poczta.fm
Precedence: bulk
X-list: linux-mips

On Mon, 6 Jul 2009 00:25:57 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> Ok, here is an updated version with an updated matroxfb and the sm501fb
> change reverted.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 

Here is a patch which should fix problem with sm501fb driver:

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 16d4f4c..924d794 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -1540,9 +1540,6 @@ static int sm501fb_init_fb(struct fb_info *fb,
 	if (ret)
 		dev_err(info->dev, "check_var() failed on initial setup?\n");
 
-	/* ensure we've activated our new configuration */
-	(fb->fbops->fb_set_par)(fb);
-
 	return 0;
 }
 

Paul, please test it (without additional initialization of the mm_lock mutext). I will post the patch
if it works for you.

An issue here is that these drivers calls fb_set_par() function (or part of it as the sisfb driver) 
but the register_framebuffer() calls the fb_set_par() also after all structures are set up. There
should be no need to call the fb_set_par() just before the register_framebuffer().

The matroxfb driver is quite far from standard driver framework by now. I vote for fixing it
by adding this early initialization of the mm_mutex for now.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Promocja ubezpieczen komunikacyjnych Ergo Hestia. Sprawdz!
http://link.interia.pl/f222f
