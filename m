Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 20:46:59 +0000 (GMT)
Received: from NAT.office.mind.be ([IPv6:::ffff:62.166.230.82]:55940 "EHLO
	codecarver.intern.mind.be") by linux-mips.org with ESMTP
	id <S8225340AbUBWUq4>; Mon, 23 Feb 2004 20:46:56 +0000
Received: from p2 by codecarver with local (Exim 3.36 #1 (Debian))
	id 1AvMyY-0000Ss-00; Mon, 23 Feb 2004 21:46:50 +0100
Date:	Mon, 23 Feb 2004 21:46:50 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Joost <Joost@stack.nl>, linux-mips@linux-mips.org
Subject: Re: fore atm card in indy?
Message-ID: <20040223204649.GF1046@mind.be>
Mail-Followup-To: peter.de.schrijver@mind.be,
	Ralf Baechle <ralf@linux-mips.org>, Joost <Joost@stack.nl>,
	linux-mips@linux-mips.org
References: <Pine.LNX.4.58.0402181631050.30510@brilsmurf.chem.tue.nl> <20040220142138.GD23404@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <20040220142138.GD23404@linux-mips.org>
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag:	Get yourself a real email client. http://www.mutt.org/
X-mate:	Mate, man gewoehnt sich an alles
User-Agent: Mutt/1.5.5.1+cvs20040105i
From:	Peter 'p2' De Schrijver <p2@mind.be>
Return-Path: <p2@mind.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@mind.be
Precedence: bulk
X-list: linux-mips


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2004 at 03:21:38PM +0100, Ralf Baechle wrote:
> On Wed, Feb 18, 2004 at 04:35:31PM +0100, Joost wrote:
>=20
> > My indy seems to be equipped with a Fore ATM device (GIA-200).
> > Would someone know if there is a way to get it back into action?
>=20
> You'll not like this answer ...  but write a driver :-)
>=20
> It seems many GIO cards are based on already Linux-supported PCI chips,
> so there's a certain chance this won't even be hard.
>=20

There is already a driver for the PCI and SBUS versions of this card. It
lives in drivers/atm/fore200e*. You 'only' need to add code for the
GIO32 specifics.

Cheers,

Peter.

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAOma5KLKVw/RurbsRAkpVAJwP3byUqlKkb9jxIbUT8LhwSA3dUACfeeNX
Sz4h7iVf0ZpWbG5FB94lL5M=
=00w0
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
