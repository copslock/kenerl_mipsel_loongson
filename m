Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 15:18:49 +0100 (BST)
Received: from frank.harvard.edu ([IPv6:::ffff:140.247.122.99]:4521 "EHLO
	frank.harvard.edu") by linux-mips.org with ESMTP
	id <S8225220AbTDYOSq>; Fri, 25 Apr 2003 15:18:46 +0100
Received: from frank.harvard.edu (frank.harvard.edu [140.247.122.99])
	by frank.harvard.edu (8.11.6/8.11.6) with ESMTP id h3PEIfI23827;
	Fri, 25 Apr 2003 10:18:41 -0400
Date: Fri, 25 Apr 2003 10:18:41 -0400 (EDT)
From: Chip Coldwell <coldwell@frank.harvard.edu>
To: Dan Aizenstros <daizenstros@quicklogic.com>
cc: kevink@mips.com, <linux-mips@linux-mips.org>
Subject: Re: NCD900 port?
In-Reply-To: <sea8dc20.085@quicklogic.com>
Message-ID: <Pine.LNX.4.44.0304251008550.23558-100000@frank.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <coldwell@frank.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: coldwell@frank.harvard.edu
Precedence: bulk
X-list: linux-mips

On Fri, 25 Apr 2003, Dan Aizenstros wrote:
> 
> The V320USC is fully documented and manuals are
> available if you want them. The QuickLogic web site
> is a bit out of date with respect to the Linux support.
> I am tracking the linux-mips CVS tree and I can send
> you a patch sometime next week. However, the patch will
> be for our Hurricane board and so you will have to make
> changes to support the NCD device.

I found the documentation on line; it looks very thorough.  I also
found the (little-endian) toolchain on your website, which is very
convenient.

The first big stumbling block will be to guess the base address where
the bridge is located.  I see in your Hurricane board it's found at
0xBC000000; is there any reason to hope that NCD would locate it in
the same place or is this pretty much an arbitrary decision?

> Can you provide any information about the bootloader?
> Does it support loading of ELF images?

I really don't know.  If it doesn't, I suppose could give it a
compressed kernel image.  Or would this require some monkeying around
with head.S?

> Also, do you know what endian the machine is using.
> The Linux port is mostly tested little endian and
> may need some work to get big endian going.

That I don't know.  If I had to guess I would say big-endian just
because of the cultural background that NCD comes from.

I'm going to do some experiments over the weekend and try to come up
with some answers to these questions.

Chip

-- 
Charles  M. "Chip" Coldwell
"Turn on, log in, tune out"
