Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id FAA13167
	for <pstadt@stud.fh-heilbronn.de>; Thu, 8 Jul 1999 05:22:43 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA4884188; Wed, 7 Jul 1999 20:18:06 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA28720
	for linux-list;
	Wed, 7 Jul 1999 20:14:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id UAA67312;
	Wed, 7 Jul 1999 20:14:20 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id UAA20666; Wed, 7 Jul 1999 20:12:03 -0700
From: "William J. Earl" <wje@fir.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14212.5891.237364.112104@fir.engr.sgi.com>
Date: Wed, 7 Jul 1999 20:12:03 -0700 (PDT)
To: Warner Losh <imp@village.org>
Cc: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        Ulf Carlsson <ulfc@thepuffingroup.com>,
        "William J. Earl" <wje@fir.engr.sgi.com>
Subject: Re: Memory corruption 
In-Reply-To: <199907080151.TAA05482@harmony.village.org>
References: <XFMail.990707230857.Harald.Koerfgen@home.ivm.de>
	<199907080151.TAA05482@harmony.village.org>
X-Mailer: VM 6.72 under Emacs 19.34.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Warner Losh writes:
 > In message <XFMail.990707230857.Harald.Koerfgen@home.ivm.de> Harald Koerfgen writes:
 > : That's definitely true for R3k DECstations, and no, flushing the icache in
 > : flush_tlb_page() does not help. I have added cacheflushing to all tlb routines,
 > : copy_page and even rw_swap_page_base() and swap_after_unlock_page() without
 > : success.
 > 
 > Don'y you want to flush the dcache as well?  I think that you can run
 > into problems when you have a dirty dcache and then dma into the pages
 > that are dirty.  Instant karma corruption, no?  Or am I thinking of
 > some other problem?

      The R3000 has a write-through cache, so there cannot be dirty cache
lines, although you do have to flush the write buffers to be completely
correct (in the case of a DMA device writing to memory VERY quickly after
the register write which starts it up, on some hardware). 
