Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 May 2008 13:13:35 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:35234 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20033905AbYEXMNd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 May 2008 13:13:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m4OCDTCO004924;
	Sat, 24 May 2008 13:13:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4OCDO98004892;
	Sat, 24 May 2008 13:13:24 +0100
Date:	Sat, 24 May 2008 13:13:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP27: misc fixes
Message-ID: <20080524121324.GC20822@linux-mips.org>
References: <20080417200742.9914FC2BFD@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080417200742.9914FC2BFD@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 17, 2008 at 10:07:42PM +0200, Thomas Bogendoerfer wrote:

> @@ -100,6 +103,13 @@ int __cpuinit bridge_probe(nasid_t nasid, int widget_id, int masterwid)
>  	 */
>  	bridge->b_wid_control |= BRIDGE_CTRL_IO_SWAP |
>  	                         BRIDGE_CTRL_MEM_SWAP;
> +#ifdef CONFIG_PAGE_SIZE_4KB
> +	bridge->b_wid_control &= ~BRIDGE_CTRL_PAGE_SIZE;
> +#elif defined(CONFIG_PAGE_SIZE_16KB)
> +	bridge->b_wid_control |= BRIDGE_CTRL_PAGE_SIZE;
> +#else
> +#error Fixme for page size other than 4kB and 16kB
> +#endif

This blows up with 64k pages or larger (if anybody is mad enough ...)  The
reason for this setting is so the BRIDGE ASIC knows about the pagesize
and can avoid prefetching over a page boundary.  That is a too small value
is always safe.  I applied your patch with this small fix on top.

Thanks,

  Ralf
