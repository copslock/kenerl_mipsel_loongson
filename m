Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Nov 2014 13:20:26 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:32844 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006584AbaK3MUXJyb0j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Nov 2014 13:20:23 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 165001538A; Sun, 30 Nov 2014 12:20:17 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     peter fuerst <post@pfrst.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: fast_iob() vs PHYS_OFFSET
References: <yw1xsih2evgn.fsf@unicorn.mansr.com>
        <Pine.LNX.4.64.1411300255520.2113@Opal.Peter>
Date:   Sun, 30 Nov 2014 12:20:17 +0000
In-Reply-To: <Pine.LNX.4.64.1411300255520.2113@Opal.Peter> (peter fuerst's
        message of "Sun, 30 Nov 2014 04:39:44 +0000 (UTC)")
Message-ID: <yw1xoaroev7i.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44519
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

> Hello,
>
> i don't know where fast_iob() is currently defined (it used to be in
> system.h in 2.6 kernels) and so don't know its current definition. But

It's in asm/barrier.h, and looks like this for non-IP28:

#define __fast_iob()				\
	__asm__ __volatile__(			\
		".set	push\n\t"		\
		".set	noreorder\n\t"		\
		"lw	$0,%0\n\t"		\
		"nop\n\t"			\
		".set	pop"			\
		: /* no output */		\
		: "m" (*(int *)CKSEG1)		\
		: "memory")

#  define fast_iob()				\
	do {					\
		__sync();			\
		__fast_iob();			\
	} while (0)
# endif

> if PHYS_OFFSET appears in the definition, this may be plain wrong.
> (and any conjunction of PHYS_OFFSET with CKSEG1 would be bizarre).
>
> PHYS_OFFSET is (at least on IP28) just the physical address, where the
> RAM starts, and has no righteous place in address-calculations, MIPS's
> "unmapped" kernel-addresses (CKSEG[12], XKPHYS) are independent from
> soldering the RAM.

CKSEG[01] map to physical addresses starting from 0 bypassing the MMU.
If there is no RAM at address 0, I wouldn't expect reading from the
first word of CKSEG1 to work very well.

> On IP28, with PHYS_OFFSET 0x20000000, RAM consequently begins at the
> kernel-address(es) 0xXY00000020000000.  (Btw, you won't reach the RAM
> with CKSEG[12] here, XKPHYS is needed)

IP28 has a special definition of __fast_iob() that reads from
CKSEG1ADDR(0x1fa00004).  I have no idea what lives at that address, but
presumably something that responds to reads in a RAM-like fashion.

My concern is over systems like AR7.  It defines PHYS_OFFSET to
0x14000000 and UNCAC_BASE, correspondingly, to 0xb4000000.  According to
the linux-mips wiki, there is some on-chip RAM at physical address 0,
which explains why the __fast_iob() macro works there.

I'm dealing with another chip with non-zero PHYS_OFFSET which AFAIK does
not have anything mapped at physical address 0 (I don't have data sheets).
The Evil Vendor Tree has ifdefs all over the place, most of them bizarre
and wrong, and I'm trying to clean things up a bit.

> The spread of PHYS_OFFSET began several years ago with someone
> introducing '#define PAGE_OFFSET (CAC_BASE + PHYS_OFFSET)' instead of
> the former '#define PAGE_OFFSET CAC_BASE'.
> Perhaps just to allow retaining 'free_area_init(zones_size)' instead of
> the need to replace this by 'free_area_init_node(0, NODE_DATA(0),
> zones_size, PHYS_OFFSET, NULL)', since the "new" PAGE_OFFSET brings in
> PHYS_OFFSET through the backdoor.
> But, since kernel-addresses are (canonically ;-) calculated by adding or
> subtracting PAGE_OFFSET, the new definition had/has to be compensated
> for by introducing PHYS_OFFSET into macros in numerous places (maybe
> by some trial-and-error actions ;-)

That was more or less the impression I got while chasing the values
through the various macro definitions.

> kind regards
>
> peter
>
> On Fri, 28 Nov 2014, Måns Rullgård wrote:
>
>> Date: Fri, 28 Nov 2014 23:50:16 +0000
>> From: Måns Rullgård <mans@mansr.com>
>> To: linux-mips@linux-mips.org
>> Subject: fast_iob() vs PHYS_OFFSET
>>
>> I'm a little confused over the interaction between fast_iob() and
>> non-zero PHYS_OFFSET.
>>
>> The __fast_iob() macro performs a load from CKSEG1.  AFAICT, CKSEG1 is
>> always (on 32-bit systems) defined to 0xa0000000.  In case of a non-zero
>> PHYS_OFFSET, this address might not map to anything in particular, and
>> almost certainly not RAM.  There is a special case for IP28, but this is
>> not the only system with an unusual address map.
>>
>> What am I missing?
>>
>> -- 
>> Måns Rullgård
>> mans@mansr.com
>>
>>

-- 
Måns Rullgård
mans@mansr.com
