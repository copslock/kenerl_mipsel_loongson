Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0PMKeW03294
	for linux-mips-outgoing; Fri, 25 Jan 2002 14:20:40 -0800
Received: from crack-ext.ab.videon.ca (crack-ext.ab.videon.ca [206.75.216.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0PMKbP03279
	for <linux-mips@oss.sgi.com>; Fri, 25 Jan 2002 14:20:37 -0800
Received: (qmail 18384 invoked from network); 25 Jan 2002 21:20:34 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by crack-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <phil@river-bank.demon.co.uk>; 25 Jan 2002 21:20:34 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16UDlx-0001TS-00; Fri, 25 Jan 2002 14:20:33 -0700
Date: Fri, 25 Jan 2002 14:20:33 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
To: Phil Thompson <phil@river-bank.demon.co.uk>
cc: linux-mips@oss.sgi.com
Subject: Re: Generic DISCONTIGMEM Support on 32bit MIPS
In-Reply-To: <3C51838A.174F8712@river-bank.demon.co.uk>
Message-ID: <Pine.LNX.3.96.1020125141828.5657B-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Fri, 25 Jan 2002, Phil Thompson wrote:

> The first question is: has anybody already done this? Particularly as,
> once you've identified where the holes are, the code isn't board
> specific.

Is this of any help?

http://kt.zork.net/kernel-traffic/kt20011112_141.html#6

William Irwin [*] announced:

A number of people have expressed a wish to replace the bitmap-based
bootmem allocator with one that tracks ranges explicitly. I have written
such a replacement in order to deal with some of the situations I have
encountered. 
[...]

Jason
