Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F07un26881
	for linux-mips-outgoing; Mon, 14 Jan 2002 16:07:56 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0F07rg26877
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 16:07:53 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0EN7p329325;
	Mon, 14 Jan 2002 15:07:51 -0800
Date: Mon, 14 Jan 2002 15:07:51 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jason Gunthorpe <jgg@debian.org>
Cc: Matthew Dharm <mdharm@momenco.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
Message-ID: <20020114150751.B29242@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIEEMNCEAA.mdharm@momenco.com> <Pine.LNX.3.96.1020114132552.25800G-100000@wakko.deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020114132552.25800G-100000@wakko.deltatee.com>; from jgg@debian.org on Mon, Jan 14, 2002 at 01:42:22PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 14, 2002 at 01:42:22PM -0700, Jason Gunthorpe wrote:

> I have such hardware myself. IMHO the best option is the mips64 kernel and
> I hope to try it someday. But in practice I'd guess that Ralf's highmem
> patch is more likely to be usuable first (?). 

Depends if you can live with the problems of the current mips64 kernel.
If you can then it's highmem-free memory managment is certainly the way
to go.  It's also not limited to peanuts numbers of gigabytes but can
support as much memory as your can tack on a MIPS.

  Ralf
