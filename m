Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2003 19:20:13 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:7312
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225199AbTFFSUK>; Fri, 6 Jun 2003 19:20:10 +0100
Received: (qmail 9738 invoked by uid 502); 6 Jun 2003 18:20:08 -0000
Date: Fri, 6 Jun 2003 11:20:08 -0700
From: ilya@theIlya.com
To: "Mitchell, Earl" <earlm@mips.com>
Cc: 'HG' <henri@broadbandnetdevices.com>, linux-mips@linux-mips.org
Subject: Re: how to get older version instead of bleeding edge
Message-ID: <20030606182008.GG4803@gateway.total-knowledge.com>
References: <0C5F4C7A1E3ED51194E200508B2CE32A022649CF@xchange.mips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Content-Disposition: inline
In-Reply-To: <0C5F4C7A1E3ED51194E200508B2CE32A022649CF@xchange.mips.com>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

latest available version is linux_2_4, which happens to be always a tip of
2.4 branch of linux-mips cvs

On Fri, Jun 06, 2003 at 11:13:23AM -0700, Mitchell, Earl wrote:
> Setup env and login ...
>=20
> export CVSROOT=3D:pserver:cvs@ftp.linux-mips.org:/home/cvs
> cvs login    # password=3Dcvs
>=20
> To get list of tags available ...
>=20
> cvs history -r -T linux
>=20
> Latest stable version is 2_4_21-pre3, to download ..
>=20
> mkdir ./linux_2_4_21-pre3
> cd ./linux_2_4_21-pre3
> cvs checkout -r linux_2_4_21-pre3 linux
>=20
> -earlm
>=20
>=20
> >-----Original Message-----
> >From: HG [mailto:henri@broadbandnetdevices.com]
> >Sent: Friday, June 06, 2003 10:57 AM
> >To: linux-mips@linux-mips.org
> >Subject: how to get older version instead of bleeding edge
> >
> >Hi all
> >
> >How I get the older version of the linux for mips kernel , in particular=
 I
> >would like the 2.4.20
> >
> >after downloading successfully the latest cvs with the web example
> >i tried to upgrade with : $ cvs
> >cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs  update -r2.4.20 linux
> >a long list of ..../filename is no longer in the repository was obtained
> >
> >any hints of the command line necessary
> >
> >thanks
> >
> >Henri
>=20
>=20

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+4NtX7sVBmHZT8w8RAsFHAKC7rzmNA5tdNe2/dAbviuIL2weaegCfTshF
IO/esKVL1SDXosBJp0tG8Wo=
=BWA/
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
