Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 07:00:30 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:49307
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225194AbTA1HA3>; Tue, 28 Jan 2003 07:00:29 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0S70Tf21036
	for linux-mips@linux-mips.org; Tue, 28 Jan 2003 08:00:29 +0100
Date: Tue, 28 Jan 2003 08:00:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: debian's mips userland on mips64
Message-ID: <20030128080029.D20541@linux-mips.org>
References: <20030122073006.GF6262@pureza.melbourne.sgi.com> <20030122124540.A31505@sgi.com> <20030122214736.GA1094@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030122214736.GA1094@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Wed, Jan 22, 2003 at 01:47:36PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 22, 2003 at 01:47:36PM -0800, Greg Lindahl wrote:

> > I don't think so.  You should rather implement a sys32_ptrace and
> > reference it in the 32bit syscall vector.  Look at the version in
> > arch/ia64/ia32/sys_ia32.c for an example.
> 
> This works as long as you aren't doing n32 - at some point we'll have
> a mature enough toolchain to do that, and we're going to need to hack
> up sys32_ptrace to do the right thing with the bigger fp register file...

Which I've done now.  Also works for native 64-bit code.

  Ralf
