Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 23:05:37 +0000 (GMT)
Received: from p508B7A82.dip.t-dialin.net ([IPv6:::ffff:80.139.122.130]:32840
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225474AbUARXFY>; Sun, 18 Jan 2004 23:05:24 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0IN5M4P003483;
	Mon, 19 Jan 2004 00:05:22 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0IN5J4W003482;
	Mon, 19 Jan 2004 00:05:19 +0100
Date: Mon, 19 Jan 2004 00:05:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: DMA_NONCOHERENT and dma_map_single
Message-ID: <20040118230519.GA31919@linux-mips.org>
References: <20040118195006.GA22616@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118195006.GA22616@sonycom.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 18, 2004 at 08:50:06PM +0100, Dimitri Torfs wrote:

>   dma_map_single() is supposed to be called on a buffer that exactly
>   starts and ends on a cacheline boundary, otherwise "bad things"
>   (e.g. overwrite of data that was written by device, ...) (especially
>   on dma non-coherent systems) may happen. 
> 
>   So what should be done when dma_map_single is not called
>   with a sane (ptr, size) argument ?
> 
>     - is the driver (caller) considered buggy and should we return a 0
>       return-value ?
>     - is the driver (caller) considered buggy but we do the mapping
>       anyway, hoping that the driver has not/will not touched/touch
>       the boundary cachelines ?

The driver is considered buggy;  dma_map_single's behaviour is undefined so
it's perfectly ok if it paints neighbour's cat pink ;-)

>     - should we take appropriate actions to make sure the
>       cache-effects do not come into play (e.g. by using some kind of
>       bounce buffer) ?

Technically bounce buffers can be handled inside dma_map_single & co but
it's not a good idea.  Better set the appropriate flags so higher levels
can allocate memory with the appropriate GFP_* flags and thereby hopefully
avoid overly frequent buffer bouncing.

  Ralf
