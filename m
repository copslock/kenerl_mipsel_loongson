Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2009 23:01:00 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49043 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808521AbZCMXA6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2009 23:00:58 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2DN0rOo031553;
	Sat, 14 Mar 2009 00:00:55 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2DN0n3l031550;
	Sat, 14 Mar 2009 00:00:49 +0100
Date:	Sat, 14 Mar 2009 00:00:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jan Nikitenko <jan.nikitenko@gmail.com>
Cc:	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: fix oops in dma_unmap_page on not coherent mips platforms
Message-ID: <20090313230049.GA30319@linux-mips.org>
References: <20081128075258.GA10200@nikitenko.systek.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081128075258.GA10200@nikitenko.systek.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

> dma_cache_wback_inv() expects virtual address, but physical was provided
> due to translation via plat_dma_addr_to_phys().
> If replaced with dma_addr_to_virt(), page fault oops from dma_unmap_page()
> is gone on au1550 platform.
> 
> Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>

Applied, finally ...

  Ralf
