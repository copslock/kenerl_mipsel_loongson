Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FL8IY32244
	for linux-mips-outgoing; Tue, 15 Jan 2002 13:08:18 -0800
Received: from scsoftware.sc-software.com (mipsdev@[206.40.202.198])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FL82P32235;
	Tue, 15 Jan 2002 13:08:02 -0800
Received: from localhost (mipsdev@localhost) by scsoftware.sc-software.com (8.8.3/8.8.3) with SMTP id MAA11508; Tue, 15 Jan 2002 12:00:13 -0800
Date: Tue, 15 Jan 2002 12:00:12 -0800 (PST)
From: John Heil <mipsdev@scsoftware.sc-software.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jason Gunthorpe <jgg@debian.org>, Matthew Dharm <mdharm@momenco.com>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
In-Reply-To: <20020114150751.B29242@dea.linux-mips.net>
Message-ID: <Pine.LNX.3.95.1020115115824.6855A-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 14 Jan 2002, Ralf Baechle wrote:

> Date: Mon, 14 Jan 2002 15:07:51 -0800
> From: Ralf Baechle <ralf@oss.sgi.com>
> To: Jason Gunthorpe <jgg@debian.org>
> Cc: Matthew Dharm <mdharm@momenco.com>, linux-mips@oss.sgi.com
> Subject: Re: MIPS64 status?
> 
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
> 
>   Ralf
> 
Who, if anyone, has a MIPS64 reference design board available ?
...With >4G memory capacity ?


Thanx
Johnh
