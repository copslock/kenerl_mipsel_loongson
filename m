Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F0xof28455
	for linux-mips-outgoing; Mon, 14 Jan 2002 16:59:50 -0800
Received: from crack-ext.ab.videon.ca (crack-ext.ab.videon.ca [206.75.216.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0F0xmg28446
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 16:59:48 -0800
Received: (qmail 9564 invoked from network); 14 Jan 2002 23:59:45 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by crack-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <mdharm@momenco.com>; 14 Jan 2002 23:59:45 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16QH0y-0007OI-00; Mon, 14 Jan 2002 16:59:45 -0700
Date: Mon, 14 Jan 2002 16:59:44 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
To: Matthew Dharm <mdharm@momenco.com>
cc: linux-mips@oss.sgi.com
Subject: RE: MIPS64 status?
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICENCCEAA.mdharm@momenco.com>
Message-ID: <Pine.LNX.3.96.1020114165623.28388B-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Mon, 14 Jan 2002, Matthew Dharm wrote:

> Does this mean we could map PCI memory/IO addresses above 4G and have
> it work?

Ooh, don't go there :> We looked at that and actually did it then backed
it out.

The PCI spec (particuarly PCI-X) tries to make it possible, but in a
general system with PCI sockets/etc it is just is not feasible. PCI
bridges need to be located below 4G, as do the majority of devices made. 
There is also a performance hit for having device registers > 4G.

You'd definately need the mips64 kernel to do that, or use ugly wired TLB
entries with normal mips.

Jason
