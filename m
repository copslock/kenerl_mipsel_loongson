Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2003 14:34:40 +0100 (BST)
Received: from p508B6685.dip.t-dialin.net ([IPv6:::ffff:80.139.102.133]:38838
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225348AbTHaNei>; Sun, 31 Aug 2003 14:34:38 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7VDYa1p001916;
	Sun, 31 Aug 2003 15:34:37 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7VDYZDG001915;
	Sun, 31 Aug 2003 15:34:35 +0200
Date: Sun, 31 Aug 2003 15:34:34 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Steve Madsen <madsen@tadpole.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode
Message-ID: <20030831133434.GA23189@linux-mips.org>
References: <3F4FCCD5.1000604@tadpole.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4FCCD5.1000604@tadpole.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 29, 2003 at 02:59:49PM -0700, Steve Madsen wrote:

> Is it possible to use more than 256 MB of system memory with the Broadcom 
> SB1250 in 32-bit mode?  The memory map I'm looking at shows me that the 
> second 256 MB of memory is at physical address 0x80000000.  I suspect that 
> due to the 2G/2G split in the kernel, I can't use memory this high without 
> moving to the 64-bit kernel.

Steve Finney's answer was correct; I'd like to add a few details though.

The explanation you gave isn't exactly right.  A 2GB/2GB split would normally
support 2GB of low memory.  We don't on MIPS due to the very inconvenient and
unchangable mappings of KSEG0/KSEG1 - something that may have been sweet
in '85 when the address map was designed but not today when 32-bit address
spaces are beginning to be fairly tight.

Highmem works ok in 2.4 as long as you have a reasonably low ratio of
highmem to lowmem.  For typical loads that means going beyond 4:1 isn't
sensible but the actual number may vary much based on exact system
configuration or workload.

  Ralf
