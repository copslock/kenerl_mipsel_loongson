Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 18:23:06 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:22176 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029481AbYEMRXE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 May 2008 18:23:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4DHN1lQ031500;
	Tue, 13 May 2008 18:23:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4DHN1QR031499;
	Tue, 13 May 2008 18:23:01 +0100
Date:	Tue, 13 May 2008 18:23:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: is remap_pfn_range should align to 2(n) * (page size) ?
Message-ID: <20080513172300.GA9788@linux-mips.org>
References: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com> <20080509095605.GB14450@linux-mips.org> <50c9a2250805111918r16913139obfc2982220636b3@mail.gmail.com> <20080512112233.GA8843@linux-mips.org> <50c9a2250805130444u4218654bw66f6158ba10b2b92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250805130444u4218654bw66f6158ba10b2b92@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2008 at 07:44:06PM +0800, zhuzhenhua wrote:

> thanks for your advice, i found in newest kernel version, in some arch , the
> dma_alloc_coherent will call split_page.
> because my kernel version is 2.6.14, so i first patch a split_page patch as
> follow:
> http://www.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/broken-out/mm-split-highorder.patch
> 
> but it seemes that there is still no split_page in
> dma_alloc_coherent/dma_alloc_noncoherent
> so i copy from other arch code to arch/mips/mm/dma-noncoherent.c (attach at
> the end of mail)
> and now my driver just use dma_alloc_coherent malloc 3M directly, and it
> seemes ok.
> i just wonder why mips arch dma_alloc_coherent/dma_alloc_nocoherent do not
> call split_page while other arch calling.

I have not identified the waste of memory as a big problem for typical
MIPS systems yet.

The 3MB requirement of your device is sort of odd because it's not a power
of two.  Have you considered splitting the allocation into a 2MB and a 1MB
allocation or would that be undersirable?

  Ralf
