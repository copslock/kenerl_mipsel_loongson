Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 03:12:54 +0000 (GMT)
Received: from p508B7762.dip.t-dialin.net ([IPv6:::ffff:80.139.119.98]:17600
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225203AbTBUDMx>; Fri, 21 Feb 2003 03:12:53 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1L3ChJ20056;
	Fri, 21 Feb 2003 04:12:43 +0100
Date: Fri, 21 Feb 2003 04:12:42 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch] bogus ramdisk sanity check on ip27
Message-ID: <20030221041242.B19392@linux-mips.org>
References: <20030220003839.GF915@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030220003839.GF915@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Thu, Feb 20, 2003 at 11:38:39AM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 11:38:39AM +1100, Andrew Clausen wrote:

> There is currently a check that the ramdisk image resides at a sane
> memory address, below "max_pfn".  However, max_pfn isn't initialized
> (and apparently isn't relevant) for ip27.  The only assignments to
> max_pfn lie inside #ifndef CONFIG_SGI_IP27.
> 
> Therefore, this test is bogus, so here's a patch to
> #ifndef CONFIG_SGI_IP27 it.
> 
> This patch applies cleanly on 2.4.x and 2.5.x (at a different offset).

No winner in a beauty contest but I think it's ok until we sort the
underlying NUMA issues which we'd have to do anyway at some point -
more ccNUMA stuff will come eventually ...

  Ralf
