Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BGrTw13288
	for linux-mips-outgoing; Mon, 11 Feb 2002 08:53:29 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BGrO913285
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 08:53:24 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E8A03836; Mon, 11 Feb 2002 16:53:02 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id BC3EB4292; Mon, 11 Feb 2002 16:37:32 +0100 (CET)
Date: Mon, 11 Feb 2002 16:37:32 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Johannes Stezenbach <js@convergence.de>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020211153732.GA31248@paradigm.rfc822.org>
References: <20020209150155.GA853@paradigm.rfc822.org> <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl> <20020211135302.GB30314@paradigm.rfc822.org> <20020211142708.GA2577@convergence.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20020211142708.GA2577@convergence.de>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2002 at 03:27:08PM +0100, Johannes Stezenbach wrote:
>=20
> The glibc-2.2.5/FAQ says:
>   1.20.   Which tools should I use for MIPS?
>=20
>   {AJ} You should use the current development version of gcc 3.0 or newer=
 from
>   CVS.  gcc 2.95.x does not work correctly on mips-linux.
>=20

Its not about gcc development but rather keeping a distribution in
sync. All Debian archs try to use the same compiler which is currently
2.95.4 which we are happy with right now - Except some minor issues
breaking 2-3 Packages ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Z+U8Uaz2rXW+gJcRAqa2AJ0TKnxZ/GCWuKkVmT4SFsJo5OnNqACcCSfU
U9OAznrWIVqq8V8tvuEFjj0=
=zSgo
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
