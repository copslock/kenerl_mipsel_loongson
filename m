Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NNSIQ25207
	for linux-mips-outgoing; Mon, 23 Jul 2001 16:28:18 -0700
Received: from dea.waldorf-gmbh.de (u-223-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.223])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NNSEO25189
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 16:28:15 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6NNRwH05015;
	Tue, 24 Jul 2001 01:27:58 +0200
Date: Tue, 24 Jul 2001 01:27:58 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Martin Schulze <joey@infodrom.north.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Question about ioctls.h
Message-ID: <20010724012757.A4953@bacchus.dhis.org>
References: <20010724010342.R31470@finlandia.infodrom.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010724010342.R31470@finlandia.infodrom.north.de>; from joey@finlandia.infodrom.north.de on Tue, Jul 24, 2001 at 01:03:43AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 24, 2001 at 01:03:43AM +0200, Martin Schulze wrote:

> Quoting <asm/ioctls.h>:
> 
> > #if defined(__USE_MISC) || defined (__KERNEL__)
> > #define tIOC            ('t' << 8)
> > #endif
> 
> Could somebody try to explain this to me?  I'm especially interested
> in the #if part.  Why isn't tIOC defined normally?  It is used later.
> in the file - and it is used externally by rp-pppoe for example.

Overly paranoid attempt at keeping the namespace cleaner than Mr Proper
himself.

  Ralf
