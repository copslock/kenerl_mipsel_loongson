Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OGv2J17303
	for linux-mips-outgoing; Wed, 24 Oct 2001 09:57:02 -0700
Received: from dea.linux-mips.net (a1as11-p81.stg.tli.de [195.252.190.81])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OGuuD17298
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 09:56:56 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9OGuiY03049;
	Wed, 24 Oct 2001 18:56:44 +0200
Date: Wed, 24 Oct 2001 18:56:44 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Petko Manolov <pmanolov@lnxw.com>, linux-mips@oss.sgi.com
Subject: Re: Malta probs
Message-ID: <20011024185644.A3025@dea.linux-mips.net>
References: <200110230102.f9N12kb20443@oss.sgi.com> <3BD5D236.8D0CE33C@lnxw.com> <20011023224718.A6283@dea.linux-mips.net> <004501c15cab$88055b60$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004501c15cab$88055b60$0deca8c0@Ulysses>; from kevink@mips.com on Wed, Oct 24, 2001 at 06:47:10PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 24, 2001 at 06:47:10PM +0200, Kevin D. Kissell wrote:

> A clue - a machine check exception results
> when there are two identical values in the
> TLB, which is unhealthy for associative RAM
> arrays (never mind that synthesized MIPS
> 4K and 5K cores may or may not actually
> have associative RAM for the TLB).  In the
> 4K cores, this condition results even if the
> two identical values are non-Valid, which was
> not true in the R4000 and R5000 CPUs, and
> which necessitated a tweak to the TLB flush
> and invaldate routines to ensure that each entry
> is written with a unique invalid value (a function
> of the index).
> 
> Please double-check that the TLB flush
> code that you are using does this.

I fixed this problem already last night.

  Ralf
