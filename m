Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ELgRs22593
	for linux-mips-outgoing; Mon, 14 Jan 2002 13:42:27 -0800
Received: from cast-ext.ab.videon.ca (cast-ext.ab.videon.ca [206.75.216.34])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ELgPg22590
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 13:42:25 -0800
Received: (qmail 17107 invoked from network); 14 Jan 2002 20:42:22 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by cast-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <mdharm@momenco.com>; 14 Jan 2002 20:42:22 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16QDvy-0006lG-00; Mon, 14 Jan 2002 13:42:22 -0700
Date: Mon, 14 Jan 2002 13:42:22 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
To: Matthew Dharm <mdharm@momenco.com>
cc: linux-mips@oss.sgi.com
Subject: RE: MIPS64 status?
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIEEMNCEAA.mdharm@momenco.com>
Message-ID: <Pine.LNX.3.96.1020114132552.25800G-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Mon, 14 Jan 2002, Matthew Dharm wrote:

> So MIPS64 denotes 64-bit data _and_ address?  Great.  But, what is the
> current state of the toolchain?  I mean, what point is having the code
> if the tools won't compile it properly?

Well, working on the kernel is a good way to get the tools working. That
is how several of the Linux archs have worked in the past.

> I guess what I'm looking for is what I should tell someone who wants
> to run MIPS Linux 64-bit with 8 gigs of RAM.

I have such hardware myself. IMHO the best option is the mips64 kernel and
I hope to try it someday. But in practice I'd guess that Ralf's highmem
patch is more likely to be usuable first (?). 

Jason
