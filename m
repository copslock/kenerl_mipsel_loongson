Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 09:16:30 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:7332 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022883AbXK0JQW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2007 09:16:22 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IwwVD-00026k-00; Tue, 27 Nov 2007 10:13:11 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4267AC2B2B; Tue, 27 Nov 2007 10:01:39 +0100 (CET)
Date:	Tue, 27 Nov 2007 10:01:39 +0100
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] SGIWD93: use cached memory access to make driver work on IP28
Message-ID: <20071127090139.GA6933@alpha.franken.de>
References: <20071126223921.A566CC2B26@solo.franken.de> <Pine.LNX.4.64.0711270927370.22167@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711270927370.22167@anakin>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Nov 27, 2007 at 09:28:14AM +0100, Geert Uytterhoeven wrote:
> >  struct hpc_chunk {
> >  	struct hpc_dma_desc desc;
> > -	u32 _padding;	/* align to quadword boundary */
> > +	u32 _padding[128/4 - 3];	/* align to biggest cache line size */
>                      ^^^^^^^^^
> (128 - sizeof(struct hpc_dma_desc))/4?

yes, that's safer. Thank you.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
