Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 22:12:42 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49372 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28578766AbYCUWMk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 22:12:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2LMCbOE005201;
	Fri, 21 Mar 2008 22:12:37 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2LMCUCD005200;
	Fri, 21 Mar 2008 22:12:30 GMT
Date:	Fri, 21 Mar 2008 22:12:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] WD33C93: let platform stub override
	no_sync/fast/dma_mode
Message-ID: <20080321221230.GA5097@linux-mips.org>
References: <20080321212543.6F769C2DF8@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080321212543.6F769C2DF8@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 21, 2008 at 10:25:43PM +0100, Thomas Bogendoerfer wrote:

> SGI machines with WD33C93 allow usage of burst mode DMA, which increases
> performance noticable. To make this selectable by the sgiwd93 stub,
> setting the values for no_sync, fast and dma_mode has been moved to the
> individual platform stubs.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

This is one of the things on my list of things to be fixed for IP22 for
even longer than I can recall.  Thanks Thomas!

  Ralf
