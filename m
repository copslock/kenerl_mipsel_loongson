Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 01:33:26 +0100 (BST)
Received: from p508B5DDF.dip.t-dialin.net ([IPv6:::ffff:80.139.93.223]:59734
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225853AbUGMAdW>; Tue, 13 Jul 2004 01:33:22 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6D0XInj026951;
	Tue, 13 Jul 2004 02:33:18 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6D0XHmV026950;
	Tue, 13 Jul 2004 02:33:17 +0200
Date: Tue, 13 Jul 2004 02:33:17 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <KevinK@mips.com>
Cc: S C <theansweriz42@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Message-ID: <20040713003317.GA26715@linux-mips.org>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ba01c46823$3729b200$0deca8c0@Ulysses>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 12, 2004 at 05:16:31PM +0200, Kevin D. Kissell wrote:

> A truly safe and general I-cache flush routine should itself run uncached,
> but a cursory glance at the linux-mips.org sources makes me think
> that we do not take that precaution by default - the flush_icache_range
> pointer looks to be set to the address of r4k_flush_icache_range()
> function, rather than its (uncacheable) alias in kseg1.  Is this something
> that's fixed in a linker script, or are we just living dangerously?

That's a new restriction in MIPS32 v2.0 and you're right, we're not trying
to deal with it yet except for the TX49xx.

  Ralf
