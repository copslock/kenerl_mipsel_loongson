Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 14:15:32 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:43539
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225011AbULOOP2>; Wed, 15 Dec 2004 14:15:28 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFEFC5u029252;
	Wed, 15 Dec 2004 15:15:12 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFEF8Wj029250;
	Wed, 15 Dec 2004 15:15:08 +0100
Date: Wed, 15 Dec 2004 15:15:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Hdei Nunoe <nunoe@co-nss.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: HIGHMEM
Message-ID: <20041215141508.GA29222@linux-mips.org>
References: <001101c4dbf9$1da02270$3ca06096@NUNOE> <20041207095837.GA13264@linux-mips.org> <001701c4e195$24d48260$3ca06096@NUNOE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001701c4e195$24d48260$3ca06096@NUNOE>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 14, 2004 at 01:26:55PM +0900, Hdei Nunoe wrote:

> >In 2.4 the support for CONFIG_DISCONTIG and CONFIG_NUMA are a bit tangled
> >with each other because IP27 is the only platform to uses these features
> >and it needs both.
> 
> Is it named "sgi-ip27"?

Yes, obviously :-)

> >Other than that you can also just setup your system
> >as 0x0 - 0x10000000 being RAM, 0x10000000 - 0x20000000 being reserved
> >memory and 0x20000000 - 0x30000000 being highmem.  Which works but is a
> >bit wasteful.
> 
> The gap in physical memory is 0x10000000 - 0x20000000, but it is 
> 0x90000000 -
> 0xC0000000 in virtual memory because there is K1 segment.  So the macros 
> such
> as __pa() or __va() does not work, I think.  Started to wonder it might not 
> be easy
> as just changing the PAGE_OFFSET value.  Do you see?

PAGE_OFFSET is the difference of a ZONE_NORMAL's virtual address and it's
physical address.  Once there is no more 1:1 mapping between physical and
virtual addresses such as in your suggestion PAGE_OFFSET can no longer be
used, that is you need to rewrite all users of this function.

  Ralf
