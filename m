Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB3JQNL11039
	for linux-mips-outgoing; Mon, 3 Dec 2001 11:26:23 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB3JQHo11036
	for <linux-mips@oss.sgi.com>; Mon, 3 Dec 2001 11:26:17 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 48C32892; Mon,  3 Dec 2001 19:26:09 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C8A8141A9; Mon,  3 Dec 2001 19:25:43 +0100 (CET)
Date: Mon, 3 Dec 2001 19:25:43 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
Cc: Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: 2.4.16 success on Indy (was Re: 2.4.16 success on Decstation 5000/150)
Message-ID: <20011203192543.A10394@paradigm.rfc822.org>
References: <20011203161921.B30391@woody.ichilton.co.uk> <Pine.LNX.4.21.0112031726021.2278-100000@hlubocky.del.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112031726021.2278-100000@hlubocky.del.cz>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2001 at 05:34:40PM +0100, Ladislav Michl wrote:
> sure :-) IRQ 8 is FIFO full and was never used (and to be honest, i don't
> know what that irq is used for). before Wed, 21 Nov 2001 17:49:32 +0100
> it was General purpose local interrupt - this one was also never
> used. see include/asm-mips/sgi/sgint23.h for more info.
>=20
> i have no clue, why you're getting this interrupt. it works pretty well
> for me...

Ok - the IRQ8 get enabled because i have CONFIG_RTC set and in
drivers/char/rtc.c around line 730 it requests:

if(request_irq(RTC_IRQ, rtc_interrupt, SA_INTERRUPT, "rtc", NULL))

Immediatly afterwards the massive ammount of IRQs. With 100Hz and 160
Chars across the screen - I would expect 1-2 lines/s on the screen.
Instead the screen fills up within tens of seconds which seems to me
like non acked IRQ.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8C8OnUaz2rXW+gJcRAs7iAJ9cCwFr+HHMyTuLga7m62PVFrNFYwCeOe5f
eWzBOA2uYLf2DRJA+4JSnBk=
=+JPp
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
