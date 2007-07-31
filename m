Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 11:00:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56278 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021626AbXGaKA3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jul 2007 11:00:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6VA0Sla004122;
	Tue, 31 Jul 2007 11:00:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6VA0RLQ004121;
	Tue, 31 Jul 2007 11:00:27 +0100
Date:	Tue, 31 Jul 2007 11:00:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dajie Tan <jiankemeng@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] 16K page size in 32 bit kernel
Message-ID: <20070731100027.GA3983@linux-mips.org>
References: <20070731130950.GA5540@sw-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070731130950.GA5540@sw-linux.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 31, 2007 at 05:09:51PM +0400, Dajie Tan wrote:

> 32-bit Kernel for loongson2e currently use 16KB page size to avoid
> cache alias problem.So, the definiton of PGDIR_SHIFT muse be 12+14.
> 
> Using 22 in 16K page size do not lead to a serious problem but the number
> of pages allocated for page table is more than previous. (cat
> /proc/vmstat | grep nr_page_table_pages)
> 
> It's been tested on FuLong mini PC(loongson2e inside).

Looking good, applied.  Thanks!

Did by coincidence any of you try 64K pages with a 32-bit kernel?

  Ralf
