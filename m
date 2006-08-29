Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 15:00:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16559 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039464AbWH2OAf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 15:00:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k7TE11x9031751;
	Tue, 29 Aug 2006 15:01:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7TE10Sn031750;
	Tue, 29 Aug 2006 15:01:00 +0100
Date:	Tue, 29 Aug 2006 15:01:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Watkins <treestem@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 64K page size
Message-ID: <20060829140100.GC29289@linux-mips.org>
References: <44EC7125.7000000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EC7125.7000000@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 23, 2006 at 11:15:49AM -0400, Peter Watkins wrote:

> There are a number of changes required to support larger page sizes, but 
> this one I thought worth sending up right away.
> 
> The code in pgtable-64.h assumes TASK_SIZE is always bigger than a first 
> level PGDIR_SIZE. This is not the case for 64K pages, where task size is 
> 40 bits (1TB) and a pgd entry can map 42 bits. This leads to 
> USER_PTRS_PER_PGD being zero for 64K pages.

Thanks, applied.

  Ralf
