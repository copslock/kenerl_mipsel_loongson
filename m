Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14MMk115876
	for linux-mips-outgoing; Mon, 4 Feb 2002 14:22:46 -0800
Received: from dea.linux-mips.net (a1as18-p231.stg.tli.de [195.252.193.231])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14MMdA15872
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 14:22:40 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g14ML8c07451;
	Mon, 4 Feb 2002 23:21:08 +0100
Date: Mon, 4 Feb 2002 23:21:08 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: gcc 3.x, -ansi and "static inline"
Message-ID: <20020204232108.A7266@dea.linux-mips.net>
References: <20020201115206.A18085@mvista.com> <20020203180151.A5371@dea.linux-mips.net> <3C5EE0D0.F2CC94CE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5EE0D0.F2CC94CE@mvista.com>; from jsun@mvista.com on Mon, Feb 04, 2002 at 11:28:16AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 04, 2002 at 11:28:16AM -0800, Jun Sun wrote:

> > On Fri, Feb 01, 2002 at 11:52:06AM -0800, Jun Sun wrote:
> > 
> > > BTW, the inclusion of "mipsregs.h" file in bitops.h seems unnecessary
> > > and caused a bunch of similar errors.
> > 
> > Indeed, it was pointless and I therefore removed it.
> 
> What about ffz()?  We can do:

Including kernel header files into user code is the actual bug but if
you think fixing that isn't an option I can certainly so a
s/inline/__inline__/

  Ralf
