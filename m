Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2004 23:50:30 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:46604
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8225003AbUJJWu0>;
	Sun, 10 Oct 2004 23:50:26 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9AMoMu17840;
	Sun, 10 Oct 2004 15:50:23 -0700
Message-ID: <4169BCA6.1080102@embeddedalley.com>
Date: Sun, 10 Oct 2004 15:50:14 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
References: <1097428659.4627.10.camel@localhost.localdomain> <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be> <Pine.LNX.4.58L.0410102004190.4217@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0410102004190.4217@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 10 Oct 2004, Geert Uytterhoeven wrote:
> 
> 
>>>Ralf, or anyone else, any suggestions on how to get a patch like the one
>>>below accepted in 2.6? It's needed due to the 36 bit address of the
>>>pcmcia controller on the Au1x CPUs.
>>
>>Perhaps you can ask the PPC people? Book E PPC has 36-bit I/O as well.
> 
> 
>  Using 36-bit pointers for PCMCIA seems questionable to me -- does the bus
> support such wide addresses?  

Sort of. The internal CPU bus has a 36 bit chip select. You never see 
the 36 bit phys address on the bus, but the PCI, external LCD, and 
pcmcia addresses are 36 bit. That's the reason for the 36 bit I/O 
address patch I sent last night.

> If not, why not use a data type that covers
> valid offsets only when passing addresses to bus access functions? 

The attribute and memory pcmcia addresses are just stored in these 
variables, and then the upper pcmcia stack layer calls ioremap on these 
addresses. Thus, you need the 36 bit I/O address patch, as well as the 
tiny pcmcia patch.

The pcmcia I/O address is ioremapped at the socket driver level. If that 
was the case with the mem and attribute addresses, I wouldn't need this 
64 bit pcmcia patch. But since it's the upper pcmcia layer that ioremaps 
these addresses, I need to store tham in 64 bit types.

Pete
