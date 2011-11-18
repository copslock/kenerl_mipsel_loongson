Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 12:05:58 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56267 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904105Ab1KRLFy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 12:05:54 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAIB5k4r010969;
        Fri, 18 Nov 2011 11:05:46 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAIB5itA010962;
        Fri, 18 Nov 2011 11:05:44 GMT
Date:   Fri, 18 Nov 2011 11:05:44 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Chen Jie <chenj@lemote.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [Question] What's difference between ioremap_wc and
 ioremap_uncached_accelerated?
Message-ID: <20111118110544.GA18331@linux-mips.org>
References: <CAGXxSxWUfNysqpfG0hWGYC0WyOMWS5R+K4euZ9miD3UD43F94A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXxSxWUfNysqpfG0hWGYC0WyOMWS5R+K4euZ9miD3UD43F94A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15301

On Thu, Nov 17, 2011 at 05:39:56PM +0800, Chen Jie wrote:

> I noticed mips defines an ioremap_uncached_accelerated in
> arch/mips/include/asm/io.h, not reuse the name of "ioremap_wc", what
> is the difference?
> 
> Some drivers use ioremap_wc, e.g. ttm_bo_ioremap() in
> drivers/gpu/drm/ttm/ttm_bo_util.c, I wonder whether these ioremap_wc
> invocations can be replaced with "ioremap_uncached_accelerated"?

Uncached Accelerated is the name under which the R10000 introduced a
cache mode that uses the CPU's write buffer to combine writes but that
otherwise is uncached.  ioremap_uncached_accelerated and ioremap_cache-
able_cow were introduced in 2002; ioremap_wc was introduced in 2008 for
x86 and the latter name became the standard.

So the two functions are the same, just named differently for historic
reasons.  I'm going to rename the function - for all practical purposes
this naming difference has turned into a bug.

Also I will rename ioremap_cacheable_cow to ioremap_cache.  Note that
that ioremap_cacheable_cow also has a bug, it is hardwired to use CCA
_CACHE_CACHABLE_COW which is not available on all MIPS cores.  I will
change it to use the same CCA that is also being used for RAM.

  Ralf
