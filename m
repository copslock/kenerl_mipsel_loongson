Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Aug 2006 20:31:29 +0100 (BST)
Received: from f2s.colonel-panic.org ([83.67.53.76]:5806 "EHLO
	nephila.localnet") by ftp.linux-mips.org with ESMTP
	id S20038563AbWHXTb2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Aug 2006 20:31:28 +0100
Received: by nephila.localnet (Postfix, from userid 1000)
	id C64C91864461; Thu, 24 Aug 2006 20:31:21 +0100 (BST)
Date:	Thu, 24 Aug 2006 20:31:21 +0100
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 9/12] removed unused resources for Cobalt
Message-ID: <20060824193121.GA23792@colonel-panic.org>
References: <20060822225755.55a055c0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822225755.55a055c0.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.9i
From:	pdh@colonel-panic.org (Peter Horton)
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 22, 2006 at 10:57:55PM +0900, Yoichi Yuasa wrote:
> 
> This patch has removed unused resources for Cobalt.
> 
> -static struct resource cobalt_io_resources[] = {
> -	{
> -		.start	= 0x00,
> -		.end	= 0x1f,
> -		.name	= "dma1",
> -		.flags	= IORESOURCE_BUSY
> -	}, {
> -		.start	= 0x40,
> -		.end	= 0x5f,
> -		.name	= "timer",
> -		.flags	= IORESOURCE_BUSY
> -	}, {
> -		.start	= 0x60,
> -		.end	= 0x6f,
> -		.name	= "keyboard",
> -		.flags	= IORESOURCE_BUSY
> -	}, {
> -		.start	= 0x80,
> -		.end	= 0x8f,
> -		.name	= "dma page reg",
> -		.flags	= IORESOURCE_BUSY
> -	}, {
> -		.start	= 0xc0,
> -		.end	= 0xdf,
> -		.name	= "dma2",
> -		.flags	= IORESOURCE_BUSY
> -	},
> -};
> -

Is this correct ? These resources maybe unused, but the registers are
there, and should be listed as unavailable.

P.
