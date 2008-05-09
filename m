Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 10:56:16 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:64913 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023396AbYEIJ4O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 May 2008 10:56:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m499u5B1016009;
	Fri, 9 May 2008 10:56:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m499u5Lo016002;
	Fri, 9 May 2008 10:56:05 +0100
Date:	Fri, 9 May 2008 10:56:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: is remap_pfn_range should align to 2(n) * (page size) ?
Message-ID: <20080509095605.GB14450@linux-mips.org>
References: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 09, 2008 at 02:54:29PM +0800, zhuzhenhua wrote:

>            i have a sensor driver want to malloc 2.xM SDRAM to capture
> data(using DMA),  so i used  remap_pfn_range to malloc 3M.
> But in /proc/meminfo, it showes free memory reduce 4M. i also check the
> /proc/buddyinfo, it seemes too.
> (i am looking inside kernel code, but not get clear at now).
> 
>  is remap_pfn_range should align to  2(n) * (page size) ?

This has nothing to do with remap_pfn_range but with the power of two
sized buckets used by the global free page pool.  Any allocation with
get_free_pages will be rounded up to the next power of two.  If that's a
real concern for you you could allocate a 4MB page then split the page
into a 2MB and two 1MB pages and free the 1MB page again.

  Ralf
