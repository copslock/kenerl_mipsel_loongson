Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7FU5R10905
	for linux-mips-outgoing; Fri, 7 Dec 2001 07:30:05 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB7FU0o10893
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 07:30:01 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB72Vh801337;
	Fri, 7 Dec 2001 00:31:43 -0200
Date: Fri, 7 Dec 2001 00:31:43 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ian Chilton <ian@ichilton.co.uk>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation 5000/150)
Message-ID: <20011207003143.E1202@dea.linux-mips.net>
References: <20011203161921.B30391@woody.ichilton.co.uk> <Pine.LNX.4.21.0112031726021.2278-100000@hlubocky.del.cz> <20011203192543.A10394@paradigm.rfc822.org> <20011203224401.A31747@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011203224401.A31747@woody.ichilton.co.uk>; from ian@ichilton.co.uk on Mon, Dec 03, 2001 at 10:44:01PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 03, 2001 at 10:44:01PM +0000, Ian Chilton wrote:

> > Immediatly afterwards the massive ammount of IRQs. With 100Hz and 160
> > Chars across the screen - I would expect 1-2 lines/s on the screen.
> > Instead the screen fills up within tens of seconds which seems to me
> > like non acked IRQ.
> 
> Weird..
> 
> Has any changes been made to the IRQ code lately?

There indeed were and the guilty person already sent me a few fixes which
I haven't applied yet.

  Ralf
