Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NN42J21680
	for linux-mips-outgoing; Mon, 23 Jul 2001 16:04:02 -0700
Received: from kuolema.infodrom.north.de (postfix@kuolema.infodrom.north.de [217.89.86.35])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NN3wO21670
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 16:03:59 -0700
Received: from finlandia.infodrom.north.de (finlandia.Infodrom.North.DE [217.89.86.34])
	by kuolema.infodrom.north.de (Postfix) with ESMTP id 3AFC84D73E
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 01:03:47 +0200 (CEST)
Received: by finlandia.infodrom.north.de (Postfix, from userid 501)
	id 2C88A109D3; Tue, 24 Jul 2001 01:03:43 +0200 (CEST)
Date: Tue, 24 Jul 2001 01:03:43 +0200
From: Martin Schulze <joey@finlandia.infodrom.north.de>
To: linux-mips@oss.sgi.com
Subject: Question about ioctls.h
Message-ID: <20010724010342.R31470@finlandia.infodrom.north.de>
Reply-To: Martin Schulze <joey@infodrom.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Quoting <asm/ioctls.h>:

> #if defined(__USE_MISC) || defined (__KERNEL__)
> #define tIOC            ('t' << 8)
> #endif

Could somebody try to explain this to me?  I'm especially interested
in the #if part.  Why isn't tIOC defined normally?  It is used later.
in the file - and it is used externally by rp-pppoe for example.

Regards,

	Joey

-- 
All language designers are arrogant.  Goes with the territory...
	-- Larry Wall
