Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 23:40:25 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:13953 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026288AbXK0XkQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2007 23:40:16 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Ix9zG-0002cJ-00; Wed, 28 Nov 2007 00:37:06 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 50CD7C2B31; Wed, 28 Nov 2007 00:36:57 +0100 (CET)
Date:	Wed, 28 Nov 2007 00:36:57 +0100
To:	peter fuerst <post@pfrst.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] SGIWD93: use cached memory access to make driver work on IP28
Message-ID: <20071127233657.GA32469@alpha.franken.de>
References: <20071126223921.A566CC2B26@solo.franken.de> <Pine.LNX.4.58.0711272348360.407@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0711272348360.407@Indigo2.Peter>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Nov 28, 2007 at 12:00:39AM +0100, peter fuerst wrote:
> unlike with sgiseeq.c, in sgiwd93.c there's no need to bloat the hpc_chunk
> and only a single dma_cache_sync-call is necessary in fill_hpc_entries and
> init_hpc_chain respectively.

funny I realized that a couple of minutes ago. A kernel with this
changes booted ok. I'll post an updated driver tomorrow.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
