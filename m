Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 23:51:07 +0200 (CEST)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36986 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492259AbZGBVvA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 23:51:00 +0200
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
	id 3A90BF0075; Thu,  2 Jul 2009 23:45:10 +0200 (CEST)
Date:	Thu, 2 Jul 2009 23:45:03 +0200
From:	Pavel Machek <pavel@ucw.cz>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: Re: [PATCH] [MIPS] Hibernation: only save pages in system ram
Message-ID: <20090702214503.GC1485@ucw.cz>
References: <1246373570-21090-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246373570-21090-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips



> arch/mips/include/asm/page.h:
> 
> 	...
> 	#ifdef CONFIG_FLATMEM
> 
> 	#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> 
> 	#elif defined(CONFIG_SPARSEMEM)
> 
> 	/* pfn_valid is defined in linux/mmzone.h */
> 	...
> 
> we can rewrite pfn_valid(pfn) to fix this problem, but I really do not
> want to touch such a widely-used macro, so, I used another solution:

Well, fixing pfn_valid() is the right way to go. It makes mips behave
like other architectures. Please do that.

> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>

NAK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
