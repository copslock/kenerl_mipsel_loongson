Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IIMs218185
	for linux-mips-outgoing; Mon, 18 Jun 2001 11:22:54 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IIMsV18182
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 11:22:54 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 56A98125BA; Mon, 18 Jun 2001 11:22:53 -0700 (PDT)
Date: Mon, 18 Jun 2001 11:22:53 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Brian Murphy <brian@murphy.dk>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Problems with mips2 compiled libc and linux 2.4.3
Message-ID: <20010618112253.A28744@lucon.org>
References: <3B2E4458.1637A08A@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B2E4458.1637A08A@murphy.dk>; from brian@murphy.dk on Mon, Jun 18, 2001 at 08:11:36PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 18, 2001 at 08:11:36PM +0200, Brian Murphy wrote:
> 
> it is linked with a glibc compiled with -mips2. It is the second if test

I patched my kernel to get around it.

> 
> which fails if any of the high 4 bits in the flags are set. According to
> the
> specs these are set for the various mipsx (x != 1) flavors - this seems

> to mean
> that we do no allow anything higher than mips1 run on linux - can this
> be
> true? If so, why?

There is no very good reason. I think we should add a MIPS ISA level
field in the mips cpuinfo so that we can check what ISA the hardware
support at the run-time.


H.J.
