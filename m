Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2002 20:51:27 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:525 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1123396AbSJGSv0>;
	Mon, 7 Oct 2002 20:51:26 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17ydtq-0000xj-00; Mon, 07 Oct 2002 14:50:42 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17ycye-0004KP-00; Mon, 07 Oct 2002 14:51:36 -0400
Date: Mon, 7 Oct 2002 14:51:36 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Johannes Stezenbach <js@convergence.de>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021007185136.GA16501@nevyn.them.org>
References: <20020916164034.GA12489@convergence.de> <20021007144749.GB16641@convergence.de> <01fd01c26e1d$add77240$10eca8c0@grendel> <20021007184344.GA17548@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007184344.GA17548@convergence.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 07, 2002 at 08:43:44PM +0200, Johannes Stezenbach wrote:
> The question is how the glibc can detect if
> a) the CPU does not have LL/SC
> b) the kernel guarantees k1 != MAGIC
> 
> I think the kernel should announce this explicitly.
> In my patch from Sep 16 I used a sysctl, but that's
> probably bad because glibc would rely on a real new
> include/linux/sysctl.h.
> 
> I need some advice on this (maybe add a line to /proc/cpuinfo,
> or create a new /proc entry? or add a sysmips call to get
> this info?).

You should be using an "aux vector"; see how PowerPC provides current
glibc with the size of a cache line.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
