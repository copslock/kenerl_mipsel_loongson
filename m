Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4U9lGnC032215
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 02:47:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4U9lG5m032214
	for linux-mips-outgoing; Thu, 30 May 2002 02:47:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4U9l9nC032211
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 02:47:10 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BB684846; Thu, 30 May 2002 11:48:38 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0D54137102; Thu, 30 May 2002 11:42:56 +0200 (CEST)
Date: Thu, 30 May 2002 11:42:56 +0200
From: Florian Lohoff <flo@rfc822.org>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Brian Murphy <brian@murphy.dk>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: New platforms
Message-ID: <20020530094255.GA18436@paradigm.rfc822.org>
References: <3CF4AAAD.7070504@murphy.dk> <Pine.LNX.4.10.10205291315520.19493-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10205291315520.19493-100000@www.transvirtual.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2002 at 01:16:53PM -0700, James Simmons wrote:
> > Hi,
> >     I have a port of linux-mips to the Lasat (later Eicon) platform(s) -
> > based on vr4300, vr5000 and vr4120 chips. I would very much like
> > to have the code incorporated in the CVS at OSS. How do I go
> > about this?
>=20
> Please at a look at the Linux MIPS project at sourceforge. We already have
> several VR chipsets supported.=20

The Eicons are not anything really embedded rather than Cobalt RaQ like.

Flo
PS: I dont like this split up tree - Currently Ralf is the one=20
feeding mainstream so please stop this diversification of the trees
as the normal user gets completely confused which makes linux mips
a VERY BAD target and does not help any popularity for the mips targets.
We had the linux-vr desaster before which helped nothing but in
the end bound developer efforts which were useless in the end.
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE89fQfUaz2rXW+gJcRAvt7AJ4xrCC0ZtBUZ3XUIi7LD34jIsZLKQCfR1/q
ehhbFC/ntyk3n+l52ncRxXg=
=fWn3
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
