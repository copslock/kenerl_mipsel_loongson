Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2007 21:25:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:3263 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029603AbXIBUZZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 2 Sep 2007 21:25:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7VNgiNa020463;
	Sat, 1 Sep 2007 01:50:13 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7VNghpW020456;
	Sat, 1 Sep 2007 01:42:43 +0200
Date:	Sat, 1 Sep 2007 01:42:43 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Markus Gothe <markus.gothe@27m.se>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: flush_kernel_dcache_page() not needed ?
Message-ID: <20070831234243.GA9979@linux-mips.org>
References: <46D8089F.3010109@gmail.com> <46D82A9F.5080001@27m.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46D82A9F.5080001@27m.se>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 31, 2007 at 04:50:07PM +0200, Markus Gothe wrote:

> Ralf added this a while ago:
> 
> "arch/mips/mm/cache.c:void __flush_dcache_page(struct page *page)"

__flush_dcache_page is just the part of flush_dcache_page which does
the real work.and has nothing to do with flush_kernel_dcache_page.

  Ralf
