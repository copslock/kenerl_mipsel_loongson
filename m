Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GK9FR24724
	for linux-mips-outgoing; Mon, 16 Jul 2001 13:09:15 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GK9EV24721
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 13:09:14 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id CE826125BC; Mon, 16 Jul 2001 13:09:13 -0700 (PDT)
Date: Mon, 16 Jul 2001 13:09:13 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Mike McDonald <mikemac@mikemac.com>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010716130913.A1412@lucon.org>
References: <20010716115012.A32434@lucon.org> <Pine.GSO.3.96.1010716214033.12988I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010716214033.12988I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 16, 2001 at 09:51:12PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 16, 2001 at 09:51:12PM +0200, Maciej W. Rozycki wrote:
> 
>  Of course, you may force version 4.1 not to make use libpthreads, either. 
> Just convince the configure script in the usual way not to use
> clock_gettime().
> 

ls shouldn't bother with clock_gettime, which is in librt and librt
needs libpthreads. RedHat 7.1 has a similar patch to make 3.79.1 to
get around it. Otherwise, make won't work right due to the 2MB stack
limit imposed by libpthreads.


H.J.
