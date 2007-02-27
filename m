Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 09:25:13 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:36537 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20038728AbXB0JZI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2007 09:25:08 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HLyWz-000875-2d; Tue, 27 Feb 2007 09:21:57 +0000
Message-ID: <45E3F834.70307@garzik.org>
Date:	Tue, 27 Feb 2007 04:21:56 -0500
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Dale Farnsworth <dale@farnsworth.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [RFC][NET] Alignment in mv643xx_eth
References: <20070226195206.GA10188@linux-mips.org>
In-Reply-To: <20070226195206.GA10188@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> The driver contains this little piece of candy:
> 
> #if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_NOT_COHERENT_CACHE)
> #define ETH_DMA_ALIGN           L1_CACHE_BYTES
> #else
> #define ETH_DMA_ALIGN           8
> #endif
> 
> Any reason why we're not using dma_get_cache_alignment() instead?
> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

applied
