Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 16:11:27 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:262 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465580AbVI3PLA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 16:11:00 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UFAsvx012083;
	Fri, 30 Sep 2005 16:10:54 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8UFAqTv012082;
	Fri, 30 Sep 2005 16:10:52 +0100
Date:	Fri, 30 Sep 2005 16:10:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: missing data cache flush for signal trampoline on fork
Message-ID: <20050930151052.GD3083@linux-mips.org>
References: <20050928.203429.02302175.nemoto@toshiba-tops.co.jp> <20050928.205758.32501424.nemoto@toshiba-tops.co.jp> <20050930.123241.72709288.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930.123241.72709288.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 30, 2005 at 12:32:41PM +0900, Atsushi Nemoto wrote:
> Date:	Fri, 30 Sep 2005 12:32:41 +0900 (JST)
> To:	linux-mips@linux-mips.org
> Cc:	ralf@linux-mips.org
> Subject: Re: missing data cache flush for signal trampoline on fork
> From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Content-Type: Text/Plain; charset=us-ascii
> 
> >>>>> On Wed, 28 Sep 2005 20:57:58 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
> anemo> Sorry, this would corrupt cpu_has_ic_fills_f_dc case.  Revised.
> 
> The patch was overkill.  The indexed-flush is required only for
> d-cache.  Revised.

Hmm...  Your patch may be right for the time being but I think this should
the whole flushing biz should actually be handled via update_mmu_cache by
adding something along the lines of:

...
	if (vma->flags & VM_EXEC)
		do_flush_icache_page(addr);
...

What do you think?

  Ralf
