Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35Lw2d07953
	for linux-mips-outgoing; Thu, 5 Apr 2001 14:58:02 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35Lw2M07950
	for <linux-mips@oss.sgi.com>; Thu, 5 Apr 2001 14:58:02 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f35LsC015068;
	Thu, 5 Apr 2001 14:54:12 -0700
Message-ID: <3ACCE94A.A551470D@mvista.com>
Date: Thu, 05 Apr 2001 14:53:14 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith M Wesolowski <wesolows@foobazco.org>
CC: linux-mips@oss.sgi.com
Subject: Re: RFC: Cleanup/detection patch
References: <20010401235212.B9737@foobazco.org> <3ACA8A3B.8BBABB11@mvista.com> <20010403203055.A17365@foobazco.org> <3ACB5FD8.6B166BA6@mvista.com> <20010405004618.A30899@foobazco.org> <3ACCD599.1765FCB2@mvista.com> <20010405140338.A1508@foobazco.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith M Wesolowski wrote:
> 
> On Thu, Apr 05, 2001 at 01:29:13PM -0700, Jun Sun wrote:
> 
> > I don't like bc_ops idea.  Usually the external cache capability is still
> > integral part of the CPU.
> 
> How can it be both an integral part of the CPU and board-specific?

Hmm, I am thinking about something like Rm7k, where the tertiary cache is
controlled by the CPU (through cache instruction and TagLo/TagHi regsiters,
etc) but the size is only known to the board.

I think some CPUs can have secondary, external cache but cannot figure the
size and, especially, the layout (# of ways, ...) automatically.  (Any
confirmation?)

Those are what I was referring to.

The key point is that machine_detection() should happen BEFORE
cpu_probe()/cache_probe() so that we have an elegant way to address the above
situation.

Jun
