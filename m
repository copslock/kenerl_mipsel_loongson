Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 00:11:25 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:44827 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038608AbWHXXLW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2006 00:11:22 +0100
Received: by mo.po.2iij.net (mo31) id k7ONBCm4047347; Fri, 25 Aug 2006 08:11:12 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k7ONB8Dv083176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 25 Aug 2006 08:11:08 +0900 (JST)
Date:	Fri, 25 Aug 2006 08:11:07 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	pdh@colonel-panic.org (Peter Horton)
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 9/12] removed unused resources for Cobalt
Message-Id: <20060825081107.45e9996e.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060824193121.GA23792@colonel-panic.org>
References: <20060822225755.55a055c0.yoichi_yuasa@tripeaks.co.jp>
	<20060824193121.GA23792@colonel-panic.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 24 Aug 2006 20:31:21 +0100
pdh@colonel-panic.org (Peter Horton) wrote:

> On Tue, Aug 22, 2006 at 10:57:55PM +0900, Yoichi Yuasa wrote:
> > 
> > This patch has removed unused resources for Cobalt.
> > 
> > -static struct resource cobalt_io_resources[] = {
> > -	{
> > -		.start	= 0x00,
> > -		.end	= 0x1f,
> > -		.name	= "dma1",
> > -		.flags	= IORESOURCE_BUSY
> > -	}, {
> > -		.start	= 0x40,
> > -		.end	= 0x5f,
> > -		.name	= "timer",
> > -		.flags	= IORESOURCE_BUSY
> > -	}, {
> > -		.start	= 0x60,
> > -		.end	= 0x6f,
> > -		.name	= "keyboard",
> > -		.flags	= IORESOURCE_BUSY
> > -	}, {
> > -		.start	= 0x80,
> > -		.end	= 0x8f,
> > -		.name	= "dma page reg",
> > -		.flags	= IORESOURCE_BUSY
> > -	}, {
> > -		.start	= 0xc0,
> > -		.end	= 0xdf,
> > -		.name	= "dma2",
> > -		.flags	= IORESOURCE_BUSY
> > -	},
> > -};
> > -
> 
> Is this correct ? These resources maybe unused, but the registers are
> there, and should be listed as unavailable.

How about the change of them to "reserved"?

Yoichi
