Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 23:34:09 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:11270 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8226750AbVGOWdu>; Fri, 15 Jul 2005 23:33:50 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j6FMLAmN023670;
	Fri, 15 Jul 2005 18:21:10 -0400
In-Reply-To: <42D836F8.8030209@mazunetworks.com>
References: <42D836F8.8030209@mazunetworks.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dc678ee4c98d1fc3eb2cb1960b759f05@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Why is mmap()ed reserved memory so slow?
Date:	Fri, 15 Jul 2005 18:35:11 -0400
To:	David Chau <dchau@mazunetworks.com>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jul 15, 2005, at 6:21 PM, David Chau wrote:

> For those of you who knows how the Linux VM works, could you tell me 
> why the memory access is so slow? It look like it might be invoking 
> the page-fault handler on every read. How can I make memory access 
> faster?

How about a little more info, like what kernel are you using and what 
are
the parameters you are sending to mmap()?

One of the things that happens here is /dev/mem is thinking this memory 
is
not real memory (because you said the system has only 253M of real
memory), so it treats it like IO space.  This causes changes to the 
attributes
of the pages, most notably the CCA type for cache or pipeline behavior,
which isn't what you want in this case.

The better way to approach this is to place an mmap() function in the
associated driver that works in conjunction with the application to gain
shared access as you expect.  This also closes a hole where an errant
application could write into unexpected places through /dev/mem.

Thanks.

	-- Dan
