Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 09:59:00 +0000 (GMT)
Received: from pD9562292.dip.t-dialin.net ([IPv6:::ffff:217.86.34.146]:23240
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224990AbULGJ6z>; Tue, 7 Dec 2004 09:58:55 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iB79wdjT012364;
	Tue, 7 Dec 2004 10:58:39 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iB79wbZv012329;
	Tue, 7 Dec 2004 10:58:37 +0100
Date: Tue, 7 Dec 2004 10:58:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Hdei Nunoe <nunoe@co-nss.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: HIGHMEM
Message-ID: <20041207095837.GA13264@linux-mips.org>
References: <001101c4dbf9$1da02270$3ca06096@NUNOE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101c4dbf9$1da02270$3ca06096@NUNOE>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 07, 2004 at 10:07:26AM +0900, Hdei Nunoe wrote:

> Has anyone succeeded the HIGHMEM with discontiguous physical memory?
> I am using kernel 2.4.18 on TX4937 with two chunks of 256Mbyte memory.
> There is 256Mbyte gap in between the physical memory blocks - lower 
> memory is 0x00000000 to 0x10000000, upper memory is 0x20000000 to
> 0x30000000.  System hungs when it create INIT process.

In 2.4 the support for CONFIG_DISCONTIG and CONFIG_NUMA are a bit tangled
with each other because IP27 is the only platform to uses these features
and it needs both.  Other than that you can also just setup your system
as 0x0 - 0x10000000 being RAM, 0x10000000 - 0x20000000 being reserved
memory and 0x20000000 - 0x30000000 being highmem.  Which works but is a
bit wasteful.

Issue #2 is that we don't support the combination of CONFIG_DISCONTIG and
CONFIG_HIGHMEM.  And highmem is a lobotomized solution for lobotomized
silicon anyway.  You have a 64-bit processor - use it's capabilities :-)

Issue #3 - As I recall the TX4937's H3 core is suffering from cache
aliases.  Handling those efficiently for highmem is not easily possible
and so we don't even try.  More recent kernels will refuse to enable
highmem on such cache configurations but something like 2.4.18 which by
now is an almost 3 year old antique doesn't know about that and will
happily crash.

I recommend you should go for a 64-bit kernel instead.  And 64-bit support
is certainly better in 2.6 than in 2.4.  Especially the area of 32-bit
binary compatibility has been improved significantly.

  Ralf
