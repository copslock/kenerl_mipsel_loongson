Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2MIaYK06491
	for linux-mips-outgoing; Thu, 22 Mar 2001 10:36:34 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2MIaXM06488
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 10:36:33 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2MIX4020006;
	Thu, 22 Mar 2001 10:33:04 -0800
Message-ID: <3ABA4539.C3E780B6@mvista.com>
Date: Thu, 22 Mar 2001 10:32:25 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jay Carlson <nop@nop.com>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs
References: <KEEOIBGCMINLAHMMNDJNIEHDCAAA.nop@nop.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jay Carlson wrote:
> 
> Disclaimer: I'm just a hobbyist.
>

Disclaimer: I am an MontaVista employee, but as always, this email only
represents my own opinion. :-)
 
> Kevin D. Kissell writes:
> 
> 
> Individual embedded Linux companies don't have much motivation to attack
> this problem alone, as it looks like it could involve extensive gcc hacking.
> If a particular customer looks like they have code density issues, it'd be
> easier for embedded linux companies to just recommend, say, ARM.  MIPS
> Technologies on the other hand carries the banner for all devices licensing
> their architecture, and any toolchain work may result in greater demand for
> their own cores and licensee products.
>

I agree.  Toolchain is the first step in the food chain.  It makes most sense
for MTI to invest in it and to make it better.  All companies that I heard of
switching from MIPS to PPC are due to toolchain (including debuggers). 
Sometimes it even has nothing to do with Linux.

I think kernel also needs improvement in terms of board/machine support.  I
wrote an email long time ago talking about introducing a board support
structure.  I predicted we would see 20 new MIPS boards added this year and
100 more down the road.  Apparently a better structure needs to be in place to
accomdate the growth. It will certainly make future porting much easier too.

While some of the improvement can be done incrementally (like time.c mess
clean-up), some (like irq, PCI?) is probably best to be done just in one shot.

Jun
