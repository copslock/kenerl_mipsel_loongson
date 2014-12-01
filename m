Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 01:29:51 +0100 (CET)
Received: from mail1.pearl-online.net ([62.159.194.147]:60033 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007753AbaLAA3smZiR3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2014 01:29:48 +0100
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id 0BB6CB21127;
        Mon,  1 Dec 2014 01:29:43 +0100 (CET)
Received: from Opal.Peter (Opal.Peter [192.168.1.1])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id sB140EWv001200;
        Mon, 1 Dec 2014 04:00:14 GMT
Received: from Opal.Peter (localhost [127.0.0.1])
        by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Sendmail/Linux 2.4.24-1-386) with ESMTP id sB11TYKg002099;
        Mon, 1 Dec 2014 01:29:34 GMT
Received: from localhost (pf@localhost)
        by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Debian-1) with ESMTP id sB11TYTO002096;
        Mon, 1 Dec 2014 01:29:34 GMT
X-Authentication-Warning: Opal.Peter: pf owned process doing -bs
Date:   Mon, 1 Dec 2014 01:29:34 +0000 (UTC)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Opal.Peter
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
cc:     linux-mips@linux-mips.org
Subject: Re: fast_iob() vs PHYS_OFFSET
In-Reply-To: <yw1xoaroev7i.fsf@unicorn.mansr.com>
Message-ID: <Pine.LNX.4.64.1412010015300.1996@Opal.Peter>
References: <yw1xsih2evgn.fsf@unicorn.mansr.com> <Pine.LNX.4.64.1411300255520.2113@Opal.Peter>
 <yw1xoaroev7i.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1834005616-1417392984=:1996"
Content-ID: <Pine.LNX.4.64.1412010018380.1996@Opal.Peter>
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-1834005616-1417392984=:1996
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1412010018381.1996@Opal.Peter>



Hello M=E5ns,

On Sun, 30 Nov 2014, M=E5ns Rullg=E5rd wrote:

> Date: Sun, 30 Nov 2014 12:20:17 +0000
> From: M=E5ns Rullg=E5rd <mans@mansr.com>
> To: peter fuerst <post@pfrst.de>
> Cc: linux-mips@linux-mips.org
> Subject: Re: fast_iob() vs PHYS_OFFSET
>

>> Date: Sun, 30 Nov 2014 04:49:30 +0000 (UTC)
>> To: M=E5ns Rullg=E5rd <mans@mansr.com>
>>
>> Sorry for the mistake below: should be CKSEG[01], not CKSEG[12].

> peter fuerst <post@pfrst.de> writes:
>
>> Hello,
>>
>> i don't know where fast_iob() is currently defined (it used to be in
>> system.h in 2.6 kernels) and so don't know its current definition. But
>
> It's in asm/barrier.h, and looks like this for non-IP28:
>
> #define __fast_iob()=09=09=09=09\
=2E..
> =09=09: "m" (*(int *)CKSEG1)=09=09\
=2E..
> # endif

this looks as it used to look since long.

>
>> if PHYS_OFFSET appears in the definition, this may be plain wrong.
>> (and any conjunction of PHYS_OFFSET with CKSEG1 would be bizarre).
>>
>> PHYS_OFFSET is (at least on IP28) just the physical address, where the
>> RAM starts, and has no righteous place in address-calculations, MIPS's
>> "unmapped" kernel-addresses (CKSEG[12], XKPHYS) are independent from
>> soldering the RAM.
>
> CKSEG[01] map to physical addresses starting from 0 bypassing the MMU.
> If there is no RAM at address 0, I wouldn't expect reading from the
> first word of CKSEG1 to work very well.
>
>> On IP28, with PHYS_OFFSET 0x20000000, RAM consequently begins at the
>> kernel-address(es) 0xXY00000020000000.  (Btw, you won't reach the RAM
>> with CKSEG[12] here, XKPHYS is needed)
>
> IP28 has a special definition of __fast_iob() that reads from
> CKSEG1ADDR(0x1fa00004).  I have no idea what lives at that address, but

IOC2, HPC3, ...

> presumably something that responds to reads in a RAM-like fashion.
>
> My concern is over systems like AR7.  It defines PHYS_OFFSET to
> 0x14000000 and UNCAC_BASE, correspondingly, to 0xb4000000.  According to

I'm confused. Shouldn't *CAC_BASE point to the begin of an address-space?

> the linux-mips wiki, there is some on-chip RAM at physical address 0,
> which explains why the __fast_iob() macro works there.
>
> I'm dealing with another chip with non-zero PHYS_OFFSET which AFAIK does
> not have anything mapped at physical address 0 (I don't have data sheets)=
=2E
> The Evil Vendor Tree has ifdefs all over the place, most of them bizarre
> and wrong, and I'm trying to clean things up a bit.

There are mailing list members, that worked a lot on AR7, perhaps they
can help you. At least provide you with data sheets.

Besides AR7, (more or less) precise definitions of *CAC_BASE, PAGE_OFFSET,
PHYS_OFFSET, ... perhaps wouldn't hurt either.

>
>> The spread of PHYS_OFFSET began several years ago with someone
>> introducing '#define PAGE_OFFSET (CAC_BASE + PHYS_OFFSET)' instead of
>> the former '#define PAGE_OFFSET CAC_BASE'.
=2E..thus opening Pandora's can.
>> Perhaps just to allow retaining 'free_area_init(zones_size)' instead of
>> the need to replace this by 'free_area_init_node(0, NODE_DATA(0),
>> zones_size, PHYS_OFFSET, NULL)', since the "new" PAGE_OFFSET brings in
>> PHYS_OFFSET through the backdoor.
>> But, since kernel-addresses are (canonically ;-) calculated by adding or
>> subtracting PAGE_OFFSET, the new definition had/has to be compensated
>> for by introducing PHYS_OFFSET into macros in numerous places (maybe
>> by some trial-and-error actions ;-)
>
> That was more or less the impression I got while chasing the values
> through the various macro definitions.
>
>> kind regards
>>
>> peter
>>
>> On Fri, 28 Nov 2014, M=E5ns Rullg=E5rd wrote:
>>
>>> Date: Fri, 28 Nov 2014 23:50:16 +0000
>>> From: M=E5ns Rullg=E5rd <mans@mansr.com>
>>> To: linux-mips@linux-mips.org
>>> Subject: fast_iob() vs PHYS_OFFSET
>>>
>>> I'm a little confused over the interaction between fast_iob() and
>>> non-zero PHYS_OFFSET.
>>>
>>> The __fast_iob() macro performs a load from CKSEG1.  AFAICT, CKSEG1 is
>>> always (on 32-bit systems) defined to 0xa0000000.  In case of a non-zer=
o
>>> PHYS_OFFSET, this address might not map to anything in particular, and
>>> almost certainly not RAM.  There is a special case for IP28, but this i=
s
>>> not the only system with an unusual address map.
>>>
>>> What am I missing?
>>>
>>> --
>>> M=E5ns Rullg=E5rd
>>> mans@mansr.com
>>>
>>>
>
> --=20
> M=E5ns Rullg=E5rd
> mans@mansr.com
>
>

best wishes

peter

---1463811839-1834005616-1417392984=:1996--
