Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jan 2003 01:49:14 +0000 (GMT)
Received: from p508B6290.dip.t-dialin.net ([IPv6:::ffff:80.139.98.144]:36827
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225245AbTAXBtB>; Fri, 24 Jan 2003 01:49:01 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0O1ms221934;
	Fri, 24 Jan 2003 02:48:54 +0100
Date: Fri, 24 Jan 2003 02:48:54 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Andrew Clausen <clausen@melbourne.sgi.com>,
	linux-mips@linux-mips.org
Subject: Re: sigset_t32 broken?
Message-ID: <20030124024854.B9031@linux-mips.org>
References: <20030123071753.GA996@pureza.melbourne.sgi.com> <Pine.LNX.4.21.0301231044270.22634-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0301231044270.22634-100000@melkor>; from vivienc@nerim.net on Thu, Jan 23, 2003 at 10:59:29AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 23, 2003 at 10:59:29AM +0100, Vivien Chappelier wrote:

> > Shouldn't those two long's be replaced with u64 and u32
> > respectively?  Is the second struct really meant to be twice the
> > size the first?
> 
> They should be the same size, otherwise sys32_rt_sigsuspend and
> sys32_rt_sigaction will return EINVAL. As the comment says:
> /* XXX: Don't preclude handling different sized sigset_t's.  */
> 
> I've posted a patch to fix that earlier this month (Monday 13 Jan
> 2003 "[2.5 PATCH] signal handling").

Most of what your patch does is undoing an accidental commit of a signal
rework that wasn't yet supposed to go out.

  Ralf
