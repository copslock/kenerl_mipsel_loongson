Received:  by oss.sgi.com id <S554246AbRBEQvP>;
	Mon, 5 Feb 2001 08:51:15 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:55054 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S553839AbRBEQu5>;
	Mon, 5 Feb 2001 08:50:57 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP
	id 407274CC5F; Mon,  5 Feb 2001 09:50:52 -0700 (MST)
Message-ID: <3A7ED9EB.6080801@Lineo.COM>
Date:   Mon, 05 Feb 2001 09:50:51 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: NFS root with cache on
References: <3A79C869.2040001@Lineo.COM> <20010204194451.A26868@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


>> Is anyone else having trouble with NFS root on
>> the 2.4.0 kernel?  It won't come up with the
>> KSEG0 cache on unless I pepper the network driver
>> with flush calls.
> 
> 
> That's expected for most old network drivers that don't yet use the
> new PCI DMA API documented in Documentation/DMA-mapping.txt.
> 
> What driver is this?

Both the stock 2.4.0 tulip and eepro100 drivers.  The
problem doesn't happen when I go back to 2.3.99pre8.

In the tulip driver, both the rx and tx ring descriptors
are adjusted with pci_alloc_consistent() and are only
touched through KSEG1.

But I must be totally clueless because in both kernels
tulip_rx() calls pci_unmap_single() which does nothing.
But the skb data pointers all point to KSEG0.  With
cache on, how in the world will the kernel be able to
see what just got DMA'd into the skb?

Another thing that has been haunting me is that
in 2.3.99pre8, kmalloc() has and #ifdef __mips__ that
flushes the cache and bumps the address up to KSEG1.
This is gone in 2.4.0, but from what I can tell, this
case didn't happen for skb allocations (i.e. dev_alloc_skb)
because they only set GFP_ATOMIC, and not GFP_DMA.

Quinn
