Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 16:33:15 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9434 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027368AbXK0QdN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 16:33:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lARGX8cX027202;
	Tue, 27 Nov 2007 16:33:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lARGWvp8027176;
	Tue, 27 Nov 2007 16:32:57 GMT
Date:	Tue, 27 Nov 2007 16:32:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	jgarzik@pobox.com
Subject: Re: [PATCH] SGISEEQ: use cached memory access to make driver work
	on IP28
Message-ID: <20071127163257.GB23642@linux-mips.org>
References: <20071126223934.84BE7C2B26@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126223934.84BE7C2B26@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 24, 2007 at 01:29:19PM +0100, Thomas Bogendoerfer wrote:

> Following patch is clearly 2.6.25 material and is needed to get SGI IP28
> machines supported.
> 
> Thomas.
> 
> SGI IP28 machines would need special treatment (enable adding addtional
> wait states) when accessing memory uncached. To avoid this pain I changed
> the driver to use only cached access to memory.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

IP28 is clearly a maximum weirdo beast.  Technically the patch looks fine
it's just a few stilistic issues such as there no reason for
DMA_SYNC_DESC_CPU and DMA_SYNC_DESC_DEV being macros so why not using
inlines.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
