Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 01:39:57 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:17421
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8225255AbUJKAjx>;
	Mon, 11 Oct 2004 01:39:53 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9B0dlu18904;
	Sun, 10 Oct 2004 17:39:48 -0700
Message-ID: <4169D64A.9030303@embeddedalley.com>
Date: Sun, 10 Oct 2004 17:39:38 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
References: <1097428659.4627.10.camel@localhost.localdomain> <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be> <Pine.LNX.4.58L.0410102004190.4217@blysk.ds.pg.gda.pl> <4169BCA6.1080102@embeddedalley.com> <Pine.LNX.4.58L.0410110102440.4217@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0410110102440.4217@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 10 Oct 2004, Pete Popov wrote:
> 
> 
>>>If not, why not use a data type that covers
>>>valid offsets only when passing addresses to bus access functions? 
>>
>>The attribute and memory pcmcia addresses are just stored in these 
>>variables, and then the upper pcmcia stack layer calls ioremap on these 
>>addresses. Thus, you need the 36 bit I/O address patch, as well as the 
>>tiny pcmcia patch.
>>
>>The pcmcia I/O address is ioremapped at the socket driver level. If that 
>>was the case with the mem and attribute addresses, I wouldn't need this 
>>64 bit pcmcia patch. But since it's the upper pcmcia layer that ioremaps 
>>these addresses, I need to store tham in 64 bit types.
> 
> 
>  OK, but then phys_t should be used for ioaddr_t universally, shouldn't
> it?  Any architecture can have the controller seen in a 64-bit memory
> space, after all.

Perhaps, but when I tried that in 2.4, I got rejected. Matt had an idea 
that works for both, mips and ppc, since the 36 bit fixup_bigphys_addr 
routine is very similar. I think I'll pursue that instead, since we 
already have that routine as part of the pci address support. Thus, I 
won't have to make pcmcia changes to common files, and no more 
64bit_pcmcia.patch hanging around in my directory.

Pete
