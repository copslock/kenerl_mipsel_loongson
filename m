Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 17:27:31 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:35978
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225200AbTDVQ1a>; Tue, 22 Apr 2003 17:27:30 +0100
Received: (qmail 21903 invoked by uid 502); 22 Apr 2003 16:27:19 -0000
Date: Tue, 22 Apr 2003 09:27:19 -0700
From: ilya@theIlya.com
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Subject: Re: Crash on insmod
Message-ID: <20030422162719.GB21861@gateway.total-knowledge.com>
References: <1051006532.8589a060yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <1051006532.8589a060yaelgilad@myrealbox.com>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think this is not an interesting part.
run the whole thing through ksymoops, and send output here.
For mor information see linux/Documentation/OOPS-tracing

	Ilya

On Tue, Apr 22, 2003 at 10:15:32AM +0000, Gilad Benjamini wrote:
> This is the interesting part from the oops message:
>=20
> Using /lib/modules/2.4.20-pre6-sb20021114 ...
> unable to handle kernel paging request at virtual address 00006e76, epc =
=3D=3D c0005100, ra =3D=3D 80117e08
> Oops in fault.c::do_page_fault, line 224:
>=20
>=20
>=20
>=20
>=20

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+pW1n7sVBmHZT8w8RAkT8AJ4q59/FCTKtYeQqBePnoz8Rpb4VTwCffXi+
kIkPA28bYIkMfnsWHZhthcc=
=BYQJ
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
