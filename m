Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 19:55:44 +0200 (CEST)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:59125 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994077AbeJDRzlzWaDp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2018 19:55:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 0D53C40A15;
        Thu,  4 Oct 2018 19:55:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WVaYVbhWTfqM; Thu,  4 Oct 2018 19:55:39 +0200 (CEST)
Received: from localhost (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7F632409F3;
        Thu,  4 Oct 2018 19:55:39 +0200 (CEST)
Date:   Thu, 4 Oct 2018 19:55:39 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Subject: Re: [PATCH] TC: Set DMA masks for devices
Message-ID: <20181004175539.GB7185@sx-9>
References: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org>
 <20181004165720.GA2361@sx-9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181004165720.GA2361@sx-9>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

H Maciej,

> > Set the regular and coherent DMA masks for TURBOchannel devices then, 
> > observing that the bus protocol supports a 34-bit (16GiB) DMA address 
> > space, by interpreting the value presented in the address cycle across 
> > the 32 `ad' lines as a 32-bit word rather than byte address[1].  The 
> > architectural size of the TURBOchannel DMA address space exceeds the 
> > maximum amount of RAM any actual TURBOchannel system in existence may 
> > have, hence both masks are the same.
> 
> A complication with the PS2 OHCI is that DMA addresses 0-0x200000 map to
> 0x1c000000-0x1c200000 as seen by the kernel. Robin suggested that the mask
> might correspond to the effective addressing capability, which would be
> DMA_BIT_MASK(21), but it does not seem to be entirely clear, since his
> commit message said that
> 
>     A somewhat similar line of reasoning also applies at the other end for
>     the mask check in dma_alloc_attrs() too - indeed, a device which cannot
>     access anything other than its own local memory probably *shouldn't*
>     have a valid mask for the general coherent DMA API.
> 
> A special circumstance here is the use of HCD_LOCAL_MEM that is a kind of
> DMA bounce buffer. Are you using anything similar with your DEFTA driver?

Sorry, I didn't interpret your comment properly. With TURBOchannel DMA
address space exceeding any practical amount of RAM, bounce buffers isn't
needed for that system. The situation is the reverse with the PS2 OHCI.

Fredrik
