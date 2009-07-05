Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 17:03:08 +0200 (CEST)
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:33350 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492015AbZGEPDB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Jul 2009 17:03:01 +0200
Received: by smtp239.poczta.interia.pl (INTERIA.PL, from userid 502)
	id 5D52842FEEC; Sun,  5 Jul 2009 16:56:24 +0200 (CEST)
Received: from poczta.interia.pl (mi02.poczta.interia.pl [10.217.12.2])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 80B8442FF22;
	Sun,  5 Jul 2009 16:56:21 +0200 (CEST)
Received: by poczta.interia.pl (INTERIA.PL, from userid 502)
	id E936B2BC510; Sun,  5 Jul 2009 16:56:20 +0200 (CEST)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 60E082BC3CB;
	Sun,  5 Jul 2009 16:56:08 +0200 (CEST)
Date:	Sun, 5 Jul 2009 17:05:47 +0200
From:	Krzysztof Helt <krzysztof.h1@poczta.fm>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Krzysztof Helt <krzysztof.h1@wp.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	=?UTF-8?Q?=E6=99=8F=E5=8D=8E?= <yanh@lemote.com>,
	zhangfx <zhangfx@lemote.com>
Subject: Re: [BUG] drivers/video/sis: deadlock introduced by
 "fbdev: add mutex for fb_mmap locking"
Message-Id: <20090705170547.c83f1cb9.krzysztof.h1@poczta.fm>
In-Reply-To: <alpine.LFD.2.01.0907050715490.3210@localhost.localdomain>
References: <1246785112.14240.34.camel@falcon>
	<alpine.LFD.2.01.0907050715490.3210@localhost.localdomain>
X-Mailer: Sylpheed 2.4.3 (GTK+ 2.11.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-EMID:	e6e2b138
Return-Path: <krzysztof.h1@poczta.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzysztof.h1@poczta.fm
Precedence: bulk
X-list: linux-mips

On Sun, 5 Jul 2009 07:19:33 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sun, 5 Jul 2009, Wu Zhangjin wrote:
> > 
> > then it works! so, I guess there is a deadlock introduced by the above
> > commit.
> 
> Hmm. Perhaps more likely, the 'mm_lock' mutex hasn't even been initialized 
> yet.  We appear to have had that problem with matroxfb and sm501fb, and it 
> may be more common than that. See commit f50bf2b2.
> 
> That said, I do agree that the mm_lock seems to be causing more problems 
> than it actually fixes, and maybe we should revert it. Krzysztof?
> 

I vote for fixing these drivers after my change. I will send a patch for the sis driver soon. I am building new kernel now.

Regards,
Krzysztof

----------------------------------------------------------------------
Rozwiaz krzyzowke i  wygraj nagrody! 
Sprawdz >>  http://link.interia.pl/f2232 
