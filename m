Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2008 08:29:16 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:59266 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20022362AbYAQI3G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2008 08:29:06 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 40CDF32E29; Thu, 17 Jan 2008 09:27:41 +0100 (CET)
Date:	Thu, 17 Jan 2008 09:27:41 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080117082741.GA2586@paradigm.rfc822.org>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20080117004054.GA12051@alpha.franken.de>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200801170924@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2008 at 01:40:54AM +0100, Thomas Bogendoerfer wrote:
> On Tue, Jan 15, 2008 at 12:27:19PM +0100, Florian Lohoff wrote:
> > Simple testcase for me is:
>=20
> this kills my IP28 after a few seconds. If I drop rdhwr or sync the
> machine hasn't locked up after running for several minutes. Looks
> like we are hiting a strange condition.
>=20
> This sort of code could be found in glibc 2.7 all over the place...
>=20
> Thomas.
>=20
> PS: Using rdhwr_noopt doesn't make a difference...

Kills my ip28 after 2 seconds ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjxF9Uaz2rXW+gJcRAj0WAKCRgZS9jhkT00HuzrqcWLAt0JrhNACaApXU
NjafeQK1KqUiceIOxhCLPnY=
=U8Za
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
