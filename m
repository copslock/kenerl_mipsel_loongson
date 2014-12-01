Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 02:30:48 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:35116 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007758AbaLABarG5FAG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2014 02:30:47 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id DFC0D1538A; Mon,  1 Dec 2014 01:30:39 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     peter fuerst <post@pfrst.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: fast_iob() vs PHYS_OFFSET
References: <yw1xsih2evgn.fsf@unicorn.mansr.com>
        <Pine.LNX.4.64.1411300255520.2113@Opal.Peter>
        <yw1xoaroev7i.fsf@unicorn.mansr.com>
        <Pine.LNX.4.64.1412010015300.1996@Opal.Peter>
Date:   Mon, 01 Dec 2014 01:30:39 +0000
In-Reply-To: <Pine.LNX.4.64.1412010015300.1996@Opal.Peter> (peter fuerst's
        message of "Mon, 1 Dec 2014 01:29:34 +0000 (UTC)")
Message-ID: <yw1xk32cdum8.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

peter fuerst <post@pfrst.de> writes:

> Hello Måns,
>
> On Sun, 30 Nov 2014, Måns Rullgård wrote:
>
>> Date: Sun, 30 Nov 2014 12:20:17 +0000
>> From: Måns Rullgård <mans@mansr.com>
>> To: peter fuerst <post@pfrst.de>
>> Cc: linux-mips@linux-mips.org
>> Subject: Re: fast_iob() vs PHYS_OFFSET
>>
>
>>> Date: Sun, 30 Nov 2014 04:49:30 +0000 (UTC)
>>> To: Måns Rullgård <mans@mansr.com>
>>>
>>> Sorry for the mistake below: should be CKSEG[01], not CKSEG[12].
>
>> peter fuerst <post@pfrst.de> writes:
>>
>>> Hello,
>>>
>>> i don't know where fast_iob() is currently defined (it used to be in
>>> system.h in 2.6 kernels) and so don't know its current definition. But
>>
>> It's in asm/barrier.h, and looks like this for non-IP28:
>>
>> #define __fast_iob()				\
> ...
>> 		: "m" (*(int *)CKSEG1)		\
> ...
>> # endif
>
> this looks as it used to look since long.
>
>>
>>> if PHYS_OFFSET appears in the definition, this may be plain wrong.
>>> (and any conjunction of PHYS_OFFSET with CKSEG1 would be bizarre).
>>>
>>> PHYS_OFFSET is (at least on IP28) just the physical address, where the
>>> RAM starts, and has no righteous place in address-calculations, MIPS's
>>> "unmapped" kernel-addresses (CKSEG[12], XKPHYS) are independent from
>>> soldering the RAM.
>>
>> CKSEG[01] map to physical addresses starting from 0 bypassing the MMU.
>> If there is no RAM at address 0, I wouldn't expect reading from the
>> first word of CKSEG1 to work very well.
>>
>>> On IP28, with PHYS_OFFSET 0x20000000, RAM consequently begins at the
>>> kernel-address(es) 0xXY00000020000000.  (Btw, you won't reach the RAM
>>> with CKSEG[12] here, XKPHYS is needed)
>>
>> IP28 has a special definition of __fast_iob() that reads from
>> CKSEG1ADDR(0x1fa00004).  I have no idea what lives at that address, but
>
> IOC2, HPC3, ...
>
>> presumably something that responds to reads in a RAM-like fashion.
>>
>> My concern is over systems like AR7.  It defines PHYS_OFFSET to
>> 0x14000000 and UNCAC_BASE, correspondingly, to 0xb4000000.  According to
>
> I'm confused. Shouldn't *CAC_BASE point to the begin of an address-space?

I can't find any description of what all these macros are supposed to
be.  This makes it a bit difficult to reason about correctness.

That said, if they were supposed to duplicate [CX]SEG[01], there
wouldn't be much need for them in the first place.

>> the linux-mips wiki, there is some on-chip RAM at physical address 0,
>> which explains why the __fast_iob() macro works there.
>>
>> I'm dealing with another chip with non-zero PHYS_OFFSET which AFAIK does
>> not have anything mapped at physical address 0 (I don't have data sheets).
>> The Evil Vendor Tree has ifdefs all over the place, most of them bizarre
>> and wrong, and I'm trying to clean things up a bit.
>
> There are mailing list members, that worked a lot on AR7, perhaps they
> can help you. At least provide you with data sheets.

I'm not working on AR7.  That was just an example currently in-tree.

> Besides AR7, (more or less) precise definitions of *CAC_BASE, PAGE_OFFSET,
> PHYS_OFFSET, ... perhaps wouldn't hurt either.

Definitely.

-- 
Måns Rullgård
mans@mansr.com
