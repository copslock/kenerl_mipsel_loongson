Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 13:12:11 +0100 (BST)
Received: from bay15-f19.bay15.hotmail.com ([IPv6:::ffff:65.54.185.19]:46091
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225221AbUIPMMG>; Thu, 16 Sep 2004 13:12:06 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 16 Sep 2004 04:38:23 -0700
Received: from 82.200.0.252 by by15fd.bay15.hotmail.msn.com with HTTP;
	Thu, 16 Sep 2004 11:38:23 GMT
X-Originating-IP: [82.200.0.252]
X-Originating-Email: [alexshinkin@hotmail.com]
X-Sender: alexshinkin@hotmail.com
From: "Alexey Shinkin" <alexshinkin@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Au1550 - Problem access Shared memory from PCI card
Date: Thu, 16 Sep 2004 18:38:23 +0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY15-F19LS73JsNgMI0005f044@hotmail.com>
X-OriginalArrivalTime: 16 Sep 2004 11:38:23.0797 (UTC) FILETIME=[AC8B3E50:01C49BE1]
Return-Path: <alexshinkin@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexshinkin@hotmail.com
Precedence: bulk
X-list: linux-mips


>There's no reason why this shouldn't work and it doesn't smell like a 
>hardware problem.
>


The problem is solved !

The reason was that shared memory on host have been allocated using
__get_free_pages(GFP_KERNEL, get_order(NumberOfBytes))

it returned addresses like 0x8xxxxxxx (KSEG0, cacheable)

I was adviced to use pci_alloc_consistent() instead , this function uses 
__get_free_pages
but sets some GFP flags and returns addresses like 0xAxxxxxxx (KSEG1).
With this function all works fine !

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail
