Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 18:27:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46796 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491097Ab1CYR13 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 18:27:29 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p2PHRAfV012754;
        Fri, 25 Mar 2011 18:27:10 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p2PHR94t012753;
        Fri, 25 Mar 2011 18:27:09 +0100
Date:   Fri, 25 Mar 2011 18:27:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
Message-ID: <20110325172709.GC8483@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 25, 2011 at 02:38:13PM +0530, naveen yadav wrote:

> We are working on 2.6.35.9 linux kernel on MIPS 34kce core and our
> cache is VIVT having cache aliasing .

No, they're VIPT unless you successfully modified your 34K core to
change it from a less than perfect cache design to the most lunatic
cache policy known to man kind ...

> When I check the implementation on ARM I can check the implemenation
> exists , but there is not similar implementation exists on MIPS.
> These API's are used by XFS module:
> 
> static inline void flush_kernel_vmap_range(void *vaddr, int size)
> static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> static inline void flush_kernel_dcache_page(struct page *page)

A known problem for (too ...) long.  I'll finally take care of it.

  Ralf
