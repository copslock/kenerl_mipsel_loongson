Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g095gEj17779
	for linux-mips-outgoing; Tue, 8 Jan 2002 21:42:14 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g095gAg17776
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 21:42:10 -0800
Received: (qmail 19625 invoked from network); 9 Jan 2002 04:42:07 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <phil@river-bank.demon.co.uk>; 9 Jan 2002 04:42:07 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16OAYr-0002eH-00; Tue, 08 Jan 2002 21:42:02 -0700
Date: Tue, 8 Jan 2002 21:42:01 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: Phil Thompson <phil@river-bank.demon.co.uk>
cc: linux-mips@oss.sgi.com
Subject: Re: How to Handle PCI Bridge Buffers?
In-Reply-To: <3C39EE20.57513318@river-bank.demon.co.uk>
Message-ID: <Pine.LNX.3.96.1020108213000.9606C-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Mon, 7 Jan 2002, Phil Thompson wrote: 

> I am working with some hardware that has a "feature" that I'd like some
> advice on how to handle. The PCI bridge has a read-ahead buffer between
> the PCI bus and system memory - used by PCI bus masters. The buffer can
> only be invalidated from software.

Geeze best put 'pci bridge' in quotes too, that's totally not allowed by
the PCI bridge spec. Delayed transactions and any data that the bridge
may prefetch have very specific lifetimes. Hardware that does what you
describe is very much non conforming.. 

Are you sure of what you are seeing?

> Is this "feature" common? Is there existing code I can look at?

No - it's a bug not a feature :>

The best you can do is have any write to a PCI io/memory space from the
CPU clear the prefetch buffer, and hope you don't hit any of the other
anomolies that can show up.

Jason
