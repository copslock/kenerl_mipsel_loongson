Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4CDY9wJ008353
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 12 May 2002 06:34:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4CDY9LD008352
	for linux-mips-outgoing; Sun, 12 May 2002 06:34:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4CDY2wJ008349
	for <linux-mips@oss.sgi.com>; Sun, 12 May 2002 06:34:03 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E5756853; Sun, 12 May 2002 15:35:44 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 29B363711E; Sun, 12 May 2002 15:35:15 +0200 (CEST)
Date: Sun, 12 May 2002 15:35:15 +0200
From: Florian Lohoff <flo@rfc822.org>
To: nsauzede <nsauzede@online.fr>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-mips@oss.sgi.com
Subject: Re: Debian on Indy.
Message-ID: <20020512133515.GA1091@paradigm.rfc822.org>
References: <Pine.LNX.4.10.10205091055260.9983-100000@www.transvirtual.com> <007001c1f940$ba95b0c0$011e1ec0@home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <007001c1f940$ba95b0c0$011e1ec0@home>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2002 at 01:08:13AM +0200, nsauzede wrote:
> Just for info : I managed to have the Debian Woody to work fine on my Indy
> (kernel is 2.4.13 if I remember well...)
>=20
> But when I tried to boot some kernel 2.5.?? (can't remember last number -=
- I
> fetched the source from CVS) I cross compiled on an i386 platform, I got =
the
> same problem : bootup crashes at SCSI probing time...
>=20
> Must be some kind of SCSI code regression or something..
>=20
> I think I already posted my problem to the list but didn't get reply....

The problem is the major block device change in 2.5 - It is still not
finished and needs more work in the individual drivers (IIRC the
driver itself has to do some error handling).

So the crash points to work to be done in the driver.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE83m+SUaz2rXW+gJcRAh3KAJwIsn5zLbJVbEQA3DgvnjsZY+CNcQCfe1CK
myEPAGDCWzVOaZSq6ksPWYk=
=eBvU
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
