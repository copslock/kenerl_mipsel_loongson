Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 12:50:07 +0100 (BST)
Received: from p508B5469.dip.t-dialin.net ([IPv6:::ffff:80.139.84.105]:3754
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225278AbTDPLuG>; Wed, 16 Apr 2003 12:50:06 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3GBo1p08217;
	Wed, 16 Apr 2003 13:50:01 +0200
Date: Wed, 16 Apr 2003 13:50:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Steve Taylor <godzilla1357@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Basic cache questions
Message-ID: <20030416135001.A29679@linux-mips.org>
References: <20030415221914.47873.qmail@web14503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030415221914.47873.qmail@web14503.mail.yahoo.com>; from godzilla1357@yahoo.com on Tue, Apr 15, 2003 at 03:19:14PM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 03:19:14PM -0700, Steve Taylor wrote:

> Hello All,   I am hoping some of you mips-linux gurus will be able to
> help me give me some tips and help me get started on some cache stuff which
> I want to do. (I know decently well about caches - but only at a
> theoretical Hennessy & Patterson level - and have just started looking
> under arch/mips/mm to familiarize myself with the mips-linux
> implementation).   Here's what I want to do - I have a CPU with 4 way SA I
> and D caches, and I want to write a module that will lock a certain memory
> region in these caches (for example, let's say I want to lock the ISR in
> the I-cache). So my questions are

> a) Is the kernel going to crash if I try to mess around with the caches
> like locking out a particular way of the cache or something like that?

> b) I'm sure there are many issues and
> complications involved in this that I probably havent even thought of  -
> any obvious and/or subtle pitfalls? and c) Do you think locking out, say,
> an entire way of a 4-way cache for a dedicated frequently used routine
> improves or degrades overall system performance?

General wisdom says locking is rarely a win but a loss unless you have
particularly pathological access patterns which is not so likely with a
4-way cache.  Cache locking is primarily useful if you are doing hard
realtime stuff and need execution time deterministic to the absolute
technical limit - even if at cost of latency and throughput.  Linux
being a general purpose UNIX clone is hardly the OS for such an
application ...

  Ralf
