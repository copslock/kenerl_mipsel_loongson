Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K3H2h11525
	for linux-mips-outgoing; Wed, 19 Sep 2001 20:17:02 -0700
Received: from dea.linux-mips.net (f-20-190.frankfurt.ipdial.viaginterkom.de [62.180.190.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K3Gxe11522
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 20:16:59 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8K3Ghk13327;
	Thu, 20 Sep 2001 05:16:43 +0200
Date: Thu, 20 Sep 2001 05:16:43 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: NON FPU cpus (again)
Message-ID: <20010920051642.C11714@dea.linux-mips.net>
References: <20010207144857.B24485@paradigm.rfc822.org> <20010920.121316.74756227.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010920.121316.74756227.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Thu, Sep 20, 2001 at 12:13:16PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 20, 2001 at 12:13:16PM +0900, Atsushi Nemoto wrote:

> Following codes in exit_thread() and flush_thread() should be executed
> only if (mips_cpu.options & MIPS_CPU_FPU) == 0, shouldn't it?
> 
> 		set_cp0_status(ST0_CU1);
> 		__asm__ __volatile__("cfc1\t$0,$31");
> 
> BTW, I can not see any point in copying FCR31 to r0.  What is a
> purpose of the cfc1 instruction?

On CPUs with imprecise exceptions a FPU exception might still be pending
and possibly be taken arbitrarily delayed.  The cfc1 instruction serves
as an exception barrier for such exceptions.  At this time TFP is the
only CPU which features imprecise exceptions.

  Ralf
