Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 08:29:28 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:39438 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225803AbVG0H3J>;
	Wed, 27 Jul 2005 08:29:09 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Dxgek-0000RB-00; Wed, 27 Jul 2005 08:48:46 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=boris)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1DxgNk-0007Bl-00; Wed, 27 Jul 2005 08:31:12 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17127.14246.112209.239338@mips.com>
Date:	Wed, 27 Jul 2005 08:28:38 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: how to access structured registers correctly
In-Reply-To: <20050726190643.GD7088@linux-mips.org>
References: <20050726182531.6341586f.Hiroshi_DOYU@montavista.co.jp>
	<20050726190643.GD7088@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.839,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> > In tx4938, every register access is done by using "volatile" like below.
> 
> Linus is right, volatile is a dangerous thing.  If you want to write
> portable code there's a bunch of things that are not being taken care of
> by plain C - even though in my opinion foo->somereg = 42 is more
> readable than writel(somereg, 42).  Among the things the pointer to
> volatile struct method doesn't catch are endianess conversion that might
> be necessary on some systems, write merging, dealing with write buffers
> or completly insane methods of attaching the bus such as the infamous
> ISA / EISA cage that's attached to the host system through a USB
> interface.

Yes, this is far outside the compiler's reach.

All of which suggests that it would make sense to define a standard function
which:

o will produce just one fixed-width write cycle to the destination;

o will deliver the data ordered so that the MSB of the C value is on
  the "most significant" bit of the device's data bus, usually the
  highest numbered bit (this doesn't solve all device endianess
  issues, but it gives you a well-defined place to start solving them);

o has a variant which returns only after some indication that the
  data was delivered;

The implementation of this function can then conceal the details of
the CPU and interconnect.

Such a function should probably not be called "writel()" because that
sounds like "write long", and "long" is not a fixed-size data type,
which undermines the promises above...  Tediously, you probably need
"writei32()", "writei16()", "writei8()"...

--
Dominic Sweetman
MIPS Technologies
