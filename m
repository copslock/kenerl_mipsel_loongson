Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2004 21:26:01 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:32957 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225458AbUC2U0A>; Mon, 29 Mar 2004 21:26:00 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B83KU-0005ys-00; Mon, 29 Mar 2004 14:25:54 -0600
Message-ID: <4068864D.1020209@realitydiluted.com>
Date: Mon, 29 Mar 2004 15:25:49 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Murphy <brian@murphy.dk>
CC: linux-mips@linux-mips.org
Subject: Re: BUG in pcnet32.c?
References: <4068809F.8070103@murphy.dk>
In-Reply-To: <4068809F.8070103@murphy.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Brian Murphy wrote:
> In pcnet32.c where the driver writer sets up her receive buffers there 
> is this line
> 
> lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, 
> rx_skbuff->len, PCI_DMA_FROMDEVICE);
> 
> the length value turns out to be 0 and crashes the running 
> process,ifconfig.
> Is making a map for a buffer of length 0 valid at all? If not what the 
> hell is going on here.
> 
> I feel this should say PKT_BUF_SZ instead of rx_skbuff->len which is the 
> length of skbuff which has been
> allocated at this point in the code, this is line 986 in todays checkout.
> 
> Something is wrong in any case, any pointers?
> 
Excellent. So my new BUG code detected another bad network driver. Your network
driver is broken and it needs fixed. I will refer you to these posts between
Jeff Garzik and myself when I found a similar issue on the 'natsemi.c' driver.
Mapping a PCI address with length zero is a BUG, period. You length should
be the maximum RX buffer length + 2. You will see from the patches in the
messages below that this is for IP header alignment. Good luck and please let
use know how it turns out.

-Steve

http://lkml.org/lkml/2004/3/16/218
http://lkml.org/lkml/2004/3/16/244
