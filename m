Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 21:20:56 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:39419 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225288AbUDTUUz>;
	Tue, 20 Apr 2004 21:20:55 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA11637;
	Tue, 20 Apr 2004 13:20:48 -0700
Message-ID: <4085861D.4030603@mvista.com>
Date: Tue, 20 Apr 2004 13:20:45 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <20040420163230Z8225288-1530+99@linux-mips.org> <20040420105116.C22846@mvista.com> <20040420201128.GC24025@linux-mips.org>
In-Reply-To: <20040420201128.GC24025@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Tue, Apr 20, 2004 at 10:51:16AM -0700, Jun Sun wrote:
>
>  
>
>>CONFIG_PCI_AUTO was meant to a board attribute.  It should not be changed
>>to be a choice at the first place.
>>
>>And, the code is not bOrked.  In 2.4 it is a life saver for most MIPS boards
>>whose firmware do not do a proper or full PCI resource assignment.
>>    
>>
>
>drivers/pci can do that, you just need to supply a few board specific
>functions, see for example arch/alpha/kernel/pci.c.  
>
>So pci_auto.c isn't only b0rked, it also duplicates code.
>  
>
I guess I have different take on it, in line with Jun's. Before pci 
auto, I remember new boards going in without proper pci config support 
or with massive amounts of new board specific code. Take a look at the 
gt64xxx code (though I think it's been cleaned up a lot since then). 
After pci auto, adding pci support for a new board became trivial and I 
haven't seen anymore code duplication with new boards adding their own, 
complete, pci resource assignment routines.  Pci auto was added a long 
time ago. If it has outlived its purpose, that's fine, but back then it 
was a major improvement to the mips pci subsystem, imho.

Pete
