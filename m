Received:  by oss.sgi.com id <S554193AbRBEVP0>;
	Mon, 5 Feb 2001 13:15:26 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:57359 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S554184AbRBEVPA>;
	Mon, 5 Feb 2001 13:15:00 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP
	id 2C41B4CE9E; Mon,  5 Feb 2001 14:14:48 -0700 (MST)
Message-ID: <3A7F17C7.4070406@Lineo.COM>
Date:   Mon, 05 Feb 2001 14:14:47 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     jsun@hermes.mvista.com
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: NFS root with cache on
References: <3A79C869.2040001@Lineo.COM> <20010204194451.A26868@bacchus.dhis.org> <3A7ED9EB.6080801@Lineo.COM> <3A7EEBD6.F4743A97@mvista.com> <3A7EF431.2060903@Lineo.COM> <3A7EFBC7.9B7D6AF9@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

jsun@hermes.mvista.com wrote:

>> 
>> I have tried that in this case but it didn't help,
>> because the receive skb data pointers all point to
>> the KSEG0 view of the data anyway. 
> 
> 
> I looked into similar problems a while back.  If I remeber correctly, the data
> pointers do point to kseg0.  It is up to the driver to do appropriate
> dma_cache_invalidate() (or some functions to that effect) at certain places.

Yes, the tulip driver calls pci_unmap_single() on the receive
buffer, but for mips (in asm-mips/pci.h) this call does
nothing.  And this is what is so confusing.  Only if the
receive buffer was forced to be in KSEG1 would this make
sense.

> 
> What is the CPU?  It seems logical to suspect about the dma cache routines.

Yes, I have scrubbed over my patch to the cache routines
many times, especially since on the IDT 334 the cache-way
selection for indexed cache ops is weird--they left the
way-bit up at bit 12 as if it were an 8KB cache, when
in reality it is only a 2KB cache.

Quinn
