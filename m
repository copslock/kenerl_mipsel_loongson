Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F18Up28710
	for linux-mips-outgoing; Mon, 14 Jan 2002 17:08:30 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0F18Rg28706
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 17:08:27 -0800
Received: (qmail 18348 invoked from network); 15 Jan 2002 00:08:24 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <linux-mips@oss.sgi.com>; 15 Jan 2002 00:08:24 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16QH9M-0007Oo-00
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 17:08:24 -0700
Date: Mon, 14 Jan 2002 17:08:24 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
cc: linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
In-Reply-To: <20020114150751.B29242@dea.linux-mips.net>
Message-ID: <Pine.LNX.3.96.1020114170007.28388C-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Mon, 14 Jan 2002, Ralf Baechle wrote:

> On Mon, Jan 14, 2002 at 01:42:22PM -0700, Jason Gunthorpe wrote:
> 
> > I have such hardware myself. IMHO the best option is the mips64 kernel and
> > I hope to try it someday. But in practice I'd guess that Ralf's highmem
> > patch is more likely to be usuable first (?). 
> 
> Depends if you can live with the problems of the current mips64 kernel.
> If you can then it's highmem-free memory managment is certainly the way
> to go.  It's also not limited to peanuts numbers of gigabytes but can
> support as much memory as your can tack on a MIPS.

Yep, totally.

I thought about starting with mips64 but it was simpler to go with the
pre-existing processor support in the mips32 kernel. I'd like to patch
mips64 up to support the CPU's I have here, but not this month :>

Could someone quickly comment on how it is running? Can it boot normal 32
bit user space OK? I know with sparc64 there were (are?) a number of
problems with missing 32 bit syscall translations for some obscure
things.. 

Jason
