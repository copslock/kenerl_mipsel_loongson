Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FCoT016625
	for linux-mips-outgoing; Fri, 15 Feb 2002 04:50:29 -0800
Received: from dea.linux-mips.net (a1as06-p212.stg.tli.de [195.252.187.212])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FCoP916616
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 04:50:25 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1FAo6S26781;
	Fri, 15 Feb 2002 11:50:06 +0100
Date: Fri, 15 Feb 2002 11:50:06 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, macro@ds2.pg.gda.pl,
   mdharm@momenco.com, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
Message-ID: <20020215115006.B26756@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020212123901.17858B-100000@delta.ds2.pg.gda.pl><010601c1b3bd$1da618e0$0deca8c0@Ulysses><20020213.102805.74755945.nemoto@toshiba-tops.co.jp> <20020215.123124.70226832.nemoto@toshiba-tops.co.jp> <006e01c1b606$27b1b060$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <006e01c1b606$27b1b060$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Feb 15, 2002 at 09:30:45AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 15, 2002 at 09:30:45AM +0100, Kevin D. Kissell wrote:

> That is, I would say, a bug in the TX39 implementation of SYNC.
> The specification is states that all stores prior to the SYNC must 
> complete before any memory ops after the sync, and that the 
> definition of a store completing is that all stored values be 
> "visible to every other processor in the system", which pretty 
> clearly implies that the write buffers must be flushed.

In practice sync just isn't good enough.  Most systems these days use
an I/O bus like PCI which uses posted writes or have some other
non-strongly ordered memory model.  Which is why something wmb() or
mb() aren't good enough in driver.  I'm just having a nice discussion
about this topic with SGI's IA64 people; we have to come up with a
portable and efficient ABI.

  Ralf
