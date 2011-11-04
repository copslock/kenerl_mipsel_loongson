Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 16:16:14 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43149 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904116Ab1KDPQK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 16:16:10 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA4FG7di014256;
        Fri, 4 Nov 2011 15:16:07 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA4FG3IA014251;
        Fri, 4 Nov 2011 15:16:03 GMT
Date:   Fri, 4 Nov 2011 15:16:03 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add fast get_user_pages
Message-ID: <20111104151603.GB13043@linux-mips.org>
References: <CAJd=RBC=_+qAnbTaYXgTOoiVdfgppRt-rBs4cnKoZKxHD14nuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJd=RBC=_+qAnbTaYXgTOoiVdfgppRt-rBs4cnKoZKxHD14nuw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3700

On Fri, Oct 28, 2011 at 09:26:23PM +0800, Hillf Danton wrote:

When we were chasing the TLB crash recently for a while I was suspecting
the default get_user_fast implementation so I ported gup.c from x86 but I
never really finished it, so thanks for ridding me of one item from my
to do list.

This probably wants some more testing in particular on 32-bit systems with
64-bit pagetables such as some Alchemy configurations or 32-bit kernels
on Sibyte systems.

I fixed up a reject in arch/mips/mm/Makefile due to whitespace differences
and queued the patch for 3.3.

Have you made any benchmarks of the new gup.c?

Thanks,

  Ralf
