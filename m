Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2011 13:08:03 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52730 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904226Ab1KGMH7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Nov 2011 13:07:59 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA7C7rMB008270;
        Mon, 7 Nov 2011 12:07:53 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA7C7r72008269;
        Mon, 7 Nov 2011 12:07:53 GMT
Date:   Mon, 7 Nov 2011 12:07:53 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add fast get_user_pages
Message-ID: <20111107120752.GA5142@linux-mips.org>
References: <CAJd=RBC=_+qAnbTaYXgTOoiVdfgppRt-rBs4cnKoZKxHD14nuw@mail.gmail.com>
 <20111104151603.GB13043@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20111104151603.GB13043@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5202

On Fri, Nov 04, 2011 at 03:16:03PM +0000, Ralf Baechle wrote:

> On Fri, Oct 28, 2011 at 09:26:23PM +0800, Hillf Danton wrote:
> 
> When we were chasing the TLB crash recently for a while I was suspecting
> the default get_user_fast implementation so I ported gup.c from x86 but I
> never really finished it, so thanks for ridding me of one item from my
> to do list.
> 
> This probably wants some more testing in particular on 32-bit systems with
> 64-bit pagetables such as some Alchemy configurations or 32-bit kernels
> on Sibyte systems.
> 
> I fixed up a reject in arch/mips/mm/Makefile due to whitespace differences
> and queued the patch for 3.3.
> 
> Have you made any benchmarks of the new gup.c?

Hitting this one in a non-hugepage build of upstream-sfr:

  CC      arch/mips/mm/gup.o
arch/mips/mm/gup.c:70:51: error: redefinition of ‘get_huge_page_tail’
include/linux/mm.h:379:51: note: previous definition of ‘get_huge_page_tail’ was here
make[2]: *** [arch/mips/mm/gup.o] Error 1
make[1]: *** [arch/mips/mm] Error 2
make: *** [arch/mips] Error 2

I fixed this one up by removing the local definition of get_huge_page_tail
but you may want to re-test.

  Ralf
