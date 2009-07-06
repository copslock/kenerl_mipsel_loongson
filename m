Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 16:48:06 +0200 (CEST)
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:43089 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491826AbZGFOsA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2009 16:48:00 +0200
Received: by smtp239.poczta.interia.pl (INTERIA.PL, from userid 502)
	id EAB18370A62; Mon,  6 Jul 2009 16:41:04 +0200 (CEST)
Received: from poczta.interia.pl (mi03.poczta.interia.pl [10.217.12.3])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id EBD90370B14;
	Mon,  6 Jul 2009 16:41:03 +0200 (CEST)
Received: by poczta.interia.pl (INTERIA.PL, from userid 502)
	id 0A88A3C3A6; Mon,  6 Jul 2009 16:41:03 +0200 (CEST)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 88CA63C396;
	Mon,  6 Jul 2009 16:40:48 +0200 (CEST)
Date:	Mon, 6 Jul 2009 16:50:36 +0200
From:	Krzysztof Helt <krzysztof.h1@poczta.fm>
To:	wuzhangjin@gmail.com
Cc:	Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, ???? <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
Subject: Re: [BUG] drivers/video/sis: deadlock introduced by
 "fbdev: add mutex for fb_mmap locking"
Message-Id: <20090706165036.d21bfaaa.krzysztof.h1@poczta.fm>
In-Reply-To: <1246842791.29532.2.camel@falcon>
References: <1246785112.14240.34.camel@falcon>
	<alpine.LFD.2.01.0907050715490.3210@localhost.localdomain>
	<20090705145203.GA8326@linux-sh.org>
	<alpine.LFD.2.01.0907050756280.3210@localhost.localdomain>
	<20090705150134.GB8326@linux-sh.org>
	<alpine.LFD.2.01.0907050816110.3210@localhost.localdomain>
	<20090705152557.GA10588@linux-sh.org>
	<20090705181808.93be24a9.krzysztof.h1@poczta.fm>
	<1246842791.29532.2.camel@falcon>
X-Mailer: Sylpheed 2.4.3 (GTK+ 2.11.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-EMID:	3ae2b138
Return-Path: <krzysztof.h1@poczta.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzysztof.h1@poczta.fm
Precedence: bulk
X-list: linux-mips

On Mon, 06 Jul 2009 09:13:11 +0800
Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> Hi,
> 
> 
> This patch also works for me, thanks!
> 
> Regards,
> Wu Zhangjin
> 

Who should I send this patch to be included as a 2.6.31 regression fix?

Regards,
Krzysztof

> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Remove redundant call to the sisfb_get_fix() before sis frambuffer is registered.
> > 
> > This fixes a problem with uninitialized the fb_info->mm_lock mutex.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > 
> > diff -urp linux-ref/drivers/video/sis/sis_main.c linux-next/drivers/video/sis/sis_main.c
> > --- linux-ref/drivers/video/sis/sis_main.c	2009-07-01 18:07:05.000000000 +0200
> > +++ linux-next/drivers/video/sis/sis_main.c	2009-07-05 17:20:33.000000000 +0200
> > @@ -6367,7 +6367,6 @@ error_3:	vfree(ivideo->bios_abase);
> >  		sis_fb_info->fix = ivideo->sisfb_fix;
> >  		sis_fb_info->screen_base = ivideo->video_vbase + ivideo->video_offset;
> >  		sis_fb_info->fbops = &sisfb_ops;
> > -		sisfb_get_fix(&sis_fb_info->fix, -1, sis_fb_info);
> >  		sis_fb_info->pseudo_palette = ivideo->pseudo_palette;
> >  
> >  		fb_alloc_cmap(&sis_fb_info->cmap, 256 , 0);
> > 
> > 
> > 
> > ----------------------------------------------------------------------
> > Najlepsze OC i AC tylko w Ergo Hestia
> > http://link.interia.pl/f222
> > 
> 
> 

----------------------------------------------------------------------
Najlepsze OC i AC tylko w Ergo Hestia
http://link.interia.pl/f222
