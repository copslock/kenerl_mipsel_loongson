Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHN05E04595
	for linux-mips-outgoing; Mon, 17 Dec 2001 15:00:05 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBHN00o04558
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 15:00:00 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBHLxrS01947;
	Mon, 17 Dec 2001 19:59:53 -0200
Date: Mon, 17 Dec 2001 19:59:53 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Karsten Merker <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: New style irqs for DEC
Message-ID: <20011217195953.B12490@dea.linux-mips.net>
References: <20011217172741.A2316@dea.linux-mips.net> <20011217221652.A6765@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011217221652.A6765@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Mon, Dec 17, 2001 at 10:16:52PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 17, 2001 at 10:16:52PM +0100, Karsten Merker wrote:

> > below is my attempt at fixing interrupts for DECstation against the
> > latest 2.4.  Can you give it a try?
> 
> Gives the following on a DECstation 5000/20 (R3k):

[long oops deleted]

> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> ------------------------------------------------------------------------------

Turns out that this is a NULL function pointer getting called.  That is
strange because it happened in the softirq code which I haven't touched
at all.  Maybe some type of memory corruption.

  Ralf
