Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2004 23:53:06 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:48140
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8225003AbUJJWxB>;
	Sun, 10 Oct 2004 23:53:01 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9AMqtu17858;
	Sun, 10 Oct 2004 15:52:55 -0700
Message-ID: <4169BD3B.1030908@embeddedalley.com>
Date: Sun, 10 Oct 2004 15:52:43 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
References: <1097428659.4627.10.camel@localhost.localdomain> <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be> <20041010123305.A23745@home.com>
In-Reply-To: <20041010123305.A23745@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Matt Porter wrote:
> On Sun, Oct 10, 2004 at 08:01:28PM +0200, Geert Uytterhoeven wrote:
> 
>>On Sun, 10 Oct 2004, Pete Popov wrote:
>>
>>>Ralf, or anyone else, any suggestions on how to get a patch like the one
>>>below accepted in 2.6? It's needed due to the 36 bit address of the
>>>pcmcia controller on the Au1x CPUs.
>>
>>Perhaps you can ask the PPC people? Book E PPC has 36-bit I/O as well.
> 
>  
> FWIW, it's specifically PPC440 cores that have a 36-bit address space.
> It should be noted that nobody has as of yet expressed public interest
> in having PCMCIA working on PPC440. I just ran into a person with a
> custom board last week interfacing a CF card that would need a similar
> patch to handle ppc's phys_addr_t.
> 
> To answer Pete's original question, I would suggest posting the patch
> to http://lists.infradead.org/mailman/listinfo/linux-pcmcia which is
> where PCMCIA subsystem development conversations are taking place. It
> might be good to cc: rmk since he's been the de facto PCMCIA
> maintainer.

I'll try that, thanks. If more SOCs needed this feature, it might have 
been possible to get it accepted in 2.4 a long time ago.  With the 
PPC440, now it's not only the Au1x that needs the patch.

Pete
