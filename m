Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2003 03:30:43 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:17314 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225226AbTDTCam>;
	Sun, 20 Apr 2003 03:30:42 +0100
Received: from mahes.visi.com (mahes.visi.com [209.98.98.96])
	by mail-out.visi.com (Postfix) with ESMTP
	id 083EF36CC; Sat, 19 Apr 2003 21:30:40 -0500 (CDT)
Received: from mahes.visi.com (localhost [127.0.0.1])
	by mahes.visi.com (8.12.9/8.12.5) with ESMTP id h3K2Ud9R020654;
	Sat, 19 Apr 2003 21:30:39 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mahes.visi.com (8.12.9/8.12.5/Submit) id h3K2UQNh020653;
	Sun, 20 Apr 2003 02:30:26 GMT
X-Authentication-Warning: mahes.visi.com: www set sender to erik@greendragon.org using -f
Received: from 170-215-41-223.bras01.mnd.mn.frontiernet.net (170-215-41-223.bras01.mnd.mn.frontiernet.net [170.215.41.223]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Sun, 20 Apr 2003 02:30:26 +0000
Message-ID: <1050805826.3ea2064281289@my.visi.com>
Date: Sun, 20 Apr 2003 02:30:26 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: TLB mapping questions
References: <1050730370.3ea0df8263a21@my.visi.com> <20030419164854.A15699@linux-mips.org>
In-Reply-To: <20030419164854.A15699@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 170.215.41.223
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Quoting Ralf Baechle <ralf@linux-mips.org>:TLB_SE
> > So if I construct a TLB entry such that cp0_entryhi is 0xffffffffc0002000,
> and
> > cp0_entrylo0 has a PFN address of 0x0000000020006, giving it the correct
> ASID
> > (0) and valid bitflags(VG), I should be able to access the physical memory
> > offset above using the ckseg2 virtual address 0xffffffffc0002000?
> 
> You also want to set the dirty flag or otherwise the page is not writable.

That's ok for the first page, it's code only.  The second page mapped by the
entry is data, so I'll set the D bit on that.

> 
> Which page size have you been using?

16 megabyte

> 
> The physical address must be a multiple of the page size of the page and
> the virtual address must be a multiple of the double of the page size of
> entry - remember that each TLB entry maps a pair of adjacent pages!

This was my main problem - after I rounded my physical load address up to the
next 16M boundary: 0xa800000021000000 and adjusted the LOADADDRESS in my
makefile to point to the beginning of ckseg2 (the address of which is a multiple
of 32M) I am now able to jump into the ckseg2 code successfully.

> The entrylo value is computed by shifting the physical address right by
> 6 bits then inserting the right flag bits into the low 6 bits.  In your
> case you want to set the valid, dirty and global bits.  You also need to
> set the 3 coherency bits.  We want cachable coherent, the same mode as
> used in the 0xa8... portion of XKPHYS.  So we set them to 5.  So:
> 
>  c0_entrylo0 = (phyaddr >> 6) | cacheable_coherent | dirty | valid | global
> 
>  c0_entrylo0 = 0x800180 | 0x28 | 0x4 | 0x2 | 0x1
> 
>  c0_entrylo0 = 0x8001af

These are the very bits I'm using.  I'm actually using a modded version of the
MAPPED_KERNEL_SETUP_TLB macro in head.S.

> An extra word about the global bit - there exists only one global bit in

I made a note of this paragraph, will do some reading on it.

> would generated the mapping and make sure the entry won't be overwritten
> by random TLB writes.

Yes, CP0_WIRED is getting set to 1 to protect this entry.

> 
> > Of course, the reason I discuss all this is that the above doesn't work. =)
> 
> Every Linux port has started in a state as advanced as where you are so
> keep up :-)

I will do so =)  My next problem is getting the stack working.

Erik



> 
>   Ralf


-- 
Erik J. Green
erik@greendragon.org
