Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 02:46:43 +0000 (GMT)
Received: from p508B7762.dip.t-dialin.net ([IPv6:::ffff:80.139.119.98]:55743
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225240AbTBUCqn>; Fri, 21 Feb 2003 02:46:43 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1L2kTp19127;
	Fri, 21 Feb 2003 03:46:29 +0100
Date: Fri, 21 Feb 2003 03:46:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch] sys32_sysinfo broken on mips64 and ia64
Message-ID: <20030221034629.A18782@linux-mips.org>
References: <20030220002655.GE915@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030220002655.GE915@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Thu, Feb 20, 2003 at 11:26:55AM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 11:26:55AM +1100, Andrew Clausen wrote:

> The sys32_sysinfo() calls are currently using an old version of
> "struct sysinfo32", in both the mips64 and ia64 ports.
> 
> busybox's init can't cope with the bogus output on my Origin 200,
> so this bug prevents the Debian installer from bootstrapping.
> 
> This is the mips64 version of the patch.  A very similar patch
> could be constructed for ia64... it's very obvious what to do,
> so I'll leave it to you ia64 people :)

Sigh...  Each time I curse some certain person for copying code from the
ia64 compat code, it was of abysimal quality back in at that time -
unlike the Sparc code.

Will apply ...

  Ralf
