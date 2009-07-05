Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 17:08:33 +0200 (CEST)
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:39489 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492067AbZGEPI0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Jul 2009 17:08:26 +0200
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 6A14063754;
	Sun,  5 Jul 2009 15:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4u1UvUepAK76; Mon,  6 Jul 2009 00:01:35 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id 1C2D063758; Mon,  6 Jul 2009 00:01:35 +0900 (JST)
Date:	Mon, 6 Jul 2009 00:01:35 +0900
From:	Paul Mundt <lethal@linux-sh.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, ???? <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
Subject: Re: [BUG] drivers/video/sis: deadlock introduced by "fbdev: add mutex for fb_mmap locking"
Message-ID: <20090705150134.GB8326@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, ???? <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
References: <1246785112.14240.34.camel@falcon> <alpine.LFD.2.01.0907050715490.3210@localhost.localdomain> <20090705145203.GA8326@linux-sh.org> <alpine.LFD.2.01.0907050756280.3210@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907050756280.3210@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 05, 2009 at 07:56:56AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 5 Jul 2009, Paul Mundt wrote:
> >  			break;
> >  	fb_info->node = i;
> >  	mutex_init(&fb_info->lock);
> > -	mutex_init(&fb_info->mm_lock);
> 
> Why not "lock" as well?
> 
I had that initially, but matroxfb will break if we do that, and
presently nothing cares about trying to take ->lock that early on.

->mm_lock was a special case as the lock/unlock pairs were sprinkled
around well before initialization, while in the ->lock case all of the
lock/unlock pairs are handled internally by the fbmem code (at least a
quick grep does not show any drivers using it on their own).
