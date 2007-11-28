Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 14:28:48 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49900 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030804AbXK1O1g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 14:27:36 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAS9o971011201
	for <linux-mips@linux-mips.org>; Wed, 28 Nov 2007 09:50:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAS9o98b011200;
	Wed, 28 Nov 2007 09:50:09 GMT
Date:	Wed, 28 Nov 2007 09:50:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] SGIWD93: use cached memory access to make driver work
	on IP28
Message-ID: <20071128095009.GA11063@linux-mips.org>
References: <20071126223921.A566CC2B26@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126223921.A566CC2B26@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 26, 2007 at 06:41:15PM +0100, Thomas Bogendoerfer wrote:

> Following patch is 2.6.25 material needed to get SGI IP28 machines
> supported.
> 
> Thomas.
> 
> SGI IP28 machines would need special treatment (enable adding addtional
> wait states) when accessing memory uncached. To avoid this pain I
> changed the driver to use only cached access to memory.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Same comment as for SGISEEQ: IP28 is clearly a maximum weirdo beast.
Technically the patch looks fine it's just a few stilistic issues such as
there no reason for DMA_SYNC_DESC_CPU and DMA_SYNC_DESC_DEV being macros
so why not using inlines.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
