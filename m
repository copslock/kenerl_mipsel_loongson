Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UL2VH22374
	for linux-mips-outgoing; Wed, 30 Jan 2002 13:02:31 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UL2Qd22367
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 13:02:26 -0800
Received: (qmail 26816 invoked from network); 30 Jan 2002 20:02:23 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <macro@ds2.pg.gda.pl>; 30 Jan 2002 20:02:23 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16W0w2-0002vS-00; Wed, 30 Jan 2002 13:02:22 -0700
Date: Wed, 30 Jan 2002 13:02:21 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <Pine.GSO.3.96.1020130151155.2880D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.3.96.1020130123109.11192A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Wed, 30 Jan 2002, Maciej W. Rozycki wrote:

> worse, recently I've identified a case it doesn't work at all on an
> R4400SC CPU -- values written to an i/o memory resource were not committed
> to the device even after executing over 40 subsequent instructions. 

Nice patch!

I was under the impression that the mb() functions existed to maintain
order of memory access and were not defined as flushes per say - so is
the time delay a concern (perhaps sticking a sync before ERET is
appropriate?)

I spent some time talking with the Sandcraft people about memory barrier
issues, and it turns out that at least on the SR71000 (and in most cases
the RM7K) the order of SysAD transactions will always match the order of
the instruction stream, but all writes are posted and all reads are split
- that is the CPU can execute two back to back uncached loads and several
back to back uncached stores without stalling the pipeline, or getting the
IO's out of order. Adding sync's and uncached loads only slows things down
for these chips. 

I understand this is because the CPUs have a single load/store unit and do
not do out of order execution. Many older/embedded MIPS designs probably
have a similar configuration, they could likely also run with out the
syncs. 

So - could you add something like CONFIG_IN_ORDER_IO which would nullify
the syncs for these processors?

BTW, does anyone know what CONFIG_WB is ment to mean? The CPU has a write
buffer that does not preserve order? 

Thanks,
Jason
