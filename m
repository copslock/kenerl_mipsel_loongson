Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 18:15:34 +0200 (CEST)
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:4433 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492207AbZGEQP2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Jul 2009 18:15:28 +0200
Received: by smtp239.poczta.interia.pl (INTERIA.PL, from userid 502)
	id 76822D00A6; Sun,  5 Jul 2009 18:08:47 +0200 (CEST)
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 94F39CFFB2;
	Sun,  5 Jul 2009 18:08:43 +0200 (CEST)
Received: by poczta.interia.pl (INTERIA.PL, from userid 502)
	id 8A47A25A5B28; Sun,  5 Jul 2009 18:08:43 +0200 (CEST)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id D079225A5B15;
	Sun,  5 Jul 2009 18:08:25 +0200 (CEST)
Date:	Sun, 5 Jul 2009 18:18:08 +0200
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
Message-Id: <20090705181808.93be24a9.krzysztof.h1@poczta.fm>
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
X-EMID:	c2e2b138
Return-Path: <krzysztof.h1@poczta.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzysztof.h1@poczta.fm
Precedence: bulk
X-list: linux-mips

On Mon, 6 Jul 2009 00:25:57 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Sun, Jul 05, 2009 at 08:19:40AM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Mon, 6 Jul 2009, Paul Mundt wrote:
> > > >
> > > > Why not "lock" as well?
> > > 
> > > I had that initially, but matroxfb will break if we do that, and
> > > presently nothing cares about trying to take ->lock that early on.
> > 
> > I really would rather have consistency than some odd rules like that.
> > 
> > In particular - if matroxfb is different and needs its own lock 
> > initialization because it doesn't use the common allocation routine, then 
> > please make _that_ consistent too. Rather than have it special-case just 
> > one lock that it needs to initialize separately, make it clear that since 
> > it does its own allocations it needs to initialize _everything_ 
> > separately.
> > 
> Ok, here is an updated version with an updated matroxfb and the sm501fb
> change reverted.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> ---
> 

This is incorrect way to fix this as some drivers do not use the framebuffer_alloc() 
at all. They use global (for a file) fb_info structure. I have done some cleanups to
the fbdev layer before the 2.6.31 and there should no drivers which uses kmalloc or
kzalloc to allocate the fb_info (your patch would break these drivers too).

A root of the whole mm_lock issue is that the fb_mmap() BKL protected two fb_info
fields which were never protected when set. I changed this by add the mm_lock 
around these fields but only in drivers which modified this fields AFTER call
to the register_framebuffer(). Some drivers set these fields using the same
function before and after the register_framebuffer(). I strongly believe that
setting these fields before the register_framebuffer() is wrong or redundant for
these drivers. See my fix for the sisfb driver below. 

I have tested the patch below. Wu Zhangjin, can you also confirm that this 
works for you (without your patch)?

I will look into the matroxfb and sm501fb drivers now. The same problem is
already fixed for the mx3fb driver and the patch is sent to Andrew Morton.

Regards,
Krzysztof


From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant call to the sisfb_get_fix() before sis frambuffer is registered.

This fixes a problem with uninitialized the fb_info->mm_lock mutex.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-ref/drivers/video/sis/sis_main.c linux-next/drivers/video/sis/sis_main.c
--- linux-ref/drivers/video/sis/sis_main.c	2009-07-01 18:07:05.000000000 +0200
+++ linux-next/drivers/video/sis/sis_main.c	2009-07-05 17:20:33.000000000 +0200
@@ -6367,7 +6367,6 @@ error_3:	vfree(ivideo->bios_abase);
 		sis_fb_info->fix = ivideo->sisfb_fix;
 		sis_fb_info->screen_base = ivideo->video_vbase + ivideo->video_offset;
 		sis_fb_info->fbops = &sisfb_ops;
-		sisfb_get_fix(&sis_fb_info->fix, -1, sis_fb_info);
 		sis_fb_info->pseudo_palette = ivideo->pseudo_palette;
 
 		fb_alloc_cmap(&sis_fb_info->cmap, 256 , 0);



----------------------------------------------------------------------
Najlepsze OC i AC tylko w Ergo Hestia
http://link.interia.pl/f222
