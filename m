Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L43dE06528
	for linux-mips-outgoing; Wed, 20 Feb 2002 20:03:39 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L43a906524
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 20:03:37 -0800
Received: (qmail 10399 invoked from network); 21 Feb 2002 03:03:35 -0000
Received: from unknown (HELO wakko.debian.net) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <mdharm@momenco.com>; 21 Feb 2002 03:03:35 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.debian.net ident=jgg)
	by wakko.debian.net with smtp (Exim 3.16 #1 (Debian))
	id 16djWB-00016i-00; Wed, 20 Feb 2002 20:03:35 -0700
Date: Wed, 20 Feb 2002 20:03:34 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.debian.net
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: Matthew Dharm <mdharm@momenco.com>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: RE: set_io_port_base()?
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIKEKFCFAA.mdharm@momenco.com>
Message-ID: <Pine.LNX.3.96.1020220195457.4254A-100000@wakko.debian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Wed, 20 Feb 2002, Matthew Dharm wrote:

> But isn't that what all the complicated logic in ioremap() is for?  It
> looks like it checks to see if it can directly address the I/O space
> via kseg1 and if not, set up a translation for it...

Yes, but ioremap does not remap io.. it remamps what linux dubs MMIO
regions. Look at drivers/net/8139too.c and check out the difference from
io and mmio. Linux's io* primitives expect an i386 like 64K IO port space,
which in mips land starts at the virtual address passed into
set_io_port_base().

BTW, the 'eepro100' driver seems to default to MMIO operation so it should
not care about set_io_port_base.. You might want to crank up speedo_debug
and make sure of the mode.

Jason
