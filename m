Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6O84RT23869
	for linux-mips-outgoing; Tue, 24 Jul 2001 01:04:27 -0700
Received: from kuolema.infodrom.north.de (postfix@kuolema.infodrom.north.de [217.89.86.35])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6O84NO23862;
	Tue, 24 Jul 2001 01:04:23 -0700
Received: from finlandia.infodrom.north.de (finlandia.Infodrom.North.DE [217.89.86.34])
	by kuolema.infodrom.north.de (Postfix) with ESMTP
	id C406A4D73F; Tue, 24 Jul 2001 10:04:18 +0200 (CEST)
Received: by finlandia.infodrom.north.de (Postfix, from userid 501)
	id 93423108DF; Tue, 24 Jul 2001 10:04:18 +0200 (CEST)
Date: Tue, 24 Jul 2001 10:04:18 +0200
From: Martin Schulze <joey@finlandia.infodrom.north.de>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Question about ioctls.h
Message-ID: <20010724100418.W31470@finlandia.infodrom.north.de>
Reply-To: Martin Schulze <joey@infodrom.north.de>
References: <20010724010342.R31470@finlandia.infodrom.north.de> <20010724012757.A4953@bacchus.dhis.org> <20010724015611.A10007@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010724015611.A10007@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jul 24, 2001 at 01:56:11AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> On Tue, Jul 24, 2001 at 01:27:58AM +0200, Ralf Baechle wrote:
> 
> > > Could somebody try to explain this to me?  I'm especially interested
> > > in the #if part.  Why isn't tIOC defined normally?  It is used later.
> > > in the file - and it is used externally by rp-pppoe for example.
> > 
> > Overly paranoid attempt at keeping the namespace cleaner than Mr Proper
> > himself.
> 
> Try the patch below.

Thanks, looks good and works well.  Somebody should commit it.

Regards,

	Joey

-- 
In the beginning was the word, and the word was content-type: text/plain
