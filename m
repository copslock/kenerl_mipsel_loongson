Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2003 19:11:55 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:4752
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225199AbTFFSLx>; Fri, 6 Jun 2003 19:11:53 +0100
Received: (qmail 9454 invoked by uid 502); 6 Jun 2003 18:11:48 -0000
Date: Fri, 6 Jun 2003 11:11:48 -0700
From: ilya@theIlya.com
To: HG <henri@broadbandnetdevices.com>
Cc: linux-mips@linux-mips.org
Subject: Re: how to get older version instead of bleeding edge
Message-ID: <20030606181148.GF4803@gateway.total-knowledge.com>
References: <002701c32c55$14305520$0500a8c0@sympatico.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <002701c32c55$14305520$0500a8c0@sympatico.ca>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Primary command that you need to know is
info cvs

OTOH, it would probably be beneficial, if we had something like
"
To check out earlier releases of kernel from cvs (i.e. 2.4) use
cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co -rlinux_2_4
"

On Fri, Jun 06, 2003 at 01:57:21PM -0400, HG wrote:
> Hi all
>=20
> How I get the older version of the linux for mips kernel , in particular I
> would like the 2.4.20
>=20
> after downloading successfully the latest cvs with the web example
> i tried to upgrade with : $ cvs
> cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs  update -r2.4.20 linux
> a long list of ..../filename is no longer in the repository was obtained
>=20
> any hints of the command line necessary
>=20
> thanks
>=20
> Henri
>=20
>=20

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+4Nlj7sVBmHZT8w8RAkyVAKCpOI35vvzyb7JXOAJKiWPsri0lCQCgyoin
jnOn05hW8XvlBr1l8I9dA6U=
=kmH0
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
