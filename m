Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OBO5W02197
	for linux-mips-outgoing; Tue, 24 Jul 2001 04:24:05 -0700
Received: from dea.waldorf-gmbh.de (u-241-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.241])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OBO1O02188
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 04:24:01 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6OBNcQ26196;
	Tue, 24 Jul 2001 13:23:38 +0200
Date: Tue, 24 Jul 2001 13:23:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Martin Schulze <joey@infodrom.north.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Question about ioctls.h
Message-ID: <20010724132338.A26049@bacchus.dhis.org>
References: <20010724010342.R31470@finlandia.infodrom.north.de> <20010724012757.A4953@bacchus.dhis.org> <20010724015611.A10007@bacchus.dhis.org> <20010724100418.W31470@finlandia.infodrom.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010724100418.W31470@finlandia.infodrom.north.de>; from joey@finlandia.infodrom.north.de on Tue, Jul 24, 2001 at 10:04:18AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 24, 2001 at 10:04:18AM +0200, Martin Schulze wrote:

> > > > Could somebody try to explain this to me?  I'm especially interested
> > > > in the #if part.  Why isn't tIOC defined normally?  It is used later.
> > > > in the file - and it is used externally by rp-pppoe for example.
> > > 
> > > Overly paranoid attempt at keeping the namespace cleaner than Mr Proper
> > > himself.
> > 
> > Try the patch below.
> 
> Thanks, looks good and works well.  Somebody should commit it.

I immediately commited it for both 2.2 and 2.4, mips and mips64.  You can
follow the commits on the linux-cvs@oss.sgi.com mailing lists.  Just
subscribe via Majordomo.

  Ralf
