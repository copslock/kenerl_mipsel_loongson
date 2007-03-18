Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2007 11:35:13 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:54828 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20021712AbXCRLfL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Mar 2007 11:35:11 +0000
Received: from SNaIlmail.Peter (unknown [77.47.7.128])
	by mail1.pearl-online.net (Postfix) with ESMTP id 1A83EAF95;
	Sun, 18 Mar 2007 12:34:56 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id l2IBVfnR000738;
	Sun, 18 Mar 2007 12:31:41 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id l2IBUMEH000456;
	Sun, 18 Mar 2007 12:30:22 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id l2IBUM78000453;
	Sun, 18 Mar 2007 12:30:22 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sun, 18 Mar 2007 12:30:22 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
 #2]
In-Reply-To: <cda58cb80703130137p39c46d8cr2dcd77ad57d4897e@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0703181212110.446@Indigo2.Peter>
References: <116841864595-git-send-email-fbuihuu@gmail.com> 
 <Pine.LNX.4.58.0703101034500.19007@Indigo2.Peter> 
 <cda58cb80703120247q435b6bb1p8a025d8597aca2a2@mail.gmail.com> 
 <Pine.LNX.4.58.0703121329450.440@Indigo2.Peter> 
 <cda58cb80703121005h53969eb2j7b2290b97b14374d@mail.gmail.com> 
 <Pine.LNX.4.58.0703122016430.438@Indigo2.Peter>
 <cda58cb80703130137p39c46d8cr2dcd77ad57d4897e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hi,

after traveling several kernel areas (for more or less related reasons),
it's now clear that you got no other choice than to introduce phys_offset.
(I let your reasoning for it mislead me before. Sorry.)

Two conditions must be met:
1) __pfn_to_page(x) == &mem_map[x - ARCH_PFN_OFFSET]
2) PAGE_OFFSET is not "the start of the kernel virtual address space",
   but the virtual address of the first page, handled by the table, as
   is set in free_area_init():
   __pfn_to_page(__pa(PAGE_OFFSET) >> PAGE_SHIFT) == &mem_map[0]

These are met if and only if
__pa(PAGE_OFFSET) == ARCH_PFN_OFFSET<<PAGE_SHIFT + r, 0 <= r < 1<<PAGE_SHIFT

Using the simpliest arithmetic formula for __pa()
"__pa(x) := x - PAGE_OFFSET + d",
we get d = ARCH_PFN_OFFSET << PAGE_SHIFT, and use the descriptive name
PHYS_OFFSET for this "d".

(Of course, i could have guessed and tried and defined PHYS_OFFSET in the
first place...)

On the other hand, "__pa(kseg) == 0" must be met for kseg in {KSEG0,KSEG1,
CKSEG0,CKSEG1,any XKPHYS-region}. This enforces:
PAGE_OFFSET = kseg + (ARCH_PFN_OFFSET << PAGE_SHIFT)

Perhaps you could have pointed to the above relations, and thus saved
several "users" from a bit of trial and error :-)


My suggestion, to use the detected offset (min_low_pfn), instead of a
predefined constant, may be too expensive. The flexibility gained by
"#define ARCH_PFN_OFFSET min_low_pfn" and hence "#define PHYS_OFFSET
(min_low_pfn << PAGE_SHIFT)" is probably not worth the cost, that arises
when these must be evaluated in so many places.


kind regards

peter
