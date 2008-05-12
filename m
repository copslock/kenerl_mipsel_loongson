Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 12:22:39 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:43136 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030582AbYELLWh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 12:22:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4CBMXPD010382;
	Mon, 12 May 2008 12:22:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4CBMXFH010381;
	Mon, 12 May 2008 12:22:33 +0100
Date:	Mon, 12 May 2008 12:22:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: is remap_pfn_range should align to 2(n) * (page size) ?
Message-ID: <20080512112233.GA8843@linux-mips.org>
References: <50c9a2250805082354x1edc1ecar89dcc3378b3bbe75@mail.gmail.com> <20080509095605.GB14450@linux-mips.org> <50c9a2250805111918r16913139obfc2982220636b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250805111918r16913139obfc2982220636b3@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2008 at 10:18:27AM +0800, zhuzhenhua wrote:

> > This has nothing to do with remap_pfn_range but with the power of two
> > sized buckets used by the global free page pool.  Any allocation with
> > get_free_pages will be rounded up to the next power of two.  If that's a
> > real concern for you you could allocate a 4MB page then split the page
> > into a 2MB and two 1MB pages and free the 1MB page again.

> thanks for your reply , i see in get_frree_pages and free_pages there is a
> get_order(size).
> but i don't understand  " allocate a 4MB page then split the page
> into a 2MB and two 1MB pages and free the 1MB page again."
> is there any function to split it?

No, you'd have to code that yourself.  Take a look at split_page() which
splits an order n page into order 0 pages.  You'd want something similar
but splitting for some non-zero order.

  Ralf
