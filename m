Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47A0owJ005378
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 03:00:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47A0otn005377
	for linux-mips-outgoing; Tue, 7 May 2002 03:00:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47A0dwJ005373;
	Tue, 7 May 2002 03:00:39 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 60B95848; Tue,  7 May 2002 12:01:59 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8EEA03711E; Tue,  7 May 2002 12:01:17 +0200 (CEST)
Date: Tue, 7 May 2002 12:01:17 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: RM200 big endian prom ?
Message-ID: <20020507100117.GA28542@paradigm.rfc822.org>
References: <20020506102732.GC27584@paradigm.rfc822.org> <20020506161110.A10422@guest.intrengr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20020506161110.A10422@guest.intrengr>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2002 at 04:11:10PM +0800, Ralf Baechle wrote:
> So far the assumption is that SNI's firmware is lookling like ARCS which =
is
> basically a big endian abortion of ARC.  Alternativly it might as well
> look similar to the firmware of the old MIPS workstations such as the
> RC3230 or similar.
>=20
> I wonder if the the magic just needs to be endianess swapped?

 From dumping the area a0001000 it does not look like it - Not even
any version or revision fits the description of the prom block.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE816XtUaz2rXW+gJcRAp+kAJ9vCiBnK1uDVaOkss6drFwl2ix/+wCg0UVN
QwSqxYKlPHuQLosqdzaj4pI=
=q679
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
