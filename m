Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GIoEX18097
	for linux-mips-outgoing; Mon, 16 Jul 2001 11:50:14 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GIoDV18094
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 11:50:13 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D924B125BC; Mon, 16 Jul 2001 11:50:12 -0700 (PDT)
Date: Mon, 16 Jul 2001 11:50:12 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Mike McDonald <mikemac@mikemac.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010716115012.A32434@lucon.org>
References: <Pine.GSO.3.96.1010716133926.12988B-100000@delta.ds2.pg.gda.pl> <200107161847.LAA09164@saturn.mikemac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107161847.LAA09164@saturn.mikemac.com>; from mikemac@mikemac.com on Mon, Jul 16, 2001 at 11:47:04AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 16, 2001 at 11:47:04AM -0700, Mike McDonald wrote:
> 
>   Not knowing anything about the glibc architecture, I have a dumb
> question: why is 'ls' doing anything at all with pthreads?

You must be using a broken Linux. /bin/ls in my RedHat 7.1/mips doesn't
use pthreads.


H.J.
