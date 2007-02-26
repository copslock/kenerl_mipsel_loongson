Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2007 21:49:53 +0000 (GMT)
Received: from xyzzy.farnsworth.org ([65.39.95.219]:18 "HELO farnsworth.org")
	by ftp.linux-mips.org with SMTP id S28639793AbXBZVtt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Feb 2007 21:49:49 +0000
Received: (qmail 741 invoked by uid 1000); 26 Feb 2007 14:48:46 -0700
From:	"Dale Farnsworth" <dale@farnsworth.org>
Date:	Mon, 26 Feb 2007 14:48:46 -0700
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Dale Farnsworth <dale@farnsworth.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC][NET] Alignment in mv643xx_eth
Message-ID: <20070226214846.GA18375@xyzzy.farnsworth.org>
References: <20070226195206.GA10188@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070226195206.GA10188@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <dale@farnsworth.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dale@farnsworth.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 26, 2007 at 07:52:06PM +0000, Ralf Baechle wrote:
> The driver contains this little piece of candy:
> 
> #if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_NOT_COHERENT_CACHE)
> #define ETH_DMA_ALIGN           L1_CACHE_BYTES
> #else
> #define ETH_DMA_ALIGN           8
> #endif
> 
> Any reason why we're not using dma_get_cache_alignment() instead?

Not that I can think of.

ACK.

Dale Farnsworth
